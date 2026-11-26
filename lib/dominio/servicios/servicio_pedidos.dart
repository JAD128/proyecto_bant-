import '../../datos/repositorios/categoria_repositorio.dart';
import '../../datos/repositorios/pedido_repositorio.dart';
import '../../utilidades/generador_ids.dart';
import '../entidades/item_carrito.dart';
import '../entidades/pedido.dart';
import '../entidades/usuario.dart';
import '../valores/estado_pedido.dart';
import '../valores/metodo_pago.dart';
import '../valores/modalidad_pedido.dart';
import 'calculador_pedido.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioPedidos {
  final PedidoRepositorio _pedidos;
  final CategoriaRepositorio _categorias;
  final CalculadorPedido _calculador;
  final ServicioPermisos _permisos;

  const ServicioPedidos({
    required this._pedidos,
    required this._categorias,
    required this._calculador,
    required this._permisos,
  });

  Future<Pedido> confirmar({
    required Usuario usuarioActivo,
    required String idempotenciaKey,
    required List<ItemCarrito> items,
    required MetodoPago metodoPago,
    required String fechaLocal,
    required String horaLocal,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.crearPedido);
    Validadores.fechaLocal(fechaLocal);
    Validadores.horaLocal(horaLocal);
    Validadores.texto(idempotenciaKey, 'idempotenciaKey', max: 200);

    final clave = idempotenciaKey.trim();
    final existente = await _pedidos.obtenerPorIdempotenciaKey(clave);
    if (existente != null) {
      return existente;
    }

    final resultado = _calculador.calcular(items);
    final itemsPedido = <ItemPedido>[];
    for (final linea in resultado.lineas) {
      final categoria = await _categorias.obtenerPorId(
        linea.producto.categoriaId,
      );
      if (categoria == null) {
        throw StateError(
          'Categoría no encontrada: ${linea.producto.categoriaId}',
        );
      }
      itemsPedido.add(
        ItemPedido(
          id: GeneradorIds.nuevo(),
          productoId: linea.producto.id,
          nombreProducto: linea.producto.nombre,
          categoriaNombre: categoria.nombre,
          cantidad: linea.cantidad,
          modalidad: linea.modalidad,
          precioUnitario: linea.precioUnitario,
          costoEmpaqueUnitario: linea.costoEmpaqueUnitario,
          subtotal: linea.subtotal,
          total: linea.total,
        ),
      );
    }

    final modalidad =
        items.any((item) => item.modalidad == ModalidadPedido.llevar)
        ? ModalidadPedido.llevar
        : ModalidadPedido.local;
    final pedido = Pedido(
      id: GeneradorIds.nuevo(),
      idempotenciaKey: clave,
      empleadoId: usuarioActivo.id,
      fechaLocal: fechaLocal,
      horaLocal: horaLocal,
      creadoEn: DateTime.now(),
      modalidad: modalidad,
      metodoPago: metodoPago,
      estado: EstadoPedido.confirmado,
      subtotal: resultado.subtotal,
      costoEmpaque: resultado.costoEmpaque,
      total: resultado.total,
      items: List.unmodifiable(itemsPedido),
    );

    await _pedidos.guardar(pedido);
    final persistido = await _pedidos.obtenerPorId(pedido.id);
    if (persistido == null) {
      throw StateError('No se pudo guardar el pedido.');
    }
    return persistido;
  }

  Future<void> anular({
    required Usuario usuarioActivo,
    required String pedidoId,
    required String motivo,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.anularPedido);
    Validadores.texto(motivo, 'motivo');
    await _pedidos.anular(
      pedidoId: pedidoId,
      motivo: motivo.trim(),
      usuarioId: usuarioActivo.id,
    );
  }

  Future<Pedido?> obtenerPorId(Usuario usuarioActivo, String pedidoId) async {
    _permisos.verificar(usuarioActivo, Accion.verHistorial);
    final pedido = await _pedidos.obtenerPorId(pedidoId);
    if (pedido == null) {
      return null;
    }
    if (!_permisos.puede(usuarioActivo, Accion.verTodosPedidos) &&
        pedido.empleadoId != usuarioActivo.id) {
      throw StateError('No tienes permiso para ver este pedido.');
    }
    return pedido;
  }
}
