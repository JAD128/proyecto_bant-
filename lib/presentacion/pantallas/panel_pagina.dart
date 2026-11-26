import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/servicios/servicio_permisos.dart';
import '../../../dominio/valores/rol.dart';
import '../../../estado/sesion_proveedor.dart';
import '../widgets/guardia_rol.dart';
import 'historial_pagina.dart';
import 'menu_pagina.dart';
import 'pedido_pagina.dart';
import 'usuarios_pagina.dart';

class PanelPagina extends StatelessWidget {
  const PanelPagina({super.key});

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProveedor>();
    final usuario = sesion.usuarioActivo;
    if (usuario == null) {
      return const SizedBox.shrink();
    }

    final esAdmin = usuario.rol == Rol.administrador;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bantú'),
        actions: [
          IconButton(
            tooltip: 'Cerrar sesión',
            icon: const Icon(Icons.logout),
            onPressed: () => context.read<SesionProveedor>().cerrarSesion(),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  esAdmin ? Icons.admin_panel_settings : Icons.badge_outlined,
                  size: 64,
                  color: Theme.of(context).colorScheme.primary,
                ),
                const SizedBox(height: 16),
                Text(
                  'Hola, ${usuario.nombre}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 4),
                Text(
                  esAdmin ? 'Administrador' : 'Empleado',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 32),
                if (esAdmin)
                  FilledButton.icon(
                    onPressed: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GuardiaRol(
                          accion: Accion.configurarUsuarios,
                          child: UsuariosPagina(),
                        ),
                      ),
                    ),
                    icon: const Icon(Icons.people_outline),
                    label: const Text('Usuarios'),
                  ),
                if (esAdmin) const SizedBox(height: 12),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.restaurant_menu_outlined),
                    title: const Text('Menú'),
                    subtitle: const Text('Categorías y productos.'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GuardiaRol(
                          accion: Accion.verMenu,
                          child: MenuPagina(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.receipt_long_outlined),
                    title: const Text('Pedidos'),
                    subtitle: const Text('Registro y cálculo en vivo.'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GuardiaRol(
                          accion: Accion.crearPedido,
                          child: PedidoPagina(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Card(
                  child: ListTile(
                    leading: const Icon(Icons.history_toggle_off_outlined),
                    title: const Text('Historial'),
                    subtitle: const Text('Consulta pedidos con filtros.'),
                    onTap: () => Navigator.of(context).push(
                      MaterialPageRoute<void>(
                        builder: (_) => const GuardiaRol(
                          accion: Accion.verHistorial,
                          child: HistorialPagina(),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.calendar_month_outlined),
                    title: Text('Cierres'),
                    subtitle: Text('Disponible en una fase posterior.'),
                  ),
                ),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.account_balance_wallet_outlined),
                    title: Text('Finanzas'),
                    subtitle: Text('Disponible en una fase posterior.'),
                  ),
                ),
                const SizedBox(height: 8),
                const Card(
                  child: ListTile(
                    leading: Icon(Icons.file_download_outlined),
                    title: Text('Exportación'),
                    subtitle: Text('Disponible en una fase posterior.'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
