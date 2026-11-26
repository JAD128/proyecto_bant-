import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/estado/pedido_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late PedidoProveedor proveedor;
  late Producto producto;

  setUp(() async {
    final ahora = DateTime.utc(2026, 1, 1, 12);
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    dependencias = Dependencias(baseDatos: base, sesion: SesionMemoria());
    await dependencias.categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    producto = Producto(
      id: 'p1',
      categoriaId: 'c1',
      nombre: 'Agua',
      precioLocal: 1000,
      costoEmpaque: 200,
      estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
      creadoEn: ahora,
      actualizadoEn: ahora,
    );
    await dependencias.productos.guardar(producto);
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
    proveedor = PedidoProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    proveedor.dispose();
    sesion.dispose();
    await base.close();
  });

  group('PedidoProveedor', () {
    test('calcula en vivo al cambiar cantidad y modalidad', () {
      expect(proveedor.resultado, isNull);

      proveedor.agregar(producto);
      expect(proveedor.resultado!.total, 1000);

      proveedor.cambiarCantidad('p1', 2);
      expect(proveedor.resultado!.subtotal, 2000);
      expect(proveedor.resultado!.costoEmpaque, 0);

      proveedor.cambiarModalidad('p1', ModalidadPedido.llevar);
      expect(proveedor.resultado!.costoEmpaque, 400);
      expect(proveedor.resultado!.total, 2400);
      expect(proveedor.itemsCarrito.single.modalidad, ModalidadPedido.llevar);

      proveedor.cambiarCantidad('p1', 0);
      expect(proveedor.itemsCarrito, isEmpty);
      expect(proveedor.resultado, isNull);
    });

    test(
      'confirma, renueva la clave y permite anular como administrador',
      () async {
        final claveInicial = proveedor.idempotenciaKey;
        proveedor.agregar(producto);

        expect(
          await proveedor.confirmar(
            metodoPago: MetodoPago.efectivo,
            fechaLocal: '2026-01-01',
            horaLocal: '12:30',
          ),
          isTrue,
        );
        expect(proveedor.error, isNull);
        expect(proveedor.itemsCarrito, isEmpty);
        expect(proveedor.idempotenciaKey, isNot(claveInicial));
        expect(proveedor.pedidoConfirmado, isNotNull);
        expect(proveedor.pedidoConfirmado!.total, 1000);
        expect(await dependencias.pedidos.obtenerTodos(), hasLength(1));

        final pedidoId = proveedor.pedidoConfirmado!.id;
        expect(await proveedor.anular(pedidoId, 'Prueba'), isTrue);
        final anulado = await dependencias.pedidos.obtenerPorId(pedidoId);
        expect(anulado!.estado, EstadoPedido.anulado);
        expect(proveedor.pedidoConfirmado!.estado, EstadoPedido.anulado);

        proveedor.reiniciar();
        expect(proveedor.pedidoConfirmado, isNull);
      },
    );

    test('expone el error de validación sin perder el carrito', () async {
      proveedor.agregar(producto);

      expect(
        await proveedor.confirmar(
          metodoPago: MetodoPago.efectivo,
          fechaLocal: '01-01-2026',
          horaLocal: '12:30',
        ),
        isFalse,
      );
      expect(proveedor.error, 'Formato YYYY-MM-DD inválido.');
      expect(proveedor.itemsCarrito, hasLength(1));
    });
  });
}
