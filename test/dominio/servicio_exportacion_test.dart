import 'dart:io';

import 'package:bantu/dominio/entidades/cierre_diario.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/calculador_finanzas.dart';
import 'package:bantu/dominio/servicios/servicio_exportacion.dart';
import 'package:bantu/dominio/servicios/servicio_finanzas.dart';
import 'package:bantu/dominio/servicios/servicio_historial.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estado_cierre.dart';
import 'package:bantu/dominio/valores/formato_exportacion.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:bantu/dominio/valores/tipo_exportacion.dart';
import 'package:excel/excel.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_cierres.dart';
import '../apoyo/fakes_finanzas.dart';
import '../apoyo/fakes_pedidos.dart';

class PermisosExportacion extends ServicioPermisos {
  const PermisosExportacion();

  @override
  bool puede(Usuario usuario, Accion accion) =>
      usuario.activo &&
      (accion == Accion.exportarInformes ||
          accion == Accion.verHistorial ||
          accion == Accion.verFinanzas);
}

Usuario usuarioExportacion({
  String id = 'admin',
  Rol rol = Rol.administrador,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: id,
    nombre: id,
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  late Directory directorio;
  late PedidoRepositorioMemoria pedidos;
  late GastoRepositorioMemoria gastos;
  late CierreRepositorioMemoria cierres;
  late ServicioExportacion servicio;
  late Usuario admin;
  late Usuario mesero;

  setUp(() async {
    directorio = await Directory.systemTemp.createTemp('bantu_exportacion_');
    pedidos = PedidoRepositorioMemoria();
    gastos = GastoRepositorioMemoria();
    cierres = CierreRepositorioMemoria();
    final permisos = const ServicioPermisos();
    final historial = ServicioHistorial(pedidos: pedidos, permisos: permisos);
    final finanzas = ServicioFinanzas(
      gastos: gastos,
      pedidos: pedidos,
      calculador: const CalculadorFinanzas(),
      permisos: permisos,
    );
    servicio = ServicioExportacion(
      historial: historial,
      finanzas: finanzas,
      cierres: cierres,
      permisos: permisos,
      abrirDirectorio: () async => directorio,
    );
    admin = usuarioExportacion();
    mesero = usuarioExportacion(id: 'mesero1', rol: Rol.empleado);

    await sembrarFinanzas(
      pedidos: pedidos,
      gastos: gastos,
      empleadoId: mesero.id,
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p-otro-empleado',
        empleadoId: 'otro-mesero',
        fechaLocal: '2026-01-06',
      ),
    );
    await cierres.guardar(
      CierreDiario(
        id: 'cierre-1',
        fechaLocal: '2026-01-05',
        estado: EstadoCierre.cerrado,
        totalPedidos: 4,
        totalVentas: 3500,
        totalEgresos: 300,
        saldoNeto: 3200,
        cerradoPor: admin.id,
        creadoEn: DateTime.utc(2026, 1, 5, 23),
      ),
    );
  });

  tearDown(() async {
    await directorio.delete(recursive: true);
  });

  group('ServicioExportacion', () {
    test('exporta pedidos a XLSX con encabezados y una fila por pedido',
        () async {
      final ruta = await servicio.exportar(
        usuarioActivo: admin,
        tipo: TipoExportacion.pedidos,
        formato: FormatoExportacion.xlsx,
        desde: '2026-01-05',
        hasta: '2026-01-06',
      );

      expect(ruta, endsWith('bantu_pedidos_2026-01-05_2026-01-06.xlsx'));
      final archivo = File(ruta);
      expect(await archivo.exists(), isTrue);
      final bytes = await archivo.readAsBytes();
      expect(bytes.length, greaterThan(0));

      final libro = Excel.decodeBytes(bytes);
      expect(libro.tables.keys, contains('Bantú'));
      final hoja = libro['Bantú'];
      expect(hoja.maxRows, 7);
      expect(_texto(hoja, 0, 0), 'ID');
      expect(_texto(hoja, 0, 10), 'Ítems');
      final ids = [
        for (var fila = 1; fila < hoja.maxRows; fila++) _texto(hoja, fila, 0),
      ];
      expect(ids, containsAll(<String>[
        'p-efectivo-local',
        'p-transferencia-llevar',
        'p-anulado',
        'p-otro-dia',
        'p-otro-empleado',
      ]));
      final filaPedido = ids.indexOf('p-efectivo-local') + 1;
      final resumenItems = _texto(hoja, filaPedido, 10);
      expect(resumenItems, contains('1 x Agua'));
      expect(resumenItems, contains('local'));
      expect(resumenItems, contains('total'));
    });

    test('exporta cierres a PDF con firma y nombre con rango', () async {
      final ruta = await servicio.exportar(
        usuarioActivo: admin,
        tipo: TipoExportacion.cierres,
        formato: FormatoExportacion.pdf,
        desde: '2026-01-05',
        hasta: '2026-01-05',
      );

      expect(ruta, endsWith('bantu_cierres_2026-01-05_2026-01-05.pdf'));
      final bytes = await File(ruta).readAsBytes();
      expect(bytes.length, greaterThan(100));
      expect(bytes.sublist(0, 4), <int>[0x25, 0x50, 0x44, 0x46]);
    });

    test('sin rango usa todo en el nombre y exporta gastos', () async {
      final ruta = await servicio.exportar(
        usuarioActivo: admin,
        tipo: TipoExportacion.gastos,
        formato: FormatoExportacion.xlsx,
      );

      expect(ruta, endsWith('bantu_gastos_todo_todo.xlsx'));
      final libro = Excel.decodeBytes(await File(ruta).readAsBytes());
      final hoja = libro['Bantú'];
      expect(hoja.maxRows, 3);
      final conceptos = [
        _texto(hoja, 1, 3),
        _texto(hoja, 2, 3),
      ];
      expect(conceptos, containsAll(<String>['Servicio', 'Combustible']));
    });

    test('rechaza empleado sin permiso de exportación', () async {
      expect(
        servicio.exportar(
          usuarioActivo: mesero,
          tipo: TipoExportacion.pedidos,
          formato: FormatoExportacion.xlsx,
        ),
        throwsStateError,
      );
      expect(await directorio.list().length, 0);
    });

    test('respeta la visibilidad del historial para empleados autorizados',
        () async {
      final autorizado = ServicioExportacion(
        historial: ServicioHistorial(
          pedidos: pedidos,
          permisos: const PermisosExportacion(),
        ),
        finanzas: ServicioFinanzas(
          gastos: gastos,
          pedidos: pedidos,
          calculador: const CalculadorFinanzas(),
          permisos: const PermisosExportacion(),
        ),
        cierres: cierres,
        permisos: const PermisosExportacion(),
        abrirDirectorio: () async => directorio,
      );

      final ruta = await autorizado.exportar(
        usuarioActivo: mesero,
        tipo: TipoExportacion.pedidos,
        formato: FormatoExportacion.xlsx,
      );
      final hoja = Excel.decodeBytes(await File(ruta).readAsBytes())['Bantú'];
      expect(hoja.maxRows, 6);
      for (var fila = 1; fila < hoja.maxRows; fila++) {
        expect(_texto(hoja, fila, 3), mesero.id);
      }
    });

    test('valida fechas y rango invertido antes de escribir', () async {
      expect(
        servicio.exportar(
          usuarioActivo: admin,
          tipo: TipoExportacion.cierres,
          formato: FormatoExportacion.pdf,
          desde: '2026-01-06',
          hasta: '2026-01-05',
        ),
        throwsArgumentError,
      );
      expect(
        servicio.exportar(
          usuarioActivo: admin,
          tipo: TipoExportacion.gastos,
          formato: FormatoExportacion.xlsx,
          desde: '05-01-2026',
        ),
        throwsArgumentError,
      );
      expect(await directorio.list().length, 0);
    });
  });
}

String _texto(Sheet hoja, int fila, int columna) {
  final valor = hoja
      .cell(
        CellIndex.indexByColumnRow(columnIndex: columna, rowIndex: fila),
      )
      .value;
  if (valor is TextCellValue) {
    return valor.value.text ?? '';
  }
  return valor?.toString() ?? '';
}
