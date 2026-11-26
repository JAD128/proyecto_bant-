import 'package:bantu/datos/repositorios/gasto_repositorio.dart';
import 'package:bantu/datos/repositorios/pedido_repositorio.dart';
import 'package:bantu/dominio/entidades/gasto.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';

import 'fakes_cierres.dart';
import 'fakes_pedidos.dart';

Gasto gastoFinanzas({
  String id = 'gasto-1',
  String descripcion = 'Servicio',
  int valor = 300,
  String fechaLocal = '2026-01-05',
  String horaLocal = '10:00',
  String usuarioId = 'admin',
}) {
  return gastoCierre(
    id: id,
    descripcion: descripcion,
    valor: valor,
    fechaLocal: fechaLocal,
    horaLocal: horaLocal,
    usuarioId: usuarioId,
  );
}

Future<void> sembrarFinanzas({
  required PedidoRepositorio pedidos,
  required GastoRepositorio gastos,
  String empleadoId = 'mesero1',
  String usuarioId = 'admin',
}) async {
  await pedidos.guardar(
    pedidoHistorial(
      empleadoId: empleadoId,
      id: 'p-efectivo-local',
      fechaLocal: '2026-01-05',
      horaLocal: '09:00',
      total: 1000,
    ),
  );
  await pedidos.guardar(
    pedidoHistorial(
      empleadoId: empleadoId,
      id: 'p-transferencia-llevar',
      fechaLocal: '2026-01-05',
      horaLocal: '12:00',
      modalidad: ModalidadPedido.llevar,
      metodoPago: MetodoPago.transferencia,
      total: 2000,
    ),
  );
  await pedidos.guardar(
    pedidoHistorial(
      empleadoId: empleadoId,
      id: 'p-efectivo-llevar',
      fechaLocal: '2026-01-05',
      horaLocal: '15:00',
      modalidad: ModalidadPedido.llevar,
      total: 500,
    ),
  );
  await pedidos.guardar(
    pedidoHistorial(
      empleadoId: empleadoId,
      id: 'p-anulado',
      fechaLocal: '2026-01-05',
      horaLocal: '16:00',
      estado: EstadoPedido.anulado,
      total: 9999,
    ),
  );
  await pedidos.guardar(
    pedidoHistorial(
      empleadoId: empleadoId,
      id: 'p-otro-dia',
      fechaLocal: '2026-01-06',
      horaLocal: '10:00',
      total: 7000,
    ),
  );

  await gastos.guardar(gastoFinanzas(valor: 300, usuarioId: usuarioId));
  await gastos.guardar(
    gastoFinanzas(
      id: 'gasto-otro-dia',
      descripcion: 'Combustible',
      valor: 100,
      fechaLocal: '2026-01-06',
      horaLocal: '11:00',
      usuarioId: usuarioId,
    ),
  );
}
