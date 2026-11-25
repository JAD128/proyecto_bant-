// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gasto_dao.dart';

// ignore_for_file: type=lint
mixin _$GastoDaoMixin on DatabaseAccessor<BantuDatabase> {
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $GastosTable get gastos => attachedDatabase.gastos;
  GastoDaoManager get managers => GastoDaoManager(this);
}

class GastoDaoManager {
  final _$GastoDaoMixin _db;
  GastoDaoManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db.attachedDatabase, _db.gastos);
}
