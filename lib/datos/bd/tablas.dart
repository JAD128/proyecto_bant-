import 'package:drift/drift.dart';

class Usuarios extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text().withLength(min: 1, max: 80)();
  TextColumn get pinHash => text()();
  TextColumn get pinSalt => text()();
  TextColumn get rol => text()();
  BoolColumn get puedeVerTodosPedidos => boolean().withDefault(const Constant(false))();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get creadoEn => dateTime()();
  DateTimeColumn get actualizadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[{nombre}];
}

class Categorias extends Table {
  TextColumn get id => text()();
  TextColumn get nombre => text().withLength(min: 1, max: 80)();
  BoolColumn get activa => boolean().withDefault(const Constant(true))();
  IntColumn get orden => integer().withDefault(const Constant(0))();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[{nombre}];
}

class Productos extends Table {
  TextColumn get id => text()();
  TextColumn get categoriaId => text().references(Categorias, #id)();
  TextColumn get nombre => text().withLength(min: 1, max: 120)();
  TextColumn get descripcion => text().nullable()();
  IntColumn get precioLocal => integer()();
  IntColumn get precioLlevar => integer().nullable()();
  IntColumn get costoEmpaque => integer().withDefault(const Constant(0))();
  TextColumn get estrategiaLlevar => text()();
  TextColumn get imagenPath => text().nullable()();
  BoolColumn get activo => boolean().withDefault(const Constant(true))();
  DateTimeColumn get creadoEn => dateTime()();
  DateTimeColumn get actualizadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class Pedidos extends Table {
  TextColumn get id => text()();
  TextColumn get idempotenciaKey => text()();
  TextColumn get empleadoId => text().references(Usuarios, #id)();
  TextColumn get fechaLocal => text()();
  TextColumn get horaLocal => text()();
  DateTimeColumn get creadoEn => dateTime()();
  TextColumn get modalidad => text()();
  TextColumn get metodoPago => text()();
  TextColumn get estado => text()();
  IntColumn get subtotal => integer()();
  IntColumn get costoEmpaque => integer()();
  IntColumn get total => integer()();
  TextColumn get motivoAnulacion => text().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[
        {idempotenciaKey},
      ];
}

class PedidoItems extends Table {
  TextColumn get id => text()();
  TextColumn get pedidoId => text().references(Pedidos, #id)();
  TextColumn get productoId => text().nullable().references(Productos, #id)();
  TextColumn get nombreProducto => text()();
  TextColumn get categoriaNombre => text()();
  IntColumn get cantidad => integer()();
  TextColumn get modalidad => text()();
  IntColumn get precioUnitario => integer()();
  IntColumn get costoEmpaqueUnitario => integer()();
  IntColumn get subtotalItem => integer()();
  IntColumn get totalItem => integer()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class Gastos extends Table {
  TextColumn get id => text()();
  TextColumn get descripcion => text()();
  IntColumn get valor => integer()();
  TextColumn get fechaLocal => text()();
  TextColumn get horaLocal => text()();
  TextColumn get categoria => text().nullable()();
  TextColumn get observaciones => text().nullable()();
  TextColumn get usuarioId => text().references(Usuarios, #id)();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class CierresDiarios extends Table {
  TextColumn get id => text()();
  TextColumn get fechaLocal => text()();
  TextColumn get estado => text()();
  IntColumn get totalPedidos => integer()();
  IntColumn get totalVentas => integer()();
  IntColumn get totalEfectivo => integer()();
  IntColumn get totalTransferencia => integer()();
  IntColumn get totalLlevar => integer()();
  IntColumn get totalLocal => integer()();
  IntColumn get totalEgresos => integer()();
  IntColumn get saldoNeto => integer()();
  TextColumn get cerradoPor => text().nullable()();
  DateTimeColumn get creadoEn => dateTime()();
  DateTimeColumn get cerradoEn => dateTime().nullable()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};

  @override
  List<Set<Column<Object>>> get uniqueKeys => <Set<Column<Object>>>[{fechaLocal}];
}

class CierreAuditorias extends Table {
  TextColumn get id => text()();
  TextColumn get cierreId => text().references(CierresDiarios, #id)();
  TextColumn get motivo => text()();
  TextColumn get valoresAntes => text()();
  TextColumn get valoresDespues => text()();
  TextColumn get usuarioId => text().references(Usuarios, #id)();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}

class PedidoAuditorias extends Table {
  TextColumn get id => text()();
  TextColumn get pedidoId => text().references(Pedidos, #id)();
  TextColumn get accion => text()();
  TextColumn get motivo => text()();
  TextColumn get usuarioId => text().references(Usuarios, #id)();
  DateTimeColumn get creadoEn => dateTime()();

  @override
  Set<Column<Object>> get primaryKey => <Column<Object>>{id};
}
