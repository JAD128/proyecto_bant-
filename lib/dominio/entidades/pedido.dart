import '../valores/estado_pedido.dart';
import '../valores/metodo_pago.dart';
import '../valores/modalidad_pedido.dart';

class ItemPedido {
  final String id;
  final String productoId;
  final String nombreProducto;
  final String categoriaNombre;
  final int cantidad;
  final ModalidadPedido modalidad;
  final int precioUnitario;
  final int costoEmpaqueUnitario;
  final int subtotal;
  final int total;

  const ItemPedido({
    required this.id,
    required this.productoId,
    required this.nombreProducto,
    required this.categoriaNombre,
    required this.cantidad,
    required this.modalidad,
    required this.precioUnitario,
    required this.costoEmpaqueUnitario,
    required this.subtotal,
    required this.total,
  });
}

class Pedido {
  final String id;
  final String idempotenciaKey;
  final String empleadoId;
  final String fechaLocal;
  final String horaLocal;
  final DateTime creadoEn;
  final ModalidadPedido modalidad;
  final MetodoPago metodoPago;
  final EstadoPedido estado;
  final int subtotal;
  final int costoEmpaque;
  final int total;
  final String? motivoAnulacion;
  final List<ItemPedido> items;

  const Pedido({
    required this.id,
    required this.idempotenciaKey,
    required this.empleadoId,
    required this.fechaLocal,
    required this.horaLocal,
    required this.creadoEn,
    required this.modalidad,
    required this.metodoPago,
    this.estado = EstadoPedido.confirmado,
    required this.subtotal,
    required this.costoEmpaque,
    required this.total,
    this.motivoAnulacion,
    this.items = const [],
  });
}
