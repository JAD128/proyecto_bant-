import 'package:bantu/datos/repositorios/pedido_repositorio.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';

class AuditoriaAnulacionMemoria {
  final String pedidoId;
  final String motivo;
  final String usuarioId;
  final DateTime creadoEn;

  const AuditoriaAnulacionMemoria({
    required this.pedidoId,
    required this.motivo,
    required this.usuarioId,
    required this.creadoEn,
  });
}

class PedidoRepositorioMemoria implements PedidoRepositorio {
  final Map<String, Pedido> _porId = <String, Pedido>{};
  final Map<String, String> _porIdempotencia = <String, String>{};
  final List<AuditoriaAnulacionMemoria> _auditorias =
      <AuditoriaAnulacionMemoria>[];

  List<AuditoriaAnulacionMemoria> get auditorias =>
      List.unmodifiable(_auditorias);

  @override
  Future<void> guardar(Pedido pedido) async {
    final idExistente = _porIdempotencia[pedido.idempotenciaKey];
    if (idExistente != null && idExistente != pedido.id) {
      throw StateError('Ya existe un pedido con esa idempotenciaKey.');
    }
    if (_porId.containsKey(pedido.id)) {
      throw StateError('Pedido ya existe: ${pedido.id}');
    }
    _porId[pedido.id] = pedido;
    _porIdempotencia[pedido.idempotenciaKey] = pedido.id;
  }

  @override
  Future<Pedido?> obtenerPorId(String id) async => _porId[id];

  @override
  Future<Pedido?> obtenerPorIdempotenciaKey(String clave) async {
    final id = _porIdempotencia[clave];
    return id == null ? null : _porId[id];
  }

  @override
  Future<List<Pedido>> obtenerTodos() async => List.unmodifiable(_porId.values);

  @override
  Future<List<Pedido>> obtenerPorFecha(String fechaLocal) async {
    return List.unmodifiable(
      _porId.values.where((pedido) => pedido.fechaLocal == fechaLocal),
    );
  }

  @override
  Future<List<Pedido>> obtenerPorEmpleado(String empleadoId) async {
    return List.unmodifiable(
      _porId.values.where((pedido) => pedido.empleadoId == empleadoId),
    );
  }

  @override
  Future<void> anular({
    required String pedidoId,
    required String motivo,
    required String usuarioId,
  }) async {
    final pedido = await obtenerPorId(pedidoId);
    if (pedido == null) {
      throw StateError('Pedido no encontrado: $pedidoId');
    }
    if (pedido.estado == EstadoPedido.anulado) {
      return;
    }
    _porId[pedido.id] = Pedido(
      id: pedido.id,
      idempotenciaKey: pedido.idempotenciaKey,
      empleadoId: pedido.empleadoId,
      fechaLocal: pedido.fechaLocal,
      horaLocal: pedido.horaLocal,
      creadoEn: pedido.creadoEn,
      modalidad: pedido.modalidad,
      metodoPago: pedido.metodoPago,
      estado: EstadoPedido.anulado,
      subtotal: pedido.subtotal,
      costoEmpaque: pedido.costoEmpaque,
      total: pedido.total,
      motivoAnulacion: motivo,
      items: pedido.items,
    );
    _auditorias.add(
      AuditoriaAnulacionMemoria(
        pedidoId: pedidoId,
        motivo: motivo,
        usuarioId: usuarioId,
        creadoEn: DateTime.now(),
      ),
    );
  }
}
