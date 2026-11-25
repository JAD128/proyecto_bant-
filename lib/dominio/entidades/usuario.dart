import '../valores/rol.dart';

class Usuario {
  final String id;
  final String nombre;
  final String pinHash;
  final String pinSalt;
  final Rol rol;
  final bool puedeVerTodosPedidos;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;

  const Usuario({
    required this.id,
    required this.nombre,
    required this.pinHash,
    required this.pinSalt,
    required this.rol,
    this.puedeVerTodosPedidos = false,
    this.activo = true,
    required this.creadoEn,
    required this.actualizadoEn,
  });
}
