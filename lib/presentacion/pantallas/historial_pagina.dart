import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/entidades/pedido.dart';
import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../dominio/valores/estado_pedido.dart';
import '../../dominio/valores/metodo_pago.dart';
import '../../dominio/valores/modalidad_pedido.dart';
import '../../estado/historial_proveedor.dart';
import '../../estado/sesion_proveedor.dart';
import '../../utilidades/formato_moneda.dart';

class HistorialPagina extends StatefulWidget {
  const HistorialPagina({super.key});

  @override
  State<HistorialPagina> createState() => _HistorialPaginaState();
}

class _HistorialPaginaState extends State<HistorialPagina> {
  final _formulario = GlobalKey<FormState>();
  final _desde = TextEditingController();
  final _hasta = TextEditingController();
  EstadoPedido? _estado;
  ModalidadPedido? _modalidad;
  String? _empleadoId;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final sesion = context.read<SesionProveedor>();
      if (sesion.esAdministrador && sesion.puede(Accion.verTodosPedidos)) {
        await sesion.cargarUsuarios();
      }
      if (!mounted) {
        return;
      }
      await context.read<HistorialProveedor>().cargar();
    });
  }

  @override
  void dispose() {
    _desde.dispose();
    _hasta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final historial = context.watch<HistorialProveedor>();
    final sesion = context.watch<SesionProveedor>();
    final puedeElegirEmpleado =
        sesion.esAdministrador && sesion.puede(Accion.verTodosPedidos);

    return Scaffold(
      appBar: AppBar(title: const Text('Historial de pedidos')),
      body: SafeArea(
        child: Form(
          key: _formulario,
          child: Column(
            children: [
              _filtros(sesion, puedeElegirEmpleado, historial.cargando),
              Expanded(child: _lista(historial, sesion)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _filtros(
    SesionProveedor sesion,
    bool puedeElegirEmpleado,
    bool cargando,
  ) {
    return Card(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 180,
              child: TextFormField(
                controller: _desde,
                decoration: const InputDecoration(
                  labelText: 'Desde (YYYY-MM-DD)',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                validator: _validarFechaOpcional,
              ),
            ),
            SizedBox(
              width: 180,
              child: TextFormField(
                controller: _hasta,
                decoration: const InputDecoration(
                  labelText: 'Hasta (YYYY-MM-DD)',
                  prefixIcon: Icon(Icons.calendar_month_outlined),
                ),
                validator: _validarFechaOpcional,
              ),
            ),
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<EstadoPedido>(
                initialValue: _estado,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Estado',
                  prefixIcon: Icon(Icons.flag_outlined),
                ),
                items: const [
                  DropdownMenuItem<EstadoPedido>(
                    value: null,
                    child: Text('Todos los estados'),
                  ),
                  DropdownMenuItem(
                    value: EstadoPedido.confirmado,
                    child: Text('Confirmado'),
                  ),
                  DropdownMenuItem(
                    value: EstadoPedido.anulado,
                    child: Text('Anulado'),
                  ),
                ],
                onChanged: cargando
                    ? null
                    : (valor) => setState(() => _estado = valor),
              ),
            ),
            SizedBox(
              width: 180,
              child: DropdownButtonFormField<ModalidadPedido>(
                initialValue: _modalidad,
                isExpanded: true,
                decoration: const InputDecoration(
                  labelText: 'Modalidad',
                  prefixIcon: Icon(Icons.delivery_dining_outlined),
                ),
                items: const [
                  DropdownMenuItem<ModalidadPedido>(
                    value: null,
                    child: Text('Todas las modalidades'),
                  ),
                  DropdownMenuItem(
                    value: ModalidadPedido.local,
                    child: Text('Local'),
                  ),
                  DropdownMenuItem(
                    value: ModalidadPedido.llevar,
                    child: Text('Llevar'),
                  ),
                ],
                onChanged: cargando
                    ? null
                    : (valor) => setState(() => _modalidad = valor),
              ),
            ),
            if (puedeElegirEmpleado)
              SizedBox(
                width: 200,
                child: DropdownButtonFormField<String?>(
                  initialValue: _empleadoId,
                  isExpanded: true,
                  decoration: const InputDecoration(
                    labelText: 'Empleado',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  items: [
                    const DropdownMenuItem<String?>(
                      value: null,
                      child: Text('Todos los empleados'),
                    ),
                    for (final usuario in sesion.usuarios)
                      DropdownMenuItem<String?>(
                        value: usuario.id,
                        child: Text(usuario.nombre),
                      ),
                  ],
                  onChanged: cargando
                      ? null
                      : (valor) => setState(() => _empleadoId = valor),
                ),
              ),
            FilledButton.icon(
              onPressed: cargando ? null : _aplicarFiltros,
              icon: const Icon(Icons.filter_list_outlined),
              label: const Text('Aplicar filtros'),
            ),
            TextButton.icon(
              onPressed: cargando ? null : _limpiarFiltros,
              icon: const Icon(Icons.clear_all_outlined),
              label: const Text('Limpiar'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lista(HistorialProveedor historial, SesionProveedor sesion) {
    if (historial.cargando && historial.pedidos.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (historial.pedidos.isEmpty) {
      return const Center(
        child: Card(
          child: ListTile(
            title: Text('No hay pedidos'),
            subtitle: Text('Prueba con otros filtros.'),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      itemCount: historial.pedidos.length,
      itemBuilder: (context, indice) {
        final pedido = historial.pedidos[indice];
        return Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${pedido.fechaLocal} · ${pedido.horaLocal}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 4),
                      Text('Total: ${FormatoMoneda.cop(pedido.total)}'),
                      Text('Estado: ${_textoEstado(pedido.estado)}'),
                      Text('Modalidad: ${_textoModalidad(pedido.modalidad)}'),
                      if (sesion.esAdministrador)
                        Text(
                          'Empleado: ${_nombreEmpleado(sesion, pedido.empleadoId)}',
                        ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                FilledButton.tonal(
                  onPressed: () => _mostrarDetalle(pedido),
                  child: const Text('Detalle'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _nombreEmpleado(SesionProveedor sesion, String id) {
    return sesion.usuarios
            .where((usuario) => usuario.id == id)
            .map((usuario) => usuario.nombre)
            .firstOrNull ??
        id;
  }

  Future<void> _mostrarDetalle(Pedido pedido) async {
    final proveedor = context.read<HistorialProveedor>();
    final detalle = await proveedor.detalle(pedido.id);
    if (!mounted) {
      return;
    }
    if (detalle == null) {
      _mostrarMensaje(proveedor.error ?? 'No se pudo cargar el detalle.');
      return;
    }

    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Detalle del pedido'),
        content: SizedBox(
          width: double.maxFinite,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                _dato('Fecha', detalle.fechaLocal),
                _dato('Hora', detalle.horaLocal),
                _dato('Estado', _textoEstado(detalle.estado)),
                _dato('Modalidad', _textoModalidad(detalle.modalidad)),
                _dato('Método de pago', _textoMetodoPago(detalle.metodoPago)),
                _dato('Subtotal', FormatoMoneda.cop(detalle.subtotal)),
                _dato('Empaque', FormatoMoneda.cop(detalle.costoEmpaque)),
                _dato('Total', FormatoMoneda.cop(detalle.total)),
                if (detalle.motivoAnulacion != null)
                  _dato('Motivo de anulación', detalle.motivoAnulacion!),
                const Divider(),
                Text(
                  'Ítems del pedido',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                for (final item in detalle.items) _tarjetaItem(item),
                if (detalle.items.isEmpty)
                  const Text('El pedido no tiene ítems registrados.'),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cerrar'),
          ),
        ],
      ),
    );
  }

  Widget _dato(String etiqueta, String valor) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Text('$etiqueta: $valor'),
    );
  }

  Widget _tarjetaItem(ItemPedido item) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${item.cantidad} × ${item.nombreProducto}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('Categoría: ${item.categoriaNombre}'),
            Text('Modalidad: ${_textoModalidad(item.modalidad)}'),
            Text('Precio unitario: ${FormatoMoneda.cop(item.precioUnitario)}'),
            Text(
              'Empaque unitario: '
              '${FormatoMoneda.cop(item.costoEmpaqueUnitario)}',
            ),
            Text('Subtotal: ${FormatoMoneda.cop(item.subtotal)}'),
            Text('Total: ${FormatoMoneda.cop(item.total)}'),
          ],
        ),
      ),
    );
  }

  Future<void> _aplicarFiltros() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<HistorialProveedor>();
    final correcto = await proveedor.cambiarFiltros(
      desde: _desde.text,
      hasta: _hasta.text,
      empleadoId: _empleadoId,
      estado: _estado,
      modalidad: _modalidad,
    );
    if (!mounted) {
      return;
    }
    if (!correcto) {
      _mostrarMensaje(proveedor.error ?? 'No se pudieron aplicar los filtros.');
    }
  }

  Future<void> _limpiarFiltros() async {
    setState(() {
      _desde.clear();
      _hasta.clear();
      _estado = null;
      _modalidad = null;
      _empleadoId = null;
    });
    final proveedor = context.read<HistorialProveedor>();
    final correcto = await proveedor.limpiarFiltros();
    if (!mounted) {
      return;
    }
    _mostrarMensaje(
      correcto
          ? 'Filtros limpiados.'
          : proveedor.error ?? 'No se pudieron limpiar los filtros.',
    );
  }

  String? _validarFechaOpcional(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      return null;
    }
    try {
      Validadores.fechaLocal(texto);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Fecha inválida.';
    }
  }

  String _textoEstado(EstadoPedido estado) =>
      estado == EstadoPedido.confirmado ? 'Confirmado' : 'Anulado';

  String _textoModalidad(ModalidadPedido modalidad) =>
      modalidad == ModalidadPedido.local ? 'Local' : 'Llevar';

  String _textoMetodoPago(MetodoPago metodoPago) => switch (metodoPago) {
    MetodoPago.efectivo => 'Efectivo',
    MetodoPago.transferencia => 'Transferencia',
  };

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
