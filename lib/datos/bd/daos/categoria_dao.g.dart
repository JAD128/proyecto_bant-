// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'categoria_dao.dart';

// ignore_for_file: type=lint
mixin _$CategoriaDaoMixin on DatabaseAccessor<BantuDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
  CategoriaDaoManager get managers => CategoriaDaoManager(this);
}

class CategoriaDaoManager {
  final _$CategoriaDaoMixin _db;
  CategoriaDaoManager(this._db);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db.attachedDatabase, _db.categorias);
}
