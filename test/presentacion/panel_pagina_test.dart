import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:bantu/presentacion/pantallas/panel_pagina.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../apoyo/fakes.dart';

void main() {
  late bd.BantuDatabase base;
  late SesionProveedor sesion;

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    sesion = SesionProveedor(
      dependencias: Dependencias(baseDatos: base, sesion: SesionMemoria()),
    );
    await sesion.inicializar();
    await sesion.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
  });

  tearDown(() async {
    sesion.dispose();
    await base.close();
  });

  Future<void> montar(WidgetTester tester, Size tamano) async {
    tester.view.physicalSize = tamano;
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);
    await tester.pumpWidget(
      ChangeNotifierProvider<SesionProveedor>.value(
        value: sesion,
        child: const MaterialApp(home: PanelPagina()),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('muestra NavigationBar en ancho estrecho', (tester) async {
    await montar(tester, const Size(400, 800));

    expect(find.byType(NavigationBar), findsOneWidget);
    expect(find.byType(NavigationRail), findsNothing);
    expect(find.text('Usuarios'), findsOneWidget);
  });

  testWidgets('muestra NavigationRail extendido en ancho grande', (
    tester,
  ) async {
    await montar(tester, const Size(1200, 800));

    expect(find.byType(NavigationBar), findsNothing);
    final rail = tester.widget<NavigationRail>(find.byType(NavigationRail));
    expect(rail.extended, isTrue);
    expect(rail.destinations.length, 8);
    expect(find.text('Usuarios'), findsOneWidget);
  });
}
