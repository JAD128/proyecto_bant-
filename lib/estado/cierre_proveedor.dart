import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/cierre_diario.dart';
import '../dominio/entidades/usuario.dart';
import '../utilidades/fechas.dart';
import 'sesion_proveedor.dart';

class CierreProveedor extends ChangeNotifier {
  final Dependencias _dependencias;
  final SesionProveedor _sesion;

  List<CierreDiario> _cierres = const [];
  CierreDiario? _cierreActual;
  List<CierreAuditoria> _auditorias = const [];
  bool _cargando = false;
  String? _error;
  late String _fechaSeleccionada;

  CierreProveedor({required this._dependencias, required this._sesion}) {
    _fechaSeleccionada = Fechas.hoyLocal();
  }

  List<CierreDiario> get cierres => List.unmodifiable(_cierres);
  CierreDiario? get cierreActual => _cierreActual;
  List<CierreAuditoria> get auditorias => List.unmodifiable(_auditorias);
  bool get cargando => _cargando;
  String? get error => _error;
  String get fechaSeleccionada => _fechaSeleccionada;

  Future<bool> cargar() {
    return _ejecutar(() async {
      _cierres = await _dependencias.servicioCierres.obtenerTodos(
        _requerirUsuario(),
      );
      _sincronizarCierreActual();
    });
  }

  Future<bool> cerrar(String fechaLocal) {
    return _ejecutar(() async {
      final creado = await _dependencias.servicioCierres.cerrarDia(
        usuarioActivo: _requerirUsuario(),
        fechaLocal: fechaLocal,
      );
      _fechaSeleccionada = creado.fechaLocal;
      _cierres = await _dependencias.servicioCierres.obtenerTodos(
        _requerirUsuario(),
      );
      _sincronizarCierreActual(idPreferido: creado.id);
    });
  }

  Future<bool> corregir(String cierreId, String motivo) {
    return _ejecutar(() async {
      final actualizado = await _dependencias.servicioCierres.corregir(
        usuarioActivo: _requerirUsuario(),
        cierreId: cierreId,
        motivo: motivo,
      );
      _cierres = await _dependencias.servicioCierres.obtenerTodos(
        _requerirUsuario(),
      );
      _sincronizarCierreActual(idPreferido: actualizado.id);
      _auditorias = await _dependencias.servicioCierres.obtenerAuditorias(
        _requerirUsuario(),
        cierreId,
      );
    });
  }

  Future<bool> verAuditorias(String cierreId) {
    return _ejecutar(() async {
      _auditorias = await _dependencias.servicioCierres.obtenerAuditorias(
        _requerirUsuario(),
        cierreId,
      );
    });
  }

  void seleccionarFecha(String fechaLocal) {
    _fechaSeleccionada = fechaLocal;
    _sincronizarCierreActual();
    notifyListeners();
  }

  void _sincronizarCierreActual({String? idPreferido}) {
    if (idPreferido != null) {
      final preferido = _cierres
          .where((cierre) => cierre.id == idPreferido)
          .firstOrNull;
      if (preferido != null) {
        _cierreActual = preferido;
        return;
      }
    }
    _cierreActual = _cierres
        .where((cierre) => cierre.fechaLocal == _fechaSeleccionada)
        .firstOrNull;
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
