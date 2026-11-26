import 'package:bantu/dominio/entidades/gasto.dart';
import 'package:bantu/dominio/entidades/usuario.dart';
import 'package:bantu/dominio/servicios/calculador_finanzas.dart';
import 'package:bantu/dominio/servicios/servicio_finanzas.dart';
import 'package:bantu/dominio/servicios/servicio_permisos.dart';
import 'package:bantu/dominio/valores/rol.dart';
import 'package:flutter_test/flutter_test.dart';

import '../apoyo/fakes_cierres.dart';
import '../apoyo/fakes_finanzas.dart';
import '../apoyo/fakes_pedidos.dart';

class PermisosSoloConsulta extends ServicioPermisos {
  const PermisosSoloConsulta();

  @override
  bool puede(Usuario usuario, Accion accion) =>
      usuario.activo && accion == Accion.verFinanzas;
}

Usuario usuarioFinanzas({
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
  late PedidoRepositorioMemoria pedidos;
  late GastoRepositorioMemoria gastos;
  late ServicioFinanzas servicio;
  late Usuario admin;
  late Usuario mesero;

  setUp(() async {
    pedidos = PedidoRepositorioMemoria();
    gastos = GastoRepositorioMemoria();
    servicio = ServicioFinanzas(
      gastos: gastos,
      pedidos: pedidos,
      calculador: const CalculadorFinanzas(),
      permisos: const ServicioPermisos(),
    );
    admin = usuarioFinanzas();
    mesero = usuarioFinanzas(id: 'mesero', rol: Rol.empleado);
    await sembrarFinanzas(pedidos: pedidos, gastos: gastos);
  });

  group('ServicioFinanzas.resumen', () {
    test(
      'separa métodos, modalidades y mantiene la caja fuera de los gastos',
      () async {
        final resumen = await servicio.resumen(admin);

        expect(resumen.cantidadPedidos, 4);
        expect(resumen.ingresos, 10500);
        expect(resumen.ingresosEfectivo, 8500);
        expect(resumen.ingresosTransferencia, 2000);
        expect(resumen.ingresosLlevar, 2500);
        expect(resumen.ingresosLocal, 8000);
        expect(resumen.egresos, 400);
        expect(resumen.saldoNeto, 10100);
        expect(resumen.efectivoEnCaja, 8500);
      },
    );

    test('filtra por rango de fechas locales', () async {
      final primerDia = await servicio.resumen(
        admin,
        desde: '2026-01-05',
        hasta: '2026-01-05',
      );
      expect(primerDia.ingresos, 3500);
      expect(primerDia.egresos, 300);
      expect(primerDia.saldoNeto, 3200);
      expect(primerDia.efectivoEnCaja, 1500);

      final segundoDia = await servicio.resumen(admin, desde: '2026-01-06');
      expect(segundoDia.ingresos, 7000);
      expect(segundoDia.egresos, 100);
      expect(segundoDia.saldoNeto, 6900);
      expect(segundoDia.efectivoEnCaja, 7000);
    });

    test('rechaza rango invertido y fechas inválidas', () async {
      expect(
        servicio.resumen(admin, desde: '2026-01-06', hasta: '2026-01-05'),
        throwsArgumentError,
      );
      expect(servicio.resumen(admin, desde: '05-01-2026'), throwsArgumentError);
      expect(servicio.resumen(admin, hasta: '2026-02-30'), throwsArgumentError);
    });

    test('exige verFinanzas', () async {
      expect(servicio.resumen(mesero), throwsStateError);
      expect(
        servicio.resumen(usuarioFinanzas(activo: false)),
        throwsStateError,
      );
    });
  });

  group('ServicioFinanzas.obtenerGastos', () {
    test('ordena descendente por fecha y creadoEn', () async {
      await gastos.guardar(
        Gasto(
          id: 'gasto-tarde',
          descripcion: 'Mantenimiento',
          valor: 50,
          fechaLocal: '2026-01-05',
          horaLocal: '10:00',
          usuarioId: admin.id,
          creadoEn: DateTime.utc(2026, 1, 5, 20),
        ),
      );

      final lista = await servicio.obtenerGastos(admin);
      expect(lista.map((gasto) => gasto.id), [
        'gasto-otro-dia',
        'gasto-tarde',
        'gasto-1',
      ]);
    });

    test('aplica el rango y valida permiso', () async {
      final lista = await servicio.obtenerGastos(
        admin,
        desde: '2026-01-05',
        hasta: '2026-01-05',
      );
      expect(lista, hasLength(1));
      expect(lista.single.descripcion, 'Servicio');
      expect(servicio.obtenerGastos(mesero), throwsStateError);
      expect(
        servicio.obtenerGastos(admin, desde: '2026-01-06', hasta: '2026-01-05'),
        throwsArgumentError,
      );
    });
  });

  group('ServicioFinanzas.registrarGasto', () {
    test('registra concepto, valor positivo y fecha', () async {
      final gasto = await servicio.registrarGasto(
        usuarioActivo: admin,
        fechaLocal: '2026-01-07',
        concepto: '  Papelería  ',
        valor: 2500,
      );

      expect(gasto.id, isNotEmpty);
      expect(gasto.descripcion, 'Papelería');
      expect(gasto.valor, 2500);
      expect(gasto.fechaLocal, '2026-01-07');
      expect(RegExp(r'^\d{2}:\d{2}$').hasMatch(gasto.horaLocal), isTrue);
      expect(gasto.usuarioId, admin.id);
      expect(
        gasto.creadoEn.difference(DateTime.now()).inSeconds.abs(),
        lessThan(10),
      );
      expect(await gastos.obtenerPorId(gasto.id), isNotNull);

      final resumen = await servicio.resumen(admin, desde: '2026-01-07');
      expect(resumen.egresos, 2500);
      expect(resumen.saldoNeto, -2500);
      expect(resumen.efectivoEnCaja, 0);
    });

    test('rechaza datos inválidos sin guardar', () async {
      expect(
        servicio.registrarGasto(
          usuarioActivo: admin,
          fechaLocal: '2026-01-07',
          concepto: '   ',
          valor: 100,
        ),
        throwsArgumentError,
      );
      expect(
        servicio.registrarGasto(
          usuarioActivo: admin,
          fechaLocal: '2026-01-07',
          concepto: 'Válido',
          valor: 0,
        ),
        throwsArgumentError,
      );
      expect(
        servicio.registrarGasto(
          usuarioActivo: admin,
          fechaLocal: '2026-01-07',
          concepto: 'Válido',
          valor: -1,
        ),
        throwsArgumentError,
      );
      expect(
        servicio.registrarGasto(
          usuarioActivo: admin,
          fechaLocal: '07-01-2026',
          concepto: 'Válido',
          valor: 100,
        ),
        throwsArgumentError,
      );
      expect(await gastos.obtenerTodos(), hasLength(2));
    });

    test('exige registrarGasto', () async {
      expect(
        servicio.registrarGasto(
          usuarioActivo: mesero,
          fechaLocal: '2026-01-07',
          concepto: 'Papelería',
          valor: 100,
        ),
        throwsStateError,
      );

      final soloConsulta = ServicioFinanzas(
        gastos: gastos,
        pedidos: pedidos,
        calculador: const CalculadorFinanzas(),
        permisos: const PermisosSoloConsulta(),
      );
      expect(await soloConsulta.obtenerGastos(mesero), isNotEmpty);
      expect(
        soloConsulta.registrarGasto(
          usuarioActivo: mesero,
          fechaLocal: '2026-01-07',
          concepto: 'Papelería',
          valor: 100,
        ),
        throwsStateError,
      );
      expect(await gastos.obtenerTodos(), hasLength(2));
    });
  });

  group('ServicioFinanzas.actualizarGasto', () {
    test('aplica cambios parciales y conserva identidad', () async {
      final anterior = (await gastos.obtenerPorId('gasto-1'))!;
      await servicio.actualizarGasto(
        usuarioActivo: admin,
        gastoId: anterior.id,
        concepto: '  Servicio ajustado  ',
        valor: 450,
        fechaLocal: '2026-01-08',
      );

      final actualizado = (await gastos.obtenerPorId(anterior.id))!;
      expect(actualizado.id, anterior.id);
      expect(actualizado.creadoEn, anterior.creadoEn);
      expect(actualizado.horaLocal, anterior.horaLocal);
      expect(actualizado.usuarioId, anterior.usuarioId);
      expect(actualizado.descripcion, 'Servicio ajustado');
      expect(actualizado.valor, 450);
      expect(actualizado.fechaLocal, '2026-01-08');

      await servicio.actualizarGasto(
        usuarioActivo: admin,
        gastoId: anterior.id,
        concepto: 'Solo concepto',
      );
      final parcial = (await gastos.obtenerPorId(anterior.id))!;
      expect(parcial.descripcion, 'Solo concepto');
      expect(parcial.valor, 450);
      expect(parcial.fechaLocal, '2026-01-08');
    });

    test('rechaza datos inválidos, gasto inexistente y sin permiso', () async {
      expect(
        servicio.actualizarGasto(
          usuarioActivo: admin,
          gastoId: 'gasto-1',
          concepto: '',
        ),
        throwsArgumentError,
      );
      expect(
        servicio.actualizarGasto(
          usuarioActivo: admin,
          gastoId: 'gasto-1',
          valor: -10,
        ),
        throwsArgumentError,
      );
      expect(
        servicio.actualizarGasto(
          usuarioActivo: admin,
          gastoId: 'gasto-1',
          fechaLocal: '2026-13-01',
        ),
        throwsArgumentError,
      );
      expect(
        servicio.actualizarGasto(
          usuarioActivo: admin,
          gastoId: 'inexistente',
          valor: 100,
        ),
        throwsStateError,
      );
      expect(
        servicio.actualizarGasto(
          usuarioActivo: mesero,
          gastoId: 'gasto-1',
          valor: 100,
        ),
        throwsStateError,
      );

      final intacto = (await gastos.obtenerPorId('gasto-1'))!;
      expect(intacto.descripcion, 'Servicio');
      expect(intacto.valor, 300);
      expect(intacto.fechaLocal, '2026-01-05');
    });
  });
}
