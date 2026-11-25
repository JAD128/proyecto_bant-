import '../../dominio/entidades/cierre_diario.dart';

abstract class CierreRepositorio {
  Future<List<CierreDiario>> obtenerTodos();

  Future<CierreDiario?> obtenerPorFecha(String fechaLocal);

  Future<List<CierreAuditoria>> obtenerAuditorias(String cierreId);

  Future<void> guardar(CierreDiario cierre);

  Future<void> actualizar(CierreDiario cierre);

  Future<void> auditar(CierreAuditoria auditoria);
}
