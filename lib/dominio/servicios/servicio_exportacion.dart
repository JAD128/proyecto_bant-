import 'dart:io';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

import '../../datos/repositorios/cierre_repositorio.dart';
import '../entidades/cierre_diario.dart';
import '../entidades/gasto.dart';
import '../entidades/pedido.dart';
import '../entidades/usuario.dart';
import '../../utilidades/formato_moneda.dart';
import '../valores/estado_cierre.dart';
import '../valores/estado_pedido.dart';
import '../valores/formato_exportacion.dart';
import '../valores/metodo_pago.dart';
import '../valores/modalidad_pedido.dart';
import '../valores/tipo_exportacion.dart';
import 'calculador_finanzas.dart';
import 'servicio_finanzas.dart';
import 'servicio_historial.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioExportacion {
  final ServicioHistorial _historial;
  final ServicioFinanzas _finanzas;
  final CierreRepositorio _cierres;
  final ServicioPermisos _permisos;
  final Future<Directory> Function() _abrirDirectorio;

  const ServicioExportacion({
    required this._historial,
    required this._finanzas,
    required this._cierres,
    required this._permisos,
    Future<Directory> Function()? abrirDirectorio,
  }) : _abrirDirectorio = abrirDirectorio ?? getApplicationDocumentsDirectory;

  Future<String> exportar({
    required Usuario usuarioActivo,
    required TipoExportacion tipo,
    required FormatoExportacion formato,
    String? desde,
    String? hasta,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.exportarInformes);
    _validarRango(desde, hasta);

    final tabla = await _obtenerTabla(usuarioActivo, tipo, desde, hasta);
    final resumen = await _finanzas.resumen(
      usuarioActivo,
      desde: desde,
      hasta: hasta,
    );
    final bytes = formato == FormatoExportacion.xlsx
        ? _crearXlsx(tabla)
        : await _crearPdf(tabla, resumen, tipo, desde, hasta);

    final directorio = await _abrirDirectorio();
    await directorio.create(recursive: true);
    final archivo = File(
      path.join(
        directorio.path,
        _nombreArchivo(tipo, formato, desde, hasta),
      ),
    );
    await archivo.writeAsBytes(bytes, flush: true);
    return archivo.path;
  }

  Future<_TablaExportacion> _obtenerTabla(
    Usuario usuarioActivo,
    TipoExportacion tipo,
    String? desde,
    String? hasta,
  ) async {
    switch (tipo) {
      case TipoExportacion.pedidos:
        final pedidos = await _historial.consultar(
          usuarioActivo,
          desde: desde,
          hasta: hasta,
        );
        return _tablaPedidos(pedidos);
      case TipoExportacion.gastos:
        final gastos = await _finanzas.obtenerGastos(
          usuarioActivo,
          desde: desde,
          hasta: hasta,
        );
        return _tablaGastos(gastos);
      case TipoExportacion.cierres:
        final cierres = await _cierres.obtenerTodos();
        final filtrados = cierres
            .where((cierre) {
              if (desde != null && cierre.fechaLocal.compareTo(desde) < 0) {
                return false;
              }
              if (hasta != null && cierre.fechaLocal.compareTo(hasta) > 0) {
                return false;
              }
              return true;
            })
            .toList()
          ..sort((a, b) => b.fechaLocal.compareTo(a.fechaLocal));
        return _tablaCierres(filtrados);
    }
  }

  _TablaExportacion _tablaPedidos(List<Pedido> pedidos) {
    return _TablaExportacion(
      encabezados: const [
        'ID',
        'Fecha',
        'Hora',
        'Empleado',
        'Modalidad',
        'Método de pago',
        'Estado',
        'Subtotal',
        'Empaque',
        'Total',
        'Ítems',
      ],
      filas: [
        for (final pedido in pedidos)
          <Object>[
            pedido.id,
            pedido.fechaLocal,
            pedido.horaLocal,
            pedido.empleadoId,
            pedido.modalidad.texto,
            pedido.metodoPago.texto,
            pedido.estado.texto,
            pedido.subtotal,
            pedido.costoEmpaque,
            pedido.total,
            _resumenItems(pedido.items),
          ],
      ],
    );
  }

  _TablaExportacion _tablaGastos(List<Gasto> gastos) {
    return _TablaExportacion(
      encabezados: const [
        'ID',
        'Fecha',
        'Hora',
        'Concepto',
        'Categoría',
        'Observaciones',
        'Valor',
        'Usuario',
      ],
      filas: [
        for (final gasto in gastos)
          <Object>[
            gasto.id,
            gasto.fechaLocal,
            gasto.horaLocal,
            gasto.descripcion,
            gasto.categoria ?? '',
            gasto.observaciones ?? '',
            gasto.valor,
            gasto.usuarioId,
          ],
      ],
    );
  }

  _TablaExportacion _tablaCierres(List<CierreDiario> cierres) {
    return _TablaExportacion(
      encabezados: const [
        'ID',
        'Fecha',
        'Estado',
        'Pedidos',
        'Ventas',
        'Efectivo',
        'Transferencia',
        'Llevar',
        'Local',
        'Egresos',
        'Saldo neto',
        'Cerrado por',
      ],
      filas: [
        for (final cierre in cierres)
          <Object>[
            cierre.id,
            cierre.fechaLocal,
            cierre.estado.texto,
            cierre.totalPedidos,
            cierre.totalVentas,
            cierre.totalEfectivo,
            cierre.totalTransferencia,
            cierre.totalLlevar,
            cierre.totalLocal,
            cierre.totalEgresos,
            cierre.saldoNeto,
            cierre.cerradoPor ?? '',
          ],
      ],
    );
  }

  String _resumenItems(List<ItemPedido> items) {
    if (items.isEmpty) {
      return 'Sin ítems';
    }
    return items
        .map(
          (item) =>
              '${item.cantidad} x ${item.nombreProducto}'
              ' (${item.modalidad.texto}, '
              '${FormatoMoneda.cop(item.precioUnitario)} c/u, '
              'total ${FormatoMoneda.cop(item.total)})',
        )
        .join('; ');
  }

  Uint8List _crearXlsx(_TablaExportacion tabla) {
    final excel = Excel.createExcel();
    const hoja = 'Bantú';
    excel.rename('Sheet1', hoja);
    final destino = excel[hoja];
    destino.appendRow([
      for (final encabezado in tabla.encabezados) TextCellValue(encabezado),
    ]);
    for (final fila in tabla.filas) {
      destino.appendRow([
        for (final valor in fila)
          switch (valor) {
            final int numero => IntCellValue(numero),
            final String texto => TextCellValue(texto),
            _ => TextCellValue(valor.toString()),
          },
      ]);
    }
    final bytes = excel.encode();
    if (bytes == null) {
      throw StateError('No se pudo generar el archivo XLSX.');
    }
    return Uint8List.fromList(bytes);
  }

  Future<Uint8List> _crearPdf(
    _TablaExportacion tabla,
    ResumenFinanciero resumen,
    TipoExportacion tipo,
    String? desde,
    String? hasta,
  ) async {
    final documento = pw.Document();
    final rango = '${_segmento(desde)} a ${_segmento(hasta)}';
    final estiloTitulo = pw.TextStyle(
      fontSize: 22,
      fontWeight: pw.FontWeight.bold,
    );
    final estiloSeccion = pw.TextStyle(
      fontSize: 13,
      fontWeight: pw.FontWeight.bold,
    );
    final estiloCelda = pw.TextStyle(fontSize: 7);
    final estiloEncabezado = pw.TextStyle(
      fontSize: 8,
      fontWeight: pw.FontWeight.bold,
    );

    documento.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4.landscape,
        margin: const pw.EdgeInsets.all(24),
        build: (context) => [
          pw.Text('Bantú', style: estiloTitulo),
          pw.SizedBox(height: 4),
          pw.Text('Informe de ${tipo.texto}', style: estiloSeccion),
          pw.Text('Rango: $rango'),
          pw.SizedBox(height: 12),
          pw.Text('Resumen financiero', style: estiloSeccion),
          pw.SizedBox(height: 4),
          pw.TableHelper.fromTextArray(
            headers: const ['Indicador', 'Valor'],
            data: [
              ['Ingresos', FormatoMoneda.cop(resumen.ingresos)],
              ['Egresos', FormatoMoneda.cop(resumen.egresos)],
              ['Saldo neto', FormatoMoneda.cop(resumen.saldoNeto)],
              ['Efectivo en caja', FormatoMoneda.cop(resumen.efectivoEnCaja)],
            ],
            cellStyle: estiloCelda,
            headerStyle: estiloEncabezado,
          ),
          pw.SizedBox(height: 16),
          pw.Text('${tipo.texto} (${tabla.filas.length})', style: estiloSeccion),
          pw.SizedBox(height: 4),
          pw.TableHelper.fromTextArray(
            headers: tabla.encabezados,
            data: [
              for (final fila in tabla.filas)
                [for (final valor in fila) valor.toString()],
            ],
            cellStyle: estiloCelda,
            headerStyle: estiloEncabezado,
          ),
        ],
      ),
    );
    return documento.save();
  }

  void _validarRango(String? desde, String? hasta) {
    if (desde != null) {
      Validadores.fechaLocal(desde);
    }
    if (hasta != null) {
      Validadores.fechaLocal(hasta);
    }
    if (desde != null && hasta != null && desde.compareTo(hasta) > 0) {
      throw ArgumentError.value(
        desde,
        'desde',
        'La fecha desde no puede ser mayor que hasta.',
      );
    }
  }

  String _nombreArchivo(
    TipoExportacion tipo,
    FormatoExportacion formato,
    String? desde,
    String? hasta,
  ) {
    final nombre = 'bantu_${tipo.name}_${_segmento(desde)}_'
        '${_segmento(hasta)}.${formato.name}';
    return nombre.replaceAll(RegExp(r'[^a-zA-Z0-9._-]'), '_');
  }

  String _segmento(String? fecha) {
    final valor = fecha?.trim();
    if (valor == null || valor.isEmpty) {
      return 'todo';
    }
    final limpio = valor.replaceAll(RegExp(r'[^0-9-]'), '');
    return limpio.isEmpty ? 'todo' : limpio;
  }
}

class _TablaExportacion {
  final List<String> encabezados;
  final List<List<Object>> filas;

  const _TablaExportacion({required this.encabezados, required this.filas});
}
