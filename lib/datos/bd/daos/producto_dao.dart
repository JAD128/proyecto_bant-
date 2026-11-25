import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'producto_dao.g.dart';

@DriftAccessor(tables: [Productos])
class ProductoDao extends DatabaseAccessor<BantuDatabase> with _$ProductoDaoMixin {
  ProductoDao(super.base);

  Future<List<Producto>> todos() {
    return (select(productos)..orderBy([(f) => OrderingTerm.asc(f.nombre)])).get();
  }

  Future<List<Producto>> activos() {
    return (select(productos)
          ..where((f) => f.activo.equals(true))
          ..orderBy([(f) => OrderingTerm.asc(f.nombre)]))
        .get();
  }

  Future<List<Producto>> porCategoria(String categoriaId) {
    return (select(productos)
          ..where((f) => f.categoriaId.equals(categoriaId) & f.activo.equals(true))
          ..orderBy([(f) => OrderingTerm.asc(f.nombre)]))
        .get();
  }

  Future<Producto?> porId(String id) {
    return (select(productos)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<int> insertar(ProductosCompanion datos) => into(productos).insert(datos);

  Future<bool> actualizar(ProductosCompanion datos) => update(productos).replace(datos);
}
