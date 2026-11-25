import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../dominio/servicios/servicio_permisos.dart';
import '../../../estado/sesion_proveedor.dart';

class GuardiaRol extends StatelessWidget {
  final Accion accion;
  final Widget child;

  const GuardiaRol({super.key, required this.accion, required this.child});

  @override
  Widget build(BuildContext context) {
    final permitido = context.watch<SesionProveedor>().puede(accion);
    if (!permitido) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: Text(
            'No tienes permiso para acceder a esta sección.',
            textAlign: TextAlign.center,
          ),
        ),
      );
    }
    return child;
  }
}
