import 'package:drift/drift.dart';

import '../../../dominio/entidades/categoria.dart';
import '../../bd/bantu_database.dart' as bd;
import '../categoria_repositorio.dart';

class DriftCategoriaRepositorio implements CategoriaRepositorio {
  final bd.BantuDatabase _base;

  const DriftCategoriaRepositorio(this._base);

  @override
  Future<List<Categoria>> obtenerTodas() async {
    final filas = await _base.categoriaDao.todos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<List<Categoria>> obtenerActivas() async {
    final filas = await _base.categoriaDao.activas();
    return filas.map(_mapear).toList();
  }

  @override
  Future<Categoria?> obtenerPorId(String id) async {
    final fila = await _base.categoriaDao.porId(id);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<void> guardar(Categoria categoria) {
    return _base.categoriaDao.insertar(
      bd.CategoriasCompanion.insert(
        id: categoria.id,
        nombre: categoria.nombre,
        activa: Value(categoria.activa),
        orden: Value(categoria.orden),
        creadoEn: categoria.creadoEn,
      ),
    );
  }

  @override
  Future<void> actualizar(Categoria categoria) {
    return _base.categoriaDao.actualizar(
      bd.CategoriasCompanion(
        id: Value(categoria.id),
        nombre: Value(categoria.nombre),
        activa: Value(categoria.activa),
        orden: Value(categoria.orden),
        creadoEn: Value(categoria.creadoEn),
      ),
    );
  }

  Categoria _mapear(dynamic fila) {
    return Categoria(
      id: fila.id as String,
      nombre: fila.nombre as String,
      activa: fila.activa as bool,
      orden: fila.orden as int,
      creadoEn: fila.creadoEn as DateTime,
    );
  }
}
