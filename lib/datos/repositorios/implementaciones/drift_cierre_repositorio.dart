import 'package:drift/drift.dart';

import '../../../dominio/entidades/cierre_diario.dart';
import '../../../dominio/valores/estado_cierre.dart';
import '../../bd/bantu_database.dart' as bd;
import '../cierre_repositorio.dart';

class DriftCierreRepositorio implements CierreRepositorio {
  final bd.BantuDatabase _base;

  const DriftCierreRepositorio(this._base);

  @override
  Future<List<CierreDiario>> obtenerTodos() async {
    final filas = await _base.cierreDao.todos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<CierreDiario?> obtenerPorFecha(String fechaLocal) async {
    final fila = await _base.cierreDao.porFecha(fechaLocal);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<List<CierreAuditoria>> obtenerAuditorias(String cierreId) async {
    final filas = await _base.cierreDao.auditoriasDeCierre(cierreId);
    return filas.map(_mapearAuditoria).toList();
  }

  @override
  Future<void> guardar(CierreDiario cierre) {
    return _base.cierreDao.insertar(
      bd.CierresDiariosCompanion.insert(
        id: cierre.id,
        fechaLocal: cierre.fechaLocal,
        estado: cierre.estado.texto,
        totalPedidos: cierre.totalPedidos,
        totalVentas: cierre.totalVentas,
        totalEfectivo: cierre.totalEfectivo,
        totalTransferencia: cierre.totalTransferencia,
        totalLlevar: cierre.totalLlevar,
        totalLocal: cierre.totalLocal,
        totalEgresos: cierre.totalEgresos,
        saldoNeto: cierre.saldoNeto,
        cerradoPor: Value(cierre.cerradoPor),
        creadoEn: cierre.creadoEn,
        cerradoEn: Value(cierre.cerradoEn),
      ),
    );
  }

  @override
  Future<void> actualizar(CierreDiario cierre) {
    return _base.cierreDao.actualizar(
      bd.CierresDiariosCompanion(
        id: Value(cierre.id),
        fechaLocal: Value(cierre.fechaLocal),
        estado: Value(cierre.estado.texto),
        totalPedidos: Value(cierre.totalPedidos),
        totalVentas: Value(cierre.totalVentas),
        totalEfectivo: Value(cierre.totalEfectivo),
        totalTransferencia: Value(cierre.totalTransferencia),
        totalLlevar: Value(cierre.totalLlevar),
        totalLocal: Value(cierre.totalLocal),
        totalEgresos: Value(cierre.totalEgresos),
        saldoNeto: Value(cierre.saldoNeto),
        cerradoPor: Value(cierre.cerradoPor),
        creadoEn: Value(cierre.creadoEn),
        cerradoEn: Value(cierre.cerradoEn),
      ),
    );
  }

  @override
  Future<void> auditar(CierreAuditoria auditoria) {
    return _base.cierreDao.insertarAuditoria(
      bd.CierreAuditoriasCompanion.insert(
        id: auditoria.id,
        cierreId: auditoria.cierreId,
        motivo: auditoria.motivo,
        valoresAntes: auditoria.valoresAntes,
        valoresDespues: auditoria.valoresDespues,
        usuarioId: auditoria.usuarioId,
        creadoEn: auditoria.creadoEn,
      ),
    );
  }

  CierreDiario _mapear(dynamic fila) {
    return CierreDiario(
      id: fila.id as String,
      fechaLocal: fila.fechaLocal as String,
      estado: estadoCierreDesdeTexto(fila.estado as String),
      totalPedidos: fila.totalPedidos as int,
      totalVentas: fila.totalVentas as int,
      totalEfectivo: fila.totalEfectivo as int,
      totalTransferencia: fila.totalTransferencia as int,
      totalLlevar: fila.totalLlevar as int,
      totalLocal: fila.totalLocal as int,
      totalEgresos: fila.totalEgresos as int,
      saldoNeto: fila.saldoNeto as int,
      cerradoPor: fila.cerradoPor as String?,
      creadoEn: fila.creadoEn as DateTime,
      cerradoEn: fila.cerradoEn as DateTime?,
    );
  }

  CierreAuditoria _mapearAuditoria(dynamic fila) {
    return CierreAuditoria(
      id: fila.id as String,
      cierreId: fila.cierreId as String,
      motivo: fila.motivo as String,
      valoresAntes: fila.valoresAntes as String,
      valoresDespues: fila.valoresDespues as String,
      usuarioId: fila.usuarioId as String,
      creadoEn: fila.creadoEn as DateTime,
    );
  }
}
