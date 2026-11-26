import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../dominio/valores/formato_exportacion.dart';
import '../../dominio/valores/tipo_exportacion.dart';
import '../../estado/exportacion_proveedor.dart';
import '../widgets/guardia_rol.dart';

class ExportacionPagina extends StatefulWidget {
  const ExportacionPagina({super.key});

  @override
  State<ExportacionPagina> createState() => _ExportacionPaginaState();
}

class _ExportacionPaginaState extends State<ExportacionPagina> {
  final _formulario = GlobalKey<FormState>();
  final _desde = TextEditingController();
  final _hasta = TextEditingController();
  TipoExportacion _tipo = TipoExportacion.pedidos;
  FormatoExportacion _formato = FormatoExportacion.xlsx;

  @override
  void dispose() {
    _desde.dispose();
    _hasta.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final exportacion = context.watch<ExportacionProveedor>();
    return GuardiaRol(
      accion: Accion.exportarInformes,
      child: Scaffold(
        appBar: AppBar(title: const Text('Exportación')),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formulario,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<TipoExportacion>(
                    initialValue: _tipo,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Tipo de informe',
                      prefixIcon: Icon(Icons.description_outlined),
                    ),
                    items: [
                      for (final tipo in TipoExportacion.values)
                        DropdownMenuItem<TipoExportacion>(
                          value: tipo,
                          child: Text(tipo.texto),
                        ),
                    ],
                    onChanged: (valor) {
                      if (valor != null) {
                        setState(() => _tipo = valor);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  DropdownButtonFormField<FormatoExportacion>(
                    initialValue: _formato,
                    isExpanded: true,
                    decoration: const InputDecoration(
                      labelText: 'Formato',
                      prefixIcon: Icon(Icons.file_download_outlined),
                    ),
                    items: [
                      for (final formato in FormatoExportacion.values)
                        DropdownMenuItem<FormatoExportacion>(
                          value: formato,
                          child: Text(formato.texto),
                        ),
                    ],
                    onChanged: (valor) {
                      if (valor != null) {
                        setState(() => _formato = valor);
                      }
                    },
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _desde,
                    decoration: const InputDecoration(
                      labelText: 'Desde (YYYY-MM-DD)',
                      prefixIcon: Icon(Icons.calendar_today_outlined),
                    ),
                    validator: _validarFechaOpcional,
                  ),
                  const SizedBox(height: 12),
                  TextFormField(
                    controller: _hasta,
                    decoration: const InputDecoration(
                      labelText: 'Hasta (YYYY-MM-DD)',
                      prefixIcon: Icon(Icons.calendar_month_outlined),
                    ),
                    validator: _validarFechaOpcional,
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: exportacion.cargando ? null : _exportar,
                    icon: const Icon(Icons.save_outlined),
                    label: Text(
                      exportacion.cargando
                          ? 'Generando...'
                          : 'Exportar ${_formato.texto}',
                    ),
                  ),
                  if (exportacion.error != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 12),
                      child: Text(
                        exportacion.error!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.error,
                        ),
                      ),
                    ),
                  if (exportacion.ruta != null)
                    Card(
                      margin: const EdgeInsets.only(top: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Archivo generado',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 4),
                            SelectableText(exportacion.ruta!),
                          ],
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

  Future<void> _exportar() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<ExportacionProveedor>();
    final correcto = await proveedor.exportar(
      tipo: _tipo,
      formato: _formato,
      desde: _desde.text.trim().isEmpty ? null : _desde.text.trim(),
      hasta: _hasta.text.trim().isEmpty ? null : _hasta.text.trim(),
    );
    if (!mounted) {
      return;
    }
    _mostrarMensaje(
      correcto
          ? 'Archivo guardado en ${proveedor.ruta}'
          : proveedor.error ?? 'No se pudo generar el archivo.',
    );
  }

  void _mostrarMensaje(String mensaje) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(mensaje)));
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
}
