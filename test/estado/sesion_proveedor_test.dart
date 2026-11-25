import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';

void main() {
  late BantuDatabase base;
  late Dependencias dependencias;
  late SesionMemoria sesion;
  late SesionProveedor proveedor;

  setUp(() async {
    base = BantuDatabase.forTesting(NativeDatabase.memory());
    sesion = SesionMemoria();
    dependencias = Dependencias(baseDatos: base, sesion: sesion);
    proveedor = SesionProveedor(dependencias: dependencias);
    await proveedor.inicializar();
  });

  tearDown(() async {
    proveedor.dispose();
    await base.close();
  });

  Future<void> configurar() async {
    final correcto = await proveedor.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
    expect(correcto, isTrue);
  }

  group('SesionProveedor', () {
    test('inicializa sin configuración ni usuario activo', () {
      expect(proveedor.inicializado, isTrue);
      expect(proveedor.configuracionInicialCompleta, isFalse);
      expect(proveedor.autenticado, isFalse);
    });

    test('configurar administrador deja la sesión autenticada', () async {
      await configurar();

      expect(proveedor.configuracionInicialCompleta, isTrue);
      expect(proveedor.esAdministrador, isTrue);
      expect(proveedor.puede(Accion.configurarUsuarios), isTrue);
      expect(proveedor.error, isNull);
    });

    test('error de acceso se expone a la UI', () async {
      await configurar();
      await proveedor.cerrarSesion();

      final correcto = await proveedor.iniciarSesion(
        nombre: 'Admin',
        pin: '0000',
      );

      expect(correcto, isFalse);
      expect(proveedor.autenticado, isFalse);
      expect(proveedor.error, 'Usuario o PIN incorrectos.');
    });

    test('la sesión se cierra y limpia el usuario activo', () async {
      await configurar();
      expect(sesion.usuarioActivoId, isNotNull);

      await proveedor.cerrarSesion();

      expect(proveedor.autenticado, isFalse);
      expect(sesion.usuarioActivoId, isNull);
    });

    test('administra empleados desde el proveedor', () async {
      await configurar();
      expect(await proveedor.cargarUsuarios(), isTrue);
      expect(proveedor.usuarios, hasLength(1));

      expect(
        await proveedor.crearEmpleado(
          nombre: 'Mesero',
          pin: '5678',
          puedeVerTodosPedidos: true,
        ),
        isTrue,
      );
      expect(proveedor.usuarios, hasLength(2));

      final empleado = proveedor.usuarios.firstWhere(
        (usuario) => usuario.nombre == 'Mesero',
      );
      expect(
        await proveedor.actualizarEmpleado(
          usuarioId: empleado.id,
          activo: false,
        ),
        isTrue,
      );
      expect(
        proveedor.usuarios.firstWhere((u) => u.id == empleado.id).activo,
        isFalse,
      );
    });
  });
}
