import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../datos/bd/bantu_database.dart';
import '../datos/repositorios/categoria_repositorio.dart';
import '../datos/repositorios/cierre_repositorio.dart';
import '../datos/repositorios/gasto_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_categoria_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_cierre_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_gasto_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_pedido_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_producto_repositorio.dart';
import '../datos/repositorios/implementaciones/drift_usuario_repositorio.dart';
import '../datos/repositorios/pedido_repositorio.dart';
import '../datos/repositorios/producto_repositorio.dart';
import '../datos/repositorios/usuario_repositorio.dart';
import '../datos/sesion/repositorio_sesion.dart';
import '../datos/sesion/repositorio_sesion_seguro.dart';
import '../dominio/servicios/calculador_finanzas.dart';
import '../dominio/servicios/calculador_pedido.dart';
import '../dominio/servicios/pin_hasher.dart';
import '../dominio/servicios/servicio_cierres.dart';
import '../dominio/servicios/servicio_historial.dart';
import '../dominio/servicios/servicio_menu.dart';
import '../dominio/servicios/servicio_pedidos.dart';
import '../dominio/servicios/servicio_permisos.dart';
import '../dominio/servicios/servicio_usuarios.dart';

class Dependencias {
  final BantuDatabase baseDatos;
  final RepositorioSesion sesion;

  late final UsuarioRepositorio usuarios;
  late final CategoriaRepositorio categorias;
  late final ProductoRepositorio productos;
  late final PedidoRepositorio pedidos;
  late final GastoRepositorio gastos;
  late final CierreRepositorio cierres;

  final CalculadorPedido calculadorPedido;
  final CalculadorFinanzas calculadorFinanzas;
  final PinHasher pinHasher;
  final ServicioPermisos permisos;
  late final ServicioUsuarios servicioUsuarios;
  late final ServicioMenu servicioMenu;
  late final ServicioPedidos servicioPedidos;
  late final ServicioHistorial servicioHistorial;
  late final ServicioCierres servicioCierres;

  Dependencias({
    required this.baseDatos,
    required this.sesion,
    this.calculadorPedido = const CalculadorPedido(),
    this.calculadorFinanzas = const CalculadorFinanzas(),
    this.pinHasher = const PinHasher(),
    this.permisos = const ServicioPermisos(),
  }) {
    usuarios = DriftUsuarioRepositorio(baseDatos);
    categorias = DriftCategoriaRepositorio(baseDatos);
    productos = DriftProductoRepositorio(baseDatos);
    pedidos = DriftPedidoRepositorio(baseDatos);
    gastos = DriftGastoRepositorio(baseDatos);
    cierres = DriftCierreRepositorio(baseDatos);
    servicioUsuarios = ServicioUsuarios(
      usuarios: usuarios,
      sesion: sesion,
      hasher: pinHasher,
      permisos: permisos,
    );
    servicioMenu = ServicioMenu(
      categorias: categorias,
      productos: productos,
      permisos: permisos,
    );
    servicioPedidos = ServicioPedidos(
      pedidos: pedidos,
      categorias: categorias,
      calculador: calculadorPedido,
      permisos: permisos,
    );
    servicioHistorial = ServicioHistorial(pedidos: pedidos, permisos: permisos);
    servicioCierres = ServicioCierres(
      cierres: cierres,
      pedidos: pedidos,
      gastos: gastos,
      calculador: calculadorFinanzas,
      permisos: permisos,
    );
  }

  factory Dependencias.paraApp() {
    return Dependencias(
      baseDatos: BantuDatabase(),
      sesion: const RepositorioSesionSeguro(FlutterSecureStorage()),
    );
  }

  Future<void> cerrar() => baseDatos.close();
}
