import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [Usuarios])
class UsuarioDao extends DatabaseAccessor<BantuDatabase> with _$UsuarioDaoMixin {
  UsuarioDao(super.base);

  Future<List<Usuario>> todos() => select(usuarios).get();

  Future<Usuario?> porId(String id) {
    return (select(usuarios)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<Usuario?> porNombre(String nombre) {
    return (select(usuarios)..where((f) => f.nombre.equals(nombre))).getSingleOrNull();
  }

  Future<int> insertar(UsuariosCompanion datos) => into(usuarios).insert(datos);

  Future<bool> actualizar(UsuariosCompanion datos) => update(usuarios).replace(datos);
}
