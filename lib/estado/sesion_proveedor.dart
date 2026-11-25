import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/servicios/servicio_permisos.dart';
import '../dominio/valores/rol.dart';

class SesionProveedor extends ChangeNotifier {
  final Dependencias _dependencias;

  Usuario? _usuarioActivo;
  List<Usuario> _usuarios = const [];
  bool _cargando = false;
  bool _inicializado = false;
  bool _configuracionInicialCompleta = false;
  String? _error;

  SesionProveedor({required this._dependencias});

  Usuario? get usuarioActivo => _usuarioActivo;
  List<Usuario> get usuarios => List.unmodifiable(_usuarios);
  bool get cargando => _cargando;
  bool get inicializado => _inicializado;
  bool get configuracionInicialCompleta => _configuracionInicialCompleta;
  bool get autenticado => _usuarioActivo != null;
  bool get esAdministrador => _usuarioActivo?.rol == Rol.administrador;
  String? get error => _error;

  bool puede(Accion accion) {
    final usuario = _usuarioActivo;
    return usuario != null && _dependencias.permisos.puede(usuario, accion);
  }

  Future<void> inicializar() async {
    if (_inicializado) {
      return;
    }
    await _ejecutar(() async {
      _configuracionInicialCompleta =
          await _dependencias.servicioUsuarios.configuracionInicialCompleta();
      if (_configuracionInicialCompleta) {
        _usuarioActivo = await _dependencias.servicioUsuarios.usuarioActivo();
      }
    });
    _inicializado = true;
    notifyListeners();
  }

  Future<bool> configurarAdministrador({
    required String nombre,
    required String pin,
    required String confirmacion,
  }) {
    return _ejecutar(() async {
      await _dependencias.servicioUsuarios.configurarAdministrador(
        nombre: nombre,
        pin: pin,
        confirmacion: confirmacion,
      );
      _configuracionInicialCompleta = true;
      _usuarioActivo = await _dependencias.servicioUsuarios.iniciarSesion(
        nombre: nombre,
        pin: pin,
      );
    });
  }

  Future<bool> iniciarSesion({required String nombre, required String pin}) {
    return _ejecutar(() async {
      _usuarioActivo = await _dependencias.servicioUsuarios.iniciarSesion(
        nombre: nombre,
        pin: pin,
      );
    });
  }

  Future<void> cerrarSesion() async {
    await _dependencias.servicioUsuarios.cerrarSesion();
    _usuarioActivo = null;
    _usuarios = const [];
    _error = null;
    notifyListeners();
  }

  Future<bool> cargarUsuarios() {
    return _ejecutar(() async {
      final activo = _requerirUsuario();
      _usuarios = await _dependencias.servicioUsuarios.obtenerUsuarios(activo);
    });
  }

  Future<bool> crearEmpleado({
    required String nombre,
    required String pin,
    bool puedeVerTodosPedidos = false,
  }) {
    return _ejecutar(() async {
      final activo = _requerirUsuario();
      await _dependencias.servicioUsuarios.crearEmpleado(
        usuarioActivo: activo,
        nombre: nombre,
        pin: pin,
        puedeVerTodosPedidos: puedeVerTodosPedidos,
      );
      _usuarios = await _dependencias.servicioUsuarios.obtenerUsuarios(activo);
    });
  }

  Future<bool> actualizarEmpleado({
    required String usuarioId,
    bool? activo,
    bool? puedeVerTodosPedidos,
  }) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioUsuarios.actualizarEmpleado(
        usuarioActivo: usuario,
        usuarioId: usuarioId,
        activo: activo,
        puedeVerTodosPedidos: puedeVerTodosPedidos,
      );
      _usuarios = await _dependencias.servicioUsuarios.obtenerUsuarios(usuario);
    });
  }

  Usuario _requerirUsuario() {
    final usuario = _usuarioActivo;
    if (usuario == null) {
      throw StateError('Debes iniciar sesión para continuar.');
    }
    return usuario;
  }

  Future<bool> _ejecutar(Future<void> Function() operacion) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      await operacion();
      return true;
    } catch (error) {
      _error = _mensaje(error);
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  String _mensaje(Object error) {
    if (error is ArgumentError) {
      return error.message?.toString() ?? 'Dato inválido.';
    }
    if (error is StateError) {
      return error.message;
    }
    return 'No se pudo completar la operación.';
  }
}
