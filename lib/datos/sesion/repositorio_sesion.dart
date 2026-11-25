abstract class RepositorioSesion {
  Future<String?> obtenerUsuarioActivoId();

  Future<void> guardarUsuarioActivo(String id);

  Future<void> cerrar();

  Future<bool> configuracionInicialCompleta();

  Future<void> marcarConfiguracionInicialCompleta();
}
