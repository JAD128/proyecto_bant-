import '../entidades/gasto.dart';
import '../entidades/pedido.dart';
import '../valores/estado_pedido.dart';
import '../valores/metodo_pago.dart';
import '../valores/modalidad_pedido.dart';

class ResumenFinanciero {
  final int ingresos;
  final int ingresosEfectivo;
  final int ingresosTransferencia;
  final int ingresosLlevar;
  final int ingresosLocal;
  final int egresos;
  final int saldoNeto;
  final int efectivoEnCaja;
  final int cantidadPedidos;

  const ResumenFinanciero({
    this.ingresos = 0,
    this.ingresosEfectivo = 0,
    this.ingresosTransferencia = 0,
    this.ingresosLlevar = 0,
    this.ingresosLocal = 0,
    this.egresos = 0,
    this.saldoNeto = 0,
    this.efectivoEnCaja = 0,
    this.cantidadPedidos = 0,
  });
}

class CalculadorFinanzas {
  const CalculadorFinanzas();

  ResumenFinanciero calcular({
    required List<Pedido> pedidos,
    required List<Gasto> gastos,
  }) {
    var ingresos = 0;
    var efectivo = 0;
    var transferencia = 0;
    var llevar = 0;
    var local = 0;
    var cantidadPedidos = 0;

    for (final pedido in pedidos) {
      if (pedido.estado != EstadoPedido.confirmado) {
        continue;
      }
      cantidadPedidos++;
      ingresos += pedido.total;
      if (pedido.metodoPago == MetodoPago.efectivo) {
        efectivo += pedido.total;
      } else {
        transferencia += pedido.total;
      }
      if (pedido.modalidad == ModalidadPedido.llevar) {
        llevar += pedido.total;
      } else {
        local += pedido.total;
      }
    }

    var egresos = 0;
    for (final gasto in gastos) {
      egresos += gasto.valor;
    }

    return ResumenFinanciero(
      ingresos: ingresos,
      ingresosEfectivo: efectivo,
      ingresosTransferencia: transferencia,
      ingresosLlevar: llevar,
      ingresosLocal: local,
      egresos: egresos,
      saldoNeto: ingresos - egresos,
      efectivoEnCaja: efectivo,
      cantidadPedidos: cantidadPedidos,
    );
  }
}
