import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/estado/finanzas_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_finanzas.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late FinanzasProveedor proveedor;
  late String adminId;

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    dependencias = Dependencias(baseDatos: base, sesion: SesionMemoria());
    sesion = SesionProveedor(dependencias: dependencias);
    await sesion.inicializar();
    expect(
      await sesion.configurarAdministrador(
        nombre: 'Admin',
        pin: '1234',
        confirmacion: '1234',
      ),
      isTrue,
    );
    adminId = sesion.usuarioActivo!.id;

    final ahora = DateTime.utc(2026, 1, 1, 12);
    await dependencias.categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    await dependencias.productos.guardar(
      Producto(
        id: 'producto-1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1000,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    await sembrarFinanzas(
      pedidos: dependencias.pedidos,
      gastos: dependencias.gastos,
      empleadoId: adminId,
      usuarioId: adminId,
    );

    proveedor = FinanzasProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    proveedor.dispose();
    sesion.dispose();
    await base.close();
  });

  group('FinanzasProveedor', () {
    test('carga el resumen y los gastos ordenados', () async {
      expect(await proveedor.cargar(), isTrue);
      expect(proveedor.error, isNull);
      expect(proveedor.resumen.ingresos, 10500);
      expect(proveedor.resumen.egresos, 400);
      expect(proveedor.resumen.saldoNeto, 10100);
      expect(proveedor.resumen.efectivoEnCaja, 8500);
      expect(proveedor.gastos.map((gasto) => gasto.id), [
        'gasto-otro-dia',
        'gasto-1',
      ]);
    });

    test('cambiarRango y limpiarRango recalculan todo', () async {
      expect(await proveedor.cargar(), isTrue);

      expect(await proveedor.cambiarRango(desde: '2026-01-06'), isTrue);
      expect(proveedor.desde, '2026-01-06');
      expect(proveedor.hasta, isNull);
      expect(proveedor.resumen.ingresos, 7000);
      expect(proveedor.resumen.egresos, 100);
      expect(proveedor.gastos, hasLength(1));

      expect(await proveedor.limpiarRango(), isTrue);
      expect(proveedor.desde, isNull);
      expect(proveedor.hasta, isNull);
      expect(proveedor.resumen.ingresos, 10500);
      expect(proveedor.gastos, hasLength(2));
    });

    test('registrar y actualizar gasto refrescan el estado', () async {
      expect(await proveedor.cargar(), isTrue);

      expect(
        await proveedor.registrarGasto(
          fechaLocal: '2026-01-07',
          concepto: 'Papelería',
          valor: 1200,
        ),
        isTrue,
      );
      expect(proveedor.error, isNull);
      expect(proveedor.gastos.first.descripcion, 'Papelería');
      expect(proveedor.resumen.egresos, 1600);
      expect(proveedor.resumen.saldoNeto, 8900);
      expect(proveedor.resumen.efectivoEnCaja, 8500);

      final gastoId = proveedor.gastos.first.id;
      expect(
        await proveedor.actualizarGasto(
          gastoId: gastoId,
          concepto: 'Papelería ajustada',
          valor: 1500,
        ),
        isTrue,
      );
      expect(proveedor.gastos.first.descripcion, 'Papelería ajustada');
      expect(proveedor.gastos.first.valor, 1500);
      expect(proveedor.resumen.egresos, 1900);
      expect(proveedor.resumen.saldoNeto, 8600);
    });

    test('expone errores de rango y de validación', () async {
      expect(await proveedor.cargar(), isTrue);

      expect(
        await proveedor.cambiarRango(desde: '2026-01-06', hasta: '2026-01-05'),
        isFalse,
      );
      expect(proveedor.error, contains('La fecha desde no puede ser mayor'));
      expect(proveedor.cargando, isFalse);

      expect(await proveedor.limpiarRango(), isTrue);
      expect(
        await proveedor.registrarGasto(
          fechaLocal: '2026-01-07',
          concepto: '   ',
          valor: 100,
        ),
        isFalse,
      );
      expect(proveedor.error, contains('Texto vacío'));
      expect(proveedor.gastos, hasLength(2));
    });
  });
}
