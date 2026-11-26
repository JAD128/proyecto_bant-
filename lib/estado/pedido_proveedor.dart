import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/item_carrito.dart';
import '../dominio/entidades/pedido.dart';
import '../dominio/entidades/producto.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/servicios/calculador_pedido.dart';
import '../dominio/valores/metodo_pago.dart';
import '../dominio/valores/modalidad_pedido.dart';
import '../utilidades/generador_ids.dart';
import 'sesion_proveedor.dart';

class PedidoProveedor extends ChangeNotifier {
  final Dependencias _dependencias;
  final SesionProveedor _sesion;

  final Map<String, ItemCarrito> _carrito = <String, ItemCarrito>{};
  String _idempotenciaKey = GeneradorIds.nuevo();
  Pedido? _pedidoConfirmado;
  bool _cargando = false;
  String? _error;

  PedidoProveedor({required this._dependencias, required this._sesion});

  List<ItemCarrito> get itemsCarrito => List.unmodifiable(_carrito.values);
  String get idempotenciaKey => _idempotenciaKey;
  Pedido? get pedidoConfirmado => _pedidoConfirmado;
  bool get cargando => _cargando;
  String? get error => _error;

  ResultadoCalculoPedido? get resultado {
    if (_carrito.isEmpty) {
      return null;
    }
    return _dependencias.calculadorPedido.calcular(itemsCarrito);
  }

  int cantidad(String productoId) => _carrito[productoId]?.cantidad ?? 0;

  ModalidadPedido modalidad(String productoId) =>
      _carrito[productoId]?.modalidad ?? ModalidadPedido.local;

  void agregar(Producto producto) {
    if (!producto.activo) {
      _error = 'El producto no está activo.';
      notifyListeners();
      return;
    }
    final actual = _carrito[producto.id];
    _carrito[producto.id] = ItemCarrito(
      producto: producto,
      cantidad: (actual?.cantidad ?? 0) + 1,
      modalidad: actual?.modalidad ?? ModalidadPedido.local,
    );
    _error = null;
    notifyListeners();
  }

  void cambiarCantidad(String productoId, int cantidad) {
    final actual = _carrito[productoId];
    if (actual == null) {
      return;
    }
    if (cantidad <= 0) {
      _carrito.remove(productoId);
    } else {
      _carrito[productoId] = ItemCarrito(
        producto: actual.producto,
        cantidad: cantidad,
        modalidad: actual.modalidad,
      );
    }
    _error = null;
    notifyListeners();
  }

  void cambiarModalidad(String productoId, ModalidadPedido modalidad) {
    final actual = _carrito[productoId];
    if (actual == null) {
      return;
    }
    _carrito[productoId] = ItemCarrito(
      producto: actual.producto,
      cantidad: actual.cantidad,
      modalidad: modalidad,
    );
    _error = null;
    notifyListeners();
  }

  Future<bool> confirmar({
    required MetodoPago metodoPago,
    required String fechaLocal,
    required String horaLocal,
  }) {
    return _ejecutar(() async {
      final pedido = await _dependencias.servicioPedidos.confirmar(
        usuarioActivo: _requerirUsuario(),
        idempotenciaKey: _idempotenciaKey,
        items: itemsCarrito,
        metodoPago: metodoPago,
        fechaLocal: fechaLocal,
        horaLocal: horaLocal,
      );
      _pedidoConfirmado = pedido;
      _prepararNuevoPedido();
    });
  }

  Future<bool> anular(String pedidoId, String motivo) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioPedidos.anular(
        usuarioActivo: usuario,
        pedidoId: pedidoId,
        motivo: motivo,
      );
      final actualizado = await _dependencias.servicioPedidos.obtenerPorId(
        usuario,
        pedidoId,
      );
      if (actualizado != null && _pedidoConfirmado?.id == pedidoId) {
        _pedidoConfirmado = actualizado;
      }
    });
  }

  void reiniciar() {
    _pedidoConfirmado = null;
    _prepararNuevoPedido();
    notifyListeners();
  }

  void _prepararNuevoPedido() {
    _carrito.clear();
    _idempotenciaKey = GeneradorIds.nuevo();
    _error = null;
  }

  Usuario _requerirUsuario() {
    final usuario = _sesion.usuarioActivo;
    if (usuario == null) {
      throw StateError('Debes iniciar sesión para continuar.');
    }
    return usuario;
  }

  Future<bool> _ejecutar(Future<void> Function() operacion) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      await operacion();
      return true;
    } catch (error) {
      _error = _mensaje(error);
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  String _mensaje(Object error) {
    if (error is ArgumentError) {
      return error.message?.toString() ?? 'Dato inválido.';
    }
    if (error is StateError) {
      return error.message;
    }
    return 'No se pudo completar la operación.';
  }
}
