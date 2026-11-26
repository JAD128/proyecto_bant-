import 'package:bantu/configuracion/dependencias.dart';
import 'package:bantu/datos/bd/bantu_database.dart' as bd;
import 'package:bantu/dominio/entidades/categoria.dart';
import 'package:bantu/dominio/entidades/producto.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/estrategia_llevar.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/estado/historial_proveedor.dart';
import 'package:bantu/estado/sesion_proveedor.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes.dart';
import '../apoyo/fakes_pedidos.dart';

void main() {
  late bd.BantuDatabase base;
  late Dependencias dependencias;
  late SesionProveedor sesion;
  late HistorialProveedor proveedor;
  late String adminId;
  late String meseroId;

  setUp(() async {
    base = bd.BantuDatabase.forTesting(NativeDatabase.memory());
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
    adminId = sesion.usuarioActivo!.id;
    expect(await sesion.crearEmpleado(nombre: 'Mesero', pin: '5678'), isTrue);
    meseroId = sesion.usuarios.firstWhere((u) => u.nombre == 'Mesero').id;

    final ahora = DateTime.utc(2026, 1, 1, 12);
    await dependencias.categorias.guardar(
      Categoria(id: 'c1', nombre: 'Bebidas', creadoEn: ahora),
    );
    await dependencias.productos.guardar(
      Producto(
        id: 'producto-1',
        categoriaId: 'c1',
        nombre: 'Agua',
        precioLocal: 1000,
        estrategiaLlevar: EstrategiaLlevar.baseMasEmpaque,
        creadoEn: ahora,
        actualizadoEn: ahora,
      ),
    );

    await dependencias.pedidos.guardar(
      pedidoHistorial(
        id: 'pedido-admin',
        empleadoId: adminId,
        fechaLocal: '2026-01-05',
        horaLocal: '11:00',
      ),
    );
    await dependencias.pedidos.guardar(
      pedidoHistorial(
        id: 'pedido-mesero-1',
        empleadoId: meseroId,
        fechaLocal: '2026-01-03',
        horaLocal: '10:00',
        estado: EstadoPedido.anulado,
        modalidad: ModalidadPedido.llevar,
        motivoAnulacion: 'Prueba',
      ),
    );
    await dependencias.pedidos.guardar(
      pedidoHistorial(
        id: 'pedido-mesero-2',
        empleadoId: meseroId,
        fechaLocal: '2026-01-01',
        horaLocal: '09:00',
      ),
    );

    proveedor = HistorialProveedor(dependencias: dependencias, sesion: sesion);
  });

  tearDown(() async {
    proveedor.dispose();
    sesion.dispose();
    await base.close();
  });

  group('HistorialProveedor', () {
    test('carga el historial y aplica y limpia filtros', () async {
      expect(await proveedor.cargar(), isTrue);
      expect(proveedor.pedidos, hasLength(3));
      expect(proveedor.pedidos.first.id, 'pedido-admin');
      expect(proveedor.error, isNull);

      expect(
        await proveedor.cambiarFiltros(
          desde: '2026-01-01',
          hasta: '2026-01-03',
          estado: EstadoPedido.anulado,
          modalidad: ModalidadPedido.llevar,
        ),
        isTrue,
      );
      expect(proveedor.desde, '2026-01-01');
      expect(proveedor.hasta, '2026-01-03');
      expect(proveedor.estado, EstadoPedido.anulado);
      expect(proveedor.modalidad, ModalidadPedido.llevar);
      expect(proveedor.pedidos.map((p) => p.id).toList(), ['pedido-mesero-1']);

      expect(await proveedor.limpiarFiltros(), isTrue);
      expect(proveedor.desde, isNull);
      expect(proveedor.hasta, isNull);
      expect(proveedor.empleadoId, isNull);
      expect(proveedor.estado, isNull);
      expect(proveedor.modalidad, isNull);
      expect(proveedor.pedidos, hasLength(3));
    });

    test('empleado ve solo sus pedidos y no puede filtrar otros', () async {
      await sesion.cerrarSesion();
      expect(await sesion.iniciarSesion(nombre: 'Mesero', pin: '5678'), isTrue);

      expect(await proveedor.cargar(), isTrue);
      expect(proveedor.pedidos.map((p) => p.id).toList(), [
        'pedido-mesero-1',
        'pedido-mesero-2',
      ]);

      expect(await proveedor.cambiarFiltros(empleadoId: adminId), isFalse);
      expect(
        proveedor.error,
        'No tienes permiso para ver pedidos de otro empleado.',
      );
      expect(proveedor.pedidos, hasLength(2));
    });

    test('expone errores de rango invertido sin reemplazar la lista', () async {
      expect(await proveedor.cargar(), isTrue);
      final anteriores = proveedor.pedidos;

      expect(
        await proveedor.cambiarFiltros(
          desde: '2026-02-01',
          hasta: '2026-01-01',
        ),
        isFalse,
      );
      expect(proveedor.error, 'La fecha desde no puede ser mayor que hasta.');
      expect(proveedor.pedidos, equals(anteriores));
      expect(proveedor.cargando, isFalse);
    });

    test('detalle devuelve el pedido o null si no existe', () async {
      final pedido = await proveedor.detalle('pedido-mesero-1');
      expect(pedido, isNotNull);
      expect(pedido!.total, 1000);
      expect(pedido.motivoAnulacion, 'Prueba');
      expect(pedido.items.single.categoriaNombre, 'Bebidas');

      expect(await proveedor.detalle('no-existe'), isNull);
      expect(proveedor.error, isNull);
    });
  });
}
