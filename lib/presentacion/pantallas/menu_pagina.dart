import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../dominio/entidades/categoria.dart';
import '../../dominio/entidades/producto.dart';
import '../../dominio/servicios/servicio_permisos.dart';
import '../../dominio/servicios/validadores.dart';
import '../../dominio/valores/estrategia_llevar.dart';
import '../../estado/menu_proveedor.dart';
import '../../utilidades/formato_moneda.dart';
import '../widgets/guardia_rol.dart';

class MenuPagina extends StatefulWidget {
  const MenuPagina({super.key});

  @override
  State<MenuPagina> createState() => _MenuPaginaState();
}

class _MenuPaginaState extends State<MenuPagina> {
  final _formularioCategoria = GlobalKey<FormState>();
  final _nombreCategoria = TextEditingController();
  final _ordenCategoria = TextEditingController(text: '0');
  String? _categoriaIdEditando;
  bool _categoriaActiva = true;

  final _formularioProducto = GlobalKey<FormState>();
  final _nombreProducto = TextEditingController();
  final _descripcionProducto = TextEditingController();
  final _precioLocal = TextEditingController();
  final _precioLlevar = TextEditingController();
  final _costoEmpaque = TextEditingController(text: '0');
  final _imagenPath = TextEditingController();
  String? _productoIdEditando;
  String? _categoriaSeleccionada;
  EstrategiaLlevar _estrategia = EstrategiaLlevar.baseMasEmpaque;
  bool _productoActivo = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final proveedor = context.read<MenuProveedor>();
      await proveedor.cargar();
      if (!mounted) {
        return;
      }
      setState(() {
        _categoriaSeleccionada ??= proveedor.categorias
            .where((categoria) => categoria.activa)
            .map((categoria) => categoria.id)
            .firstOrNull;
      });
    });
  }

  @override
  void dispose() {
    _nombreCategoria.dispose();
    _ordenCategoria.dispose();
    _nombreProducto.dispose();
    _descripcionProducto.dispose();
    _precioLocal.dispose();
    _precioLlevar.dispose();
    _costoEmpaque.dispose();
    _imagenPath.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final menu = context.watch<MenuProveedor>();

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menú'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Categorías'),
              Tab(text: 'Productos'),
            ],
          ),
        ),
        body: SafeArea(
          child: TabBarView(
            children: [
              _vistaCategorias(menu),
              _vistaProductos(menu),
            ],
          ),
        ),
      ),
    );
  }

  Widget _vistaCategorias(MenuProveedor menu) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GuardiaRol(
            accion: Accion.crearCategoria,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formularioCategoria,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _categoriaIdEditando == null
                            ? 'Nueva categoría'
                            : 'Editar categoría',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nombreCategoria,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.category_outlined),
                        ),
                        validator: (valor) => _validarTexto(valor, 'nombre'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _ordenCategoria,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Orden',
                          prefixIcon: Icon(Icons.numbers_outlined),
                        ),
                        validator: (valor) => _validarEntero(valor, 'orden'),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Activa'),
                        value: _categoriaActiva,
                        onChanged: menu.cargando
                            ? null
                            : (valor) =>
                                  setState(() => _categoriaActiva = valor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed:
                                  menu.cargando ? null : _guardarCategoria,
                              icon: const Icon(Icons.save_outlined),
                              label: Text(
                                _categoriaIdEditando == null
                                    ? 'Crear categoría'
                                    : 'Guardar cambios',
                              ),
                            ),
                          ),
                          if (_categoriaIdEditando != null) ...[
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: _limpiarCategoria,
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Categorías registradas',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (menu.cargando && menu.categorias.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            for (final categoria in menu.categorias)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.category_outlined),
                  title: Text(categoria.nombre),
                  subtitle: Text(
                    'Orden ${categoria.orden} · '
                    '${categoria.activa ? 'Activa' : 'Inactiva'}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GuardiaRol(
                        accion: Accion.editarCategoria,
                        child: Semantics(
                          button: true,
                          label: 'Editar categoría ${categoria.nombre}',
                          child: IconButton(
                            tooltip: 'Editar categoría',
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: menu.cargando
                                ? null
                                : () => _editarCategoria(categoria),
                          ),
                        ),
                      ),
                      GuardiaRol(
                        accion: Accion.desactivarCategoria,
                        child: Semantics(
                          button: true,
                          label: 'Desactivar categoría ${categoria.nombre}',
                          child: IconButton(
                            tooltip: 'Desactivar categoría',
                            icon: const Icon(Icons.block_outlined),
                            onPressed: menu.cargando || !categoria.activa
                                ? null
                                : () => _desactivarCategoria(categoria),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  Widget _vistaProductos(MenuProveedor menu) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          GuardiaRol(
            accion: Accion.crearProducto,
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Form(
                  key: _formularioProducto,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        _productoIdEditando == null
                            ? 'Nuevo producto'
                            : 'Editar producto',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<String>(
                        initialValue: _categoriaSeleccionada,
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          prefixIcon: Icon(Icons.category_outlined),
                        ),
                        items: [
                          for (final categoria in menu.categorias)
                            DropdownMenuItem<String>(
                              value: categoria.id,
                              child: Text(
                                categoria.activa
                                    ? categoria.nombre
                                    : '${categoria.nombre} (inactiva)',
                              ),
                            ),
                        ],
                        onChanged: menu.cargando
                            ? null
                            : (valor) =>
                                  setState(() => _categoriaSeleccionada = valor),
                        validator: (valor) => valor == null || valor.isEmpty
                            ? 'Selecciona una categoría.'
                            : null,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _nombreProducto,
                        decoration: const InputDecoration(
                          labelText: 'Nombre',
                          prefixIcon: Icon(Icons.restaurant_menu_outlined),
                        ),
                        validator: (valor) => _validarTexto(valor, 'nombre'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _descripcionProducto,
                        maxLines: 2,
                        decoration: const InputDecoration(
                          labelText: 'Descripción (opcional)',
                          prefixIcon: Icon(Icons.notes_outlined),
                        ),
                        validator: (valor) =>
                            _validarDescripcion(valor ?? ''),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _precioLocal,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Precio local (COP)',
                          prefixIcon: Icon(Icons.attach_money_outlined),
                        ),
                        validator: (valor) =>
                            _validarEntero(valor, 'precioLocal'),
                      ),
                      const SizedBox(height: 12),
                      DropdownButtonFormField<EstrategiaLlevar>(
                        initialValue: _estrategia,
                        decoration: const InputDecoration(
                          labelText: 'Estrategia para llevar',
                          prefixIcon: Icon(Icons.delivery_dining_outlined),
                        ),
                        items: const [
                          DropdownMenuItem(
                            value: EstrategiaLlevar.baseMasEmpaque,
                            child: Text('Base + empaque'),
                          ),
                          DropdownMenuItem(
                            value: EstrategiaLlevar.precioFijo,
                            child: Text('Precio fijo'),
                          ),
                        ],
                        onChanged: menu.cargando
                            ? null
                            : (valor) {
                                if (valor != null) {
                                  setState(() => _estrategia = valor);
                                }
                              },
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _precioLlevar,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Precio fijo de llevar (opcional)',
                          prefixIcon: Icon(Icons.local_shipping_outlined),
                        ),
                        validator: _validarPrecioLlevar,
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _costoEmpaque,
                        keyboardType: TextInputType.number,
                        decoration: const InputDecoration(
                          labelText: 'Costo de empaque (COP)',
                          prefixIcon: Icon(Icons.inventory_2_outlined),
                        ),
                        validator: (valor) =>
                            _validarEntero(valor, 'costoEmpaque'),
                      ),
                      const SizedBox(height: 12),
                      TextFormField(
                        controller: _imagenPath,
                        decoration: const InputDecoration(
                          labelText: 'Ruta de imagen (opcional)',
                          prefixIcon: Icon(Icons.image_outlined),
                        ),
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Activo'),
                        value: _productoActivo,
                        onChanged: menu.cargando
                            ? null
                            : (valor) =>
                                  setState(() => _productoActivo = valor),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          Expanded(
                            child: FilledButton.icon(
                              onPressed: menu.cargando ? null : _guardarProducto,
                              icon: const Icon(Icons.save_outlined),
                              label: Text(
                                _productoIdEditando == null
                                    ? 'Crear producto'
                                    : 'Guardar cambios',
                              ),
                            ),
                          ),
                          if (_productoIdEditando != null) ...[
                            const SizedBox(width: 8),
                            TextButton(
                              onPressed: _limpiarProducto,
                              child: const Text('Cancelar'),
                            ),
                          ],
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Productos registrados',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          if (menu.cargando && menu.productos.isEmpty)
            const Center(child: CircularProgressIndicator())
          else
            for (final producto in menu.productos)
              Card(
                child: ListTile(
                  leading: const Icon(Icons.restaurant_menu_outlined),
                  title: Text(producto.nombre),
                  subtitle: Text(
                    '${_textoCategoria(menu, producto.categoriaId)} · '
                    '${FormatoMoneda.cop(producto.precioLocal)} · '
                    '${producto.estrategiaLlevar == EstrategiaLlevar.precioFijo
                        ? 'Precio fijo'
                        : 'Base + empaque'}'
                    '${producto.activo ? '' : ' · Inactivo'}',
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      GuardiaRol(
                        accion: Accion.editarProducto,
                        child: Semantics(
                          button: true,
                          label: 'Editar producto ${producto.nombre}',
                          child: IconButton(
                            tooltip: 'Editar producto',
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: menu.cargando
                                ? null
                                : () => _editarProducto(producto),
                          ),
                        ),
                      ),
                      GuardiaRol(
                        accion: Accion.desactivarProducto,
                        child: Semantics(
                          button: true,
                          label: 'Desactivar producto ${producto.nombre}',
                          child: IconButton(
                            tooltip: 'Desactivar producto',
                            icon: const Icon(Icons.block_outlined),
                            onPressed: menu.cargando || !producto.activo
                                ? null
                                : () => _desactivarProducto(producto),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
        ],
      ),
    );
  }

  String _textoCategoria(MenuProveedor menu, String id) {
    return menu.categorias
            .where((categoria) => categoria.id == id)
            .map((categoria) => categoria.nombre)
            .firstOrNull ??
        'Sin categoría';
  }

  String? _validarTexto(String? valor, String campo) {
    try {
      Validadores.texto(valor ?? '', campo);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Texto inválido.';
    }
  }

  String? _validarDescripcion(String valor) {
    try {
      Validadores.descripcion(valor.trim().isEmpty ? null : valor);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Descripción inválida.';
    }
  }

  String? _validarEntero(String? valor, String campo) {
    final numero = int.tryParse(valor?.trim() ?? '');
    if (numero == null) {
      return 'Escribe un número entero.';
    }
    try {
      Validadores.dinero(numero, campo);
      return null;
    } on ArgumentError catch (error) {
      return error.message?.toString() ?? 'Valor inválido.';
    }
  }

  String? _validarPrecioLlevar(String? valor) {
    final texto = valor?.trim() ?? '';
    if (texto.isEmpty) {
      if (_estrategia == EstrategiaLlevar.precioFijo) {
        return 'Escribe el precio fijo de llevar.';
      }
      return null;
    }
    return _validarEntero(valor, 'precioLlevar');
  }

  Future<void> _guardarCategoria() async {
    if (!_formularioCategoria.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<MenuProveedor>();
    final correcto = await proveedor.guardarCategoria(
      id: _categoriaIdEditando,
      nombre: _nombreCategoria.text,
      orden: int.tryParse(_ordenCategoria.text) ?? 0,
      activa: _categoriaActiva,
    );
    if (correcto) {
      if (mounted) {
        _limpiarCategoria();
      }
      return;
    }
    if (mounted) {
      _mostrarError(proveedor.error);
    }
  }

  Future<void> _desactivarCategoria(Categoria categoria) async {
    final proveedor = context.read<MenuProveedor>();
    final correcto = await proveedor.desactivarCategoria(
      categoriaId: categoria.id,
    );
    if (!correcto && mounted) {
      _mostrarError(proveedor.error);
      return;
    }
    if (correcto && mounted && _categoriaIdEditando == categoria.id) {
      _limpiarCategoria();
    }
  }

  void _editarCategoria(Categoria categoria) {
    setState(() {
      _categoriaIdEditando = categoria.id;
      _nombreCategoria.text = categoria.nombre;
      _ordenCategoria.text = categoria.orden.toString();
      _categoriaActiva = categoria.activa;
    });
  }

  void _limpiarCategoria() {
    setState(() {
      _categoriaIdEditando = null;
      _nombreCategoria.clear();
      _ordenCategoria.text = '0';
      _categoriaActiva = true;
    });
  }

  Future<void> _guardarProducto() async {
    if (!_formularioProducto.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    final proveedor = context.read<MenuProveedor>();
    final precioLlevarTexto = _precioLlevar.text.trim();
    final correcto = await proveedor.guardarProducto(
      id: _productoIdEditando,
      categoriaId: _categoriaSeleccionada!,
      nombre: _nombreProducto.text,
      descripcion:
          _descripcionProducto.text.trim().isEmpty
              ? null
              : _descripcionProducto.text.trim(),
      precioLocal: int.parse(_precioLocal.text),
      precioLlevar:
          precioLlevarTexto.isEmpty ? null : int.parse(precioLlevarTexto),
      costoEmpaque: int.tryParse(_costoEmpaque.text) ?? 0,
      estrategiaLlevar: _estrategia,
      activo: _productoActivo,
      imagenPath:
          _imagenPath.text.trim().isEmpty ? null : _imagenPath.text.trim(),
    );
    if (correcto) {
      if (mounted) {
        _limpiarProducto();
      }
      return;
    }
    if (mounted) {
      _mostrarError(proveedor.error);
    }
  }

  Future<void> _desactivarProducto(Producto producto) async {
    final proveedor = context.read<MenuProveedor>();
    final correcto = await proveedor.desactivarProducto(
      productoId: producto.id,
    );
    if (!correcto && mounted) {
      _mostrarError(proveedor.error);
      return;
    }
    if (correcto && mounted && _productoIdEditando == producto.id) {
      _limpiarProducto();
    }
  }

  void _editarProducto(Producto producto) {
    setState(() {
      _productoIdEditando = producto.id;
      _categoriaSeleccionada = producto.categoriaId;
      _nombreProducto.text = producto.nombre;
      _descripcionProducto.text = producto.descripcion ?? '';
      _precioLocal.text = producto.precioLocal.toString();
      _precioLlevar.text = producto.precioLlevar?.toString() ?? '';
      _costoEmpaque.text = producto.costoEmpaque.toString();
      _imagenPath.text = producto.imagenPath ?? '';
      _estrategia = producto.estrategiaLlevar;
      _productoActivo = producto.activo;
    });
  }

  void _limpiarProducto() {
    setState(() {
      _productoIdEditando = null;
      _nombreProducto.clear();
      _descripcionProducto.clear();
      _precioLocal.clear();
      _precioLlevar.clear();
      _costoEmpaque.text = '0';
      _imagenPath.clear();
      _estrategia = EstrategiaLlevar.baseMasEmpaque;
      _productoActivo = true;
    });
  }

  void _mostrarError(String? mensaje) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(mensaje ?? 'No se pudo completar la operación.')),
    );
  }
}
