import '../../dominio/entidades/categoria.dart';

abstract class CategoriaRepositorio {
  Future<List<Categoria>> obtenerTodas();

  Future<List<Categoria>> obtenerActivas();

  Future<Categoria?> obtenerPorId(String id);

  Future<void> guardar(Categoria categoria);

  Future<void> actualizar(Categoria categoria);

  Future<void> desactivar(String id);
}
