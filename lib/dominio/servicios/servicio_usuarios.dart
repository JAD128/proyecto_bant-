import '../../datos/repositorios/usuario_repositorio.dart';
import '../../datos/sesion/repositorio_sesion.dart';
import '../../utilidades/generador_ids.dart';
import '../entidades/usuario.dart';
import '../valores/rol.dart';
import 'pin_hasher.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioUsuarios {
  final UsuarioRepositorio _usuarios;
  final RepositorioSesion _sesion;
  final PinHasher _hasher;
  final ServicioPermisos _permisos;

  const ServicioUsuarios({
    required this._usuarios,
    required this._sesion,
    required this._hasher,
    required this._permisos,
  });

  Future<bool> configuracionInicialCompleta() async {
    if (!await _sesion.configuracionInicialCompleta()) {
      return false;
    }
    return _hayAdministrador();
  }

  Future<void> configurarAdministrador({
    required String nombre,
    required String pin,
    required String confirmacion,
  }) async {
    if (await _hayAdministrador()) {
      throw StateError('Ya existe un administrador configurado.');
    }
    Validadores.texto(nombre, 'nombre', max: 80);
    if (pin != confirmacion) {
      throw ArgumentError.value(
        confirmacion,
        'confirmacion',
        'Los PIN no coinciden.',
      );
    }

    final claves = _hasher.crear(pin);
    final ahora = DateTime.now();
    await _usuarios.guardar(
      Usuario(
        id: GeneradorIds.nuevo(),
        nombre: nombre.trim(),
        pinHash: claves['hash']!,
        pinSalt: claves['salt']!,
        rol: Rol.administrador,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    await _sesion.marcarConfiguracionInicialCompleta();
  }

  Future<Usuario> iniciarSesion({
    required String nombre,
    required String pin,
  }) async {
    Validadores.texto(nombre, 'nombre', max: 80);
    Validadores.pin(pin);

    final buscado = nombre.trim().toLowerCase();
    final usuarios = await _usuarios.obtenerTodos();
    Usuario? usuario;
    for (final candidato in usuarios) {
      if (candidato.nombre.toLowerCase() == buscado) {
        usuario = candidato;
        break;
      }
    }

    if (usuario == null ||
        !usuario.activo ||
        !_hasher.verificar(
          pin: pin,
          hash: usuario.pinHash,
          salt: usuario.pinSalt,
        )) {
      throw StateError('Usuario o PIN incorrectos.');
    }

    await _sesion.guardarUsuarioActivo(usuario.id);
    return usuario;
  }

  Future<Usuario?> usuarioActivo() async {
    final id = await _sesion.obtenerUsuarioActivoId();
    if (id == null) {
      return null;
    }

    final usuario = await _usuarios.obtenerPorId(id);
    if (usuario == null || !usuario.activo) {
      await _sesion.cerrar();
      return null;
    }
    return usuario;
  }

  Future<void> cerrarSesion() => _sesion.cerrar();

  Future<List<Usuario>> obtenerUsuarios(Usuario usuarioActivo) async {
    _permisos.verificar(usuarioActivo, Accion.configurarUsuarios);
    return _usuarios.obtenerTodos();
  }

  Future<Usuario> crearEmpleado({
    required Usuario usuarioActivo,
    required String nombre,
    required String pin,
    bool puedeVerTodosPedidos = false,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.configurarUsuarios);
    Validadores.texto(nombre, 'nombre', max: 80);

    final normalizado = nombre.trim().toLowerCase();
    final usuarios = await _usuarios.obtenerTodos();
    if (usuarios.any((u) => u.nombre.toLowerCase() == normalizado)) {
      throw StateError('Ya existe un usuario con ese nombre.');
    }

    final claves = _hasher.crear(pin);
    final ahora = DateTime.now();
    final empleado = Usuario(
      id: GeneradorIds.nuevo(),
      nombre: nombre.trim(),
      pinHash: claves['hash']!,
      pinSalt: claves['salt']!,
      rol: Rol.empleado,
      puedeVerTodosPedidos: puedeVerTodosPedidos,
      creadoEn: ahora,
      actualizadoEn: ahora,
    );
    await _usuarios.guardar(empleado);
    return empleado;
  }

  Future<void> actualizarEmpleado({
    required Usuario usuarioActivo,
    required String usuarioId,
    bool? activo,
    bool? puedeVerTodosPedidos,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.configurarUsuarios);
    if (usuarioId == usuarioActivo.id) {
      throw StateError('No puedes modificar tu propio usuario aquí.');
    }

    final actual = await _usuarios.obtenerPorId(usuarioId);
    if (actual == null) {
      throw StateError('Usuario no encontrado.');
    }
    if (actual.rol != Rol.empleado) {
      throw StateError('El administrador no se puede modificar aquí.');
    }

    await _usuarios.actualizar(
      Usuario(
        id: actual.id,
        nombre: actual.nombre,
        pinHash: actual.pinHash,
        pinSalt: actual.pinSalt,
        rol: actual.rol,
        puedeVerTodosPedidos: puedeVerTodosPedidos ?? actual.puedeVerTodosPedidos,
        activo: activo ?? actual.activo,
        creadoEn: actual.creadoEn,
        actualizadoEn: DateTime.now(),
      ),
    );
  }

  Future<bool> _hayAdministrador() async {
    final usuarios = await _usuarios.obtenerTodos();
    return usuarios.any((usuario) => usuario.rol == Rol.administrador);
  }
}
