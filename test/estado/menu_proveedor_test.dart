import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/estado/menu_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';

void main() {
  late BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late MenuProveedor menu;

  setUp(() async {
    base = BantuDatabase.forTesting(NativeDatabase.memory());
    dependencias = Dependencias(baseDatos: base, sesion: SesionMemoria());
    sesion = SesionProveedor(dependencias: dependencias);
    await sesion.inicializar();
    expect(
      await sesion.configurarAdministrador(
        nombre: 'Admin',
        pin: '1234',
        confirmacion: '1234',
      ),
      isTrue,
    );
    menu = MenuProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    menu.dispose();
    sesion.dispose();
    await base.close();
  });

  group('MenuProveedor', () {
    test('carga el menú vacío sin errores', () async {
      expect(await menu.cargar(), isTrue);
      expect(menu.categorias, isEmpty);
      expect(menu.productos, isEmpty);
      expect(menu.cargando, isFalse);
      expect(menu.error, isNull);
    });

    test('admin crea, edita y desactiva categorías y productos', () async {
      expect(
        await menu.guardarCategoria(nombre: 'Bebidas', orden: 1),
        isTrue,
      );
      final categoria = menu.categorias.single;
      expect(categoria.nombre, 'Bebidas');

      expect(
        await menu.guardarProducto(
          categoriaId: categoria.id,
          nombre: 'Agua',
          precioLocal: 1000,
          costoEmpaque: 200,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        isTrue,
      );
      final producto = menu.productos.single;
      expect(producto.precioLocal, 1000);

      expect(
        await menu.guardarProducto(
          id: producto.id,
          categoriaId: categoria.id,
          nombre: 'Agua con gas',
          precioLocal: 1200,
          precioLlevar: 1500,
          costoEmpaque: 250,
          estrategiaLlevar: EstrategiaLlevar.precioFijo,
        ),
        isTrue,
      );
      final editado = menu.productos.single;
      expect(editado.nombre, 'Agua con gas');
      expect(editado.precioLlevar, 1500);

      expect(await menu.desactivarProducto(productoId: editado.id), isTrue);
      expect(menu.productos.single.activo, isFalse);

      expect(await menu.desactivarCategoria(categoriaId: categoria.id), isTrue);
      expect(menu.categorias.single.activa, isFalse);
      expect(menu.error, isNull);
    });

    test('expone errores de validación del servicio', () async {
      expect(await menu.guardarCategoria(nombre: 'Bebidas'), isTrue);
      expect(await menu.guardarCategoria(nombre: 'bebidas'), isFalse);
      expect(menu.error, 'Ya existe una categoría con ese nombre.');
    });

    test('empleado ve solo datos activos y no escribe', () async {
      expect(await menu.guardarCategoria(nombre: 'Bebidas'), isTrue);
      final categoria = menu.categorias.single;
      expect(
        await menu.guardarProducto(
          categoriaId: categoria.id,
          nombre: 'Agua',
          precioLocal: 1000,
          estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        ),
        isTrue,
      );
      expect(
        await menu.desactivarProducto(productoId: menu.productos.single.id),
        isTrue,
      );
      expect(await sesion.crearEmpleado(nombre: 'Mesero', pin: '5678'), isTrue);

      await sesion.cerrarSesion();
      expect(await sesion.iniciarSesion(nombre: 'Mesero', pin: '5678'), isTrue);
      expect(await menu.cargar(), isTrue);
      expect(menu.categorias, hasLength(1));
      expect(menu.productos, isEmpty);

      expect(await menu.guardarCategoria(nombre: 'Postres'), isFalse);
      expect(menu.error, 'El usuario no tiene permiso para crearCategoria.');
    });
  });
}
