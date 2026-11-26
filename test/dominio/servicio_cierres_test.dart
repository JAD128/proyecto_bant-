import 'dart:convert';

import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/calculador_finanzas.dart';
import 'package:bantu/dominio/servicios/servicio_cierres.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/estado_cierre.dart';
import 'package:bantu/dominio/valores/estado_pedido.dart';
import 'package:bantu/dominio/valores/metodo_pago.dart';
import 'package:bantu/dominio/valores/modalidad_pedido.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_cierres.dart';
import '../apoyo/fakes_pedidos.dart';

class PermisosSoloFinanzas extends ServicioPermisos {
  const PermisosSoloFinanzas();

  @override
  bool puede(Usuario usuario, Accion accion) =>
      usuario.activo && accion == Accion.verFinanzas;
}

Usuario usuarioCierre({
  String id = 'admin',
  Rol rol = Rol.administrador,
  bool activo = true,
}) {
  final ahora = DateTime.utc(2026, 1, 1, 12);
  return Usuario(
    id: id,
    nombre: id,
    pinHash: 'hash',
    pinSalt: 'salt',
    rol: rol,
    activo: activo,
    creadoEn: ahora,
    actualizadoEn: ahora,
  );
}

void main() {
  late CierreRepositorioMemoria cierres;
  late PedidoRepositorioMemoria pedidos;
  late GastoRepositorioMemoria gastos;
  late ServicioCierres servicio;
  late Usuario admin;
  late Usuario mesero;

  setUp(() async {
    cierres = CierreRepositorioMemoria();
    pedidos = PedidoRepositorioMemoria();
    gastos = GastoRepositorioMemoria();
    servicio = ServicioCierres(
      cierres: cierres,
      pedidos: pedidos,
      gastos: gastos,
      calculador: const CalculadorFinanzas(),
      permisos: const ServicioPermisos(),
    );
    admin = usuarioCierre();
    mesero = usuarioCierre(id: 'mesero', rol: Rol.empleado);

    await pedidos.guardar(
      pedidoHistorial(id: 'p-efectivo', fechaLocal: '2026-01-05', total: 1000),
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p-transferencia',
        fechaLocal: '2026-01-05',
        total: 2000,
        modalidad: ModalidadPedido.llevar,
        metodoPago: MetodoPago.transferencia,
      ),
    );
    await pedidos.guardar(
      pedidoHistorial(
        id: 'p-anulado',
        fechaLocal: '2026-01-05',
        total: 9999,
        estado: EstadoPedido.anulado,
      ),
    );
    await pedidos.guardar(
      pedidoHistorial(id: 'p-otro-dia', fechaLocal: '2026-01-06', total: 5000),
    );
    await gastos.guardar(gastoCierre(valor: 300));
    await gastos.guardar(
      gastoCierre(id: 'gasto-otro-dia', fechaLocal: '2026-01-06', valor: 100),
    );
  });

  group('ServicioCierres', () {
    test('cierra el día con el snapshot calculado', () async {
      final cierre = await servicio.cerrarDia(
        usuarioActivo: admin,
        fechaLocal: '2026-01-05',
      );

      expect(cierre.estado, EstadoCierre.cerrado);
      expect(cierre.cerradoPor, admin.id);
      expect(cierre.creadoEn, equals(cierre.cerradoEn));
      expect(cierre.totalPedidos, 2);
      expect(cierre.totalVentas, 3000);
      expect(cierre.totalEfectivo, 1000);
      expect(cierre.totalTransferencia, 2000);
      expect(cierre.totalLlevar, 2000);
      expect(cierre.totalLocal, 1000);
      expect(cierre.totalEgresos, 300);
      expect(cierre.saldoNeto, 2700);
      expect(await cierres.obtenerPorFecha('2026-01-05'), isNotNull);
      expect(await cierres.obtenerPorFecha('2026-01-06'), isNull);
    });

    test('rechaza fecha local inválida', () async {
      expect(
        servicio.cerrarDia(usuarioActivo: admin, fechaLocal: '05-01-2026'),
        throwsA(isA<ArgumentError>()),
      );
      expect(await cierres.obtenerTodos(), isEmpty);
    });

    test('rechaza cerrar dos veces la misma fecha', () async {
      await servicio.cerrarDia(usuarioActivo: admin, fechaLocal: '2026-01-05');
      expect(
        servicio.cerrarDia(usuarioActivo: admin, fechaLocal: '2026-01-05'),
        throwsA(
          isA<StateError>().having(
            (error) => error.message,
            'message',
            'Ya existe un cierre para esa fecha.',
          ),
        ),
      );
      expect(await cierres.obtenerTodos(), hasLength(1));
    });

    test(
      'corrige recalculando, audita antes de actualizar y preserva el original',
      () async {
        final original = await servicio.cerrarDia(
          usuarioActivo: admin,
          fechaLocal: '2026-01-05',
        );
        await pedidos.guardar(
          pedidoHistorial(id: 'p-nuevo', fechaLocal: '2026-01-05', total: 500),
        );

        final corregido = await servicio.corregir(
          usuarioActivo: admin,
          cierreId: original.id,
          motivo: 'Pedido omitido',
        );

        expect(corregido.id, original.id);
        expect(corregido.fechaLocal, original.fechaLocal);
        expect(corregido.creadoEn, original.creadoEn);
        expect(corregido.cerradoEn, original.cerradoEn);
        expect(corregido.cerradoPor, original.cerradoPor);
        expect(corregido.totalVentas, 3500);
        expect(corregido.saldoNeto, 3200);

        final auditorias = await cierres.obtenerAuditorias(original.id);
        expect(auditorias, hasLength(1));
        expect(auditorias.single.motivo, 'Pedido omitido');
        expect(auditorias.single.usuarioId, admin.id);
        final antes =
            jsonDecode(auditorias.single.valoresAntes) as Map<String, dynamic>;
        final despues = jsonDecode(
          auditorias.single.valoresDespues,
        ) as Map<String, dynamic>;
        expect(antes['totalVentas'], 3000);
        expect(despues['totalVentas'], 3500);
        expect(antes['saldoNeto'], 2700);
        expect(despues['saldoNeto'], 3200);
        expect(cierres.operaciones, ['auditar', 'actualizar']);
      },
    );

    test('empleado no puede cerrar, corregir ni consultar', () async {
      expect(
        servicio.cerrarDia(usuarioActivo: mesero, fechaLocal: '2026-01-05'),
        throwsStateError,
      );
      expect(servicio.obtenerTodos(mesero), throwsStateError);
      expect(
        servicio.obtenerAuditorias(mesero, 'cualquiera'),
        throwsStateError,
      );

      final cierre = await servicio.cerrarDia(
        usuarioActivo: admin,
        fechaLocal: '2026-01-05',
      );
      expect(
        servicio.corregir(
          usuarioActivo: mesero,
          cierreId: cierre.id,
          motivo: 'Intento indebido',
        ),
        throwsStateError,
      );
      expect(await cierres.obtenerTodos(), hasLength(1));
      expect(await cierres.obtenerAuditorias(cierre.id), isEmpty);
    });

    test('consulta acepta verFinanzas sin permitir cerrar', () async {
      final lectura = ServicioCierres(
        cierres: cierres,
        pedidos: pedidos,
        gastos: gastos,
        calculador: const CalculadorFinanzas(),
        permisos: const PermisosSoloFinanzas(),
      );
      await servicio.cerrarDia(usuarioActivo: admin, fechaLocal: '2026-01-05');

      expect(await lectura.obtenerTodos(mesero), hasLength(1));
      expect(await lectura.obtenerPorFecha(mesero, '2026-01-05'), isNotNull);
      expect(
        lectura.cerrarDia(usuarioActivo: mesero, fechaLocal: '2026-01-06'),
        throwsStateError,
      );
    });

    test('rechaza corregir un cierre inexistente o motivo vacío', () async {
      final cierre = await servicio.cerrarDia(
        usuarioActivo: admin,
        fechaLocal: '2026-01-05',
      );
      expect(
        servicio.corregir(
          usuarioActivo: admin,
          cierreId: 'inexistente',
          motivo: 'Ajuste',
        ),
        throwsStateError,
      );
      expect(
        servicio.corregir(
          usuarioActivo: admin,
          cierreId: cierre.id,
          motivo: '   ',
        ),
        throwsArgumentError,
      );
      expect(await cierres.obtenerAuditorias(cierre.id), isEmpty);
    });
  });
}
