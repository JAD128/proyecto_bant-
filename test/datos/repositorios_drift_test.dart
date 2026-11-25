import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/datos/repositorios/implementaciones/drift_categoria_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_pedido_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_producto_repositorio.dart';
import 'package:bantu/datos/repositorios/implementaciones/drift_usuario_repositorio.dart';
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late bd.BantuDatabase base;
  final ahora = DateTime.utc(2026, 1, 1, 12);

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
    await DriftCategoriaRepositorio(base).guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
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
  });

  tearDown(() async {
    await base.close();
  });

  test('producto se guarda, se lee y se desactiva', () async {
    final repositorio = DriftProductoRepositorio(base);
    await repositorio.guardar(
      Producto(
        id: 'p1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1000,
        precioLlevar: 1500,
        costoEmpaque: 200,
        estrategiaLlevar: EstrategiaLlevar.precioFijo,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );

    final obtenido = await repositorio.obtenerPorId('p1');
    expect(obtenido, isNotNull);
    expect(obtenido!.nombre, 'Agua');
    expect(obtenido.estrategiaLlevar, EstrategiaLlevar.precioFijo);
    expect(obtenido.activo, isTrue);
    expect(await repositorio.obtenerActivos(), hasLength(1));

    await repositorio.desactivar('p1');
    final desactivado = await repositorio.obtenerPorId('p1');
    expect(desactivado!.activo, isFalse);
    expect(await repositorio.obtenerActivos(), isEmpty);
  });

  test('pedido conserva items y anulacion con auditoria', () async {
    await DriftProductoRepositorio(base).guardar(
      Producto(
        id: 'p1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1300,
        costoEmpaque: 300,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );
    final repositorio = DriftPedidoRepositorio(base);
    await repositorio.guardar(
      Pedido(
        id: 'ped1',
        idempotenciaKey: 'idem-1',
        empleadoId: 'u1',
        fechaLocal: '2026-01-01',
        horaLocal: '12:30',
        creadoEn: ahora,
        modalidad: ModalidadPedido.llevar,
        metodoPago: MetodoPago.efectivo,
        subtotal: 1300,
        costoEmpaque: 300,
        total: 1600,
        items: [
          const ItemPedido(
            id: 'item1',
            productoId: 'p1',
            nombreProducto: 'Agua',
            categoriaNombre: 'Bebidas',
            cantidad: 1,
            modalidad: ModalidadPedido.llevar,
            precioUnitario: 1300,
            costoEmpaqueUnitario: 300,
            subtotal: 1300,
            total: 1600,
          ),
        ],
      ),
    );

    final obtenido = await repositorio.obtenerPorId('ped1');
    expect(obtenido, isNotNull);
    expect(obtenido!.items, hasLength(1));
    expect(obtenido.items.single.nombreProducto, 'Agua');
    expect(obtenido.total, 1600);
    expect(await repositorio.obtenerPorFecha('2026-01-01'), hasLength(1));
    expect(await repositorio.obtenerPorEmpleado('u1'), hasLength(1));

    await repositorio.anular(
      pedidoId: 'ped1',
      motivo: 'Error del mesero',
      usuarioId: 'u1',
    );
    final anulado = await repositorio.obtenerPorId('ped1');
    expect(anulado!.estado, EstadoPedido.anulado);
    expect(anulado.motivoAnulacion, 'Error del mesero');
  });
}
