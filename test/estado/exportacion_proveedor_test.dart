import 'dart:io';

import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/servicios/servicio_exportacion.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/formato_exportacion.dart';
import 'package:bantu/dominio/valores/tipo_exportacion.dart';
import 'package:bantu/estado/exportacion_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_finanzas.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late Directory directorio;
  late ExportacionProveedor proveedor;

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
    directorio = await Directory.systemTemp.createTemp('bantu_provider_xlsx_');

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
      empleadoId: sesion.usuarioActivo!.id,
      usuarioId: sesion.usuarioActivo!.id,
    );

    final servicio = ServicioExportacion(
      historial: dependencias.servicioHistorial,
      finanzas: dependencias.servicioFinanzas,
      cierres: dependencias.cierres,
      permisos: dependencias.permisos,
      abrirDirectorio: () async => directorio,
    );
    proveedor = ExportacionProveedor(
      dependencias: dependencias,
      sesion: sesion,
      servicio: servicio,
    );
  });

  tearDown(() async {
    proveedor.dispose();
    sesion.dispose();
    await directorio.delete(recursive: true);
    await base.close();
  });

  group('ExportacionProveedor', () {
    test('exporta y publica la ruta del archivo', () async {
      expect(
        await proveedor.exportar(
          tipo: TipoExportacion.pedidos,
          formato: FormatoExportacion.xlsx,
          desde: '2026-01-05',
          hasta: '2026-01-05',
        ),
        isTrue,
      );
      expect(proveedor.error, isNull);
      expect(proveedor.cargando, isFalse);
      expect(
        proveedor.ruta,
        endsWith('bantu_pedidos_2026-01-05_2026-01-05.xlsx'),
      );
      final archivo = File(proveedor.ruta!);
      expect(await archivo.exists(), isTrue);
      expect((await archivo.readAsBytes()).length, greaterThan(0));
    });

    test('expone errores de validación y limpia la ruta anterior', () async {
      expect(
        await proveedor.exportar(
          tipo: TipoExportacion.gastos,
          formato: FormatoExportacion.pdf,
        ),
        isTrue,
      );
      expect(proveedor.ruta, isNotNull);

      expect(
        await proveedor.exportar(
          tipo: TipoExportacion.gastos,
          formato: FormatoExportacion.pdf,
          desde: '2026-01-06',
          hasta: '2026-01-05',
        ),
        isFalse,
      );
      expect(proveedor.ruta, isNull);
      expect(proveedor.error, contains('La fecha desde no puede ser mayor'));
      expect(proveedor.cargando, isFalse);
    });

    test('rechaza la exportación sin sesión activa', () async {
      await sesion.cerrarSesion();
      expect(
        await proveedor.exportar(
          tipo: TipoExportacion.cierres,
          formato: FormatoExportacion.pdf,
        ),
        isFalse,
      );
      expect(proveedor.error, contains('Debes iniciar sesión'));
      expect(await directorio.list().length, 0);
    });
  });
}
