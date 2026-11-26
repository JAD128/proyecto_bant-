import '../../datos/repositorios/pedido_repositorio.dart';
import '../entidades/pedido.dart';
import '../entidades/usuario.dart';
import '../valores/estado_pedido.dart';
import '../valores/modalidad_pedido.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioHistorial {
  final PedidoRepositorio _pedidos;
  final ServicioPermisos _permisos;

  const ServicioHistorial({required this._pedidos, required this._permisos});

  Future<List<Pedido>> consultar(
    Usuario usuarioActivo, {
    String? desde,
    String? hasta,
    String? empleadoId,
    EstadoPedido? estado,
    ModalidadPedido? modalidad,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.verHistorial);
    _validarRango(desde, hasta);

    final puedeVerTodos = _permisos.puede(
      usuarioActivo,
      Accion.verTodosPedidos,
    );
    final filtroEmpleado = _filtroEmpleado(
      usuarioActivo,
      puedeVerTodos,
      empleadoId,
    );

    final pedidos = await _pedidos.obtenerTodos();
    final resultado = pedidos.where((pedido) {
      if (filtroEmpleado != null && pedido.empleadoId != filtroEmpleado) {
        return false;
      }
      if (desde != null && pedido.fechaLocal.compareTo(desde) < 0) {
        return false;
      }
      if (hasta != null && pedido.fechaLocal.compareTo(hasta) > 0) {
        return false;
      }
      if (estado != null && pedido.estado != estado) {
        return false;
      }
      if (modalidad != null && pedido.modalidad != modalidad) {
        return false;
      }
      return true;
    }).toList();

    resultado.sort((a, b) {
      final porFecha = b.fechaLocal.compareTo(a.fechaLocal);
      if (porFecha != 0) {
        return porFecha;
      }
      final porHora = b.horaLocal.compareTo(a.horaLocal);
      if (porHora != 0) {
        return porHora;
      }
      return b.creadoEn.compareTo(a.creadoEn);
    });

    return List.unmodifiable(resultado);
  }

  Future<Pedido?> detalle(Usuario usuarioActivo, String pedidoId) async {
    _permisos.verificar(usuarioActivo, Accion.verHistorial);

    final pedido = await _pedidos.obtenerPorId(pedidoId);
    if (pedido == null) {
      return null;
    }
    if (!_permisos.puede(usuarioActivo, Accion.verTodosPedidos) &&
        pedido.empleadoId != usuarioActivo.id) {
      throw StateError('No tienes permiso para ver este pedido.');
    }
    return pedido;
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

  String? _filtroEmpleado(
    Usuario usuarioActivo,
    bool puedeVerTodos,
    String? empleadoId,
  ) {
    if (!puedeVerTodos) {
      if (empleadoId != null && empleadoId.trim() != usuarioActivo.id) {
        throw StateError(
          'No tienes permiso para ver pedidos de otro empleado.',
        );
      }
      return usuarioActivo.id;
    }
    final filtro = empleadoId?.trim();
    return filtro == null || filtro.isEmpty ? null : filtro;
  }
}
