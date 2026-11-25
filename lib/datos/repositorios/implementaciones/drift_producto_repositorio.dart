import 'package:drift/drift.dart';

import '../../../dominio/entidades/producto.dart';
import '../../../dominio/valores/estrategia_llevar.dart';
import '../../bd/bantu_database.dart' as bd;
import '../producto_repositorio.dart';

class DriftProductoRepositorio implements ProductoRepositorio {
  final bd.BantuDatabase _base;

  const DriftProductoRepositorio(this._base);

  @override
  Future<List<Producto>> obtenerTodos() async {
    final filas = await _base.productoDao.todos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<List<Producto>> obtenerActivos() async {
    final filas = await _base.productoDao.activos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<List<Producto>> obtenerPorCategoria(String categoriaId) async {
    final filas = await _base.productoDao.porCategoria(categoriaId);
    return filas.map(_mapear).toList();
  }

  @override
  Future<Producto?> obtenerPorId(String id) async {
    final fila = await _base.productoDao.porId(id);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<void> guardar(Producto producto) {
    return _base.productoDao.insertar(
      bd.ProductosCompanion.insert(
        id: producto.id,
        categoriaId: producto.categoriaId,
        nombre: producto.nombre,
        descripcion: Value(producto.descripcion),
        precioLocal: producto.precioLocal,
        precioLlevar: Value(producto.precioLlevar),
        costoEmpaque: Value(producto.costoEmpaque),
        estrategiaLlevar: producto.estrategiaLlevar.texto,
        imagenPath: Value(producto.imagenPath),
        activo: Value(producto.activo),
        creadoEn: producto.creadoEn,
        actualizadoEn: producto.actualizadoEn,
      ),
    );
  }

  @override
  Future<void> actualizar(Producto producto) {
    return _base.productoDao.actualizar(
      bd.ProductosCompanion(
        id: Value(producto.id),
        categoriaId: Value(producto.categoriaId),
        nombre: Value(producto.nombre),
        descripcion: Value(producto.descripcion),
        precioLocal: Value(producto.precioLocal),
        precioLlevar: Value(producto.precioLlevar),
        costoEmpaque: Value(producto.costoEmpaque),
        estrategiaLlevar: Value(producto.estrategiaLlevar.texto),
        imagenPath: Value(producto.imagenPath),
        activo: Value(producto.activo),
        creadoEn: Value(producto.creadoEn),
        actualizadoEn: Value(producto.actualizadoEn),
      ),
    );
  }

  @override
  Future<void> desactivar(String id) async {
    final producto = await obtenerPorId(id);
    if (producto == null) {
      throw StateError('Producto no encontrado: $id');
    }
    await actualizar(
      Producto(
        id: producto.id,
        categoriaId: producto.categoriaId,
        nombre: producto.nombre,
        descripcion: producto.descripcion,
        precioLocal: producto.precioLocal,
        precioLlevar: producto.precioLlevar,
        costoEmpaque: producto.costoEmpaque,
        estrategiaLlevar: producto.estrategiaLlevar,
        imagenPath: producto.imagenPath,
        activo: false,
        creadoEn: producto.creadoEn,
        actualizadoEn: DateTime.now(),
      ),
    );
  }

  Producto _mapear(dynamic fila) {
    return Producto(
      id: fila.id as String,
      categoriaId: fila.categoriaId as String,
      nombre: fila.nombre as String,
      descripcion: fila.descripcion as String?,
      precioLocal: fila.precioLocal as int,
      precioLlevar: fila.precioLlevar as int?,
      costoEmpaque: fila.costoEmpaque as int,
      estrategiaLlevar: estrategiaLlevarDesdeTexto(fila.estrategiaLlevar as String),
      imagenPath: fila.imagenPath as String?,
      activo: fila.activo as bool,
      creadoEn: fila.creadoEn as DateTime,
      actualizadoEn: fila.actualizadoEn as DateTime,
    );
  }
}
