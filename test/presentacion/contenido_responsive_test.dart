import 'package:bantu/presentacion/widgets/contenido_responsive.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  Future<void> montar(WidgetTester tester, Size tamano) async {
    tester.view.physicalSize = tamano;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: ContenidoResponsive(
            child: SizedBox(
              key: Key('contenido'),
              width: double.infinity,
              height: 20,
            ),
          ),
        ),
      ),
    );
  }

  testWidgets('en superficie estrecha aplica padding de 16 y centra', (
    tester,
  ) async {
    await montar(tester, const Size(400, 800));

    final contenido = find.byKey(ContenidoResponsive.clave);
    expect(contenido, findsOneWidget);
    final constrained = tester.widget<ConstrainedBox>(
      find.descendant(of: contenido, matching: find.byType(ConstrainedBox)),
    );
    expect(constrained.constraints.maxWidth, ContenidoResponsive.anchoMaximo);
    final padding = tester.widget<Padding>(
      find.descendant(of: contenido, matching: find.byType(Padding)),
    );
    expect(padding.padding, const EdgeInsets.all(16));
    expect(
      tester.getSize(find.byKey(const Key('contenido'))).width,
      400 - 2 * ContenidoResponsive.paddingMovil,
    );
    expect(
      tester.getCenter(find.byKey(const Key('contenido'))).dx,
      closeTo(200, 1),
    );
  });

  testWidgets('en superficie ancha limita el ancho y usa padding de 24', (
    tester,
  ) async {
    await montar(tester, const Size(1200, 800));

    final contenido = find.byKey(ContenidoResponsive.clave);
    final padding = tester.widget<Padding>(
      find.descendant(of: contenido, matching: find.byType(Padding)),
    );
    expect(padding.padding, const EdgeInsets.all(24));
    final ancho = tester.getSize(find.byKey(const Key('contenido'))).width;
    expect(ancho, lessThanOrEqualTo(ContenidoResponsive.anchoMaximo));
    expect(
      ancho,
      ContenidoResponsive.anchoMaximo - 2 * ContenidoResponsive.paddingTablet,
    );
    expect(
      tester.getCenter(find.byKey(const Key('contenido'))).dx,
      closeTo(600, 1),
    );
  });
}
