// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cierre_dao.dart';

// ignore_for_file: type=lint
mixin _$CierreDaoMixin on DatabaseAccessor<BantuDatabase> {
  $CierresDiariosTable get cierresDiarios => attachedDatabase.cierresDiarios;
  $UsuariosTable get usuarios => attachedDatabase.usuarios;
  $CierreAuditoriasTable get cierreAuditorias =>
      attachedDatabase.cierreAuditorias;
  CierreDaoManager get managers => CierreDaoManager(this);
}

class CierreDaoManager {
  final _$CierreDaoMixin _db;
  CierreDaoManager(this._db);
  $$CierresDiariosTableTableManager get cierresDiarios =>
      $$CierresDiariosTableTableManager(
        _db.attachedDatabase,
        _db.cierresDiarios,
      );
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db.attachedDatabase, _db.usuarios);
  $$CierreAuditoriasTableTableManager get cierreAuditorias =>
      $$CierreAuditoriasTableTableManager(
        _db.attachedDatabase,
        _db.cierreAuditorias,
      );
}
