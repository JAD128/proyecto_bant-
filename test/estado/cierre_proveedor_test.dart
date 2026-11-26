import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/estado/cierre_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_cierres.dart';
import '../apoyo/fakes_pedidos.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late CierreProveedor proveedor;
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

    await dependencias.pedidos.guardar(
      pedidoHistorial(
        id: 'pedido-1',
        empleadoId: adminId,
        fechaLocal: '2026-01-05',
        total: 1000,
      ),
    );
    await dependencias.gastos.guardar(
      gastoCierre(valor: 200, usuarioId: adminId),
    );

    proveedor = CierreProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    proveedor.dispose();
    sesion.dispose();
    await base.close();
  });

  group('CierreProveedor', () {
    test('carga, cierra, corrige y expone las auditorías', () async {
      expect(await proveedor.cargar(), isTrue);
      expect(proveedor.cierres, isEmpty);
      expect(proveedor.error, isNull);

      expect(await proveedor.cerrar('2026-01-05'), isTrue);
      expect(proveedor.cierres, hasLength(1));
      expect(proveedor.cierreActual?.totalVentas, 1000);
      expect(proveedor.cierreActual?.saldoNeto, 800);
      expect(proveedor.fechaSeleccionada, '2026-01-05');

      await dependencias.pedidos.guardar(
        pedidoHistorial(
          id: 'pedido-2',
          empleadoId: adminId,
          fechaLocal: '2026-01-05',
          total: 500,
        ),
      );
      final cierreId = proveedor.cierreActual!.id;
      expect(await proveedor.corregir(cierreId, 'Ajuste del turno'), isTrue);
      expect(proveedor.cierreActual?.id, cierreId);
      expect(proveedor.cierreActual?.totalVentas, 1500);
      expect(proveedor.error, isNull);

      expect(await proveedor.verAuditorias(cierreId), isTrue);
      expect(proveedor.auditorias, hasLength(1));
      expect(proveedor.auditorias.single.motivo, 'Ajuste del turno');
      expect(
        proveedor.auditorias.single.valoresAntes,
        contains('"totalVentas":1000'),
      );
      expect(
        proveedor.auditorias.single.valoresDespues,
        contains('"totalVentas":1500'),
      );
    });

    test('expone errores de fecha y duplicado', () async {
      expect(await proveedor.cerrar('2026-01-05'), isTrue);
      expect(await proveedor.cerrar('2026-01-05'), isFalse);
      expect(proveedor.error, 'Ya existe un cierre para esa fecha.');
      expect(proveedor.cierres, hasLength(1));

      expect(await proveedor.cerrar('01-05-2026'), isFalse);
      expect(proveedor.error, 'Formato YYYY-MM-DD inválido.');
      expect(proveedor.cargando, isFalse);
    });

    test('seleccionarFecha sincroniza el cierre actual', () async {
      expect(await proveedor.cerrar('2026-01-05'), isTrue);

      proveedor.seleccionarFecha('2026-01-06');
      expect(proveedor.fechaSeleccionada, '2026-01-06');
      expect(proveedor.cierreActual, isNull);

      proveedor.seleccionarFecha('2026-01-05');
      expect(proveedor.cierreActual, isNotNull);
      expect(proveedor.cierreActual?.fechaLocal, '2026-01-05');
    });
  });
}
