import '../valores/estado_cierre.dart';

class CierreDiario {
  final String id;
  final String fechaLocal;
  final EstadoCierre estado;
  final int totalPedidos;
  final int totalVentas;
  final int totalEfectivo;
  final int totalTransferencia;
  final int totalLlevar;
  final int totalLocal;
  final int totalEgresos;
  final int saldoNeto;
  final String? cerradoPor;
  final DateTime creadoEn;
  final DateTime? cerradoEn;

  const CierreDiario({
    required this.id,
    required this.fechaLocal,
    this.estado = EstadoCierre.abierto,
    this.totalPedidos = 0,
    this.totalVentas = 0,
    this.totalEfectivo = 0,
    this.totalTransferencia = 0,
    this.totalLlevar = 0,
    this.totalLocal = 0,
    this.totalEgresos = 0,
    this.saldoNeto = 0,
    this.cerradoPor,
    required this.creadoEn,
    this.cerradoEn,
  });
}

class CierreAuditoria {
  final String id;
  final String cierreId;
  final String motivo;
  final String valoresAntes;
  final String valoresDespues;
  final String usuarioId;
  final DateTime creadoEn;

  const CierreAuditoria({
    required this.id,
    required this.cierreId,
    required this.motivo,
    required this.valoresAntes,
    required this.valoresDespues,
    required this.usuarioId,
    required this.creadoEn,
  });
}
