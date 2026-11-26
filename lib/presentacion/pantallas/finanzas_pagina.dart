import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/entidades/gasto.dart';
import '../../dominio/servicios/calculador_finanzas.dart';
import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../estado/finanzas_proveedor.dart';
import '../../utilidades/fechas.dart';
import '../../utilidades/formato_moneda.dart';
import '../widgets/contenido_responsive.dart';
import '../widgets/guardia_rol.dart';

class FinanzasPagina extends StatefulWidget {
  const FinanzasPagina({super.key});

  @override
  State<FinanzasPagina> createState() => _FinanzasPaginaState();
}

class _FinanzasPaginaState extends State<FinanzasPagina> {
  final _formularioRango = GlobalKey<FormState>();
  final _formularioGasto = GlobalKey<FormState>();
  final _desde = TextEditingController();
  final _hasta = TextEditingController();
  final _concepto = TextEditingController();
  final _valor = TextEditingController();
  final _fechaGasto = TextEditingController(text: Fechas.hoyLocal());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await context.read<FinanzasProveedor>().cargar();
    });
  }

  @override
  void dispose() {
    _desde.dispose();
    _hasta.dispose();
    _concepto.dispose();
    _valor.dispose();
    _fechaGasto.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final finanzas = context.watch<FinanzasProveedor>();
    return GuardiaRol(
      accion: Accion.verFinanzas,
      child: Scaffold(
        appBar: AppBar(title: const Text('Finanzas')),
        body: SafeArea(
          child: ContenidoResponsive(
            child: Column(
              children: [
                Form(key: _formularioRango, child: _tarjetaRango(finanzas)),
                _resumen(finanzas.resumen),
                if (finanzas.error != null)
                  Text(
                    finanzas.error!,
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        GuardiaRol(
                          accion: Accion.registrarGasto,
                          child: Form(
                            key: _formularioGasto,
                            child: _formularioGastoWidget(finanzas),
                          ),
                        ),
                        _listaGastos(finanzas),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _tarjetaRango(FinanzasProveedor finanzas) {
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
            Semantics(
              button: true,
              label: 'Aplicar rango financiero',
              child: FilledButton.icon(
                onPressed: finanzas.cargando ? null : _aplicarRango,
                icon: const Icon(Icons.filter_list_outlined),
                label: const Text('Aplicar rango'),
              ),
            ),
            Semantics(
              button: true,
              label: 'Limpiar rango financiero',
              child: TextButton.icon(
                onPressed: finanzas.cargando ? null : _limpiarRango,
                icon: const Icon(Icons.clear_all_outlined),
                label: const Text('Limpiar'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _resumen(ResumenFinanciero resumen) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        _dato('Ingresos', FormatoMoneda.cop(resumen.ingresos)),
        _dato('Egresos', FormatoMoneda.cop(resumen.egresos)),
        _dato('Saldo neto', FormatoMoneda.cop(resumen.saldoNeto)),
        _dato('Efectivo en caja', FormatoMoneda.cop(resumen.efectivoEnCaja)),
        _dato('Llevar', FormatoMoneda.cop(resumen.ingresosLlevar)),
        _dato('Local', FormatoMoneda.cop(resumen.ingresosLocal)),
      ],
    );
  }

  Widget _dato(String etiqueta, String valor) {
    return Semantics(
      label: '$etiqueta: $valor',
      child: SizedBox(
        width: 165,
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(etiqueta, style: Theme.of(context).textTheme.labelLarge),
                const SizedBox(height: 4),
                Text(valor, style: Theme.of(context).textTheme.titleMedium),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _formularioGastoWidget(FinanzasProveedor finanzas) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Registrar gasto',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _concepto,
              maxLength: 120,
              decoration: const InputDecoration(
                labelText: 'Concepto',
                prefixIcon: Icon(Icons.description_outlined),
              ),
              validator: _validarConcepto,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _valor,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Valor (COP)',
                prefixIcon: Icon(Icons.attach_money_outlined),
              ),
              validator: _validarValor,
            ),
            const SizedBox(height: 8),
            TextFormField(
              controller: _fechaGasto,
              decoration: const InputDecoration(
                labelText: 'Fecha (YYYY-MM-DD)',
                prefixIcon: Icon(Icons.event_outlined),
              ),
              validator: _validarFecha,
            ),
            const SizedBox(height: 12),
            Semantics(
              button: true,
              label: 'Registrar gasto',
              child: FilledButton.icon(
                onPressed: finanzas.cargando ? null : _registrarGasto,
                icon: const Icon(Icons.add_outlined),
                label: const Text('Registrar gasto'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _listaGastos(FinanzasProveedor finanzas) {
    if (finanzas.gastos.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 8),
        child: Card(
          child: ListTile(
            title: Text('No hay gastos registrados'),
            subtitle: Text('Registra un gasto para verlo aquí.'),
          ),
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(vertical: 8),
      itemCount: finanzas.gastos.length,
      itemBuilder: (context, indice) {
        final gasto = finanzas.gastos[indice];
        return Card(
          child: ListTile(
            title: Text(gasto.descripcion),
            subtitle: Semantics(
              label:
                  'Gasto de ${FormatoMoneda.cop(gasto.valor)} '
                  'el ${gasto.fechaLocal}',
              child: Text(
                '${gasto.fechaLocal} · ${FormatoMoneda.cop(gasto.valor)}',
              ),
            ),
            trailing: Semantics(
              button: true,
              label: 'Editar gasto ${gasto.descripcion}',
              child: TextButton.icon(
                onPressed: () => _editarGasto(gasto),
                icon: const Icon(Icons.edit_outlined),
                label: const Text('Editar'),
              ),
            ),
          ),
        );
      },
    );
  }

  Future<void> _aplicarRango() async {
    if (!_formularioRango.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<FinanzasProveedor>();
    final correcto = await proveedor.cambiarRango(
      desde: _desde.text,
      hasta: _hasta.text,
    );
    if (!mounted) {
      return;
    }
    if (!correcto) {
      _mostrarMensaje(proveedor.error ?? 'No se pudo aplicar el rango.');
    }
  }

  Future<void> _limpiarRango() async {
    setState(() {
      _desde.clear();
      _hasta.clear();
    });
    final proveedor = context.read<FinanzasProveedor>();
    final correcto = await proveedor.limpiarRango();
    if (!mounted) {
      return;
    }
    _mostrarMensaje(
      correcto ? 'Rango limpiado.' : proveedor.error ?? 'No se pudo limpiar.',
    );
  }

  Future<void> _registrarGasto() async {
    if (!_formularioGasto.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<FinanzasProveedor>();
    final correcto = await proveedor.registrarGasto(
      fechaLocal: _fechaGasto.text.trim(),
      concepto: _concepto.text.trim(),
      valor: int.parse(_valor.text.trim()),
    );
    if (!mounted) {
      return;
    }
    if (correcto) {
      setState(() {
        _concepto.clear();
        _valor.clear();
      });
    }
    _mostrarMensaje(
      correcto
          ? 'Gasto registrado.'
          : proveedor.error ?? 'No se pudo registrar el gasto.',
    );
  }

  Future<void> _editarGasto(Gasto gasto) async {
    await showDialog<void>(
      context: context,
      builder: (context) => _DialogoEdicionGasto(gasto: gasto),
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
  }
}

class _DialogoEdicionGasto extends StatefulWidget {
  final Gasto gasto;

  const _DialogoEdicionGasto({required this.gasto});

  @override
  State<_DialogoEdicionGasto> createState() => _DialogoEdicionGastoState();
}

class _DialogoEdicionGastoState extends State<_DialogoEdicionGasto> {
  final _formulario = GlobalKey<FormState>();
  late final TextEditingController _concepto;
  late final TextEditingController _valor;
  late final TextEditingController _fecha;

  @override
  void initState() {
    super.initState();
    _concepto = TextEditingController(text: widget.gasto.descripcion);
    _valor = TextEditingController(text: widget.gasto.valor.toString());
    _fecha = TextEditingController(text: widget.gasto.fechaLocal);
  }

  @override
  void dispose() {
    _concepto.dispose();
    _valor.dispose();
    _fecha.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cargando = context.watch<FinanzasProveedor>().cargando;
    return AlertDialog(
      title: const Text('Editar gasto'),
      content: SingleChildScrollView(
        child: Form(
          key: _formulario,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _concepto,
                maxLength: 120,
                decoration: const InputDecoration(labelText: 'Concepto'),
                validator: _validarConcepto,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _valor,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Valor (COP)'),
                validator: _validarValor,
              ),
              const SizedBox(height: 8),
              TextFormField(
                controller: _fecha,
                decoration: const InputDecoration(
                  labelText: 'Fecha (YYYY-MM-DD)',
                ),
                validator: _validarFecha,
              ),
            ],
          ),
        ),
      ),
      actions: [
        Semantics(
          button: true,
          label: 'Cancelar edición de gasto',
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancelar'),
          ),
        ),
        Semantics(
          button: true,
          label: 'Guardar cambios del gasto',
          child: FilledButton(
            onPressed: cargando ? null : _guardar,
            child: const Text('Guardar'),
          ),
        ),
      ],
    );
  }

  Future<void> _guardar() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    final proveedor = context.read<FinanzasProveedor>();
    final messenger = ScaffoldMessenger.of(context);
    final correcto = await proveedor.actualizarGasto(
      gastoId: widget.gasto.id,
      concepto: _concepto.text.trim(),
      valor: int.parse(_valor.text.trim()),
      fechaLocal: _fecha.text.trim(),
    );
    if (!mounted) {
      return;
    }
    if (correcto) {
      Navigator.of(context).pop();
    }
    messenger.showSnackBar(
      SnackBar(
        content: Text(
          correcto
              ? 'Gasto actualizado.'
              : proveedor.error ?? 'No se pudo actualizar el gasto.',
        ),
      ),
    );
  }
}

String? _validarConcepto(String? valor) {
  try {
    Validadores.texto(valor?.trim() ?? '', 'concepto');
    return null;
  } on ArgumentError catch (error) {
    return error.message?.toString() ?? 'Concepto inválido.';
  }
}

String? _validarValor(String? valor) {
  final numero = int.tryParse(valor?.trim() ?? '');
  if (numero == null) {
    return 'Ingresa un valor numérico.';
  }
  try {
    Validadores.dinero(numero, 'valor');
  } on ArgumentError catch (error) {
    return error.message?.toString() ?? 'Valor inválido.';
  }
  if (numero <= 0) {
    return 'El valor debe ser positivo.';
  }
  return null;
}

String? _validarFechaOpcional(String? valor) {
  final texto = valor?.trim() ?? '';
  if (texto.isEmpty) {
    return null;
  }
  return _validarFecha(texto);
}

String? _validarFecha(String? valor) {
  try {
    Validadores.fechaLocal(valor?.trim() ?? '');
    return null;
  } on ArgumentError catch (error) {
    return error.message?.toString() ?? 'Fecha inválida.';
  }
}
