// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'producto_dao.dart';

// ignore_for_file: type=lint
mixin _$ProductoDaoMixin on DatabaseAccessor<BantuDatabase> {
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $ProductosTable get productos => attachedDatabase.productos;
  ProductoDaoManager get managers => ProductoDaoManager(this);
}

class ProductoDaoManager {
  final _$ProductoDaoMixin _db;
  ProductoDaoManager(this._db);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db.attachedDatabase, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db.attachedDatabase, _db.productos);
}
