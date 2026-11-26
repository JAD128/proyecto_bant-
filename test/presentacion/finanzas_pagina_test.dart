import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/estado/finanzas_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:bantu/presentacion/pantallas/finanzas_pagina.dart';
import 'package:bantu/utilidades/formato_moneda.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_finanzas.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late FinanzasProveedor finanzas;

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    dependencias = Dependencias(baseDatos: base, sesion: SesionMemoria());
    sesion = SesionProveedor(dependencias: dependencias);
    await sesion.inicializar();
    await sesion.configurarAdministrador(
      nombre: 'Admin',
      pin: '1234',
      confirmacion: '1234',
    );
    final adminId = sesion.usuarioActivo!.id;
    final ahora = DateTime.utc(2026, 1, 1, 12);
    await dependencias.categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    await dependencias.productos.guardar(
      Producto(
        id: 'producto-1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1000,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    await sembrarFinanzas(
      pedidos: dependencias.pedidos,
      gastos: dependencias.gastos,
      empleadoId: adminId,
      usuarioId: adminId,
    );
    finanzas = FinanzasProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    finanzas.dispose();
    sesion.dispose();
    await base.close();
  });

  testWidgets('muestra el resumen, registra y edita un gasto', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Dependencias>.value(value: dependencias),
          ChangeNotifierProvider<SesionProveedor>.value(value: sesion),
          ChangeNotifierProvider<FinanzasProveedor>.value(value: finanzas),
        ],
        child: const MaterialApp(home: FinanzasPagina()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Finanzas'), findsOneWidget);
    expect(find.text('Ingresos'), findsOneWidget);
    expect(find.text(FormatoMoneda.cop(10500)), findsOneWidget);
    expect(find.text('Servicio'), findsOneWidget);

    await tester.enterText(
      find.widgetWithText(TextFormField, 'Concepto'),
      'Papelería',
    );
    await tester.enterText(
      find.widgetWithText(TextFormField, 'Valor (COP)'),
      '1200',
    );
    final registrar = find.widgetWithText(FilledButton, 'Registrar gasto');
    await tester.ensureVisible(registrar);
    await tester.tap(registrar);
    await tester.pumpAndSettle();

    expect(find.text('Papelería'), findsOneWidget);
    expect(find.text('Gasto registrado.'), findsOneWidget);
    expect(finanzas.resumen.egresos, 1600);

    final editar = find.widgetWithText(TextButton, 'Editar').first;
    await tester.ensureVisible(editar);
    await tester.tap(editar);
    await tester.pumpAndSettle();
    final dialogo = find.byType(AlertDialog);
    expect(dialogo, findsOneWidget);
    await tester.enterText(
      find.descendant(
        of: dialogo,
        matching: find.widgetWithText(TextFormField, 'Concepto'),
      ),
      'Papelería ajustada',
    );
    await tester.tap(
      find.descendant(
        of: dialogo,
        matching: find.widgetWithText(FilledButton, 'Guardar'),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Papelería ajustada'), findsOneWidget);
    expect(finanzas.gastos.first.valor, 1200);
  });
}
