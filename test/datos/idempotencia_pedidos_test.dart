import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/datos/repositorios/implementaciones/drift_categoria_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_pedido_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_producto_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_usuario_repositorio.dart';
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/item_carrito.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/calculador_pedido.dart';
import 'package:bantu/dominio/servicios/servicio_pedidos.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bd.BantuDatabase base;
  late DriftPedidoRepositorio repositorio;
  final ahora = DateTime.utc(2026, 1, 1, 12);

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    await DriftCategoriaRepositorio(base)
        .guardar(Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora));
    await DriftUsuarioRepositorio(base).guardar(
      Usuario(
        id: 'u1',
        nombre: 'Administrador',
        pinHash: 'hash',
        pinSalt: 'salt',
        rol: Rol.administrador,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    await DriftProductoRepositorio(base).guardar(
      Producto(
        id: 'p1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1000,
        costoEmpaque: 200,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    repositorio = DriftPedidoRepositorio(base);
  });

  tearDown(() async {
    await base.close();
  });

  Pedido pedido({String id = 'ped1', String clave = 'idem-1'}) {
    return Pedido(
      id: id,
      idempotenciaKey: clave,
      empleadoId: 'u1',
      fechaLocal: '2026-01-01',
      horaLocal: '12:30',
      creadoEn: ahora,
      modalidad: ModalidadPedido.local,
      metodoPago: MetodoPago.efectivo,
      subtotal: 1000,
      costoEmpaque: 0,
      total: 1000,
      items: [
        ItemPedido(
          id: 'item-$id',
          productoId: 'p1',
          nombreProducto: 'Agua',
          categoriaNombre: 'Bebidas',
          cantidad: 1,
          modalidad: ModalidadPedido.local,
          precioUnitario: 1000,
          costoEmpaqueUnitario: 0,
          subtotal: 1000,
          total: 1000,
        ),
      ],
    );
  }

  test('clave duplicada directa se rechaza y el lector devuelve uno', () async {
    await repositorio.guardar(pedido());

    expect(() => repositorio.guardar(pedido(id: 'ped2')), throwsException);

    final encontrado = await repositorio.obtenerPorIdempotenciaKey('idem-1');
    expect(encontrado, isNotNull);
    expect(encontrado!.id, 'ped1');
    expect(await repositorio.obtenerTodos(), hasLength(1));
  });

  test(
    'servicio confirma dos veces la misma clave sin excepción ni duplicado',
    () async {
      final servicio = ServicioPedidos(
        pedidos: repositorio,
        categorias: DriftCategoriaRepositorio(base),
        calculador: const CalculadorPedido(),
        permisos: const ServicioPermisos(),
      );
      final producto = await DriftProductoRepositorio(base).obtenerPorId('p1');
      final items = [ItemCarrito(producto: producto!, cantidad: 1)];
      final activeUser = await DriftUsuarioRepositorio(base).obtenerPorId('u1');

      final primero = await servicio.confirmar(
        usuarioActivo: activeUser!,
        idempotenciaKey: 'idem-servicio',
        items: items,
        metodoPago: MetodoPago.efectivo,
        fechaLocal: '2026-01-01',
        horaLocal: '12:30',
      );
      final segundo = await servicio.confirmar(
        usuarioActivo: activeUser,
        idempotenciaKey: 'idem-servicio',
        items: items,
        metodoPago: MetodoPago.efectivo,
        fechaLocal: '2026-01-01',
        horaLocal: '12:30',
      );

      expect(segundo.id, primero.id);
      expect(segundo.items, hasLength(1));
      final encontrado = await repositorio.obtenerPorIdempotenciaKey(
        'idem-servicio',
      );
      expect(encontrado, isNotNull);
      expect(encontrado!.id, primero.id);
      expect(await repositorio.obtenerTodos(), hasLength(1));
    },
  );
}
