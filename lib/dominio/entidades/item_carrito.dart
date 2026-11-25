import '../valores/modalidad_pedido.dart';
import 'producto.dart';

class ItemCarrito {
  final Producto producto;
  final int cantidad;
  final ModalidadPedido modalidad;

  const ItemCarrito({
    required this.producto,
    required this.cantidad,
    this.modalidad = ModalidadPedido.local,
  });
}
