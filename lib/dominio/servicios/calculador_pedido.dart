import '../entidades/item_carrito.dart';
import '../entidades/producto.dart';
import '../valores/estrategia_llevar.dart';
import '../valores/modalidad_pedido.dart';
import 'validadores.dart';

class ResultadoLinea {
  final Producto producto;
  final int cantidad;
  final ModalidadPedido modalidad;
  final int precioUnitario;
  final int costoEmpaqueUnitario;
  final int subtotal;
  final int total;

  const ResultadoLinea({
    required this.producto,
    required this.cantidad,
    required this.modalidad,
    required this.precioUnitario,
    required this.costoEmpaqueUnitario,
    required this.subtotal,
    required this.total,
  });
}

class ResultadoCalculoPedido {
  final List<ResultadoLinea> lineas;
  final int subtotal;
  final int costoEmpaque;
  final int total;

  const ResultadoCalculoPedido({
    required this.lineas,
    required this.subtotal,
    required this.costoEmpaque,
    required this.total,
  });
}

class CalculadorPedido {
  const CalculadorPedido();

  ResultadoCalculoPedido calcular(List<ItemCarrito> items) {
    if (items.isEmpty) {
      throw ArgumentError.value(items, 'items', 'El pedido debe tener productos.');
    }

    final vistos = <String>{};
    var subtotal = 0;
    var costoEmpaque = 0;
    final lineas = <ResultadoLinea>[];

    for (final item in items) {
      final producto = item.producto;
      if (item.cantidad <= 0) {
        throw ArgumentError.value(item.cantidad, 'cantidad', 'Debe ser mayor a cero.');
      }
      if (!producto.activo) {
        throw ArgumentError.value(producto.id, 'producto', 'El producto no está activo.');
      }
      if (!vistos.add(producto.id)) {
        throw ArgumentError.value(producto.id, 'producto', 'Producto duplicado en el carrito.');
      }

      Validadores.dinero(producto.precioLocal, 'precioLocal');
      Validadores.dinero(producto.costoEmpaque, 'costoEmpaque');

      late final int precioUnitario;
      late final int empaqueUnitario;

      if (item.modalidad == ModalidadPedido.local) {
        precioUnitario = producto.precioLocal;
        empaqueUnitario = 0;
      } else if (producto.estrategiaLlevar == EstrategiaLlevar.precioFijo) {
        final precioLlevar = producto.precioLlevar;
        if (precioLlevar == null) {
          throw ArgumentError.value(
            producto.id,
            'precioLlevar',
            'Falta el precio para llevar con estrategia precioFijo.',
          );
        }
        Validadores.dinero(precioLlevar, 'precioLlevar');
        precioUnitario = precioLlevar;
        empaqueUnitario = 0;
      } else {
        precioUnitario = producto.precioLocal;
        empaqueUnitario = producto.costoEmpaque;
      }

      final subtotalLinea = item.cantidad * precioUnitario;
      final empaqueLinea = item.cantidad * empaqueUnitario;
      subtotal += subtotalLinea;
      costoEmpaque += empaqueLinea;

      lineas.add(
        ResultadoLinea(
          producto: producto,
          cantidad: item.cantidad,
          modalidad: item.modalidad,
          precioUnitario: precioUnitario,
          costoEmpaqueUnitario: empaqueUnitario,
          subtotal: subtotalLinea,
          total: subtotalLinea + empaqueLinea,
        ),
      );
    }

    return ResultadoCalculoPedido(
      lineas: lineas,
      subtotal: subtotal,
      costoEmpaque: costoEmpaque,
      total: subtotal + costoEmpaque,
    );
  }
}
