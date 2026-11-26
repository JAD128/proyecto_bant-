import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/gasto.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/servicios/calculador_finanzas.dart';
import 'sesion_proveedor.dart';

class FinanzasProveedor extends ChangeNotifier {
  final Dependencias _dependencias;
  final SesionProveedor _sesion;

  ResumenFinanciero _resumen = const ResumenFinanciero();
  List<Gasto> _gastos = const [];
  String? _desde;
  String? _hasta;
  bool _cargando = false;
  String? _error;

  FinanzasProveedor({required this._dependencias, required this._sesion});

  ResumenFinanciero get resumen => _resumen;
  List<Gasto> get gastos => List.unmodifiable(_gastos);
  String? get desde => _desde;
  String? get hasta => _hasta;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<bool> cargar() {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      _resumen = await _dependencias.servicioFinanzas.resumen(
        usuario,
        desde: _desde,
        hasta: _hasta,
      );
      _gastos = await _dependencias.servicioFinanzas.obtenerGastos(
        usuario,
        desde: _desde,
        hasta: _hasta,
      );
    });
  }

  Future<bool> cambiarRango({String? desde, String? hasta}) {
    _desde = _normalizar(desde);
    _hasta = _normalizar(hasta);
    return cargar();
  }

  Future<bool> limpiarRango() => cambiarRango();

  Future<bool> registrarGasto({
    required String fechaLocal,
    required String concepto,
    required int valor,
  }) {
    return _ejecutar(() async {
      await _dependencias.servicioFinanzas.registrarGasto(
        usuarioActivo: _requerirUsuario(),
        fechaLocal: fechaLocal,
        concepto: concepto,
        valor: valor,
      );
      await _recargar();
    });
  }

  Future<bool> actualizarGasto({
    required String gastoId,
    String? fechaLocal,
    String? concepto,
    int? valor,
  }) {
    return _ejecutar(() async {
      await _dependencias.servicioFinanzas.actualizarGasto(
        usuarioActivo: _requerirUsuario(),
        gastoId: gastoId,
        fechaLocal: fechaLocal,
        concepto: concepto,
        valor: valor,
      );
      await _recargar();
    });
  }

  Future<void> _recargar() async {
    final usuario = _requerirUsuario();
    _resumen = await _dependencias.servicioFinanzas.resumen(
      usuario,
      desde: _desde,
      hasta: _hasta,
    );
    _gastos = await _dependencias.servicioFinanzas.obtenerGastos(
      usuario,
      desde: _desde,
      hasta: _hasta,
    );
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
