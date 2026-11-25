import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'gasto_dao.g.dart';

@DriftAccessor(tables: [Gastos])
class GastoDao extends DatabaseAccessor<BantuDatabase> with _$GastoDaoMixin {
  GastoDao(super.base);

  Future<List<Gasto>> todos() {
    return (select(gastos)..orderBy([(f) => OrderingTerm.desc(f.creadoEn)])).get();
  }

  Future<List<Gasto>> porFecha(String fechaLocal) {
    return (select(gastos)
          ..where((f) => f.fechaLocal.equals(fechaLocal))
          ..orderBy([(f) => OrderingTerm.desc(f.creadoEn)]))
        .get();
  }

  Future<Gasto?> porId(String id) {
    return (select(gastos)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertar(GastosCompanion datos) => into(gastos).insert(datos);

  Future<bool> actualizar(GastosCompanion datos) => update(gastos).replace(datos);
}
