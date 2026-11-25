import '../../dominio/entidades/pedido.dart';

abstract class PedidoRepositorio {
  Future<void> guardar(Pedido pedido);

  Future<Pedido?> obtenerPorId(String id);

  Future<List<Pedido>> obtenerTodos();

  Future<List<Pedido>> obtenerPorFecha(String fechaLocal);

  Future<List<Pedido>> obtenerPorEmpleado(String empleadoId);

  Future<void> anular({
    required String pedidoId,
    required String motivo,
    required String usuarioId,
  });
}
