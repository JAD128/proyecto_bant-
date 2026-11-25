enum EstadoPedido {
  confirmado,
  anulado,
}

extension EstadoPedidoExtension on EstadoPedido {
  String get texto => name;
}

EstadoPedido estadoPedidoDesdeTexto(String valor) => EstadoPedido.values.byName(valor);
