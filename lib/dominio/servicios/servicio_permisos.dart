import '../entidades/usuario.dart';
import '../valores/rol.dart';

enum Accion {
  verMenu,
  crearPedido,
  verHistorial,
  verTodosPedidos,
  crearProducto,
  editarProducto,
  desactivarProducto,
  crearCategoria,
  editarCategoria,
  desactivarCategoria,
  verFinanzas,
  registrarGasto,
  cerrarDia,
  exportarInformes,
  configurarUsuarios,
}

class ServicioPermisos {
  const ServicioPermisos();

  bool puede(Usuario usuario, Accion accion) {
    if (!usuario.activo) {
      return false;
    }
    if (usuario.rol == Rol.administrador) {
      return true;
    }

    switch (accion) {
      case Accion.verMenu:
      case Accion.crearPedido:
      case Accion.verHistorial:
        return true;
      case Accion.verTodosPedidos:
        return usuario.puedeVerTodosPedidos;
      default:
        return false;
    }
  }

  void verificar(Usuario usuario, Accion accion) {
    if (!puede(usuario, accion)) {
      throw StateError('El usuario no tiene permiso para ${accion.name}.');
    }
  }
}
