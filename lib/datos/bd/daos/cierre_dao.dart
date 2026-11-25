import 'package:drift/drift.dart';

import '../bantu_database.dart';
import '../tablas.dart';

part 'cierre_dao.g.dart';

@DriftAccessor(tables: [CierresDiarios, CierreAuditorias])
class CierreDao extends DatabaseAccessor<BantuDatabase> with _$CierreDaoMixin {
  CierreDao(super.base);

  Future<List<CierresDiario>> todos() {
    return (select(cierresDiarios)..orderBy([(f) => OrderingTerm.desc(f.fechaLocal)]))
        .get();
  }

  Future<CierresDiario?> porFecha(String fechaLocal) {
    return (select(cierresDiarios)..where((f) => f.fechaLocal.equals(fechaLocal)))
        .getSingleOrNull();
  }

  Future<List<CierreAuditoria>> auditoriasDeCierre(String cierreId) {
    return (select(cierreAuditorias)
          ..where((f) => f.cierreId.equals(cierreId))
          ..orderBy([(f) => OrderingTerm.desc(f.creadoEn)]))
        .get();
  }

  Future<int> insertar(CierresDiariosCompanion datos) =>
      into(cierresDiarios).insert(datos);

  Future<bool> actualizar(CierresDiariosCompanion datos) =>
      update(cierresDiarios).replace(datos);

  Future<int> insertarAuditoria(CierreAuditoriasCompanion datos) =>
      into(cierreAuditorias).insert(datos);
}
