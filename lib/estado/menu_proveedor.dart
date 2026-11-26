import 'package:flutter/foundation.dart';

import '../configuracion/dependencias.dart';
import '../dominio/entidades/categoria.dart';
import '../dominio/entidades/producto.dart';
import '../dominio/entidades/usuario.dart';
import '../dominio/servicios/servicio_permisos.dart';
import '../dominio/valores/estrategia_llevar.dart';
import 'sesion_proveedor.dart';

class MenuProveedor extends ChangeNotifier {
  final Dependencias _dependencias;
  final SesionProveedor _sesion;

  List<Categoria> _categorias = const [];
  List<Producto> _productos = const [];
  bool _cargando = false;
  String? _error;

  MenuProveedor({required this._dependencias, required this._sesion});

  List<Categoria> get categorias => List.unmodifiable(_categorias);
  List<Producto> get productos => List.unmodifiable(_productos);
  bool get cargando => _cargando;
  String? get error => _error;

  Future<bool> cargar() {
    return _ejecutar(() async {
      await _recargar(_requerirUsuario());
    });
  }

  Future<bool> guardarCategoria({
    String? id,
    required String nombre,
    int orden = 0,
    bool activa = true,
  }) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioMenu.guardarCategoria(
        usuarioActivo: usuario,
        id: id,
        nombre: nombre,
        orden: orden,
        activa: activa,
      );
      await _recargar(usuario);
    });
  }

  Future<bool> desactivarCategoria({required String categoriaId}) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioMenu.desactivarCategoria(
        usuarioActivo: usuario,
        categoriaId: categoriaId,
      );
      await _recargar(usuario);
    });
  }

  Future<bool> guardarProducto({
    String? id,
    required String categoriaId,
    required String nombre,
    String? descripcion,
    required int precioLocal,
    int? precioLlevar,
    int costoEmpaque = 0,
    required EstrategiaLlevar estrategiaLlevar,
    bool activo = true,
    String? imagenPath,
  }) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioMenu.guardarProducto(
        usuarioActivo: usuario,
        id: id,
        categoriaId: categoriaId,
        nombre: nombre,
        descripcion: descripcion,
        precioLocal: precioLocal,
        precioLlevar: precioLlevar,
        costoEmpaque: costoEmpaque,
        estrategiaLlevar: estrategiaLlevar,
        activo: activo,
        imagenPath: imagenPath,
      );
      await _recargar(usuario);
    });
  }

  Future<bool> desactivarProducto({required String productoId}) {
    return _ejecutar(() async {
      final usuario = _requerirUsuario();
      await _dependencias.servicioMenu.desactivarProducto(
        usuarioActivo: usuario,
        productoId: productoId,
      );
      await _recargar(usuario);
    });
  }

  Future<void> _recargar(Usuario usuario) async {
    final incluirInactivos = _sesion.puede(Accion.crearCategoria);
    _categorias = await _dependencias.servicioMenu.obtenerCategorias(
      usuario,
      soloActivas: !incluirInactivos,
    );
    _productos = await _dependencias.servicioMenu.obtenerProductos(
      usuario,
      soloActivos: !incluirInactivos,
    );
  }

  Usuario _requerirUsuario() {
    final usuario = _sesion.usuarioActivo;
    if (usuario == null) {
      throw StateError('Debes iniciar sesión para continuar.');
    }
    return usuario;
  }

  Future<bool> _ejecutar(Future<void> Function() operacion) async {
    _cargando = true;
    _error = null;
    notifyListeners();
    try {
      await operacion();
      return true;
    } catch (error) {
      _error = _mensaje(error);
      return false;
    } finally {
      _cargando = false;
      notifyListeners();
    }
  }

  String _mensaje(Object error) {
    if (error is ArgumentError) {
      return error.message?.toString() ?? 'Dato inválido.';
    }
    if (error is StateError) {
      return error.message;
    }
    return 'No se pudo completar la operación.';
  }
}
