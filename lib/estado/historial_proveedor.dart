import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/pedido.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/valores/estado_pedido.dart';
import '../dominio/valores/modalidad_pedido.dart';
import 'sesion_proveedor.dart';

class HistorialProveedor extends ChangeNotifier {
  final Dependencias _dependencias;
  final SesionProveedor _sesion;

  List<Pedido> _pedidos = const [];
  bool _cargando = false;
  String? _error;
  String? _desde;
  String? _hasta;
  String? _empleadoId;
  EstadoPedido? _estado;
  ModalidadPedido? _modalidad;

  HistorialProveedor({required this._dependencias, required this._sesion});

  List<Pedido> get pedidos => List.unmodifiable(_pedidos);
  bool get cargando => _cargando;
  String? get error => _error;
  String? get desde => _desde;
  String? get hasta => _hasta;
  String? get empleadoId => _empleadoId;
  EstadoPedido? get estado => _estado;
  ModalidadPedido? get modalidad => _modalidad;

  Future<bool> cargar() {
    return _ejecutar(() async {
      _pedidos = await _dependencias.servicioHistorial.consultar(
        _requerirUsuario(),
        desde: _desde,
        hasta: _hasta,
        empleadoId: _empleadoId,
        estado: _estado,
        modalidad: _modalidad,
      );
    });
  }

  Future<bool> cambiarFiltros({
    String? desde,
    String? hasta,
    String? empleadoId,
    EstadoPedido? estado,
    ModalidadPedido? modalidad,
  }) {
    _desde = _normalizar(desde);
    _hasta = _normalizar(hasta);
    _empleadoId = _normalizar(empleadoId);
    _estado = estado;
    _modalidad = modalidad;
    return cargar();
  }

  Future<bool> limpiarFiltros() {
    return cambiarFiltros();
  }

  Future<Pedido?> detalle(String pedidoId) async {
    Pedido? resultado;
    final correcto = await _ejecutar(() async {
      resultado = await _dependencias.servicioHistorial.detalle(
        _requerirUsuario(),
        pedidoId,
      );
    });
    return correcto ? resultado : null;
  }

  String? _normalizar(String? valor) {
    final recortado = valor?.trim();
    return recortado == null || recortado.isEmpty ? null : recortado;
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
