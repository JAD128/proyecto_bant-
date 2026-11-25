enum EstrategiaLlevar {
  precioFijo,
  baseMasEmpaque,
}

extension EstrategiaLlevarExtension on EstrategiaLlevar {
  String get texto => name;
}

EstrategiaLlevar estrategiaLlevarDesdeTexto(String valor) => EstrategiaLlevar.values.byName(valor);
