import 'package:drift/drift.dart';

import '../../../dominio/entidades/usuario.dart';
import '../../../dominio/valores/rol.dart';
import '../../bd/bantu_database.dart' as bd;
import '../usuario_repositorio.dart';

class DriftUsuarioRepositorio implements UsuarioRepositorio {
  final bd.BantuDatabase _base;

  const DriftUsuarioRepositorio(this._base);

  @override
  Future<List<Usuario>> obtenerTodos() async {
    final filas = await _base.usuarioDao.todos();
    return filas.map(_mapear).toList();
  }

  @override
  Future<Usuario?> obtenerPorId(String id) async {
    final fila = await _base.usuarioDao.porId(id);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<Usuario?> obtenerPorNombre(String nombre) async {
    final fila = await _base.usuarioDao.porNombre(nombre);
    return fila == null ? null : _mapear(fila);
  }

  @override
  Future<void> guardar(Usuario usuario) {
    return _base.usuarioDao.insertar(
      bd.UsuariosCompanion.insert(
        id: usuario.id,
        nombre: usuario.nombre,
        pinHash: usuario.pinHash,
        pinSalt: usuario.pinSalt,
        rol: usuario.rol.texto,
        puedeVerTodosPedidos: Value(usuario.puedeVerTodosPedidos),
        activo: Value(usuario.activo),
        creadoEn: usuario.creadoEn,
        actualizadoEn: usuario.actualizadoEn,
      ),
    );
  }

  @override
  Future<void> actualizar(Usuario usuario) {
    return _base.usuarioDao.actualizar(
      bd.UsuariosCompanion(
        id: Value(usuario.id),
        nombre: Value(usuario.nombre),
        pinHash: Value(usuario.pinHash),
        pinSalt: Value(usuario.pinSalt),
        rol: Value(usuario.rol.texto),
        puedeVerTodosPedidos: Value(usuario.puedeVerTodosPedidos),
        activo: Value(usuario.activo),
        creadoEn: Value(usuario.creadoEn),
        actualizadoEn: Value(usuario.actualizadoEn),
      ),
    );
  }

  Usuario _mapear(dynamic fila) {
    return Usuario(
      id: fila.id as String,
      nombre: fila.nombre as String,
      pinHash: fila.pinHash as String,
      pinSalt: fila.pinSalt as String,
      rol: rolDesdeTexto(fila.rol as String),
      puedeVerTodosPedidos: fila.puedeVerTodosPedidos as bool,
      activo: fila.activo as bool,
      creadoEn: fila.creadoEn as DateTime,
      actualizadoEn: fila.actualizadoEn as DateTime,
    );
  }
}
