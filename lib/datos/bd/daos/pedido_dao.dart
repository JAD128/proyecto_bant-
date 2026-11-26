import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'pedido_dao.g.dart';

@DriftAccessor(tables: [Pedidos, PedidoItems, PedidoAuditorias])
class PedidoDao extends DatabaseAccessor<BantuDatabase> with _$PedidoDaoMixin {
  PedidoDao(super.base);

  Future<List<Pedido>> todos() {
    return (select(
      pedidos,
    )..orderBy([(f) => OrderingTerm.desc(f.creadoEn)])).get();
  }

  Future<List<Pedido>> porFecha(String fechaLocal) {
    return (select(pedidos)
          ..where((f) => f.fechaLocal.equals(fechaLocal))
          ..orderBy([(f) => OrderingTerm.desc(f.creadoEn)]))
        .get();
  }

  Future<List<Pedido>> porEmpleado(String empleadoId) {
    return (select(pedidos)
          ..where((f) => f.empleadoId.equals(empleadoId))
          ..orderBy([(f) => OrderingTerm.desc(f.creadoEn)]))
        .get();
  }

  Future<Pedido?> porId(String id) {
    return (select(pedidos)..where((f) => f.id.equals(id))).getSingleOrNull();
  }

  Future<Pedido?> porIdempotenciaKey(String clave) {
    return (select(
      pedidos,
    )..where((f) => f.idempotenciaKey.equals(clave))).getSingleOrNull();
  }

  Future<List<PedidoItem>> itemsDePedido(String pedidoId) {
    return (select(
      pedidoItems,
    )..where((f) => f.pedidoId.equals(pedidoId))).get();
  }

  Future<void> insertarConItems(
    PedidosCompanion pedido,
    List<PedidoItemsCompanion> items,
  ) async {
    await db.transaction(() async {
      await into(pedidos).insert(pedido);
      for (final item in items) {
        await into(pedidoItems).insert(item);
      }
    });
  }

  Future<bool> actualizar(PedidosCompanion datos) =>
      update(pedidos).replace(datos);

  Future<int> insertarAuditoria(PedidoAuditoriasCompanion datos) =>
      into(pedidoAuditorias).insert(datos);
}
