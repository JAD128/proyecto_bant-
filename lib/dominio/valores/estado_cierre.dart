enum EstadoCierre {
  abierto,
  cerrado,
}

extension EstadoCierreExtension on EstadoCierre {
  String get texto => name;
}

EstadoCierre estadoCierreDesdeTexto(String valor) => EstadoCierre.values.byName(valor);
