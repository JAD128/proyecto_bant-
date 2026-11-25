import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/servicios/validadores.dart';
import '../../../estado/sesion_proveedor.dart';

class InicioSesionPagina extends StatefulWidget {
  const InicioSesionPagina({super.key});

  @override
  State<InicioSesionPagina> createState() => _InicioSesionPaginaState();
}

class _InicioSesionPaginaState extends State<InicioSesionPagina> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _pin = TextEditingController();
  bool _ocultarPin = true;

  @override
  void dispose() {
    _nombre.dispose();
    _pin.dispose();
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
              const SizedBox(height: 48),
              Icon(
                Icons.lock_person_outlined,
                size: 72,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(height: 16),
              Text(
                'Ingresar a Bantú',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
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
                        labelText: 'Usuario',
                        prefixIcon: Icon(Icons.person_outline),
                      ),
                      validator: (valor) {
                        final texto = valor?.trim() ?? '';
                        if (texto.isEmpty) return 'Escribe el usuario.';
                        if (texto.length > 80) return 'Máximo 80 caracteres.';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _pin,
                      obscureText: _ocultarPin,
                      keyboardType: TextInputType.number,
                      textInputAction: TextInputAction.done,
                      decoration: InputDecoration(
                        labelText: 'PIN',
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
                      onFieldSubmitted: (_) => _ingresar(),
                    ),
                    const SizedBox(height: 24),
                    FilledButton.icon(
                      onPressed: sesion.cargando ? null : _ingresar,
                      icon: const Icon(Icons.login),
                      label: const Text('Ingresar'),
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

  Future<void> _ingresar() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<SesionProveedor>();
    final correcto = await proveedor.iniciarSesion(
      nombre: _nombre.text,
      pin: _pin.text,
    );
    if (correcto) {
      _pin.clear();
    } else if (mounted) {
      _mostrarError(proveedor.error);
    }
  }

  void _mostrarError(String? mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje ?? 'No se pudo iniciar sesión.')),
    );
  }
}
