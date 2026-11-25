class Categoria {
  final String id;
  final String nombre;
  final bool activa;
  final int orden;
  final DateTime creadoEn;

  const Categoria({
    required this.id,
    required this.nombre,
    this.activa = true,
    this.orden = 0,
    required this.creadoEn,
  });
}
