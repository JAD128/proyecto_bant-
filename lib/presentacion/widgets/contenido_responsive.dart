import 'package:flutter/material.dart';

class ContenidoResponsive extends StatelessWidget {
  static const double anchoMaximo = 960;
  static const double umbralTablet = 600;
  static const double paddingMovil = 16;
  static const double paddingTablet = 24;
  static const Key clave = Key('contenido_responsive');

  final Widget child;

  const ContenidoResponsive({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final ancho = constraints.maxWidth.isFinite
            ? constraints.maxWidth
            : anchoMaximo;
        final padding = ancho >= umbralTablet ? paddingTablet : paddingMovil;
        return Align(
          key: clave,
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: anchoMaximo),
            child: Padding(padding: EdgeInsets.all(padding), child: child),
          ),
        );
      },
    );
  }
}
