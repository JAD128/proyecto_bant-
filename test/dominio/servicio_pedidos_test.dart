import 'package:bantu/datos/repositorios/categoria_repositorio.dart';
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/item_carrito.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/calculador_pedido.dart';
import 'package:bantu/dominio/servicios/servicio_pedidos.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_menu.dart';
import '../apoyo/fakes_pedidos.dart';

Producto producto({
  String id = 'p1',
  String nombre = 'Agua',
  int precioLocal = 1000,
  int? precioLlevar,
  int costoEmpaque = 0,
  EstrategiaLlevar estrategia = EstrategiaLlevar.baseMasEmpaque,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Producto(
    id: id,
    categoriaId: 'c1',
    nombre: nombre,
    precioLocal: precioLocal,
    precioLlevar: precioLlevar,
    costoEmpaque: costoEmpaque,
    estrategiaLlevar: estrategia,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

Usuario usuario({Rol rol = Rol.administrador}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: rol == Rol.administrador ? 'admin' : 'mesero',
    nombre: rol == Rol.administrador ? 'Admin' : 'Mesero',
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  late PedidoRepositorioMemoria pedidos;
  late CategoriaRepositorio categorias;
  late ServicioPedidos servicio;

  setUp(() async {
    final ahora = DateTime.utc(2026, 1, 1, 12);
    pedidos = PedidoRepositorioMemoria();
    categorias = CategoriaRepositorioMemoria();
    await categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    servicio = ServicioPedidos(
      pedidos: pedidos,
      categorias: categorias,
      calculador: const CalculadorPedido(),
      permisos: const ServicioPermisos(),
    );
  });

  Future<Pedido> confirmar({
    String clave = 'clave-1',
    required List<ItemCarrito> items,
    String fechaLocal = '2026-01-01',
    String horaLocal = '12:30',
    Rol rol = Rol.administrador,
  }) {
    return servicio.confirmar(
      usuarioActivo: usuario(rol: rol),
      idempotenciaKey: clave,
      items: items,
      metodoPago: MetodoPago.efectivo,
      fechaLocal: fechaLocal,
      horaLocal: horaLocal,
    );
  }

  group('ServicioPedidos', () {
    test('confirma con snapshot exacto del producto y la categoría', () async {
      final pedido = await confirmar(
        items: [
          ItemCarrito(
            producto: producto(
              precioLlevar: 1500,
              costoEmpaque: 200,
              estrategia: EstrategiaLlevar.precioFijo,
            ),
            cantidad: 2,
            modalidad: ModalidadPedido.llevar,
          ),
        ],
      );

      expect(pedido.idempotenciaKey, 'clave-1');
      expect(pedido.empleadoId, 'admin');
      expect(pedido.estado, EstadoPedido.confirmado);
      expect(pedido.metodoPago, MetodoPago.efectivo);
      expect(pedido.fechaLocal, '2026-01-01');
      expect(pedido.horaLocal, '12:30');
      expect(pedido.id, isNotEmpty);
      expect(pedido.items, hasLength(1));

      final item = pedido.items.single;
      expect(item.id, isNotEmpty);
      expect(item.productoId, 'p1');
      expect(item.nombreProducto, 'Agua');
      expect(item.categoriaNombre, 'Bebidas');
      expect(item.cantidad, 2);
      expect(item.modalidad, ModalidadPedido.llevar);
      expect(item.precioUnitario, 1500);
      expect(item.costoEmpaqueUnitario, 0);
      expect(item.subtotal, 3000);
      expect(item.total, 3000);
      expect(pedido.subtotal, 3000);
      expect(pedido.costoEmpaque, 0);
      expect(pedido.total, 3000);
    });

    test(
      'modalidad mixta se guarda como llevar y conserva cada línea',
      () async {
        final pedido = await confirmar(
          items: [
            ItemCarrito(producto: producto(costoEmpaque: 300), cantidad: 2),
            ItemCarrito(
              producto: producto(
                id: 'p2',
                nombre: 'Café',
                precioLocal: 2000,
                costoEmpaque: 100,
              ),
              cantidad: 1,
              modalidad: ModalidadPedido.llevar,
            ),
          ],
        );

        expect(pedido.modalidad, ModalidadPedido.llevar);
        expect(pedido.items.map((item) => item.modalidad).toList(), [
          ModalidadPedido.local,
          ModalidadPedido.llevar,
        ]);
        expect(pedido.subtotal, 4000);
        expect(pedido.costoEmpaque, 100);
        expect(pedido.total, 4100);
      },
    );

    test('carrito sin líneas de llevar se guarda como local', () async {
      final pedido = await confirmar(
        items: [
          ItemCarrito(producto: producto(costoEmpaque: 500), cantidad: 1),
        ],
      );

      expect(pedido.modalidad, ModalidadPedido.local);
      expect(pedido.costoEmpaque, 0);
    });

    test('idempotencia devuelve el pedido existente sin duplicar', () async {
      final items = [ItemCarrito(producto: producto(), cantidad: 1)];
      final primero = await confirmar(clave: 'clave-dup', items: items);
      final segundo = await confirmar(clave: 'clave-dup', items: items);

      expect(segundo.id, primero.id);
      expect(segundo.creadoEn, primero.creadoEn);
      expect(await pedidos.obtenerTodos(), hasLength(1));
      expect(await pedidos.obtenerPorIdempotenciaKey('clave-dup'), isNotNull);
    });

    test(
      'empleado no puede anular y administrador sí, con auditoría',
      () async {
        final pedido = await confirmar(
          items: [ItemCarrito(producto: producto(), cantidad: 1)],
        );

        expect(
          () => servicio.anular(
            usuarioActivo: usuario(rol: Rol.empleado),
            pedidoId: pedido.id,
            motivo: 'Error del mesero',
          ),
          throwsStateError,
        );
        expect(
          (await pedidos.obtenerPorId(pedido.id))!.estado,
          EstadoPedido.confirmado,
        );

        await servicio.anular(
          usuarioActivo: usuario(rol: Rol.administrador),
          pedidoId: pedido.id,
          motivo: 'Error del mesero',
        );
        final anulado = await pedidos.obtenerPorId(pedido.id);
        expect(anulado!.estado, EstadoPedido.anulado);
        expect(anulado.motivoAnulacion, 'Error del mesero');
        expect(pedidos.auditorias, hasLength(1));
        expect(pedidos.auditorias.single.usuarioId, 'admin');
      },
    );

    test('rechaza fecha y hora inválidas', () async {
      final items = [ItemCarrito(producto: producto(), cantidad: 1)];

      expect(
        () => confirmar(
          clave: 'clave-fecha',
          items: items,
          fechaLocal: '01-01-2026',
        ),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        () => confirmar(clave: 'clave-hora', items: items, horaLocal: '25:00'),
        throwsA(isA<ArgumentError>()),
      );
      expect(await pedidos.obtenerTodos(), isEmpty);
    });

    test('rechaza idempotenciaKey vacía', () async {
      expect(
        () => confirmar(
          clave: '   ',
          items: [ItemCarrito(producto: producto(), cantidad: 1)],
        ),
        throwsA(isA<ArgumentError>()),
      );
    });
  });
}
