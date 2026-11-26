import 'package:bantu/datos/repositorios/pedido_repositorio.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';

Pedido pedidoHistorial({
  String id = 'pedido-1',
  String empleadoId = 'mesero1',
  String fechaLocal = '2026-01-01',
  String horaLocal = '12:00',
  EstadoPedido estado = EstadoPedido.confirmado,
  ModalidadPedido modalidad = ModalidadPedido.local,
  MetodoPago metodoPago = MetodoPago.efectivo,
  int total = 1000,
  String? motivoAnulacion,
  List<ItemPedido>? items,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Pedido(
    id: id,
    idempotenciaKey: 'clave-$id',
    empleadoId: empleadoId,
    fechaLocal: fechaLocal,
    horaLocal: horaLocal,
    creadoEn: ahora,
    modalidad: modalidad,
    metodoPago: metodoPago,
    estado: estado,
    subtotal: total,
    costoEmpaque: 0,
    total: total,
    motivoAnulacion: motivoAnulacion,
    items:
        items ??
        [
          ItemPedido(
            id: 'item-$id',
            productoId: 'producto-1',
            nombreProducto: 'Agua',
            categoriaNombre: 'Bebidas',
            cantidad: 1,
            modalidad: modalidad,
            precioUnitario: total,
            costoEmpaqueUnitario: 0,
            subtotal: total,
            total: total,
          ),
        ],
  );
}

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
