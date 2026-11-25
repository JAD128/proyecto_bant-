import 'package:drift/drift.dart';

import '../../../dominio/entidades/pedido.dart';
import '../../../dominio/valores/estado_pedido.dart';
import '../../../dominio/valores/metodo_pago.dart';
import '../../../dominio/valores/modalidad_pedido.dart';
import '../../../utilidades/generador_ids.dart';
import '../../bd/bantu_database.dart' as bd;
import '../pedido_repositorio.dart';

class DriftPedidoRepositorio implements PedidoRepositorio {
  final bd.BantuDatabase _base;

  const DriftPedidoRepositorio(this._base);

  @override
  Future<void> guardar(Pedido pedido) {
    return _base.pedidoDao.insertarConItems(
      bd.PedidosCompanion.insert(
        id: pedido.id,
        idempotenciaKey: pedido.idempotenciaKey,
        empleadoId: pedido.empleadoId,
        fechaLocal: pedido.fechaLocal,
        horaLocal: pedido.horaLocal,
        creadoEn: pedido.creadoEn,
        modalidad: pedido.modalidad.texto,
        metodoPago: pedido.metodoPago.texto,
        estado: pedido.estado.texto,
        subtotal: pedido.subtotal,
        costoEmpaque: pedido.costoEmpaque,
        total: pedido.total,
        motivoAnulacion: Value(pedido.motivoAnulacion),
      ),
      [
        for (final item in pedido.items)
          bd.PedidoItemsCompanion.insert(
            id: item.id,
            pedidoId: pedido.id,
            productoId: Value(item.productoId),
            nombreProducto: item.nombreProducto,
            categoriaNombre: item.categoriaNombre,
            cantidad: item.cantidad,
            modalidad: item.modalidad.texto,
            precioUnitario: item.precioUnitario,
            costoEmpaqueUnitario: item.costoEmpaqueUnitario,
            subtotalItem: item.subtotal,
            totalItem: item.total,
          ),
      ],
    );
  }

  @override
  Future<Pedido?> obtenerPorId(String id) async {
    final fila = await _base.pedidoDao.porId(id);
    return fila == null ? null : _mapearPedido(fila);
  }

  @override
  Future<List<Pedido>> obtenerTodos() async {
    final filas = await _base.pedidoDao.todos();
    return Future.wait(filas.map(_mapearPedido));
  }

  @override
  Future<List<Pedido>> obtenerPorFecha(String fechaLocal) async {
    final filas = await _base.pedidoDao.porFecha(fechaLocal);
    return Future.wait(filas.map(_mapearPedido));
  }

  @override
  Future<List<Pedido>> obtenerPorEmpleado(String empleadoId) async {
    final filas = await _base.pedidoDao.porEmpleado(empleadoId);
    return Future.wait(filas.map(_mapearPedido));
  }

  @override
  Future<void> anular({
    required String pedidoId,
    required String motivo,
    required String usuarioId,
  }) async {
    final pedido = await obtenerPorId(pedidoId);
    if (pedido == null) {
      throw StateError('Pedido no encontrado: $pedidoId');
    }
    if (pedido.estado == EstadoPedido.anulado) {
      return;
    }

    await _base.pedidoDao.actualizar(
      bd.PedidosCompanion(
        id: Value(pedido.id),
        idempotenciaKey: Value(pedido.idempotenciaKey),
        empleadoId: Value(pedido.empleadoId),
        fechaLocal: Value(pedido.fechaLocal),
        horaLocal: Value(pedido.horaLocal),
        creadoEn: Value(pedido.creadoEn),
        modalidad: Value(pedido.modalidad.texto),
        metodoPago: Value(pedido.metodoPago.texto),
        estado: Value(EstadoPedido.anulado.texto),
        subtotal: Value(pedido.subtotal),
        costoEmpaque: Value(pedido.costoEmpaque),
        total: Value(pedido.total),
        motivoAnulacion: Value(motivo),
      ),
    );

    await _base.pedidoDao.insertarAuditoria(
      bd.PedidoAuditoriasCompanion.insert(
        id: GeneradorIds.nuevo(),
        pedidoId: pedidoId,
        accion: EstadoPedido.anulado.texto,
        motivo: motivo,
        usuarioId: usuarioId,
        creadoEn: DateTime.now(),
      ),
    );
  }

  Future<Pedido> _mapearPedido(dynamic fila) async {
    final filasItems = await _base.pedidoDao.itemsDePedido(fila.id as String);
    return Pedido(
      id: fila.id as String,
      idempotenciaKey: fila.idempotenciaKey as String,
      empleadoId: fila.empleadoId as String,
      fechaLocal: fila.fechaLocal as String,
      horaLocal: fila.horaLocal as String,
      creadoEn: fila.creadoEn as DateTime,
      modalidad: modalidadDesdeTexto(fila.modalidad as String),
      metodoPago: metodoPagoDesdeTexto(fila.metodoPago as String),
      estado: estadoPedidoDesdeTexto(fila.estado as String),
      subtotal: fila.subtotal as int,
      costoEmpaque: fila.costoEmpaque as int,
      total: fila.total as int,
      motivoAnulacion: fila.motivoAnulacion as String?,
      items: filasItems.map(_mapearItem).toList(),
    );
  }

  ItemPedido _mapearItem(dynamic fila) {
    return ItemPedido(
      id: fila.id as String,
      productoId: fila.productoId as String,
      nombreProducto: fila.nombreProducto as String,
      categoriaNombre: fila.categoriaNombre as String,
      cantidad: fila.cantidad as int,
      modalidad: modalidadDesdeTexto(fila.modalidad as String),
      precioUnitario: fila.precioUnitario as int,
      costoEmpaqueUnitario: fila.costoEmpaqueUnitario as int,
      subtotal: fila.subtotalItem as int,
      total: fila.totalItem as int,
    );
  }
}
