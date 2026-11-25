import 'package:drift/drift.dart';

import '../../../dominio/entidades/gasto.dart';
import '../../bd/bantu_database.dart' as bd;
import '../gasto_repositorio.dart';

class DriftGastoRepositorio implements GastoRepositorio {
  final bd.BantuDatabase _base;

  const DriftGastoRepositorio(this._base);

  @override
  Future<List<Gasto>> obtenerTodos() async {
    final filas = await _base.gastoDao.todos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<List<Gasto>> obtenerPorFecha(String fechaLocal) async {
    final filas = await _base.gastoDao.porFecha(fechaLocal);
    return filas.map(_mapear).toList();
  }

  @override
  Future<Gasto?> obtenerPorId(String id) async {
    final fila = await _base.gastoDao.porId(id);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<void> guardar(Gasto gasto) {
    return _base.gastoDao.insertar(
      bd.GastosCompanion.insert(
        id: gasto.id,
        descripcion: gasto.descripcion,
        valor: gasto.valor,
        fechaLocal: gasto.fechaLocal,
        horaLocal: gasto.horaLocal,
        categoria: Value(gasto.categoria),
        observaciones: Value(gasto.observaciones),
        usuarioId: gasto.usuarioId,
        creadoEn: gasto.creadoEn,
      ),
    );
  }

  @override
  Future<void> actualizar(Gasto gasto) {
    return _base.gastoDao.actualizar(
      bd.GastosCompanion(
        id: Value(gasto.id),
        descripcion: Value(gasto.descripcion),
        valor: Value(gasto.valor),
        fechaLocal: Value(gasto.fechaLocal),
        horaLocal: Value(gasto.horaLocal),
        categoria: Value(gasto.categoria),
        observaciones: Value(gasto.observaciones),
        usuarioId: Value(gasto.usuarioId),
        creadoEn: Value(gasto.creadoEn),
      ),
    );
  }

  Gasto _mapear(dynamic fila) {
    return Gasto(
      id: fila.id as String,
      descripcion: fila.descripcion as String,
      valor: fila.valor as int,
      fechaLocal: fila.fechaLocal as String,
      horaLocal: fila.horaLocal as String,
      categoria: fila.categoria as String?,
      observaciones: fila.observaciones as String?,
      usuarioId: fila.usuarioId as String,
      creadoEn: fila.creadoEn as DateTime,
    );
  }
}
