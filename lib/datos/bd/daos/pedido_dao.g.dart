// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pedido_dao.dart';

// ignore_for_file: type=lint
mixin _$PedidoDaoMixin on DatabaseAccessor<BantuDatabase> {
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $PedidosTable get pedidos => attachedDatabase.pedidos;
  $CategoriasTable get categorias => attachedDatabase.categorias;
  $ProductosTable get productos => attachedDatabase.productos;
  $PedidoItemsTable get pedidoItems => attachedDatabase.pedidoItems;
  $PedidoAuditoriasTable get pedidoAuditorias =>
      attachedDatabase.pedidoAuditorias;
  PedidoDaoManager get managers => PedidoDaoManager(this);
}

class PedidoDaoManager {
  final _$PedidoDaoMixin _db;
  PedidoDaoManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$PedidosTableTableManager get pedidos =>
      $$PedidosTableTableManager(_db.attachedDatabase, _db.pedidos);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db.attachedDatabase, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db.attachedDatabase, _db.productos);
  $$PedidoItemsTableTableManager get pedidoItems =>
      $$PedidoItemsTableTableManager(_db.attachedDatabase, _db.pedidoItems);
  $$PedidoAuditoriasTableTableManager get pedidoAuditorias =>
      $$PedidoAuditoriasTableTableManager(
        _db.attachedDatabase,
        _db.pedidoAuditorias,
      );
}
