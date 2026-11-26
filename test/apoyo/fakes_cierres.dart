import 'package:bantu/datos/repositorios/cierre_repositorio.dart';
import 'package:bantu/datos/repositorios/gasto_repositorio.dart';
import 'package:bantu/dominio/entidades/cierre_diario.dart';
import 'package:bantu/dominio/entidades/gasto.dart';

Gasto gastoCierre({
  String id = 'gasto-1',
  String descripcion = 'Servicio',
  int valor = 300,
  String fechaLocal = '2026-01-05',
  String horaLocal = '10:00',
  String usuarioId = 'admin',
}) {
  return Gasto(
    id: id,
    descripcion: descripcion,
    valor: valor,
    fechaLocal: fechaLocal,
    horaLocal: horaLocal,
    usuarioId: usuarioId,
    creadoEn: DateTime.utc(2026, 1, 5, 10),
  );
}

class CierreRepositorioMemoria implements CierreRepositorio {
  final Map<String, CierreDiario> _porId = <String, CierreDiario>{};
  final List<CierreAuditoria> _auditorias = <CierreAuditoria>[];
  final List<String> operaciones = <String>[];

  @override
  Future<List<CierreDiario>> obtenerTodos() async {
    final lista = _porId.values.toList();
    lista.sort((a, b) => b.fechaLocal.compareTo(a.fechaLocal));
    return List.unmodifiable(lista);
  }

  @override
  Future<CierreDiario?> obtenerPorFecha(String fechaLocal) async {
    final cierres = _porId.values.where(
      (cierre) => cierre.fechaLocal == fechaLocal,
    );
    return cierres.firstOrNull;
  }

  @override
  Future<List<CierreAuditoria>> obtenerAuditorias(String cierreId) async {
    return List.unmodifiable(
      _auditorias.where((auditoria) => auditoria.cierreId == cierreId),
    );
  }

  @override
  Future<void> guardar(CierreDiario cierre) async {
    if (await obtenerPorFecha(cierre.fechaLocal) != null) {
      throw StateError('Ya existe un cierre para esa fecha.');
    }
    _porId[cierre.id] = cierre;
  }

  @override
  Future<void> actualizar(CierreDiario cierre) async {
    operaciones.add('actualizar');
    if (!_porId.containsKey(cierre.id)) {
      throw StateError('Cierre no encontrado.');
    }
    _porId[cierre.id] = cierre;
  }

  @override
  Future<void> auditar(CierreAuditoria auditoria) async {
    operaciones.add('auditar');
    _auditorias.add(auditoria);
  }
}

class GastoRepositorioMemoria implements GastoRepositorio {
  final Map<String, Gasto> _porId = <String, Gasto>{};

  @override
  Future<List<Gasto>> obtenerTodos() async => List.unmodifiable(_porId.values);

  @override
  Future<List<Gasto>> obtenerPorFecha(String fechaLocal) async {
    return List.unmodifiable(
      _porId.values.where((gasto) => gasto.fechaLocal == fechaLocal),
    );
  }

  @override
  Future<Gasto?> obtenerPorId(String id) async => _porId[id];

  @override
  Future<void> guardar(Gasto gasto) async {
    if (_porId.containsKey(gasto.id)) {
      throw StateError('Gasto ya existe: ${gasto.id}');
    }
    _porId[gasto.id] = gasto;
  }

  @override
  Future<void> actualizar(Gasto gasto) async {
    if (!_porId.containsKey(gasto.id)) {
      throw StateError('Gasto no encontrado.');
    }
    _porId[gasto.id] = gasto;
  }
}
