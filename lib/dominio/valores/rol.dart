enum Rol {
  administrador,
  empleado,
}

extension RolExtension on Rol {
  String get texto => name;
}

Rol rolDesdeTexto(String valor) => Rol.values.byName(valor);
