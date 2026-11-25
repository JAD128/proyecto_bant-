import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'repositorio_sesion.dart';

class RepositorioSesionSeguro implements RepositorioSesion {
  static const String _claveUsuario = 'bantu.usuario_activo';
  static const String _claveConfigurado = 'bantu.configuracion_inicial';

  final FlutterSecureStorage _almacen;

  const RepositorioSesionSeguro(this._almacen);

  @override
  Future<String?> obtenerUsuarioActivoId() => _almacen.read(key: _claveUsuario);

  @override
  Future<void> guardarUsuarioActivo(String id) =>
      _almacen.write(key: _claveUsuario, value: id);

  @override
  Future<void> cerrar() => _almacen.delete(key: _claveUsuario);

  @override
  Future<bool> configuracionInicialCompleta() async {
    final valor = await _almacen.read(key: _claveConfigurado);
    return valor == 'true';
  }

  @override
  Future<void> marcarConfiguracionInicialCompleta() =>
      _almacen.write(key: _claveConfigurado, value: 'true');
}
