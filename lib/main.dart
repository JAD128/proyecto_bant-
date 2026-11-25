import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'configuracion/dependencias.dart';
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
  runApp(BantuApp(dependencias: dependencias, sesion: sesion));
}

class BantuApp extends StatelessWidget {
  final Dependencias dependencias;
  final SesionProveedor sesion;

  const BantuApp({
    super.key,
    required this.dependencias,
    required this.sesion,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<Dependencias>.value(value: dependencias),
        ChangeNotifierProvider<SesionProveedor>.value(value: sesion),
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
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
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
