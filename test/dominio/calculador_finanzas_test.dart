import 'package:bantu/dominio/entidades/gasto.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/servicios/calculador_finanzas.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:flutter_test/flutter_test.dart';

Pedido pedido({
  required String id,
  required int total,
  ModalidadPedido modalidad = ModalidadPedido.local,
  MetodoPago metodoPago = MetodoPago.efectivo,
  EstadoPedido estado = EstadoPedido.confirmado,
}) {
  return Pedido(
    id: id,
    idempotenciaKey: 'idem-$id',
    empleadoId: 'u1',
    fechaLocal: '2026-01-01',
    horaLocal: '12:00',
    creadoEn: DateTime.utc(2026, 1, 1, 12),
    modalidad: modalidad,
    metodoPago: metodoPago,
    estado: estado,
    subtotal: total,
    costoEmpaque: 0,
    total: total,
  );
}

void main() {
  const calculador = CalculadorFinanzas();

  group('CalculadorFinanzas', () {
    test('separa ingresos por metodo y modalidad', () {
      final resumen = calculador.calcular(
        pedidos: [
          pedido(id: 'p1', total: 20000),
          pedido(
            id: 'p2',
            total: 15000,
            modalidad: ModalidadPedido.llevar,
            metodoPago: MetodoPago.transferencia,
          ),
          pedido(id: 'p3', total: 99999, estado: EstadoPedido.anulado),
        ],
        gastos: [
          Gasto(
            id: 'g1',
            descripcion: 'Combustible',
            valor: 5000,
            fechaLocal: '2026-01-01',
            horaLocal: '13:00',
            usuarioId: 'u1',
            creadoEn: DateTime.utc(2026, 1, 1, 13),
          ),
        ],
      );

      expect(resumen.cantidadPedidos, 2);
      expect(resumen.ingresos, 35000);
      expect(resumen.ingresosEfectivo, 20000);
      expect(resumen.ingresosTransferencia, 15000);
      expect(resumen.ingresosLocal, 20000);
      expect(resumen.ingresosLlevar, 15000);
      expect(resumen.egresos, 5000);
      expect(resumen.saldoNeto, 30000);
      expect(resumen.efectivoEnCaja, 20000);
    });

    test('los gastos no afectan el efectivo en caja', () {
      final resumen = calculador.calcular(
        pedidos: [pedido(id: 'p1', total: 10000)],
        gastos: [
          Gasto(
            id: 'g1',
            descripcion: 'Papeleria',
            valor: 7000,
            fechaLocal: '2026-01-01',
            horaLocal: '14:00',
            usuarioId: 'u1',
            creadoEn: DateTime.utc(2026, 1, 1, 14),
          ),
        ],
      );

      expect(resumen.efectivoEnCaja, 10000);
      expect(resumen.saldoNeto, 3000);
    });

    test('resumen vacio en cero', () {
      final resumen = calculador.calcular(pedidos: const [], gastos: const []);

      expect(resumen.ingresos, 0);
      expect(resumen.egresos, 0);
      expect(resumen.saldoNeto, 0);
      expect(resumen.efectivoEnCaja, 0);
      expect(resumen.cantidadPedidos, 0);
    });
  });
}
