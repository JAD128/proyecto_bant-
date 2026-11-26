import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/estado/historial_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:bantu/presentacion/pantallas/historial_pagina.dart';
import 'package:bantu/utilidades/formato_moneda.dart';
import 'package:drift/native.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_pedidos.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late HistorialProveedor historial;

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

    final ahora = DateTime.utc(2026, 1, 1, 12);
    await dependencias.categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    await dependencias.productos.guardar(
      Producto(
        id: 'producto-1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1500,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    await dependencias.pedidos.guardar(
      pedidoHistorial(
        id: 'pedido-ui',
        empleadoId: sesion.usuarioActivo!.id,
        fechaLocal: '2026-01-05',
        horaLocal: '14:20',
        estado: EstadoPedido.confirmado,
        total: 1500,
      ),
    );

    historial = HistorialProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    historial.dispose();
    sesion.dispose();
    await base.close();
  });

  testWidgets('muestra el pedido y abre su detalle histórico', (tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          Provider<Dependencias>.value(value: dependencias),
          ChangeNotifierProvider<SesionProveedor>.value(value: sesion),
          ChangeNotifierProvider<HistorialProveedor>.value(value: historial),
        ],
        child: const MaterialApp(home: HistorialPagina()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Historial de pedidos'), findsOneWidget);
    expect(find.text('2026-01-05 · 14:20'), findsOneWidget);
    expect(find.text('Total: ${FormatoMoneda.cop(1500)}'), findsOneWidget);

    await tester.tap(find.text('Detalle'));
    await tester.pumpAndSettle();

    expect(find.text('Detalle del pedido'), findsOneWidget);
    expect(find.text('Ítems del pedido'), findsOneWidget);
    expect(find.text('1 × Agua'), findsOneWidget);
    expect(find.text('Categoría: Bebidas'), findsOneWidget);
    expect(find.text('Método de pago: Efectivo'), findsOneWidget);
  });
}
