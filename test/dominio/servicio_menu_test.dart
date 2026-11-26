import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/servicio_menu.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_menu.dart';

Usuario usuarioMenu({Rol rol = Rol.administrador, bool activo = true}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: 'u1',
    nombre: 'Usuario',
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    activo: activo,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

ServicioMenu crearServicio(
  CategoriaRepositorioMemoria categorias,
  ProductoRepositorioMemoria productos,
) {
  return ServicioMenu(
    categorias: categorias,
    productos: productos,
    permisos: const ServicioPermisos(),
  );
}

Future<Categoria> crearCategoriaBase(
  ServicioMenu servicio,
  CategoriaRepositorioMemoria repositorio,
  Usuario admin,
) async {
  await servicio.guardarCategoria(
    usuarioActivo: admin,
    nombre: 'Bebidas',
    orden: 1,
  );
  return (await repositorio.obtenerTodas()).single;
}

void main() {
  late CategoriaRepositorioMemoria categorias;
  late ProductoRepositorioMemoria productos;
  late ServicioMenu servicio;
  late Usuario admin;
  late Usuario empleado;

  setUp(() {
    categorias = CategoriaRepositorioMemoria();
    productos = ProductoRepositorioMemoria();
    servicio = crearServicio(categorias, productos);
    admin = usuarioMenu();
    empleado = usuarioMenu(rol: Rol.empleado);
  });

  group('ServicioMenu', () {
    test('empleado lee el menú pero no puede modificarlo', () async {
      final categoria = await crearCategoriaBase(servicio, categorias, admin);

      expect(await servicio.obtenerCategorias(empleado), hasLength(1));
      expect(await servicio.obtenerProductos(empleado), isEmpty);
      expect(
        servicio.guardarCategoria(usuarioActivo: empleado, nombre: 'Postres'),
        throwsStateError,
      );
      expect(
        servicio.desactivarCategoria(
          usuarioActivo: empleado,
          categoriaId: categoria.id,
        ),
        throwsStateError,
      );
      expect(
        servicio.guardarProducto(
          usuarioActivo: empleado,
          categoriaId: categoria.id,
          nombre: 'Agua',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        throwsStateError,
      );
      expect(
        servicio.desactivarProducto(
          usuarioActivo: empleado,
          productoId: 'p1',
        ),
        throwsStateError,
      );
      expect(
        servicio.obtenerCategorias(usuarioMenu(activo: false)),
        throwsStateError,
      );
    });

    test('admin crea y edita categorías sin duplicados', () async {
      await servicio.guardarCategoria(
        usuarioActivo: admin,
        nombre: '  Bebidas  ',
        orden: 1,
      );
      final original = (await categorias.obtenerTodas()).single;
      expect(original.nombre, 'Bebidas');

      expect(
        servicio.guardarCategoria(
          usuarioActivo: admin,
          nombre: 'bebidas',
        ),
        throwsStateError,
      );

      await servicio.guardarCategoria(
        usuarioActivo: admin,
        id: original.id,
        nombre: 'Bebidas frías',
        orden: 3,
        activa: false,
      );
      final editada = (await categorias.obtenerTodas()).single;

      expect(editada.nombre, 'Bebidas frías');
      expect(editada.orden, 3);
      expect(editada.activa, isFalse);
      expect(editada.creadoEn, original.creadoEn);
    });

    test('admin crea y edita productos con snapshot simple', () async {
      final categoria = await crearCategoriaBase(servicio, categorias, admin);

      await servicio.guardarProducto(
        usuarioActivo: admin,
        categoriaId: categoria.id,
        nombre: '  Agua  ',
        descripcion: 'Botella 500 ml',
        precioLocal: 1000,
        precioLlevar: 1500,
        costoEmpaque: 200,
        estrategiaLlevar: EstrategiaLlevar.precioFijo,
      );
      final original = (await productos.obtenerTodos()).single;
      expect(original.nombre, 'Agua');
      expect(original.precioLocal, 1000);
      expect(original.precioLlevar, 1500);
      expect(original.costoEmpaque, 200);
      expect(original.estrategiaLlevar, EstrategiaLlevar.precioFijo);

      expect(
        servicio.guardarProducto(
          usuarioActivo: admin,
          categoriaId: categoria.id,
          nombre: 'agua',
          precioLocal: 900,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        throwsStateError,
      );

      await servicio.guardarProducto(
        usuarioActivo: admin,
        id: original.id,
        categoriaId: categoria.id,
        nombre: 'Agua con gas',
        precioLocal: 1100,
        precioLlevar: 0,
        costoEmpaque: 300,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        activo: false,
      );
      final editado = (await productos.obtenerTodos()).single;

      expect(editado.nombre, 'Agua con gas');
      expect(editado.precioLlevar, isNull);
      expect(editado.estrategiaLlevar, EstrategiaLlevar.baseMasEmpaque);
      expect(editado.activo, isFalse);
      expect(editado.creadoEn, original.creadoEn);
    });

    test('valida precio fijo, categoría y nombres', () async {
      final categoria = await crearCategoriaBase(servicio, categorias, admin);

      expect(
        servicio.guardarProducto(
          usuarioActivo: admin,
          categoriaId: categoria.id,
          nombre: 'Agua',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.precioFijo,
        ),
        throwsArgumentError,
      );
      expect(
        servicio.guardarProducto(
          usuarioActivo: admin,
          categoriaId: 'inexistente',
          nombre: 'Agua',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        throwsStateError,
      );
      expect(
        servicio.guardarProducto(
          usuarioActivo: admin,
          categoriaId: categoria.id,
          nombre: '   ',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        throwsArgumentError,
      );

      await servicio.desactivarCategoria(
        usuarioActivo: admin,
        categoriaId: categoria.id,
      );
      expect(
        servicio.guardarProducto(
          usuarioActivo: admin,
          categoriaId: categoria.id,
          nombre: 'Agua',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        throwsStateError,
      );
    });

    test('desactiva categorías y productos conservando el histórico', () async {
      final categoria = await crearCategoriaBase(servicio, categorias, admin);
      await servicio.guardarProducto(
        usuarioActivo: admin,
        categoriaId: categoria.id,
        nombre: 'Agua',
        precioLocal: 1000,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
      );
      final producto = (await productos.obtenerTodos()).single;

      await servicio.desactivarProducto(
        usuarioActivo: admin,
        productoId: producto.id,
      );
      expect((await productos.obtenerPorId(producto.id))!.activo, isFalse);
      expect(await servicio.obtenerProductos(admin), isEmpty);
      expect(
        (await servicio.obtenerProductos(admin, soloActivos: false)).single.id,
        producto.id,
      );

      await servicio.desactivarCategoria(
        usuarioActivo: admin,
        categoriaId: categoria.id,
      );
      expect((await categorias.obtenerPorId(categoria.id))!.activa, isFalse);
      expect(await servicio.obtenerCategorias(admin), isEmpty);
      expect(
        (await servicio.obtenerCategorias(admin, soloActivas: false)).single.id,
        categoria.id,
      );
    });

    test('las lecturas devuelven un snapshot que no cambia', () async {
      final categoria = await crearCategoriaBase(servicio, categorias, admin);
      final snapshotCategorias = await servicio.obtenerCategorias(admin);
      final snapshotProductos = await servicio.obtenerProductos(
        admin,
        categoriaId: categoria.id,
      );

      await servicio.guardarCategoria(
        usuarioActivo: admin,
        nombre: 'Postres',
      );
      await servicio.guardarProducto(
        usuarioActivo: admin,
        categoriaId: categoria.id,
        nombre: 'Agua',
        precioLocal: 1000,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
      );

      expect(snapshotCategorias, hasLength(1));
      expect(snapshotProductos, isEmpty);
      expect(await servicio.obtenerCategorias(admin), hasLength(2));
      expect(await servicio.obtenerProductos(admin), hasLength(1));
    });
  });
}
