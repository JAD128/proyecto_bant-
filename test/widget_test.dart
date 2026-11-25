import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:bantu/main.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'apoyo/fakes.dart';

Future<SesionProveedor> crearProveedor(BantuDatabase base) async {
  final proveedor = SesionProveedor(
    dependencias: Dependencias(
      baseDatos: base,
      sesion: SesionMemoria(),
    ),
  );
  await proveedor.inicializar();
  return proveedor;
}

Future<void> montar(WidgetTester tester, SesionProveedor proveedor) async {
  await tester.pumpWidget(
    ChangeNotifierProvider<SesionProveedor>.value(
      value: proveedor,
      child: const MaterialApp(home: SelectorPagina()),
    ),
  );
  await tester.pumpAndSettle();
}

void main() {
  late BantuDatabase base;

  setUp(() {
    base = BantuDatabase.forTesting(NativeDatabase.memory());
  });

  tearDown(() async {
    await base.close();
  });

  testWidgets('configura administrador y abre el panel', (tester) async {
    final proveedor = await crearProveedor(base);
    await montar(tester, proveedor);

    expect(find.text('Bienvenido a Bantú'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.enterText(find.byType(TextFormField).at(2), '1234');
    await tester.tap(find.text('Crear administrador'));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Admin'), findsOneWidget);
  });

  testWidgets('inicia sesión con nombre en minúsculas', (tester) async {
    final proveedor = await crearProveedor(base);
    await proveedor.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
    await proveedor.cerrarSesion();
    await montar(tester, proveedor);

    expect(find.text('Ingresar a Bantú'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'admin');
    await tester.enterText(find.byType(TextFormField).at(1), '1234');
    await tester.tap(find.text('Ingresar'));
    await tester.pumpAndSettle();

    expect(find.text('Hola, Admin'), findsOneWidget);
  });

  testWidgets('cierra sesión desde el panel', (tester) async {
    final proveedor = await crearProveedor(base);
    await proveedor.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
    await montar(tester, proveedor);

    await tester.tap(find.byTooltip('Cerrar sesión'));
    await tester.pumpAndSettle();

    expect(find.text('Ingresar a Bantú'), findsOneWidget);
  });

  testWidgets('admin crea un empleado desde la pantalla de usuarios',
      (tester) async {
    final proveedor = await crearProveedor(base);
    await proveedor.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
    await montar(tester, proveedor);

    await tester.tap(find.text('Usuarios'));
    await tester.pumpAndSettle();
    expect(find.text('Nuevo empleado'), findsOneWidget);

    await tester.enterText(find.byType(TextFormField).at(0), 'Mesero');
    await tester.enterText(find.byType(TextFormField).at(1), '5678');
    await tester.tap(find.text('Crear empleado'));
    await tester.pumpAndSettle();

    expect(find.text('Mesero'), findsOneWidget);
  });
}
