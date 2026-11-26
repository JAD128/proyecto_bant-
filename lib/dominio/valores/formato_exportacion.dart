enum FormatoExportacion {
  xlsx,
  pdf,
}

extension FormatoExportacionExtension on FormatoExportacion {
  String get texto => switch (this) {
    FormatoExportacion.xlsx => 'XLSX',
    FormatoExportacion.pdf => 'PDF',
  };
}

FormatoExportacion formatoExportacionDesdeTexto(String valor) =>
    FormatoExportacion.values.byName(valor);
