import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/entidades/usuario.dart';
import '../../../dominio/servicios/servicio_permisos.dart';
import '../../../dominio/valores/rol.dart';
import '../../../estado/sesion_proveedor.dart';
import '../widgets/contenido_responsive.dart';
import '../widgets/guardia_rol.dart';
import 'cierres_pagina.dart';
import 'exportacion_pagina.dart';
import 'finanzas_pagina.dart';
import 'historial_pagina.dart';
import 'menu_pagina.dart';
import 'pedido_pagina.dart';
import 'usuarios_pagina.dart';

class PanelPagina extends StatelessWidget {
  static const double umbralNavegacionAmplia = 900;

  const PanelPagina({super.key});

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProveedor>();
    final usuario = sesion.usuarioActivo;
    if (usuario == null) {
      return const SizedBox.shrink();
    }

    final esAdmin = usuario.rol == Rol.administrador;
    final destinos = _destinos(esAdmin);
    final contenido = ContenidoResponsive(
      child: _bienvenida(context, usuario, esAdmin),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        final anchoGrande = constraints.maxWidth >= umbralNavegacionAmplia;
        return Scaffold(
          appBar: AppBar(
            title: const Text('Bantú'),
            actions: [
              Semantics(
                button: true,
                label: 'Cerrar sesión',
                child: IconButton(
                  tooltip: 'Cerrar sesión',
                  icon: const Icon(Icons.logout),
                  onPressed: () =>
                      context.read<SesionProveedor>().cerrarSesion(),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: anchoGrande
                ? Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      NavigationRail(
                        extended: true,
                        labelType: NavigationRailLabelType.none,
                        selectedIndex: 0,
                        onDestinationSelected: (indice) =>
                            _abrir(context, destinos, indice),
                        destinations: [
                          for (final destino in destinos)
                            NavigationRailDestination(
                              icon: Icon(destino.icono),
                              selectedIcon: Icon(destino.iconoSeleccionado),
                              label: Text(destino.etiqueta),
                            ),
                        ],
                      ),
                      const VerticalDivider(width: 1),
                      Expanded(child: contenido),
                    ],
                  )
                : contenido,
          ),
          bottomNavigationBar: anchoGrande
              ? null
              : NavigationBar(
                  selectedIndex: 0,
                  labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
                  onDestinationSelected: (indice) =>
                      _abrir(context, destinos, indice),
                  destinations: [
                    for (final destino in destinos)
                      NavigationDestination(
                        icon: Icon(destino.icono),
                        selectedIcon: Icon(destino.iconoSeleccionado),
                        label: destino.etiqueta,
                        tooltip: destino.tooltip,
                      ),
                  ],
                ),
        );
      },
    );
  }

  Widget _bienvenida(BuildContext context, Usuario usuario, bool esAdmin) {
    return Column(
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
        const SizedBox(height: 16),
        const Text(
          'Selecciona una opción en la navegación para continuar.',
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  List<_DestinoPanel> _destinos(bool esAdmin) {
    final destinos = <_DestinoPanel>[
      const _DestinoPanel(
        etiqueta: 'Panel',
        tooltip: 'Panel principal',
        icono: Icons.space_dashboard_outlined,
        iconoSeleccionado: Icons.space_dashboard,
      ),
    ];
    if (esAdmin) {
      destinos.add(
        _DestinoPanel(
          etiqueta: 'Usuarios',
          tooltip: 'Ir a usuarios',
          icono: Icons.people_outline,
          iconoSeleccionado: Icons.people,
          pagina: (_) => const GuardiaRol(
            accion: Accion.configurarUsuarios,
            child: UsuariosPagina(),
          ),
        ),
      );
    }
    destinos.addAll([
      _DestinoPanel(
        etiqueta: 'Menú',
        tooltip: 'Ir al menú',
        icono: Icons.restaurant_menu_outlined,
        iconoSeleccionado: Icons.restaurant_menu,
        pagina: (_) =>
            const GuardiaRol(accion: Accion.verMenu, child: MenuPagina()),
      ),
      _DestinoPanel(
        etiqueta: 'Pedidos',
        tooltip: 'Ir a pedidos',
        icono: Icons.receipt_long_outlined,
        iconoSeleccionado: Icons.receipt_long,
        pagina: (_) =>
            const GuardiaRol(accion: Accion.crearPedido, child: PedidoPagina()),
      ),
      _DestinoPanel(
        etiqueta: 'Historial',
        tooltip: 'Ir al historial',
        icono: Icons.history_toggle_off_outlined,
        iconoSeleccionado: Icons.history_toggle_off,
        pagina: (_) => const GuardiaRol(
          accion: Accion.verHistorial,
          child: HistorialPagina(),
        ),
      ),
      _DestinoPanel(
        etiqueta: 'Cierres',
        tooltip: 'Ir a cierres',
        icono: Icons.calendar_month_outlined,
        iconoSeleccionado: Icons.calendar_month,
        pagina: (_) => const CierresPagina(),
      ),
      _DestinoPanel(
        etiqueta: 'Finanzas',
        tooltip: 'Ir a finanzas',
        icono: Icons.account_balance_wallet_outlined,
        iconoSeleccionado: Icons.account_balance_wallet,
        pagina: (_) => const GuardiaRol(
          accion: Accion.verFinanzas,
          child: FinanzasPagina(),
        ),
      ),
      _DestinoPanel(
        etiqueta: 'Exportación',
        tooltip: 'Ir a exportación',
        icono: Icons.file_download_outlined,
        iconoSeleccionado: Icons.file_download,
        pagina: (_) => const GuardiaRol(
          accion: Accion.exportarInformes,
          child: ExportacionPagina(),
        ),
      ),
    ]);
    return destinos;
  }

  void _abrir(BuildContext context, List<_DestinoPanel> destinos, int indice) {
    final pagina = destinos[indice].pagina;
    if (pagina == null) {
      return;
    }
    Navigator.of(context).push<void>(MaterialPageRoute<void>(builder: pagina));
  }
}

class _DestinoPanel {
  final String etiqueta;
  final String tooltip;
  final IconData icono;
  final IconData iconoSeleccionado;
  final WidgetBuilder? pagina;

  const _DestinoPanel({
    required this.etiqueta,
    required this.tooltip,
    required this.icono,
    required this.iconoSeleccionado,
    this.pagina,
  });
}
