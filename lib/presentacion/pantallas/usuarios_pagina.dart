import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/servicios/validadores.dart';
import '../../../dominio/valores/rol.dart';
import '../../../estado/sesion_proveedor.dart';
import '../widgets/contenido_responsive.dart';

class UsuariosPagina extends StatefulWidget {
  const UsuariosPagina({super.key});

  @override
  State<UsuariosPagina> createState() => _UsuariosPaginaState();
}

class _UsuariosPaginaState extends State<UsuariosPagina> {
  final _formulario = GlobalKey<FormState>();
  final _nombre = TextEditingController();
  final _pin = TextEditingController();
  bool _puedeVerTodosPedidos = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SesionProveedor>().cargarUsuarios();
    });
  }

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
      appBar: AppBar(title: const Text('Usuarios')),
      body: SafeArea(
        child: ContenidoResponsive(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      key: _formulario,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Text(
                            'Nuevo empleado',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _nombre,
                            decoration: const InputDecoration(
                              labelText: 'Nombre',
                              prefixIcon: Icon(Icons.person_outline),
                            ),
                            validator: (valor) {
                              final texto = valor?.trim() ?? '';
                              if (texto.isEmpty) return 'Escribe el nombre.';
                              if (texto.length > 80) {
                                return 'Máximo 80 caracteres.';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _pin,
                            obscureText: true,
                            keyboardType: TextInputType.number,
                            decoration: const InputDecoration(
                              labelText: 'PIN de 4 a 6 dígitos',
                              prefixIcon: Icon(Icons.lock_outline),
                            ),
                            validator: (valor) {
                              try {
                                Validadores.pin(valor ?? '');
                                return null;
                              } on ArgumentError catch (error) {
                                return error.message?.toString() ??
                                    'PIN inválido.';
                              }
                            },
                          ),
                          SwitchListTile(
                            contentPadding: EdgeInsets.zero,
                            title: const Text('Ver todos los pedidos'),
                            value: _puedeVerTodosPedidos,
                            onChanged: sesion.cargando
                                ? null
                                : (valor) => setState(
                                    () => _puedeVerTodosPedidos = valor,
                                  ),
                          ),
                          const SizedBox(height: 8),
                          Semantics(
                            button: true,
                            label: 'Crear empleado',
                            child: FilledButton.icon(
                              onPressed: sesion.cargando ? null : _crear,
                              icon: const Icon(Icons.person_add_outlined),
                              label: const Text('Crear empleado'),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                Text(
                  'Usuarios registrados',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                if (sesion.cargando && sesion.usuarios.isEmpty)
                  const Center(child: CircularProgressIndicator())
                else
                  for (final usuario in sesion.usuarios)
                    Card(
                      child: Column(
                        children: [
                          ListTile(
                            leading: Icon(
                              usuario.rol == Rol.administrador
                                  ? Icons.admin_panel_settings_outlined
                                  : Icons.badge_outlined,
                            ),
                            title: Text(usuario.nombre),
                            subtitle: Text(
                              usuario.rol == Rol.administrador
                                  ? 'Administrador'
                                  : 'Empleado',
                            ),
                          ),
                          if (usuario.rol == Rol.empleado)
                            Column(
                              children: [
                                SwitchListTile(
                                  title: const Text('Activo'),
                                  value: usuario.activo,
                                  onChanged: sesion.cargando
                                      ? null
                                      : (valor) =>
                                            _cambiar(usuario.id, activo: valor),
                                ),
                                SwitchListTile(
                                  title: const Text('Ver todos los pedidos'),
                                  value: usuario.puedeVerTodosPedidos,
                                  onChanged: sesion.cargando || !usuario.activo
                                      ? null
                                      : (valor) => _cambiar(
                                          usuario.id,
                                          puedeVerTodosPedidos: valor,
                                        ),
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _crear() async {
    if (!_formulario.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<SesionProveedor>();
    final correcto = await proveedor.crearEmpleado(
      nombre: _nombre.text,
      pin: _pin.text,
      puedeVerTodosPedidos: _puedeVerTodosPedidos,
    );
    if (correcto) {
      _nombre.clear();
      _pin.clear();
      setState(() => _puedeVerTodosPedidos = false);
    } else if (mounted) {
      _mostrarError(proveedor.error);
    }
  }

  Future<void> _cambiar(
    String usuarioId, {
    bool? activo,
    bool? puedeVerTodosPedidos,
  }) async {
    final proveedor = context.read<SesionProveedor>();
    final correcto = await proveedor.actualizarEmpleado(
      usuarioId: usuarioId,
      activo: activo,
      puedeVerTodosPedidos: puedeVerTodosPedidos,
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
