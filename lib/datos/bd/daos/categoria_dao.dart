import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'categoria_dao.g.dart';

@DriftAccessor(tables: [Categorias])
class CategoriaDao extends DatabaseAccessor<BantuDatabase> with _$CategoriaDaoMixin {
  CategoriaDao(super.base);

  Future<List<Categoria>> todos() {
    return (select(categorias)..orderBy([(f) => OrderingTerm.asc(f.orden)])).get();
  }

  Future<List<Categoria>> activas() {
    return (select(categorias)
          ..where((f) => f.activa.equals(true))
          ..orderBy([(f) => OrderingTerm.asc(f.orden)]))
        .get();
  }

  Future<Categoria?> porId(String id) {
    return (select(categorias)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertar(CategoriasCompanion datos) => into(categorias).insert(datos);

  Future<bool> actualizar(CategoriasCompanion datos) => update(categorias).replace(datos);
}
