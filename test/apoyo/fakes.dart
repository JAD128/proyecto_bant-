import 'package:bantu/datos/repositorios/usuario_repositorio.dart';
import 'package:bantu/datos/sesion/repositorio_sesion.dart';
import 'package:bantu/dominio/entidades/usuario.dart';

class UsuarioRepositorioMemoria implements UsuarioRepositorio {
  final Map<String, Usuario> _porId = <String, Usuario>{};
  final Map<String, String> _porNombre = <String, String>{};

  @override
  Future<List<Usuario>> obtenerTodos() async => _porId.values.toList();

  @override
  Future<Usuario?> obtenerPorId(String id) async => _porId[id];

  @override
  Future<Usuario?> obtenerPorNombre(String nombre) async {
    final id = _porNombre[nombre.trim().toLowerCase()];
    return id == null ? null : _porId[id];
  }

  @override
  Future<void> guardar(Usuario usuario) async {
    final clave = usuario.nombre.trim().toLowerCase();
    if (_porNombre.containsKey(clave)) {
      throw StateError('Ya existe un usuario con ese nombre.');
    }
    _porId[usuario.id] = usuario;
    _porNombre[clave] = usuario.id;
  }

  @override
  Future<void> actualizar(Usuario usuario) async {
    if (!_porId.containsKey(usuario.id)) {
      throw StateError('Usuario no encontrado.');
    }
    final anterior = _porId[usuario.id]!;
    final claveAnterior = anterior.nombre.trim().toLowerCase();
    final claveNueva = usuario.nombre.trim().toLowerCase();
    if (claveAnterior != claveNueva && _porNombre.containsKey(claveNueva)) {
      throw StateError('Ya existe un usuario con ese nombre.');
    }
    _porId[usuario.id] = usuario;
    if (claveAnterior != claveNueva) {
      _porNombre.remove(claveAnterior);
      _porNombre[claveNueva] = usuario.id;
    }
  }
}

class SesionMemoria implements RepositorioSesion {
  String? usuarioActivoId;
  bool configurado = false;

  @override
  Future<String?> obtenerUsuarioActivoId() async => usuarioActivoId;

  @override
  Future<void> guardarUsuarioActivo(String id) async => usuarioActivoId = id;

  @override
  Future<void> cerrar() async => usuarioActivoId = null;

  @override
  Future<bool> configuracionInicialCompleta() async => configurado;

  @override
  Future<void> marcarConfiguracionInicialCompleta() async => configurado = true;
}
