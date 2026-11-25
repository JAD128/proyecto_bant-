import '../../dominio/entidades/producto.dart';

abstract class ProductoRepositorio {
  Future<List<Producto>> obtenerTodos();

  Future<List<Producto>> obtenerActivos();

  Future<List<Producto>> obtenerPorCategoria(String categoriaId);

  Future<Producto?> obtenerPorId(String id);

  Future<void> guardar(Producto producto);

  Future<void> actualizar(Producto producto);

  Future<void> desactivar(String id);
}
