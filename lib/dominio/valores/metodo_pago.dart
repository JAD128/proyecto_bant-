enum MetodoPago {
  efectivo,
  transferencia,
}

extension MetodoPagoExtension on MetodoPago {
  String get texto => name;
}

MetodoPago metodoPagoDesdeTexto(String valor) => MetodoPago.values.byName(valor);
