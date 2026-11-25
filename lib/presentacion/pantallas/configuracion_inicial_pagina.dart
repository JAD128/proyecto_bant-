import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/servicios/validadores.dart';
import '../../../estado/sesion_proveedor.dart';

class ConfiguracionInicialPagina extends StatefulWidget {
  const ConfiguracionInicialPagina({super.key});

  @override
  State<ConfiguracionInicialPagina> createState() =>
      _ConfiguracionInicialPaginaState();
}

class _ConfiguracionInicialPaginaState
    extends State<ConfiguracionInicialPagina> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _pin = TextEditingController();
  final _confirmacion = TextEditingController();
  bool _ocultarPin = true;

  @override
  void dispose() {
    _nombre.dispose();
    _pin.dispose();
    _confirmacion.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProveedor>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 32),
              Icon(
                Icons.restaurant_menu,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Bienvenido a Bantú',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 8),
              const Text(
                'Crea el usuario administrador para comenzar.',
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 32),
              Form(
                key: _formulario,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: _nombre,
                      textInputAction: TextInputAction.next,
                      decoration: const InputDecoration(
                        labelText: 'Nombre del administrador',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (valor) {
                        final texto = valor?.trim() ?? '';
                        if (texto.isEmpty) return 'Escribe el nombre.';
                        if (texto.length > 80) return 'Máximo 80 caracteres.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pin,
                      obscureText: _ocultarPin,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        labelText: 'PIN de 4 a 6 dígitos',
                        prefixIcon: const Icon(Icons.lock_outline),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _ocultarPin
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                          ),
                          onPressed: () =>
                              setState(() => _ocultarPin = !_ocultarPin),
                        ),
                      ),
                      validator: (valor) {
                        try {
                          Validadores.pin(valor ?? '');
                          return null;
                        } on ArgumentError catch (error) {
                          return error.message?.toString() ?? 'PIN inválido.';
                        }
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _confirmacion,
                      obscureText: _ocultarPin,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: const InputDecoration(
                        labelText: 'Confirma el PIN',
                        prefixIcon: Icon(Icons.lock_outline),
                      ),
                      validator: (valor) => valor == _pin.text
                          ? null
                          : 'Los PIN no coinciden.',
                      onFieldSubmitted: (_) => _guardar(),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: sesion.cargando ? null : _guardar,
                      icon: sesion.cargando
                          ? const SizedBox.square(
                              dimension: 18,
                              child: CircularProgressIndicator(strokeWidth: 2),
                            )
                          : const Icon(Icons.check),
                      label: const Text('Crear administrador'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _guardar() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<SesionProveedor>();
    final correcto = await proveedor.configurarAdministrador(
      nombre: _nombre.text,
      pin: _pin.text,
      confirmacion: _confirmacion.text,
    );
    if (!correcto && mounted) {
      _mostrarError(proveedor.error);
    }
  }

  void _mostrarError(String? mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje ?? 'No se pudo completar la operación.')),
    );
  }
}
