import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/entidades/producto.dart';
import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../dominio/valores/metodo_pago.dart';
import '../../dominio/valores/modalidad_pedido.dart';
import '../../estado/menu_proveedor.dart';
import '../../estado/pedido_proveedor.dart';
import '../../utilidades/fechas.dart';
import '../../utilidades/formato_moneda.dart';
import '../widgets/contenido_responsive.dart';
import '../widgets/guardia_rol.dart';

class PedidoPagina extends StatefulWidget {
  const PedidoPagina({super.key});

  @override
  State<PedidoPagina> createState() => _PedidoPaginaState();
}

class _PedidoPaginaState extends State<PedidoPagina> {
  final _formulario = GlobalKey<FormState>();
  final _fecha = TextEditingController(text: Fechas.claveLocal(DateTime.now()));
  final _hora = TextEditingController(text: Fechas.horaLocal(DateTime.now()));
  final _pedidoIdAnular = TextEditingController();
  final _motivoAnular = TextEditingController();
  MetodoPago _metodoPago = MetodoPago.efectivo;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<MenuProveedor>().cargar();
    });
  }

  @override
  void dispose() {
    _fecha.dispose();
    _hora.dispose();
    _pedidoIdAnular.dispose();
    _motivoAnular.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProveedor>();
    final pedido = context.watch<PedidoProveedor>();
    final productosActivos = menu.productos
        .where((producto) => producto.activo)
        .toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Pedidos')),
      body: SafeArea(
        child: ContenidoResponsive(
          child: Form(
            key: _formulario,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _resumen(pedido),
                  const SizedBox(height: 24),
                  Text(
                    'Productos activos',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  if (menu.cargando && productosActivos.isEmpty)
                    const Center(child: CircularProgressIndicator())
                  else if (productosActivos.isEmpty)
                    const Card(
                      child: ListTile(
                        title: Text('No hay productos activos.'),
                        subtitle: Text(
                          'Configura el menú antes de registrar pedidos.',
                        ),
                      ),
                    )
                  else
                    for (final producto in productosActivos)
                      _controlProducto(producto, pedido),
                  const SizedBox(height: 24),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Datos del pedido',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _fecha,
                            decoration: const InputDecoration(
                              labelText: 'Fecha (YYYY-MM-DD)',
                              prefixIcon: Icon(Icons.calendar_today_outlined),
                            ),
                            validator: _validarFecha,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _hora,
                            decoration: const InputDecoration(
                              labelText: 'Hora (HH:mm)',
                              prefixIcon: Icon(Icons.access_time_outlined),
                            ),
                            validator: _validarHora,
                          ),
                          const SizedBox(height: 12),
                          DropdownButtonFormField<MetodoPago>(
                            initialValue: _metodoPago,
                            decoration: const InputDecoration(
                              labelText: 'Método de pago',
                              prefixIcon: Icon(Icons.payments_outlined),
                            ),
                            items: const [
                              DropdownMenuItem(
                                value: MetodoPago.efectivo,
                                child: Text('Efectivo'),
                              ),
                              DropdownMenuItem(
                                value: MetodoPago.transferencia,
                                child: Text('Transferencia'),
                              ),
                            ],
                            onChanged: pedido.cargando
                                ? null
                                : (valor) {
                                    if (valor != null) {
                                      setState(() => _metodoPago = valor);
                                    }
                                  },
                          ),
                          const SizedBox(height: 16),
                          Semantics(
                            button: true,
                            label: 'Confirmar pedido',
                            child: FilledButton.icon(
                              onPressed:
                                  pedido.cargando ||
                                      pedido.itemsCarrito.isEmpty ||
                                      pedido.resultado == null
                                  ? null
                                  : _confirmar,
                              icon: const Icon(Icons.check_circle_outline),
                              label: const Text('Confirmar'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  GuardiaRol(
                    accion: Accion.anularPedido,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Anular pedido',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _pedidoIdAnular,
                              decoration: const InputDecoration(
                                labelText: 'ID del pedido',
                                prefixIcon: Icon(Icons.receipt_outlined),
                              ),
                              validator: (valor) =>
                                  _validarTexto(valor, 'pedidoId'),
                            ),
                            const SizedBox(height: 12),
                            TextFormField(
                              controller: _motivoAnular,
                              decoration: const InputDecoration(
                                labelText: 'Motivo',
                                prefixIcon: Icon(Icons.notes_outlined),
                              ),
                              validator: (valor) =>
                                  _validarTexto(valor, 'motivo'),
                            ),
                            const SizedBox(height: 16),
                            Semantics(
                              button: true,
                              label: 'Anular pedido',
                              child: FilledButton.tonalIcon(
                                onPressed: pedido.cargando ? null : _anular,
                                icon: const Icon(Icons.block_outlined),
                                label: const Text('Anular pedido'),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _resumen(PedidoProveedor pedido) {
    final resultado = pedido.resultado;
    final llevar =
        resultado?.lineas.any(
          (linea) => linea.modalidad == ModalidadPedido.llevar,
        ) ??
        false;
    final estiloTotal = Theme.of(context).textTheme.titleMedium;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Resumen en vivo',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            _fila('Subtotal', FormatoMoneda.cop(resultado?.subtotal ?? 0)),
            const SizedBox(height: 4),
            _fila('Empaque', FormatoMoneda.cop(resultado?.costoEmpaque ?? 0)),
            const Divider(),
            _fila(
              'Total',
              FormatoMoneda.cop(resultado?.total ?? 0),
              estiloTotal,
            ),
            const SizedBox(height: 4),
            Text(
              llevar ? 'Modalidad: llevar' : 'Modalidad: local',
              textAlign: TextAlign.end,
            ),
          ],
        ),
      ),
    );
  }

  Widget _fila(String etiqueta, String valor, [TextStyle? estilo]) {
    return Semantics(
      container: true,
      label: '$etiqueta: $valor',
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(etiqueta, style: estilo),
          Text(valor, style: estilo),
        ],
      ),
    );
  }

  Widget _controlProducto(Producto producto, PedidoProveedor pedido) {
    final cantidad = pedido.cantidad(producto.id);
    final modalidad = pedido.modalidad(producto.id);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.restaurant_menu_outlined),
              title: Text(producto.nombre),
              subtitle: Text(FormatoMoneda.cop(producto.precioLocal)),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Semantics(
                    button: true,
                    label: 'Quitar ${producto.nombre}',
                    child: IconButton(
                      tooltip: 'Quitar ${producto.nombre}',
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: pedido.cargando || cantidad == 0
                          ? null
                          : () => pedido.cambiarCantidad(
                              producto.id,
                              cantidad - 1,
                            ),
                    ),
                  ),
                  Semantics(
                    label: 'Cantidad de ${producto.nombre}: $cantidad',
                    child: Text('$cantidad'),
                  ),
                  Semantics(
                    button: true,
                    label: 'Agregar ${producto.nombre}',
                    child: IconButton(
                      tooltip: 'Agregar ${producto.nombre}',
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: pedido.cargando
                          ? null
                          : () => pedido.agregar(producto),
                    ),
                  ),
                ],
              ),
            ),
            if (cantidad > 0)
              Semantics(
                label: 'Modalidad de ${producto.nombre}: ${modalidad.texto}',
                child: Row(
                  children: [
                    const Text('Modalidad:'),
                    const SizedBox(width: 8),
                    DropdownButton<ModalidadPedido>(
                      value: modalidad,
                      items: const [
                        DropdownMenuItem(
                          value: ModalidadPedido.local,
                          child: Text('Local'),
                        ),
                        DropdownMenuItem(
                          value: ModalidadPedido.llevar,
                          child: Text('Llevar'),
                        ),
                      ],
                      onChanged: pedido.cargando
                          ? null
                          : (valor) {
                              if (valor != null) {
                                pedido.cambiarModalidad(producto.id, valor);
                              }
                            },
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _confirmar() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<PedidoProveedor>();
    final correcto = await proveedor.confirmar(
      metodoPago: _metodoPago,
      fechaLocal: _fecha.text.trim(),
      horaLocal: _hora.text.trim(),
    );
    if (!mounted) {
      return;
    }
    final pedido = proveedor.pedidoConfirmado;
    final mensaje = correcto && pedido != null
        ? 'Pedido confirmado por ${FormatoMoneda.cop(pedido.total)}.'
        : proveedor.error ?? 'No se pudo confirmar el pedido.';
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }

  Future<void> _anular() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<PedidoProveedor>();
    final correcto = await proveedor.anular(
      _pedidoIdAnular.text.trim(),
      _motivoAnular.text.trim(),
    );
    if (!mounted) {
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          correcto
              ? 'Pedido anulado.'
              : proveedor.error ?? 'No se pudo anular el pedido.',
        ),
      ),
    );
    if (correcto) {
      _pedidoIdAnular.clear();
      _motivoAnular.clear();
    }
  }

  String? _validarFecha(String? valor) {
    try {
      Validadores.fechaLocal(valor?.trim() ?? '');
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Fecha inválida.';
    }
  }

  String? _validarHora(String? valor) {
    try {
      Validadores.horaLocal(valor?.trim() ?? '');
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Hora inválida.';
    }
  }

  String? _validarTexto(String? valor, String campo) {
    try {
      Validadores.texto(valor?.trim() ?? '', campo);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Texto inválido.';
    }
  }
}
