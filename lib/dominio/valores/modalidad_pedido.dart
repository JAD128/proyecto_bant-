enum ModalidadPedido {
  local,
  llevar,
}

extension ModalidadPedidoExtension on ModalidadPedido {
  String get texto => name;
}

ModalidadPedido modalidadDesdeTexto(String valor) => ModalidadPedido.values.byName(valor);
