import 'package:bantu/datos/repositorios/categoria_repositorio.dart';
import 'package:bantu/datos/repositorios/producto_repositorio.dart';
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';

class CategoriaRepositorioMemoria implements CategoriaRepositorio {
  final Map<String, Categoria> _porId = <String, Categoria>{};

  @override
  Future<List<Categoria>> obtenerTodas() async {
    final categorias = _porId.values.toList();
    categorias.sort((a, b) => a.orden.compareTo(b.orden));
    return List.unmodifiable(categorias);
  }

  @override
  Future<List<Categoria>> obtenerActivas() async {
    final categorias = (await obtenerTodas())
        .where((categoria) => categoria.activa)
        .toList();
    return List.unmodifiable(categorias);
  }

  @override
  Future<Categoria?> obtenerPorId(String id) async => _porId[id];

  @override
  Future<void> guardar(Categoria categoria) async {
    if (_porId.containsKey(categoria.id)) {
      throw StateError('Categoría ya existe: ${categoria.id}');
    }
    _porId[categoria.id] = categoria;
  }

  @override
  Future<void> actualizar(Categoria categoria) async {
    if (!_porId.containsKey(categoria.id)) {
      throw StateError('Categoría no encontrada: ${categoria.id}');
    }
    _porId[categoria.id] = categoria;
  }

  @override
  Future<void> desactivar(String id) async {
    final categoria = await obtenerPorId(id);
    if (categoria == null) {
      throw StateError('Categoría no encontrada: $id');
    }
    await actualizar(
      Categoria(
        id: categoria.id,
        nombre: categoria.nombre,
        activa: false,
        orden: categoria.orden,
        creadoEn: categoria.creadoEn,
      ),
    );
  }
}

class ProductoRepositorioMemoria implements ProductoRepositorio {
  final Map<String, Producto> _porId = <String, Producto>{};

  @override
  Future<List<Producto>> obtenerTodos() async {
    final productos = _porId.values.toList();
    productos.sort((a, b) => a.nombre.compareTo(b.nombre));
    return List.unmodifiable(productos);
  }

  @override
  Future<List<Producto>> obtenerActivos() async {
    final productos = (await obtenerTodos())
        .where((producto) => producto.activo)
        .toList();
    return List.unmodifiable(productos);
  }

  @override
  Future<List<Producto>> obtenerPorCategoria(String categoriaId) async {
    final productos = (await obtenerTodos())
        .where(
          (producto) =>
              producto.categoriaId == categoriaId && producto.activo,
        )
        .toList();
    return List.unmodifiable(productos);
  }

  @override
  Future<Producto?> obtenerPorId(String id) async => _porId[id];

  @override
  Future<void> guardar(Producto producto) async {
    if (_porId.containsKey(producto.id)) {
      throw StateError('Producto ya existe: ${producto.id}');
    }
    _porId[producto.id] = producto;
  }

  @override
  Future<void> actualizar(Producto producto) async {
    if (!_porId.containsKey(producto.id)) {
      throw StateError('Producto no encontrado: ${producto.id}');
    }
    _porId[producto.id] = producto;
  }

  @override
  Future<void> desactivar(String id) async {
    final producto = await obtenerPorId(id);
    if (producto == null) {
      throw StateError('Producto no encontrado: $id');
    }
    await actualizar(
      Producto(
        id: producto.id,
        categoriaId: producto.categoriaId,
        nombre: producto.nombre,
        descripcion: producto.descripcion,
        precioLocal: producto.precioLocal,
        precioLlevar: producto.precioLlevar,
        costoEmpaque: producto.costoEmpaque,
        estrategiaLlevar: producto.estrategiaLlevar,
        imagenPath: producto.imagenPath,
        activo: false,
        creadoEn: producto.creadoEn,
        actualizadoEn: DateTime.now(),
      ),
    );
  }
}
