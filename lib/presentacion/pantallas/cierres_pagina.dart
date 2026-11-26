import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/entidades/cierre_diario.dart';
import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../dominio/valores/estado_cierre.dart';
import '../../estado/cierre_proveedor.dart';
import '../../utilidades/formato_moneda.dart';
import '../widgets/contenido_responsive.dart';
import '../widgets/guardia_rol.dart';

class CierresPagina extends StatefulWidget {
  const CierresPagina({super.key});

  @override
  State<CierresPagina> createState() => _CierresPaginaState();
}

class _CierresPaginaState extends State<CierresPagina> {
  final _claveFecha = GlobalKey<FormState>();
  final _claveCorreccion = GlobalKey<FormState>();
  final _fecha = TextEditingController();
  final _motivo = TextEditingController();

  @override
  void initState() {
    super.initState();
    _fecha.text = context.read<CierreProveedor>().fechaSeleccionada;
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<CierreProveedor>().cargar();
    });
  }

  @override
  void dispose() {
    _fecha.dispose();
    _motivo.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final proveedor = context.watch<CierreProveedor>();
    return GuardiaRol(
      accion: Accion.cerrarDia,
      child: Scaffold(
        appBar: AppBar(title: const Text('Cierres diarios')),
        body: SafeArea(
          child: ContenidoResponsive(
            child: Column(
              children: [
                Form(key: _claveFecha, child: _tarjetaFecha(proveedor)),
                Form(
                  key: _claveCorreccion,
                  child: _tarjetaCorreccion(proveedor),
                ),
                if (proveedor.error != null)
                  Text(
                    proveedor.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                Expanded(child: _lista(proveedor)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tarjetaFecha(CierreProveedor proveedor) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Wrap(
          spacing: 12,
          runSpacing: 12,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: TextFormField(
                controller: _fecha,
                decoration: const InputDecoration(
                  labelText: 'Fecha (YYYY-MM-DD)',
                  prefixIcon: Icon(Icons.calendar_today_outlined),
                ),
                validator: _validarFecha,
                onChanged: (valor) => context
                    .read<CierreProveedor>()
                    .seleccionarFecha(valor.trim()),
              ),
            ),
            Semantics(
              button: true,
              label: 'Cerrar día',
              child: FilledButton.icon(
                onPressed: proveedor.cargando ? null : _cerrarDia,
                icon: const Icon(Icons.lock_outline),
                label: const Text('Cerrar día'),
              ),
            ),
            if (proveedor.cargando)
              const SizedBox(
                width: 24,
                height: 24,
                child: CircularProgressIndicator(strokeWidth: 2),
              ),
          ],
        ),
      ),
    );
  }

  Widget _tarjetaCorreccion(CierreProveedor proveedor) {
    final cierre = proveedor.cierreActual;
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Cierre seleccionado: ${cierre?.fechaLocal ?? 'ninguno'}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _motivo,
              maxLines: 2,
              maxLength: 500,
              decoration: const InputDecoration(
                labelText: 'Motivo de la corrección',
                prefixIcon: Icon(Icons.edit_note_outlined),
              ),
              validator: _validarMotivo,
            ),
            const SizedBox(height: 8),
            Semantics(
              button: true,
              label: 'Corregir cierre',
              child: FilledButton.tonalIcon(
                onPressed: (proveedor.cargando || cierre == null)
                    ? null
                    : _corregir,
                icon: const Icon(Icons.task_alt_outlined),
                label: const Text('Corregir cierre'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _lista(CierreProveedor proveedor) {
    if (proveedor.cargando && proveedor.cierres.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }
    if (proveedor.cierres.isEmpty) {
      return const Center(
        child: Card(
          child: ListTile(
            title: Text('No hay cierres registrados'),
            subtitle: Text('Cierra un día para guardar su snapshot.'),
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.only(bottom: 16),
      itemCount: proveedor.cierres.length,
      itemBuilder: (context, indice) {
        final cierre = proveedor.cierres[indice];
        final seleccionado = proveedor.cierreActual?.id == cierre.id;
        return Card(
          color: seleccionado
              ? Theme.of(context).colorScheme.primaryContainer
              : null,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        '${cierre.fechaLocal} · ${cierre.estado.texto}',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                    ),
                    if (seleccionado)
                      const Icon(Icons.check_circle_outline, size: 20),
                  ],
                ),
                const SizedBox(height: 8),
                _totales(cierre),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Semantics(
                      button: true,
                      label: 'Seleccionar cierre de ${cierre.fechaLocal}',
                      child: TextButton.icon(
                        onPressed: () => context
                            .read<CierreProveedor>()
                            .seleccionarFecha(cierre.fechaLocal),
                        icon: const Icon(Icons.task_alt_outlined),
                        label: const Text('Seleccionar'),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Semantics(
                      button: true,
                      label: 'Ver auditorías de ${cierre.fechaLocal}',
                      child: TextButton.icon(
                        onPressed: () => _verAuditorias(cierre),
                        icon: const Icon(Icons.history_outlined),
                        label: const Text('Auditorías'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _totales(CierreDiario cierre) {
    return Wrap(
      spacing: 12,
      runSpacing: 4,
      children: [
        _dato('Pedidos', '${cierre.totalPedidos}'),
        _dato('Ventas', FormatoMoneda.cop(cierre.totalVentas)),
        _dato('Efectivo', FormatoMoneda.cop(cierre.totalEfectivo)),
        _dato('Transferencia', FormatoMoneda.cop(cierre.totalTransferencia)),
        _dato('Llevar', FormatoMoneda.cop(cierre.totalLlevar)),
        _dato('Local', FormatoMoneda.cop(cierre.totalLocal)),
        _dato('Egresos', FormatoMoneda.cop(cierre.totalEgresos)),
        _dato('Saldo neto', FormatoMoneda.cop(cierre.saldoNeto)),
      ],
    );
  }

  Widget _dato(String etiqueta, String valor) =>
      Semantics(label: '$etiqueta: $valor', child: Text('$etiqueta: $valor'));

  Future<void> _cerrarDia() async {
    if (!_claveFecha.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<CierreProveedor>();
    final fecha = _fecha.text.trim();
    proveedor.seleccionarFecha(fecha);
    final correcto = await proveedor.cerrar(fecha);
    if (!mounted) {
      return;
    }
    if (correcto) {
      setState(() => _fecha.text = proveedor.fechaSeleccionada);
    }
    _mostrarMensaje(
      correcto
          ? 'Cierre registrado.'
          : proveedor.error ?? 'No se pudo cerrar el día.',
    );
  }

  Future<void> _corregir() async {
    final cierre = context.read<CierreProveedor>().cierreActual;
    if (cierre == null) {
      _mostrarMensaje('Selecciona un cierre para corregir.');
      return;
    }
    if (!_claveCorreccion.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<CierreProveedor>();
    final correcto = await proveedor.corregir(cierre.id, _motivo.text.trim());
    if (!mounted) {
      return;
    }
    if (correcto) {
      _motivo.clear();
    }
    _mostrarMensaje(
      correcto
          ? 'Cierre corregido y auditado.'
          : proveedor.error ?? 'No se pudo corregir el cierre.',
    );
  }

  Future<void> _verAuditorias(CierreDiario cierre) async {
    final proveedor = context.read<CierreProveedor>();
    final correcto = await proveedor.verAuditorias(cierre.id);
    if (!mounted) {
      return;
    }
    if (!correcto) {
      _mostrarMensaje(
        proveedor.error ?? 'No se pudieron cargar las auditorías.',
      );
      return;
    }
    final auditorias = proveedor.auditorias;
    await showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Auditorías de ${cierre.fechaLocal}'),
        content: SizedBox(
          width: double.maxFinite,
          child: auditorias.isEmpty
              ? const Text('Este cierre no tiene correcciones registradas.')
              : SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      for (final auditoria in auditorias)
                        _tarjetaAuditoria(auditoria),
                    ],
                  ),
                ),
        ),
        actions: [
          Semantics(
            button: true,
            label: 'Cerrar auditorías',
            child: TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cerrar'),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tarjetaAuditoria(CierreAuditoria auditoria) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Motivo: ${auditoria.motivo}',
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('Fecha: ${auditoria.creadoEn.toLocal().toIso8601String()}'),
            Text('Usuario: ${auditoria.usuarioId}'),
            const SizedBox(height: 4),
            Text('Valores antes: ${auditoria.valoresAntes}'),
            const SizedBox(height: 4),
            Text('Valores después: ${auditoria.valoresDespues}'),
          ],
        ),
      ),
    );
  }

  String? _validarFecha(String? valor) {
    try {
      Validadores.fechaLocal(valor?.trim() ?? '');
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Fecha inválida.';
    }
  }

  String? _validarMotivo(String? valor) {
    try {
      Validadores.texto(valor?.trim() ?? '', 'motivo', max: 500);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Motivo inválido.';
    }
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }
}
