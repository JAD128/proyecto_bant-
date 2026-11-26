import '../../datos/repositorios/categoria_repositorio.dart';
import '../../datos/repositorios/producto_repositorio.dart';
import '../../utilidades/generador_ids.dart';
import '../entidades/categoria.dart';
import '../entidades/producto.dart';
import '../entidades/usuario.dart';
import '../valores/estrategia_llevar.dart';
import 'servicio_permisos.dart';
import 'validadores.dart';

class ServicioMenu {
  final CategoriaRepositorio _categorias;
  final ProductoRepositorio _productos;
  final ServicioPermisos _permisos;

  const ServicioMenu({
    required this._categorias,
    required this._productos,
    required this._permisos,
  });

  Future<List<Categoria>> obtenerCategorias(
    Usuario usuarioActivo, {
    bool soloActivas = true,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.verMenu);
    final categorias = soloActivas
        ? await _categorias.obtenerActivas()
        : await _categorias.obtenerTodas();
    return List.unmodifiable(categorias);
  }

  Future<List<Producto>> obtenerProductos(
    Usuario usuarioActivo, {
    String? categoriaId,
    bool soloActivos = true,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.verMenu);

    late final List<Producto> productos;
    if (categoriaId != null) {
      final todos = await _productos.obtenerTodos();
      productos = todos.where((producto) => producto.categoriaId == categoriaId).toList();
    } else {
      productos = soloActivos
          ? await _productos.obtenerActivos()
          : await _productos.obtenerTodos();
    }

    final visibles = soloActivos
        ? productos.where((producto) => producto.activo).toList()
        : productos;
    return List.unmodifiable(visibles);
  }

  Future<void> guardarCategoria({
    required Usuario usuarioActivo,
    String? id,
    required String nombre,
    int orden = 0,
    bool activa = true,
  }) async {
    _permisos.verificar(
      usuarioActivo,
      id == null ? Accion.crearCategoria : Accion.editarCategoria,
    );
    Validadores.texto(nombre, 'nombre', max: 120);
    final nombreNormalizado = nombre.trim().toLowerCase();

    final categorias = await _categorias.obtenerTodas();
    if (categorias.any(
      (categoria) =>
          categoria.id != id &&
          categoria.nombre.trim().toLowerCase() == nombreNormalizado,
    )) {
      throw StateError('Ya existe una categoría con ese nombre.');
    }

    final ahora = DateTime.now();
    if (id == null) {
      await _categorias.guardar(
        Categoria(
          id: GeneradorIds.nuevo(),
          nombre: nombre.trim(),
          activa: activa,
          orden: orden,
          creadoEn: ahora,
        ),
      );
      return;
    }

    final actual = await _categorias.obtenerPorId(id);
    if (actual == null) {
      throw StateError('Categoría no encontrada.');
    }
    await _categorias.actualizar(
      Categoria(
        id: actual.id,
        nombre: nombre.trim(),
        activa: activa,
        orden: orden,
        creadoEn: actual.creadoEn,
      ),
    );
  }

  Future<void> desactivarCategoria({
    required Usuario usuarioActivo,
    required String categoriaId,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.desactivarCategoria);
    await _categorias.desactivar(categoriaId);
  }

  Future<void> guardarProducto({
    required Usuario usuarioActivo,
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
  }) async {
    _permisos.verificar(
      usuarioActivo,
      id == null ? Accion.crearProducto : Accion.editarProducto,
    );
    Validadores.texto(nombre, 'nombre', max: 120);
    Validadores.descripcion(descripcion);
    Validadores.dinero(precioLocal, 'precioLocal');
    Validadores.dinero(costoEmpaque, 'costoEmpaque');
    if (precioLlevar != null) {
      Validadores.dinero(precioLlevar, 'precioLlevar');
    }

    final categoria = await _categorias.obtenerPorId(categoriaId);
    if (categoria == null || !categoria.activa) {
      throw StateError('La categoría no existe o está inactiva.');
    }

    if (estrategiaLlevar == EstrategiaLlevar.precioFijo && precioLlevar == null) {
      throw ArgumentError.value(
        null,
        'precioLlevar',
        'La estrategia precio fijo requiere un precio de llevar.',
      );
    }
    final precioLlevarNormalizado =
        estrategiaLlevar == EstrategiaLlevar.baseMasEmpaque
            ? null
            : precioLlevar;

    final nombreNormalizado = nombre.trim().toLowerCase();
    final productos = await _productos.obtenerTodos();
    if (productos.any(
      (producto) =>
          producto.id != id &&
          producto.categoriaId == categoriaId &&
          producto.nombre.trim().toLowerCase() == nombreNormalizado,
    )) {
      throw StateError('Ya existe un producto con ese nombre en la categoría.');
    }

    final ahora = DateTime.now();
    if (id == null) {
      await _productos.guardar(
        Producto(
          id: GeneradorIds.nuevo(),
          categoriaId: categoriaId,
          nombre: nombre.trim(),
          descripcion: descripcion,
          precioLocal: precioLocal,
          precioLlevar: precioLlevarNormalizado,
          costoEmpaque: costoEmpaque,
          estrategiaLlevar: estrategiaLlevar,
          imagenPath: imagenPath,
          activo: activo,
          creadoEn: ahora,
          actualizadoEn: ahora,
        ),
      );
      return;
    }

    final actual = await _productos.obtenerPorId(id);
    if (actual == null) {
      throw StateError('Producto no encontrado.');
    }
    await _productos.actualizar(
      Producto(
        id: actual.id,
        categoriaId: categoriaId,
        nombre: nombre.trim(),
        descripcion: descripcion,
        precioLocal: precioLocal,
        precioLlevar: precioLlevarNormalizado,
        costoEmpaque: costoEmpaque,
        estrategiaLlevar: estrategiaLlevar,
        imagenPath: imagenPath,
        activo: activo,
        creadoEn: actual.creadoEn,
        actualizadoEn: ahora,
      ),
    );
  }

  Future<void> desactivarProducto({
    required Usuario usuarioActivo,
    required String productoId,
  }) async {
    _permisos.verificar(usuarioActivo, Accion.desactivarProducto);
    await _productos.desactivar(productoId);
  }
}
