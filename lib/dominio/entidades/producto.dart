import '../valores/estrategia_llevar.dart';

class Producto {
  final String id;
  final String categoriaId;
  final String nombre;
  final String? descripcion;
  final int precioLocal;
  final int? precioLlevar;
  final int costoEmpaque;
  final EstrategiaLlevar estrategiaLlevar;
  final String? imagenPath;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;

  const Producto({
    required this.id,
    required this.categoriaId,
    required this.nombre,
    this.descripcion,
    required this.precioLocal,
    this.precioLlevar,
    this.costoEmpaque = 0,
    this.estrategiaLlevar = EstrategiaLlevar.baseMasEmpaque,
    this.imagenPath,
    this.activo = true,
    required this.creadoEn,
    required this.actualizadoEn,
  });
}
