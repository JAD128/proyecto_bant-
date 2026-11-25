import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/pin_hasher.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/servicios/servicio_usuarios.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';

ServicioUsuarios crearServicio(
  UsuarioRepositorioMemoria usuarios,
  SesionMemoria sesion,
) {
  return ServicioUsuarios(
    usuarios: usuarios,
    sesion: sesion,
    hasher: const PinHasher(),
    permisos: const ServicioPermisos(),
  );
}

Future<Usuario> configurarAdmin(
  ServicioUsuarios servicio,
  UsuarioRepositorioMemoria usuarios,
) async {
  await servicio.configurarAdministrador(
    nombre: 'Admin',
    pin: '1234',
    confirmacion: '1234',
  );
  return (await usuarios.obtenerTodos()).first;
}

void main() {
  group('ServicioUsuarios', () {
    test('configura el administrador una sola vez', () async {
      final usuarios = UsuarioRepositorioMemoria();
      final sesion = SesionMemoria();
      final servicio = crearServicio(usuarios, sesion);

      expect(await servicio.configuracionInicialCompleta(), isFalse);
      final admin = await configurarAdmin(servicio, usuarios);

      expect(admin.rol, Rol.administrador);
      expect(admin.nombre, 'Admin');
      expect(admin.pinHash, isNot('1234'));
      expect(await servicio.configuracionInicialCompleta(), isTrue);
      expect(
        servicio.configurarAdministrador(
          nombre: 'Otro',
          pin: '9999',
          confirmacion: '9999',
        ),
        throwsStateError,
      );
    });

    test('rechaza PIN y confirmación distintos', () async {
      final servicio = crearServicio(
        UsuarioRepositorioMemoria(),
        SesionMemoria(),
      );

      expect(
        servicio.configurarAdministrador(
          nombre: 'Admin',
          pin: '1234',
          confirmacion: '1235',
        ),
        throwsArgumentError,
      );
    });

    test('inicia sesión sin distinguir mayúsculas y guarda la sesión', () async {
      final usuarios = UsuarioRepositorioMemoria();
      final sesion = SesionMemoria();
      final servicio = crearServicio(usuarios, sesion);
      final admin = await configurarAdmin(servicio, usuarios);

      final autenticado = await servicio.iniciarSesion(
        nombre: 'admin',
        pin: '1234',
      );

      expect(autenticado.id, admin.id);
      expect(sesion.usuarioActivoId, admin.id);
      expect(
        servicio.iniciarSesion(nombre: 'Admin', pin: '0000'),
        throwsStateError,
      );
    });

    test('no permite iniciar sesión con usuario inactivo', () async {
      final usuarios = UsuarioRepositorioMemoria();
      final sesion = SesionMemoria();
      final servicio = crearServicio(usuarios, sesion);
      await configurarAdmin(servicio, usuarios);

      await servicio.crearEmpleado(
        usuarioActivo: (await usuarios.obtenerTodos()).first,
        nombre: 'Mesero',
        pin: '5678',
      );
      final mesero = (await usuarios.obtenerTodos()).firstWhere(
        (u) => u.nombre == 'Mesero',
      );
      await usuarios.actualizar(
        Usuario(
          id: mesero.id,
          nombre: mesero.nombre,
          pinHash: mesero.pinHash,
          pinSalt: mesero.pinSalt,
          rol: mesero.rol,
          activo: false,
          creadoEn: mesero.creadoEn,
          actualizadoEn: mesero.actualizadoEn,
        ),
      );

      expect(
        servicio.iniciarSesion(nombre: 'Mesero', pin: '5678'),
        throwsStateError,
      );
    });

    test('usuario activo inexistente cierra la sesión', () async {
      final sesion = SesionMemoria()..usuarioActivoId = 'no-existe';
      final servicio = crearServicio(UsuarioRepositorioMemoria(), sesion);

      expect(await servicio.usuarioActivo(), isNull);
      expect(sesion.usuarioActivoId, isNull);
    });

    test('crea empleados y valida permisos del administrador', () async {
      final usuarios = UsuarioRepositorioMemoria();
      final sesion = SesionMemoria();
      final servicio = crearServicio(usuarios, sesion);
      final admin = await configurarAdmin(servicio, usuarios);

      final empleado = await servicio.crearEmpleado(
        usuarioActivo: admin,
        nombre: 'Mesero',
        pin: '5678',
        puedeVerTodosPedidos: true,
      );

      expect(empleado.rol, Rol.empleado);
      expect(empleado.puedeVerTodosPedidos, isTrue);
      expect(await servicio.obtenerUsuarios(admin), hasLength(2));
      expect(
        servicio.crearEmpleado(
          usuarioActivo: admin,
          nombre: 'Mesero',
          pin: '1111',
        ),
        throwsStateError,
      );
      expect(
        servicio.crearEmpleado(
          usuarioActivo: empleado,
          nombre: 'Cocinero',
          pin: '2222',
        ),
        throwsStateError,
      );
    });

    test('actualiza permisos de empleados sin permitir autocambio', () async {
      final usuarios = UsuarioRepositorioMemoria();
      final servicio = crearServicio(usuarios, SesionMemoria());
      final admin = await configurarAdmin(servicio, usuarios);
      final empleado = await servicio.crearEmpleado(
        usuarioActivo: admin,
        nombre: 'Mesero',
        pin: '5678',
      );

      await servicio.actualizarEmpleado(
        usuarioActivo: admin,
        usuarioId: empleado.id,
        activo: false,
        puedeVerTodosPedidos: true,
      );
      final actualizado = await usuarios.obtenerPorId(empleado.id);

      expect(actualizado!.activo, isFalse);
      expect(actualizado.puedeVerTodosPedidos, isTrue);
      expect(
        servicio.actualizarEmpleado(
          usuarioActivo: admin,
          usuarioId: admin.id,
          activo: false,
        ),
        throwsStateError,
      );
    });
  });
}
