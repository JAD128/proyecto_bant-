class Gasto {
  final String id;
  final String descripcion;
  final int valor;
  final String fechaLocal;
  final String horaLocal;
  final String? categoria;
  final String? observaciones;
  final String usuarioId;
  final DateTime creadoEn;

  const Gasto({
    required this.id,
    required this.descripcion,
    required this.valor,
    required this.fechaLocal,
    required this.horaLocal,
    this.categoria,
    this.observaciones,
    required this.usuarioId,
    required this.creadoEn,
  });
}
