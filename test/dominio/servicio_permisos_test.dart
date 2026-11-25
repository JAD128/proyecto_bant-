import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

Usuario usuario({
  Rol rol = Rol.empleado,
  bool activo = true,
  bool puedeVerTodosPedidos = false,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: 'u1',
    nombre: 'Usuario',
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    puedeVerTodosPedidos: puedeVerTodosPedidos,
    activo: activo,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  const permisos = ServicioPermisos();

  group('ServicioPermisos', () {
    test('administrador activo puede todo', () {
      final admin = usuario(rol: Rol.administrador);

      for (final accion in Accion.values) {
        expect(permisos.puede(admin, accion), isTrue, reason: accion.name);
      }
    });

    test('usuario inactivo no puede nada', () {
      final inactivo = usuario(rol: Rol.administrador, activo: false);

      expect(permisos.puede(inactivo, Accion.verMenu), isFalse);
      expect(permisos.puede(inactivo, Accion.crearPedido), isFalse);
    });

    test('empleado solo puede menu, pedidos e historial', () {
      final empleado = usuario();

      expect(permisos.puede(empleado, Accion.verMenu), isTrue);
      expect(permisos.puede(empleado, Accion.crearPedido), isTrue);
      expect(permisos.puede(empleado, Accion.verHistorial), isTrue);
      expect(permisos.puede(empleado, Accion.verTodosPedidos), isFalse);
      expect(permisos.puede(empleado, Accion.verFinanzas), isFalse);
      expect(permisos.puede(empleado, Accion.configurarUsuarios), isFalse);
    });

    test('empleado con permiso ve todos los pedidos', () {
      final empleado = usuario(puedeVerTodosPedidos: true);

      expect(permisos.puede(empleado, Accion.verTodosPedidos), isTrue);
      expect(permisos.puede(empleado, Accion.verFinanzas), isFalse);
    });

    test('verificar lanza StateError sin permiso', () {
      expect(
        () => permisos.verificar(usuario(), Accion.cerrarDia),
        throwsStateError,
      );
    });
  });
}
