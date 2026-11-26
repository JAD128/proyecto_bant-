import '../../datos/repositorios/gasto_repositorio.dart';
import '../../datos/repositorios/pedido_repositorio.dart';
import '../../utilidades/fechas.dart';
import '../../utilidades/generador_ids.dart';
import '../entidades/gasto.dart';
import '../entidades/usuario.dart';
import 'calculador_finanzas.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioFinanzas {
  final GastoRepositorio _gastos;
  final PedidoRepositorio _pedidos;
  final CalculadorFinanzas _calculador;
  final ServicioPermisos _permisos;

  const ServicioFinanzas({
    required this._gastos,
    required this._pedidos,
    required this._calculador,
    required this._permisos,
  });

  Future<ResumenFinanciero> resumen(
    Usuario usuarioActivo, {
    String? desde,
    String? hasta,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.verFinanzas);
    _validarRango(desde, hasta);

    final pedidos = await _pedidos.obtenerTodos();
    final gastos = await _gastos.obtenerTodos();
    return _calculador.calcular(
      pedidos: _enRango(pedidos, desde, hasta, (pedido) => pedido.fechaLocal),
      gastos: _enRango(gastos, desde, hasta, (gasto) => gasto.fechaLocal),
    );
  }

  Future<List<Gasto>> obtenerGastos(
    Usuario usuarioActivo, {
    String? desde,
    String? hasta,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.verFinanzas);
    _validarRango(desde, hasta);

    final resultado = _enRango(
      await _gastos.obtenerTodos(),
      desde,
      hasta,
      (gasto) => gasto.fechaLocal,
    );
    resultado.sort((a, b) {
      final porFecha = b.fechaLocal.compareTo(a.fechaLocal);
      if (porFecha != 0) {
        return porFecha;
      }
      return b.creadoEn.compareTo(a.creadoEn);
    });
    return List.unmodifiable(resultado);
  }

  Future<Gasto> registrarGasto({
    required Usuario usuarioActivo,
    required String fechaLocal,
    required String concepto,
    required int valor,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.registrarGasto);
    Validadores.texto(concepto, 'concepto', max: 120);
    _validarFecha(fechaLocal);
    _validarValor(valor);

    final ahora = DateTime.now();
    final gasto = Gasto(
      id: GeneradorIds.nuevo(),
      descripcion: concepto.trim(),
      valor: valor,
      fechaLocal: fechaLocal,
      horaLocal: Fechas.horaLocal(ahora),
      usuarioId: usuarioActivo.id,
      creadoEn: ahora,
    );
    await _gastos.guardar(gasto);
    return gasto;
  }

  Future<void> actualizarGasto({
    required Usuario usuarioActivo,
    required String gastoId,
    String? fechaLocal,
    String? concepto,
    int? valor,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.registrarGasto);
    Validadores.texto(gastoId, 'gastoId');

    if (fechaLocal != null) {
      _validarFecha(fechaLocal);
    }
    if (concepto != null) {
      Validadores.texto(concepto, 'concepto', max: 120);
    }
    if (valor != null) {
      _validarValor(valor);
    }

    final gasto = await _gastos.obtenerPorId(gastoId);
    if (gasto == null) {
      throw StateError('Gasto no encontrado.');
    }

    await _gastos.actualizar(
      Gasto(
        id: gasto.id,
        descripcion: concepto == null ? gasto.descripcion : concepto.trim(),
        valor: valor ?? gasto.valor,
        fechaLocal: fechaLocal ?? gasto.fechaLocal,
        horaLocal: gasto.horaLocal,
        categoria: gasto.categoria,
        observaciones: gasto.observaciones,
        usuarioId: gasto.usuarioId,
        creadoEn: gasto.creadoEn,
      ),
    );
  }

  void _validarRango(String? desde, String? hasta) {
    if (desde != null) {
      _validarFecha(desde);
    }
    if (hasta != null) {
      _validarFecha(hasta);
    }
    if (desde != null && hasta != null && desde.compareTo(hasta) > 0) {
      throw ArgumentError.value(
        desde,
        'desde',
        'La fecha desde no puede ser mayor que hasta.',
      );
    }
  }

  void _validarFecha(String fechaLocal) => Validadores.fechaLocal(fechaLocal);

  void _validarValor(int valor) {
    Validadores.dinero(valor, 'valor');
    if (valor <= 0) {
      throw ArgumentError.value(valor, 'valor', 'El valor debe ser positivo.');
    }
  }

  List<T> _enRango<T>(
    List<T> elementos,
    String? desde,
    String? hasta,
    String Function(T elemento) fechaDe,
  ) {
    return elementos.where((elemento) {
      final fecha = fechaDe(elemento);
      if (desde != null && fecha.compareTo(desde) < 0) {
        return false;
      }
      if (hasta != null && fecha.compareTo(hasta) > 0) {
        return false;
      }
      return true;
    }).toList();
  }
}
