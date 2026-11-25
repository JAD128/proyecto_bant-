import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:path_provider/path_provider.dart';

import 'daos/cierre_dao.dart';
import 'daos/gasto_dao.dart';
import 'daos/pedido_dao.dart';
import 'daos/producto_dao.dart';
import 'daos/usuario_dao.dart';
import 'daos/categoria_dao.dart';
import 'tablas.dart';

part 'bantu_database.g.dart';

@DriftDatabase(
  tables: [
    Usuarios,
    Categorias,
    Productos,
    Pedidos,
    PedidoItems,
    Gastos,
    CierresDiarios,
    CierreAuditorias,
    PedidoAuditorias,
  ],
  daos: [
    UsuarioDao,
    CategoriaDao,
    ProductoDao,
    PedidoDao,
    GastoDao,
    CierreDao,
  ],
)
class BantuDatabase extends _$BantuDatabase {
  BantuDatabase([QueryExecutor? executor]) : super(executor ?? _abrirConexion());

  BantuDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) async => m.createAll(),
      beforeOpen: (details) async {
        await customStatement('PRAGMA foreign_keys = ON');
      },
    );
  }

  static QueryExecutor _abrirConexion() {
    return driftDatabase(
      name: 'bantu',
      native: const DriftNativeOptions(
        databaseDirectory: getApplicationSupportDirectory,
      ),
    );
  }
}
