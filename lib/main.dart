import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configuracion/dependencias.dart';
import 'estado/cierre_proveedor.dart';
import 'estado/finanzas_proveedor.dart';
import 'estado/historial_proveedor.dart';
import 'estado/menu_proveedor.dart';
import 'estado/pedido_proveedor.dart';
import 'estado/sesion_proveedor.dart';
import 'presentacion/pantallas/configuracion_inicial_pagina.dart';
import 'presentacion/pantallas/inicio_sesion_pagina.dart';
import 'presentacion/pantallas/panel_pagina.dart';
import 'tema/tema_bantu.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dependencias = Dependencias.paraApp();
  final sesion = SesionProveedor(dependencias: dependencias);
  await sesion.inicializar();
  final menu = MenuProveedor(dependencias: dependencias, sesion: sesion);
  final pedido = PedidoProveedor(dependencias: dependencias, sesion: sesion);
  final historial = HistorialProveedor(
    dependencias: dependencias,
    sesion: sesion,
  );
  final cierre = CierreProveedor(dependencias: dependencias, sesion: sesion);
  final finanzas = FinanzasProveedor(
    dependencias: dependencias,
    sesion: sesion,
  );
  runApp(
    BantuApp(
      dependencias: dependencias,
      sesion: sesion,
      menu: menu,
      pedido: pedido,
      historial: historial,
      cierre: cierre,
      finanzas: finanzas,
    ),
  );
}

class BantuApp extends StatelessWidget {
  final Dependencias dependencias;
  final SesionProveedor sesion;
  final MenuProveedor menu;
  final PedidoProveedor pedido;
  final HistorialProveedor historial;
  final CierreProveedor cierre;
  final FinanzasProveedor finanzas;

  const BantuApp({
    super.key,
    required this.dependencias,
    required this.sesion,
    required this.menu,
    required this.pedido,
    required this.historial,
    required this.cierre,
    required this.finanzas,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dependencias>.value(value: dependencias),
        ChangeNotifierProvider<SesionProveedor>.value(value: sesion),
        ChangeNotifierProvider<MenuProveedor>.value(value: menu),
        ChangeNotifierProvider<PedidoProveedor>.value(value: pedido),
        ChangeNotifierProvider<HistorialProveedor>.value(value: historial),
        ChangeNotifierProvider<CierreProveedor>.value(value: cierre),
        ChangeNotifierProvider<FinanzasProveedor>.value(value: finanzas),
      ],
      child: MaterialApp(
        title: 'Bantú',
        theme: TemaBantu.claro,
        debugShowCheckedModeBanner: false,
        home: const SelectorPagina(),
      ),
    );
  }
}

class SelectorPagina extends StatelessWidget {
  const SelectorPagina({super.key});

  @override
  Widget build(BuildContext context) {
    final sesion = context.watch<SesionProveedor>();
    if (!sesion.inicializado) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    if (!sesion.configuracionInicialCompleta) {
      return const ConfiguracionInicialPagina();
    }
    if (!sesion.autenticado) {
      return const InicioSesionPagina();
    }
    return const PanelPagina();
  }
}
