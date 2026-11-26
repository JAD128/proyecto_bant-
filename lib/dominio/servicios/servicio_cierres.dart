import 'dart:convert';

import '../../datos/repositorios/cierre_repositorio.dart';
import '../../datos/repositorios/gasto_repositorio.dart';
import '../../datos/repositorios/pedido_repositorio.dart';
import '../../utilidades/generador_ids.dart';
import '../entidades/cierre_diario.dart';
import '../entidades/usuario.dart';
import '../valores/estado_cierre.dart';
import 'calculador_finanzas.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioCierres {
  final CierreRepositorio _cierres;
  final PedidoRepositorio _pedidos;
  final GastoRepositorio _gastos;
  final CalculadorFinanzas _calculador;
  final ServicioPermisos _permisos;

  const ServicioCierres({
    required this._cierres,
    required this._pedidos,
    required this._gastos,
    required this._calculador,
    required this._permisos,
  });

  Future<CierreDiario> cerrarDia({
    required Usuario usuarioActivo,
    required String fechaLocal,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.cerrarDia);
    Validadores.fechaLocal(fechaLocal);

    final existente = await _cierres.obtenerPorFecha(fechaLocal);
    if (existente != null) {
      throw StateError('Ya existe un cierre para esa fecha.');
    }

    final resumen = await _resumen(fechaLocal);
    final ahora = DateTime.now();
    await _cierres.guardar(
      CierreDiario(
        id: GeneradorIds.nuevo(),
        fechaLocal: fechaLocal,
        estado: EstadoCierre.cerrado,
        totalPedidos: resumen.cantidadPedidos,
        totalVentas: resumen.ingresos,
        totalEfectivo: resumen.ingresosEfectivo,
        totalTransferencia: resumen.ingresosTransferencia,
        totalLlevar: resumen.ingresosLlevar,
        totalLocal: resumen.ingresosLocal,
        totalEgresos: resumen.egresos,
        saldoNeto: resumen.saldoNeto,
        cerradoPor: usuarioActivo.id,
        creadoEn: ahora,
        cerradoEn: ahora,
      ),
    );

    final guardado = await _cierres.obtenerPorFecha(fechaLocal);
    if (guardado == null) {
      throw StateError('No se pudo leer el cierre guardado.');
    }
    return guardado;
  }

  Future<CierreDiario> corregir({
    required Usuario usuarioActivo,
    required String cierreId,
    required String motivo,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.cerrarDia);
    Validadores.texto(motivo, 'motivo', max: 500);

    final cierres = await _cierres.obtenerTodos();
    final anterior = cierres
        .where((cierre) => cierre.id == cierreId)
        .firstOrNull;
    if (anterior == null) {
      throw StateError('Cierre no encontrado.');
    }

    final resumen = await _resumen(anterior.fechaLocal);
    final actualizado = CierreDiario(
      id: anterior.id,
      fechaLocal: anterior.fechaLocal,
      estado: EstadoCierre.cerrado,
      totalPedidos: resumen.cantidadPedidos,
      totalVentas: resumen.ingresos,
      totalEfectivo: resumen.ingresosEfectivo,
      totalTransferencia: resumen.ingresosTransferencia,
      totalLlevar: resumen.ingresosLlevar,
      totalLocal: resumen.ingresosLocal,
      totalEgresos: resumen.egresos,
      saldoNeto: resumen.saldoNeto,
      cerradoPor: anterior.cerradoPor,
      creadoEn: anterior.creadoEn,
      cerradoEn: anterior.cerradoEn,
    );

    await _cierres.auditar(
      CierreAuditoria(
        id: GeneradorIds.nuevo(),
        cierreId: anterior.id,
        motivo: motivo.trim(),
        valoresAntes: _valores(anterior),
        valoresDespues: _valores(actualizado),
        usuarioId: usuarioActivo.id,
        creadoEn: DateTime.now(),
      ),
    );
    await _cierres.actualizar(actualizado);
    return actualizado;
  }

  Future<List<CierreDiario>> obtenerTodos(Usuario usuarioActivo) async {
    _verificarConsulta(usuarioActivo);
    return _cierres.obtenerTodos();
  }

  Future<CierreDiario?> obtenerPorFecha(
    Usuario usuarioActivo,
    String fechaLocal,
  ) async {
    _verificarConsulta(usuarioActivo);
    return _cierres.obtenerPorFecha(fechaLocal);
  }

  Future<List<CierreAuditoria>> obtenerAuditorias(
    Usuario usuarioActivo,
    String cierreId,
  ) async {
    _verificarConsulta(usuarioActivo);
    return _cierres.obtenerAuditorias(cierreId);
  }

  void _verificarConsulta(Usuario usuarioActivo) {
    if (!_permisos.puede(usuarioActivo, Accion.verFinanzas) &&
        !_permisos.puede(usuarioActivo, Accion.cerrarDia)) {
      throw StateError('El usuario no tiene permiso para consultar cierres.');
    }
  }

  Future<ResumenFinanciero> _resumen(String fechaLocal) async {
    final pedidos = await _pedidos.obtenerPorFecha(fechaLocal);
    final gastos = await _gastos.obtenerPorFecha(fechaLocal);
    return _calculador.calcular(pedidos: pedidos, gastos: gastos);
  }

  String _valores(CierreDiario cierre) => jsonEncode(<String, Object?>{
    'fechaLocal': cierre.fechaLocal,
    'estado': cierre.estado.texto,
    'totalPedidos': cierre.totalPedidos,
    'totalVentas': cierre.totalVentas,
    'totalEfectivo': cierre.totalEfectivo,
    'totalTransferencia': cierre.totalTransferencia,
    'totalLlevar': cierre.totalLlevar,
    'totalLocal': cierre.totalLocal,
    'totalEgresos': cierre.totalEgresos,
    'saldoNeto': cierre.saldoNeto,
  });
}
