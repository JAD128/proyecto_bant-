import '../../dominio/entidades/usuario.dart';

abstract class UsuarioRepositorio {
  Future<List<Usuario>> obtenerTodos();

  Future<Usuario?> obtenerPorId(String id);

  Future<Usuario?> obtenerPorNombre(String nombre);

  Future<void> guardar(Usuario usuario);

  Future<void> actualizar(Usuario usuario);
}
