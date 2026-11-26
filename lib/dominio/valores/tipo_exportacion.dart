enum TipoExportacion {
  pedidos,
  gastos,
  cierres,
}

extension TipoExportacionExtension on TipoExportacion {
  String get texto => switch (this) {
    TipoExportacion.pedidos => 'Pedidos',
    TipoExportacion.gastos => 'Gastos',
    TipoExportacion.cierres => 'Cierres',
  };
}

TipoExportacion tipoExportacionDesdeTexto(String valor) =>
    TipoExportacion.values.byName(valor);
