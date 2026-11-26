import 'package:bantu/dominio/entidades/pedido.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/servicio_historial.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_pedidos.dart';

Usuario usuarioHistorial({
  String id = 'mesero1',
  Rol rol = Rol.empleado,
  bool puedeVerTodosPedidos = false,
  bool activo = true,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: id,
    nombre: id,
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    puedeVerTodosPedidos: puedeVerTodosPedidos,
    activo: activo,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  late PedidoRepositorioMemoria pedidos;
  late ServicioHistorial servicio;
  late Usuario admin;
  late Usuario mesero;

  setUp(() async {
    pedidos = PedidoRepositorioMemoria();
    servicio = ServicioHistorial(
      pedidos: pedidos,
      permisos: const ServicioPermisos(),
    );
    admin = usuarioHistorial(id: 'admin', rol: Rol.administrador);
    mesero = usuarioHistorial();

    await pedidos.guardar(
      pedidoHistorial(
        id: 'p1',
        empleadoId: 'mesero1',
        fechaLocal: '2026-01-03',
        horaLocal: '10:00',
      ),
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p2',
        empleadoId: 'mesero1',
        fechaLocal: '2026-01-01',
        horaLocal: '09:00',
        estado: EstadoPedido.anulado,
        modalidad: ModalidadPedido.llevar,
        motivoAnulacion: 'Error del mesero',
      ),
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p3',
        empleadoId: 'mesero2',
        fechaLocal: '2026-01-04',
        horaLocal: '08:30',
        modalidad: ModalidadPedido.llevar,
        metodoPago: MetodoPago.transferencia,
      ),
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p4',
        empleadoId: 'mesero2',
        fechaLocal: '2025-12-31',
        horaLocal: '23:00',
      ),
    );
  });

  group('ServicioHistorial', () {
    test('empleado ve solo sus pedidos, ordenados por fecha y hora', () async {
      final resultado = await servicio.consultar(mesero);

      expect(resultado.map((pedido) => pedido.id).toList(), ['p1', 'p2']);
      expect(
        () => resultado.add(pedidoHistorial(id: 'externo', empleadoId: 'otro')),
        throwsA(isA<UnsupportedError>()),
      );
    });

    test('admin ve todos; empleado con permiso también', () async {
      final comoAdmin = await servicio.consultar(admin);
      expect(comoAdmin.map((pedido) => pedido.id).toList(), [
        'p3',
        'p1',
        'p2',
        'p4',
      ]);

      final conPermiso = await servicio.consultar(
        usuarioHistorial(id: 'supervisor', puedeVerTodosPedidos: true),
      );
      expect(conPermiso, hasLength(4));
    });

    test(
      'rechaza filtrar otro empleado sin permiso y usuarios inactivos',
      () async {
        expect(
          servicio.consultar(mesero, empleadoId: 'mesero2'),
          throwsStateError,
        );
        expect(
          servicio.consultar(usuarioHistorial(id: 'mesero1', activo: false)),
          throwsStateError,
        );
        expect(servicio.detalle(mesero, 'p3'), throwsStateError);
      },
    );

    test('aplica filtros de rango, estado, modalidad y empleado', () async {
      final rango = await servicio.consultar(
        admin,
        desde: '2026-01-01',
        hasta: '2026-01-03',
      );
      expect(rango.map((pedido) => pedido.id).toList(), ['p1', 'p2']);

      final estado = await servicio.consultar(
        admin,
        estado: EstadoPedido.confirmado,
      );
      expect(estado.map((pedido) => pedido.id).toList(), ['p3', 'p1', 'p4']);

      final modalidad = await servicio.consultar(
        admin,
        modalidad: ModalidadPedido.llevar,
      );
      expect(modalidad.map((pedido) => pedido.id).toList(), ['p3', 'p2']);

      final porEmpleado = await servicio.consultar(
        admin,
        empleadoId: 'mesero2',
      );
      expect(porEmpleado.map((pedido) => pedido.id).toList(), ['p3', 'p4']);

      final combinados = await servicio.consultar(
        admin,
        desde: '2026-01-01',
        hasta: '2026-01-04',
        empleadoId: 'mesero2',
        estado: EstadoPedido.confirmado,
        modalidad: ModalidadPedido.llevar,
      );
      expect(combinados.map((pedido) => pedido.id).toList(), ['p3']);
    });

    test('valida fechas y rechaza rango invertido', () async {
      expect(
        servicio.consultar(admin, desde: '01-01-2026'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        servicio.consultar(admin, hasta: '2026/01/03'),
        throwsA(isA<ArgumentError>()),
      );
      expect(
        servicio.consultar(admin, desde: '2026-01-03', hasta: '2026-01-01'),
        throwsA(isA<ArgumentError>()),
      );
    });

    test(
      'detalle respeta propiedad y muestra el snapshot sin recalcular',
      () async {
        final item = ItemPedido(
          id: 'item-raro',
          productoId: 'producto-1',
          nombreProducto: 'Agua',
          categoriaNombre: 'Bebidas',
          cantidad: 1,
          modalidad: ModalidadPedido.llevar,
          precioUnitario: 100,
          costoEmpaqueUnitario: 0,
          subtotal: 100,
          total: 100,
        );
        await pedidos.guardar(
          pedidoHistorial(
            id: 'p-raro',
            empleadoId: 'mesero1',
            total: 9999,
            estado: EstadoPedido.anulado,
            motivoAnulacion: 'Prueba',
            items: [item],
          ),
        );

        final propio = await servicio.detalle(mesero, 'p-raro');
        expect(propio, isNotNull);
        expect(propio!.total, 9999);
        expect(propio.motivoAnulacion, 'Prueba');
        expect(propio.metodoPago, MetodoPago.efectivo);
        expect(propio.items.single.nombreProducto, 'Agua');
        expect(propio.items.single.categoriaNombre, 'Bebidas');
        expect(propio.items.single.modalidad, ModalidadPedido.llevar);
        expect(propio.items.single.precioUnitario, 100);
        expect(propio.items.single.subtotal, 100);
        expect(propio.items.single.total, 100);

        expect(await servicio.detalle(admin, 'p3'), isNotNull);
        expect(await servicio.detalle(admin, 'inexistente'), isNull);
      },
    );
  });
}
