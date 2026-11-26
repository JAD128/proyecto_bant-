import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/servicios/servicio_exportacion.dart';
import '../dominio/valores/formato_exportacion.dart';
import '../dominio/valores/tipo_exportacion.dart';
import 'sesion_proveedor.dart';

class ExportacionProveedor extends ChangeNotifier {
  final SesionProveedor _sesion;
  final ServicioExportacion _servicio;

  String? _ruta;
  bool _cargando = false;
  String? _error;

  ExportacionProveedor({
    required Dependencias dependencias,
    required this._sesion,
    ServicioExportacion? servicio,
  }) : _servicio = servicio ?? dependencias.servicioExportacion;

  String? get ruta => _ruta;
  bool get cargando => _cargando;
  String? get error => _error;

  Future<bool> exportar({
    required TipoExportacion tipo,
    required FormatoExportacion formato,
    String? desde,
    String? hasta,
  }) {
    return _ejecutar(() async {
      _ruta = await _servicio.exportar(
        usuarioActivo: _requerirUsuario(),
        tipo: tipo,
        formato: formato,
        desde: desde,
        hasta: hasta,
      );
    });
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
    _ruta = null;
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
    return 'No se pudo generar el archivo.';
  }
}
