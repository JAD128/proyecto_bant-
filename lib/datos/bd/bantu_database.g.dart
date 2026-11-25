// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bantu_database.dart';

// ignore_for_file: type=lint
class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinHashMeta = const VerificationMeta(
    'pinHash',
  );
  @override
  late final GeneratedColumn<String> pinHash = GeneratedColumn<String>(
    'pin_hash',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pinSaltMeta = const VerificationMeta(
    'pinSalt',
  );
  @override
  late final GeneratedColumn<String> pinSalt = GeneratedColumn<String>(
    'pin_salt',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _rolMeta = const VerificationMeta('rol');
  @override
  late final GeneratedColumn<String> rol = GeneratedColumn<String>(
    'rol',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _puedeVerTodosPedidosMeta =
      const VerificationMeta('puedeVerTodosPedidos');
  @override
  late final GeneratedColumn<bool> puedeVerTodosPedidos = GeneratedColumn<bool>(
    'puede_ver_todos_pedidos',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("puede_ver_todos_pedidos" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    pinHash,
    pinSalt,
    rol,
    puedeVerTodosPedidos,
    activo,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'usuarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<Usuario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('pin_hash')) {
      context.handle(
        _pinHashMeta,
        pinHash.isAcceptableOrUnknown(data['pin_hash']!, _pinHashMeta),
      );
    } else if (isInserting) {
      context.missing(_pinHashMeta);
    }
    if (data.containsKey('pin_salt')) {
      context.handle(
        _pinSaltMeta,
        pinSalt.isAcceptableOrUnknown(data['pin_salt']!, _pinSaltMeta),
      );
    } else if (isInserting) {
      context.missing(_pinSaltMeta);
    }
    if (data.containsKey('rol')) {
      context.handle(
        _rolMeta,
        rol.isAcceptableOrUnknown(data['rol']!, _rolMeta),
      );
    } else if (isInserting) {
      context.missing(_rolMeta);
    }
    if (data.containsKey('puede_ver_todos_pedidos')) {
      context.handle(
        _puedeVerTodosPedidosMeta,
        puedeVerTodosPedidos.isAcceptableOrUnknown(
          data['puede_ver_todos_pedidos']!,
          _puedeVerTodosPedidosMeta,
        ),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {nombre},
  ];
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Usuario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      pinHash: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_hash'],
      )!,
      pinSalt: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pin_salt'],
      )!,
      rol: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rol'],
      )!,
      puedeVerTodosPedidos: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}puede_ver_todos_pedidos'],
      )!,
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final String id;
  final String nombre;
  final String pinHash;
  final String pinSalt;
  final String rol;
  final bool puedeVerTodosPedidos;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  const Usuario({
    required this.id,
    required this.nombre,
    required this.pinHash,
    required this.pinSalt,
    required this.rol,
    required this.puedeVerTodosPedidos,
    required this.activo,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['pin_hash'] = Variable<String>(pinHash);
    map['pin_salt'] = Variable<String>(pinSalt);
    map['rol'] = Variable<String>(rol);
    map['puede_ver_todos_pedidos'] = Variable<bool>(puedeVerTodosPedidos);
    map['activo'] = Variable<bool>(activo);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      pinHash: Value(pinHash),
      pinSalt: Value(pinSalt),
      rol: Value(rol),
      puedeVerTodosPedidos: Value(puedeVerTodosPedidos),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory Usuario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      pinHash: serializer.fromJson<String>(json['pinHash']),
      pinSalt: serializer.fromJson<String>(json['pinSalt']),
      rol: serializer.fromJson<String>(json['rol']),
      puedeVerTodosPedidos: serializer.fromJson<bool>(
        json['puedeVerTodosPedidos'],
      ),
      activo: serializer.fromJson<bool>(json['activo']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'pinHash': serializer.toJson<String>(pinHash),
      'pinSalt': serializer.toJson<String>(pinSalt),
      'rol': serializer.toJson<String>(rol),
      'puedeVerTodosPedidos': serializer.toJson<bool>(puedeVerTodosPedidos),
      'activo': serializer.toJson<bool>(activo),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  Usuario copyWith({
    String? id,
    String? nombre,
    String? pinHash,
    String? pinSalt,
    String? rol,
    bool? puedeVerTodosPedidos,
    bool? activo,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) => Usuario(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    pinHash: pinHash ?? this.pinHash,
    pinSalt: pinSalt ?? this.pinSalt,
    rol: rol ?? this.rol,
    puedeVerTodosPedidos: puedeVerTodosPedidos ?? this.puedeVerTodosPedidos,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  Usuario copyWithCompanion(UsuariosCompanion data) {
    return Usuario(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      pinHash: data.pinHash.present ? data.pinHash.value : this.pinHash,
      pinSalt: data.pinSalt.present ? data.pinSalt.value : this.pinSalt,
      rol: data.rol.present ? data.rol.value : this.rol,
      puedeVerTodosPedidos: data.puedeVerTodosPedidos.present
          ? data.puedeVerTodosPedidos.value
          : this.puedeVerTodosPedidos,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('rol: $rol, ')
          ..write('puedeVerTodosPedidos: $puedeVerTodosPedidos, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nombre,
    pinHash,
    pinSalt,
    rol,
    puedeVerTodosPedidos,
    activo,
    creadoEn,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.pinHash == this.pinHash &&
          other.pinSalt == this.pinSalt &&
          other.rol == this.rol &&
          other.puedeVerTodosPedidos == this.puedeVerTodosPedidos &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<String> pinHash;
  final Value<String> pinSalt;
  final Value<String> rol;
  final Value<bool> puedeVerTodosPedidos;
  final Value<bool> activo;
  final Value<DateTime> creadoEn;
  final Value<DateTime> actualizadoEn;
  final Value<int> rowid;
  const UsuariosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.pinHash = const Value.absent(),
    this.pinSalt = const Value.absent(),
    this.rol = const Value.absent(),
    this.puedeVerTodosPedidos = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UsuariosCompanion.insert({
    required String id,
    required String nombre,
    required String pinHash,
    required String pinSalt,
    required String rol,
    this.puedeVerTodosPedidos = const Value.absent(),
    this.activo = const Value.absent(),
    required DateTime creadoEn,
    required DateTime actualizadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       pinHash = Value(pinHash),
       pinSalt = Value(pinSalt),
       rol = Value(rol),
       creadoEn = Value(creadoEn),
       actualizadoEn = Value(actualizadoEn);
  static Insertable<Usuario> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<String>? pinHash,
    Expression<String>? pinSalt,
    Expression<String>? rol,
    Expression<bool>? puedeVerTodosPedidos,
    Expression<bool>? activo,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? actualizadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (pinHash != null) 'pin_hash': pinHash,
      if (pinSalt != null) 'pin_salt': pinSalt,
      if (rol != null) 'rol': rol,
      if (puedeVerTodosPedidos != null)
        'puede_ver_todos_pedidos': puedeVerTodosPedidos,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UsuariosCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<String>? pinHash,
    Value<String>? pinSalt,
    Value<String>? rol,
    Value<bool>? puedeVerTodosPedidos,
    Value<bool>? activo,
    Value<DateTime>? creadoEn,
    Value<DateTime>? actualizadoEn,
    Value<int>? rowid,
  }) {
    return UsuariosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      pinHash: pinHash ?? this.pinHash,
      pinSalt: pinSalt ?? this.pinSalt,
      rol: rol ?? this.rol,
      puedeVerTodosPedidos: puedeVerTodosPedidos ?? this.puedeVerTodosPedidos,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (pinHash.present) {
      map['pin_hash'] = Variable<String>(pinHash.value);
    }
    if (pinSalt.present) {
      map['pin_salt'] = Variable<String>(pinSalt.value);
    }
    if (rol.present) {
      map['rol'] = Variable<String>(rol.value);
    }
    if (puedeVerTodosPedidos.present) {
      map['puede_ver_todos_pedidos'] = Variable<bool>(
        puedeVerTodosPedidos.value,
      );
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('pinHash: $pinHash, ')
          ..write('pinSalt: $pinSalt, ')
          ..write('rol: $rol, ')
          ..write('puedeVerTodosPedidos: $puedeVerTodosPedidos, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 80,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _activaMeta = const VerificationMeta('activa');
  @override
  late final GeneratedColumn<bool> activa = GeneratedColumn<bool>(
    'activa',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activa" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _ordenMeta = const VerificationMeta('orden');
  @override
  late final GeneratedColumn<int> orden = GeneratedColumn<int>(
    'orden',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, activa, orden, creadoEn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'categorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<Categoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('activa')) {
      context.handle(
        _activaMeta,
        activa.isAcceptableOrUnknown(data['activa']!, _activaMeta),
      );
    }
    if (data.containsKey('orden')) {
      context.handle(
        _ordenMeta,
        orden.isAcceptableOrUnknown(data['orden']!, _ordenMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {nombre},
  ];
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Categoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      activa: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activa'],
      )!,
      orden: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final String id;
  final String nombre;
  final bool activa;
  final int orden;
  final DateTime creadoEn;
  const Categoria({
    required this.id,
    required this.nombre,
    required this.activa,
    required this.orden,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['nombre'] = Variable<String>(nombre);
    map['activa'] = Variable<bool>(activa);
    map['orden'] = Variable<int>(orden);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      id: Value(id),
      nombre: Value(nombre),
      activa: Value(activa),
      orden: Value(orden),
      creadoEn: Value(creadoEn),
    );
  }

  factory Categoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      id: serializer.fromJson<String>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      activa: serializer.fromJson<bool>(json['activa']),
      orden: serializer.fromJson<int>(json['orden']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'nombre': serializer.toJson<String>(nombre),
      'activa': serializer.toJson<bool>(activa),
      'orden': serializer.toJson<int>(orden),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  Categoria copyWith({
    String? id,
    String? nombre,
    bool? activa,
    int? orden,
    DateTime? creadoEn,
  }) => Categoria(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    activa: activa ?? this.activa,
    orden: orden ?? this.orden,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Categoria copyWithCompanion(CategoriasCompanion data) {
    return Categoria(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      activa: data.activa.present ? data.activa.value : this.activa,
      orden: data.orden.present ? data.orden.value : this.orden,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('activa: $activa, ')
          ..write('orden: $orden, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, activa, orden, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.activa == this.activa &&
          other.orden == this.orden &&
          other.creadoEn == this.creadoEn);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<String> id;
  final Value<String> nombre;
  final Value<bool> activa;
  final Value<int> orden;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const CategoriasCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.activa = const Value.absent(),
    this.orden = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CategoriasCompanion.insert({
    required String id,
    required String nombre,
    this.activa = const Value.absent(),
    this.orden = const Value.absent(),
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       nombre = Value(nombre),
       creadoEn = Value(creadoEn);
  static Insertable<Categoria> custom({
    Expression<String>? id,
    Expression<String>? nombre,
    Expression<bool>? activa,
    Expression<int>? orden,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (activa != null) 'activa': activa,
      if (orden != null) 'orden': orden,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CategoriasCompanion copyWith({
    Value<String>? id,
    Value<String>? nombre,
    Value<bool>? activa,
    Value<int>? orden,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return CategoriasCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      activa: activa ?? this.activa,
      orden: orden ?? this.orden,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (activa.present) {
      map['activa'] = Variable<bool>(activa.value);
    }
    if (orden.present) {
      map['orden'] = Variable<int>(orden.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('activa: $activa, ')
          ..write('orden: $orden, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ProductosTable extends Productos
    with TableInfo<$ProductosTable, Producto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ProductosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaIdMeta = const VerificationMeta(
    'categoriaId',
  );
  @override
  late final GeneratedColumn<String> categoriaId = GeneratedColumn<String>(
    'categoria_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES categorias (id)',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 120,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _precioLocalMeta = const VerificationMeta(
    'precioLocal',
  );
  @override
  late final GeneratedColumn<int> precioLocal = GeneratedColumn<int>(
    'precio_local',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioLlevarMeta = const VerificationMeta(
    'precioLlevar',
  );
  @override
  late final GeneratedColumn<int> precioLlevar = GeneratedColumn<int>(
    'precio_llevar',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _costoEmpaqueMeta = const VerificationMeta(
    'costoEmpaque',
  );
  @override
  late final GeneratedColumn<int> costoEmpaque = GeneratedColumn<int>(
    'costo_empaque',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _estrategiaLlevarMeta = const VerificationMeta(
    'estrategiaLlevar',
  );
  @override
  late final GeneratedColumn<String> estrategiaLlevar = GeneratedColumn<String>(
    'estrategia_llevar',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _imagenPathMeta = const VerificationMeta(
    'imagenPath',
  );
  @override
  late final GeneratedColumn<String> imagenPath = GeneratedColumn<String>(
    'imagen_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _activoMeta = const VerificationMeta('activo');
  @override
  late final GeneratedColumn<bool> activo = GeneratedColumn<bool>(
    'activo',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("activo" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actualizadoEnMeta = const VerificationMeta(
    'actualizadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> actualizadoEn =
      GeneratedColumn<DateTime>(
        'actualizado_en',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    categoriaId,
    nombre,
    descripcion,
    precioLocal,
    precioLlevar,
    costoEmpaque,
    estrategiaLlevar,
    imagenPath,
    activo,
    creadoEn,
    actualizadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'productos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Producto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('categoria_id')) {
      context.handle(
        _categoriaIdMeta,
        categoriaId.isAcceptableOrUnknown(
          data['categoria_id']!,
          _categoriaIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaIdMeta);
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    }
    if (data.containsKey('precio_local')) {
      context.handle(
        _precioLocalMeta,
        precioLocal.isAcceptableOrUnknown(
          data['precio_local']!,
          _precioLocalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioLocalMeta);
    }
    if (data.containsKey('precio_llevar')) {
      context.handle(
        _precioLlevarMeta,
        precioLlevar.isAcceptableOrUnknown(
          data['precio_llevar']!,
          _precioLlevarMeta,
        ),
      );
    }
    if (data.containsKey('costo_empaque')) {
      context.handle(
        _costoEmpaqueMeta,
        costoEmpaque.isAcceptableOrUnknown(
          data['costo_empaque']!,
          _costoEmpaqueMeta,
        ),
      );
    }
    if (data.containsKey('estrategia_llevar')) {
      context.handle(
        _estrategiaLlevarMeta,
        estrategiaLlevar.isAcceptableOrUnknown(
          data['estrategia_llevar']!,
          _estrategiaLlevarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_estrategiaLlevarMeta);
    }
    if (data.containsKey('imagen_path')) {
      context.handle(
        _imagenPathMeta,
        imagenPath.isAcceptableOrUnknown(data['imagen_path']!, _imagenPathMeta),
      );
    }
    if (data.containsKey('activo')) {
      context.handle(
        _activoMeta,
        activo.isAcceptableOrUnknown(data['activo']!, _activoMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('actualizado_en')) {
      context.handle(
        _actualizadoEnMeta,
        actualizadoEn.isAcceptableOrUnknown(
          data['actualizado_en']!,
          _actualizadoEnMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_actualizadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Producto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Producto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      categoriaId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria_id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      ),
      precioLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_local'],
      )!,
      precioLlevar: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_llevar'],
      ),
      costoEmpaque: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_empaque'],
      )!,
      estrategiaLlevar: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estrategia_llevar'],
      )!,
      imagenPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}imagen_path'],
      ),
      activo: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}activo'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      actualizadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}actualizado_en'],
      )!,
    );
  }

  @override
  $ProductosTable createAlias(String alias) {
    return $ProductosTable(attachedDatabase, alias);
  }
}

class Producto extends DataClass implements Insertable<Producto> {
  final String id;
  final String categoriaId;
  final String nombre;
  final String? descripcion;
  final int precioLocal;
  final int? precioLlevar;
  final int costoEmpaque;
  final String estrategiaLlevar;
  final String? imagenPath;
  final bool activo;
  final DateTime creadoEn;
  final DateTime actualizadoEn;
  const Producto({
    required this.id,
    required this.categoriaId,
    required this.nombre,
    this.descripcion,
    required this.precioLocal,
    this.precioLlevar,
    required this.costoEmpaque,
    required this.estrategiaLlevar,
    this.imagenPath,
    required this.activo,
    required this.creadoEn,
    required this.actualizadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['categoria_id'] = Variable<String>(categoriaId);
    map['nombre'] = Variable<String>(nombre);
    if (!nullToAbsent || descripcion != null) {
      map['descripcion'] = Variable<String>(descripcion);
    }
    map['precio_local'] = Variable<int>(precioLocal);
    if (!nullToAbsent || precioLlevar != null) {
      map['precio_llevar'] = Variable<int>(precioLlevar);
    }
    map['costo_empaque'] = Variable<int>(costoEmpaque);
    map['estrategia_llevar'] = Variable<String>(estrategiaLlevar);
    if (!nullToAbsent || imagenPath != null) {
      map['imagen_path'] = Variable<String>(imagenPath);
    }
    map['activo'] = Variable<bool>(activo);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['actualizado_en'] = Variable<DateTime>(actualizadoEn);
    return map;
  }

  ProductosCompanion toCompanion(bool nullToAbsent) {
    return ProductosCompanion(
      id: Value(id),
      categoriaId: Value(categoriaId),
      nombre: Value(nombre),
      descripcion: descripcion == null && nullToAbsent
          ? const Value.absent()
          : Value(descripcion),
      precioLocal: Value(precioLocal),
      precioLlevar: precioLlevar == null && nullToAbsent
          ? const Value.absent()
          : Value(precioLlevar),
      costoEmpaque: Value(costoEmpaque),
      estrategiaLlevar: Value(estrategiaLlevar),
      imagenPath: imagenPath == null && nullToAbsent
          ? const Value.absent()
          : Value(imagenPath),
      activo: Value(activo),
      creadoEn: Value(creadoEn),
      actualizadoEn: Value(actualizadoEn),
    );
  }

  factory Producto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Producto(
      id: serializer.fromJson<String>(json['id']),
      categoriaId: serializer.fromJson<String>(json['categoriaId']),
      nombre: serializer.fromJson<String>(json['nombre']),
      descripcion: serializer.fromJson<String?>(json['descripcion']),
      precioLocal: serializer.fromJson<int>(json['precioLocal']),
      precioLlevar: serializer.fromJson<int?>(json['precioLlevar']),
      costoEmpaque: serializer.fromJson<int>(json['costoEmpaque']),
      estrategiaLlevar: serializer.fromJson<String>(json['estrategiaLlevar']),
      imagenPath: serializer.fromJson<String?>(json['imagenPath']),
      activo: serializer.fromJson<bool>(json['activo']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      actualizadoEn: serializer.fromJson<DateTime>(json['actualizadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'categoriaId': serializer.toJson<String>(categoriaId),
      'nombre': serializer.toJson<String>(nombre),
      'descripcion': serializer.toJson<String?>(descripcion),
      'precioLocal': serializer.toJson<int>(precioLocal),
      'precioLlevar': serializer.toJson<int?>(precioLlevar),
      'costoEmpaque': serializer.toJson<int>(costoEmpaque),
      'estrategiaLlevar': serializer.toJson<String>(estrategiaLlevar),
      'imagenPath': serializer.toJson<String?>(imagenPath),
      'activo': serializer.toJson<bool>(activo),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'actualizadoEn': serializer.toJson<DateTime>(actualizadoEn),
    };
  }

  Producto copyWith({
    String? id,
    String? categoriaId,
    String? nombre,
    Value<String?> descripcion = const Value.absent(),
    int? precioLocal,
    Value<int?> precioLlevar = const Value.absent(),
    int? costoEmpaque,
    String? estrategiaLlevar,
    Value<String?> imagenPath = const Value.absent(),
    bool? activo,
    DateTime? creadoEn,
    DateTime? actualizadoEn,
  }) => Producto(
    id: id ?? this.id,
    categoriaId: categoriaId ?? this.categoriaId,
    nombre: nombre ?? this.nombre,
    descripcion: descripcion.present ? descripcion.value : this.descripcion,
    precioLocal: precioLocal ?? this.precioLocal,
    precioLlevar: precioLlevar.present ? precioLlevar.value : this.precioLlevar,
    costoEmpaque: costoEmpaque ?? this.costoEmpaque,
    estrategiaLlevar: estrategiaLlevar ?? this.estrategiaLlevar,
    imagenPath: imagenPath.present ? imagenPath.value : this.imagenPath,
    activo: activo ?? this.activo,
    creadoEn: creadoEn ?? this.creadoEn,
    actualizadoEn: actualizadoEn ?? this.actualizadoEn,
  );
  Producto copyWithCompanion(ProductosCompanion data) {
    return Producto(
      id: data.id.present ? data.id.value : this.id,
      categoriaId: data.categoriaId.present
          ? data.categoriaId.value
          : this.categoriaId,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      precioLocal: data.precioLocal.present
          ? data.precioLocal.value
          : this.precioLocal,
      precioLlevar: data.precioLlevar.present
          ? data.precioLlevar.value
          : this.precioLlevar,
      costoEmpaque: data.costoEmpaque.present
          ? data.costoEmpaque.value
          : this.costoEmpaque,
      estrategiaLlevar: data.estrategiaLlevar.present
          ? data.estrategiaLlevar.value
          : this.estrategiaLlevar,
      imagenPath: data.imagenPath.present
          ? data.imagenPath.value
          : this.imagenPath,
      activo: data.activo.present ? data.activo.value : this.activo,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      actualizadoEn: data.actualizadoEn.present
          ? data.actualizadoEn.value
          : this.actualizadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Producto(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('precioLocal: $precioLocal, ')
          ..write('precioLlevar: $precioLlevar, ')
          ..write('costoEmpaque: $costoEmpaque, ')
          ..write('estrategiaLlevar: $estrategiaLlevar, ')
          ..write('imagenPath: $imagenPath, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    categoriaId,
    nombre,
    descripcion,
    precioLocal,
    precioLlevar,
    costoEmpaque,
    estrategiaLlevar,
    imagenPath,
    activo,
    creadoEn,
    actualizadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Producto &&
          other.id == this.id &&
          other.categoriaId == this.categoriaId &&
          other.nombre == this.nombre &&
          other.descripcion == this.descripcion &&
          other.precioLocal == this.precioLocal &&
          other.precioLlevar == this.precioLlevar &&
          other.costoEmpaque == this.costoEmpaque &&
          other.estrategiaLlevar == this.estrategiaLlevar &&
          other.imagenPath == this.imagenPath &&
          other.activo == this.activo &&
          other.creadoEn == this.creadoEn &&
          other.actualizadoEn == this.actualizadoEn);
}

class ProductosCompanion extends UpdateCompanion<Producto> {
  final Value<String> id;
  final Value<String> categoriaId;
  final Value<String> nombre;
  final Value<String?> descripcion;
  final Value<int> precioLocal;
  final Value<int?> precioLlevar;
  final Value<int> costoEmpaque;
  final Value<String> estrategiaLlevar;
  final Value<String?> imagenPath;
  final Value<bool> activo;
  final Value<DateTime> creadoEn;
  final Value<DateTime> actualizadoEn;
  final Value<int> rowid;
  const ProductosCompanion({
    this.id = const Value.absent(),
    this.categoriaId = const Value.absent(),
    this.nombre = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.precioLocal = const Value.absent(),
    this.precioLlevar = const Value.absent(),
    this.costoEmpaque = const Value.absent(),
    this.estrategiaLlevar = const Value.absent(),
    this.imagenPath = const Value.absent(),
    this.activo = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.actualizadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ProductosCompanion.insert({
    required String id,
    required String categoriaId,
    required String nombre,
    this.descripcion = const Value.absent(),
    required int precioLocal,
    this.precioLlevar = const Value.absent(),
    this.costoEmpaque = const Value.absent(),
    required String estrategiaLlevar,
    this.imagenPath = const Value.absent(),
    this.activo = const Value.absent(),
    required DateTime creadoEn,
    required DateTime actualizadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       categoriaId = Value(categoriaId),
       nombre = Value(nombre),
       precioLocal = Value(precioLocal),
       estrategiaLlevar = Value(estrategiaLlevar),
       creadoEn = Value(creadoEn),
       actualizadoEn = Value(actualizadoEn);
  static Insertable<Producto> custom({
    Expression<String>? id,
    Expression<String>? categoriaId,
    Expression<String>? nombre,
    Expression<String>? descripcion,
    Expression<int>? precioLocal,
    Expression<int>? precioLlevar,
    Expression<int>? costoEmpaque,
    Expression<String>? estrategiaLlevar,
    Expression<String>? imagenPath,
    Expression<bool>? activo,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? actualizadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (categoriaId != null) 'categoria_id': categoriaId,
      if (nombre != null) 'nombre': nombre,
      if (descripcion != null) 'descripcion': descripcion,
      if (precioLocal != null) 'precio_local': precioLocal,
      if (precioLlevar != null) 'precio_llevar': precioLlevar,
      if (costoEmpaque != null) 'costo_empaque': costoEmpaque,
      if (estrategiaLlevar != null) 'estrategia_llevar': estrategiaLlevar,
      if (imagenPath != null) 'imagen_path': imagenPath,
      if (activo != null) 'activo': activo,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (actualizadoEn != null) 'actualizado_en': actualizadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ProductosCompanion copyWith({
    Value<String>? id,
    Value<String>? categoriaId,
    Value<String>? nombre,
    Value<String?>? descripcion,
    Value<int>? precioLocal,
    Value<int?>? precioLlevar,
    Value<int>? costoEmpaque,
    Value<String>? estrategiaLlevar,
    Value<String?>? imagenPath,
    Value<bool>? activo,
    Value<DateTime>? creadoEn,
    Value<DateTime>? actualizadoEn,
    Value<int>? rowid,
  }) {
    return ProductosCompanion(
      id: id ?? this.id,
      categoriaId: categoriaId ?? this.categoriaId,
      nombre: nombre ?? this.nombre,
      descripcion: descripcion ?? this.descripcion,
      precioLocal: precioLocal ?? this.precioLocal,
      precioLlevar: precioLlevar ?? this.precioLlevar,
      costoEmpaque: costoEmpaque ?? this.costoEmpaque,
      estrategiaLlevar: estrategiaLlevar ?? this.estrategiaLlevar,
      imagenPath: imagenPath ?? this.imagenPath,
      activo: activo ?? this.activo,
      creadoEn: creadoEn ?? this.creadoEn,
      actualizadoEn: actualizadoEn ?? this.actualizadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (categoriaId.present) {
      map['categoria_id'] = Variable<String>(categoriaId.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (precioLocal.present) {
      map['precio_local'] = Variable<int>(precioLocal.value);
    }
    if (precioLlevar.present) {
      map['precio_llevar'] = Variable<int>(precioLlevar.value);
    }
    if (costoEmpaque.present) {
      map['costo_empaque'] = Variable<int>(costoEmpaque.value);
    }
    if (estrategiaLlevar.present) {
      map['estrategia_llevar'] = Variable<String>(estrategiaLlevar.value);
    }
    if (imagenPath.present) {
      map['imagen_path'] = Variable<String>(imagenPath.value);
    }
    if (activo.present) {
      map['activo'] = Variable<bool>(activo.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (actualizadoEn.present) {
      map['actualizado_en'] = Variable<DateTime>(actualizadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ProductosCompanion(')
          ..write('id: $id, ')
          ..write('categoriaId: $categoriaId, ')
          ..write('nombre: $nombre, ')
          ..write('descripcion: $descripcion, ')
          ..write('precioLocal: $precioLocal, ')
          ..write('precioLlevar: $precioLlevar, ')
          ..write('costoEmpaque: $costoEmpaque, ')
          ..write('estrategiaLlevar: $estrategiaLlevar, ')
          ..write('imagenPath: $imagenPath, ')
          ..write('activo: $activo, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('actualizadoEn: $actualizadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PedidosTable extends Pedidos with TableInfo<$PedidosTable, Pedido> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _idempotenciaKeyMeta = const VerificationMeta(
    'idempotenciaKey',
  );
  @override
  late final GeneratedColumn<String> idempotenciaKey = GeneratedColumn<String>(
    'idempotencia_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _empleadoIdMeta = const VerificationMeta(
    'empleadoId',
  );
  @override
  late final GeneratedColumn<String> empleadoId = GeneratedColumn<String>(
    'empleado_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _fechaLocalMeta = const VerificationMeta(
    'fechaLocal',
  );
  @override
  late final GeneratedColumn<String> fechaLocal = GeneratedColumn<String>(
    'fecha_local',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horaLocalMeta = const VerificationMeta(
    'horaLocal',
  );
  @override
  late final GeneratedColumn<String> horaLocal = GeneratedColumn<String>(
    'hora_local',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modalidadMeta = const VerificationMeta(
    'modalidad',
  );
  @override
  late final GeneratedColumn<String> modalidad = GeneratedColumn<String>(
    'modalidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _metodoPagoMeta = const VerificationMeta(
    'metodoPago',
  );
  @override
  late final GeneratedColumn<String> metodoPago = GeneratedColumn<String>(
    'metodo_pago',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalMeta = const VerificationMeta(
    'subtotal',
  );
  @override
  late final GeneratedColumn<int> subtotal = GeneratedColumn<int>(
    'subtotal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoEmpaqueMeta = const VerificationMeta(
    'costoEmpaque',
  );
  @override
  late final GeneratedColumn<int> costoEmpaque = GeneratedColumn<int>(
    'costo_empaque',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalMeta = const VerificationMeta('total');
  @override
  late final GeneratedColumn<int> total = GeneratedColumn<int>(
    'total',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoAnulacionMeta = const VerificationMeta(
    'motivoAnulacion',
  );
  @override
  late final GeneratedColumn<String> motivoAnulacion = GeneratedColumn<String>(
    'motivo_anulacion',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    idempotenciaKey,
    empleadoId,
    fechaLocal,
    horaLocal,
    creadoEn,
    modalidad,
    metodoPago,
    estado,
    subtotal,
    costoEmpaque,
    total,
    motivoAnulacion,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedidos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Pedido> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('idempotencia_key')) {
      context.handle(
        _idempotenciaKeyMeta,
        idempotenciaKey.isAcceptableOrUnknown(
          data['idempotencia_key']!,
          _idempotenciaKeyMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_idempotenciaKeyMeta);
    }
    if (data.containsKey('empleado_id')) {
      context.handle(
        _empleadoIdMeta,
        empleadoId.isAcceptableOrUnknown(data['empleado_id']!, _empleadoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_empleadoIdMeta);
    }
    if (data.containsKey('fecha_local')) {
      context.handle(
        _fechaLocalMeta,
        fechaLocal.isAcceptableOrUnknown(data['fecha_local']!, _fechaLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaLocalMeta);
    }
    if (data.containsKey('hora_local')) {
      context.handle(
        _horaLocalMeta,
        horaLocal.isAcceptableOrUnknown(data['hora_local']!, _horaLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_horaLocalMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('modalidad')) {
      context.handle(
        _modalidadMeta,
        modalidad.isAcceptableOrUnknown(data['modalidad']!, _modalidadMeta),
      );
    } else if (isInserting) {
      context.missing(_modalidadMeta);
    }
    if (data.containsKey('metodo_pago')) {
      context.handle(
        _metodoPagoMeta,
        metodoPago.isAcceptableOrUnknown(data['metodo_pago']!, _metodoPagoMeta),
      );
    } else if (isInserting) {
      context.missing(_metodoPagoMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('subtotal')) {
      context.handle(
        _subtotalMeta,
        subtotal.isAcceptableOrUnknown(data['subtotal']!, _subtotalMeta),
      );
    } else if (isInserting) {
      context.missing(_subtotalMeta);
    }
    if (data.containsKey('costo_empaque')) {
      context.handle(
        _costoEmpaqueMeta,
        costoEmpaque.isAcceptableOrUnknown(
          data['costo_empaque']!,
          _costoEmpaqueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoEmpaqueMeta);
    }
    if (data.containsKey('total')) {
      context.handle(
        _totalMeta,
        total.isAcceptableOrUnknown(data['total']!, _totalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalMeta);
    }
    if (data.containsKey('motivo_anulacion')) {
      context.handle(
        _motivoAnulacionMeta,
        motivoAnulacion.isAcceptableOrUnknown(
          data['motivo_anulacion']!,
          _motivoAnulacionMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {idempotenciaKey},
  ];
  @override
  Pedido map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Pedido(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      idempotenciaKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}idempotencia_key'],
      )!,
      empleadoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}empleado_id'],
      )!,
      fechaLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_local'],
      )!,
      horaLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hora_local'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      modalidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modalidad'],
      )!,
      metodoPago: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}metodo_pago'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      subtotal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal'],
      )!,
      costoEmpaque: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_empaque'],
      )!,
      total: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total'],
      )!,
      motivoAnulacion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo_anulacion'],
      ),
    );
  }

  @override
  $PedidosTable createAlias(String alias) {
    return $PedidosTable(attachedDatabase, alias);
  }
}

class Pedido extends DataClass implements Insertable<Pedido> {
  final String id;
  final String idempotenciaKey;
  final String empleadoId;
  final String fechaLocal;
  final String horaLocal;
  final DateTime creadoEn;
  final String modalidad;
  final String metodoPago;
  final String estado;
  final int subtotal;
  final int costoEmpaque;
  final int total;
  final String? motivoAnulacion;
  const Pedido({
    required this.id,
    required this.idempotenciaKey,
    required this.empleadoId,
    required this.fechaLocal,
    required this.horaLocal,
    required this.creadoEn,
    required this.modalidad,
    required this.metodoPago,
    required this.estado,
    required this.subtotal,
    required this.costoEmpaque,
    required this.total,
    this.motivoAnulacion,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['idempotencia_key'] = Variable<String>(idempotenciaKey);
    map['empleado_id'] = Variable<String>(empleadoId);
    map['fecha_local'] = Variable<String>(fechaLocal);
    map['hora_local'] = Variable<String>(horaLocal);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    map['modalidad'] = Variable<String>(modalidad);
    map['metodo_pago'] = Variable<String>(metodoPago);
    map['estado'] = Variable<String>(estado);
    map['subtotal'] = Variable<int>(subtotal);
    map['costo_empaque'] = Variable<int>(costoEmpaque);
    map['total'] = Variable<int>(total);
    if (!nullToAbsent || motivoAnulacion != null) {
      map['motivo_anulacion'] = Variable<String>(motivoAnulacion);
    }
    return map;
  }

  PedidosCompanion toCompanion(bool nullToAbsent) {
    return PedidosCompanion(
      id: Value(id),
      idempotenciaKey: Value(idempotenciaKey),
      empleadoId: Value(empleadoId),
      fechaLocal: Value(fechaLocal),
      horaLocal: Value(horaLocal),
      creadoEn: Value(creadoEn),
      modalidad: Value(modalidad),
      metodoPago: Value(metodoPago),
      estado: Value(estado),
      subtotal: Value(subtotal),
      costoEmpaque: Value(costoEmpaque),
      total: Value(total),
      motivoAnulacion: motivoAnulacion == null && nullToAbsent
          ? const Value.absent()
          : Value(motivoAnulacion),
    );
  }

  factory Pedido.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Pedido(
      id: serializer.fromJson<String>(json['id']),
      idempotenciaKey: serializer.fromJson<String>(json['idempotenciaKey']),
      empleadoId: serializer.fromJson<String>(json['empleadoId']),
      fechaLocal: serializer.fromJson<String>(json['fechaLocal']),
      horaLocal: serializer.fromJson<String>(json['horaLocal']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      modalidad: serializer.fromJson<String>(json['modalidad']),
      metodoPago: serializer.fromJson<String>(json['metodoPago']),
      estado: serializer.fromJson<String>(json['estado']),
      subtotal: serializer.fromJson<int>(json['subtotal']),
      costoEmpaque: serializer.fromJson<int>(json['costoEmpaque']),
      total: serializer.fromJson<int>(json['total']),
      motivoAnulacion: serializer.fromJson<String?>(json['motivoAnulacion']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'idempotenciaKey': serializer.toJson<String>(idempotenciaKey),
      'empleadoId': serializer.toJson<String>(empleadoId),
      'fechaLocal': serializer.toJson<String>(fechaLocal),
      'horaLocal': serializer.toJson<String>(horaLocal),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'modalidad': serializer.toJson<String>(modalidad),
      'metodoPago': serializer.toJson<String>(metodoPago),
      'estado': serializer.toJson<String>(estado),
      'subtotal': serializer.toJson<int>(subtotal),
      'costoEmpaque': serializer.toJson<int>(costoEmpaque),
      'total': serializer.toJson<int>(total),
      'motivoAnulacion': serializer.toJson<String?>(motivoAnulacion),
    };
  }

  Pedido copyWith({
    String? id,
    String? idempotenciaKey,
    String? empleadoId,
    String? fechaLocal,
    String? horaLocal,
    DateTime? creadoEn,
    String? modalidad,
    String? metodoPago,
    String? estado,
    int? subtotal,
    int? costoEmpaque,
    int? total,
    Value<String?> motivoAnulacion = const Value.absent(),
  }) => Pedido(
    id: id ?? this.id,
    idempotenciaKey: idempotenciaKey ?? this.idempotenciaKey,
    empleadoId: empleadoId ?? this.empleadoId,
    fechaLocal: fechaLocal ?? this.fechaLocal,
    horaLocal: horaLocal ?? this.horaLocal,
    creadoEn: creadoEn ?? this.creadoEn,
    modalidad: modalidad ?? this.modalidad,
    metodoPago: metodoPago ?? this.metodoPago,
    estado: estado ?? this.estado,
    subtotal: subtotal ?? this.subtotal,
    costoEmpaque: costoEmpaque ?? this.costoEmpaque,
    total: total ?? this.total,
    motivoAnulacion: motivoAnulacion.present
        ? motivoAnulacion.value
        : this.motivoAnulacion,
  );
  Pedido copyWithCompanion(PedidosCompanion data) {
    return Pedido(
      id: data.id.present ? data.id.value : this.id,
      idempotenciaKey: data.idempotenciaKey.present
          ? data.idempotenciaKey.value
          : this.idempotenciaKey,
      empleadoId: data.empleadoId.present
          ? data.empleadoId.value
          : this.empleadoId,
      fechaLocal: data.fechaLocal.present
          ? data.fechaLocal.value
          : this.fechaLocal,
      horaLocal: data.horaLocal.present ? data.horaLocal.value : this.horaLocal,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      modalidad: data.modalidad.present ? data.modalidad.value : this.modalidad,
      metodoPago: data.metodoPago.present
          ? data.metodoPago.value
          : this.metodoPago,
      estado: data.estado.present ? data.estado.value : this.estado,
      subtotal: data.subtotal.present ? data.subtotal.value : this.subtotal,
      costoEmpaque: data.costoEmpaque.present
          ? data.costoEmpaque.value
          : this.costoEmpaque,
      total: data.total.present ? data.total.value : this.total,
      motivoAnulacion: data.motivoAnulacion.present
          ? data.motivoAnulacion.value
          : this.motivoAnulacion,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Pedido(')
          ..write('id: $id, ')
          ..write('idempotenciaKey: $idempotenciaKey, ')
          ..write('empleadoId: $empleadoId, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('horaLocal: $horaLocal, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('modalidad: $modalidad, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado, ')
          ..write('subtotal: $subtotal, ')
          ..write('costoEmpaque: $costoEmpaque, ')
          ..write('total: $total, ')
          ..write('motivoAnulacion: $motivoAnulacion')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    idempotenciaKey,
    empleadoId,
    fechaLocal,
    horaLocal,
    creadoEn,
    modalidad,
    metodoPago,
    estado,
    subtotal,
    costoEmpaque,
    total,
    motivoAnulacion,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Pedido &&
          other.id == this.id &&
          other.idempotenciaKey == this.idempotenciaKey &&
          other.empleadoId == this.empleadoId &&
          other.fechaLocal == this.fechaLocal &&
          other.horaLocal == this.horaLocal &&
          other.creadoEn == this.creadoEn &&
          other.modalidad == this.modalidad &&
          other.metodoPago == this.metodoPago &&
          other.estado == this.estado &&
          other.subtotal == this.subtotal &&
          other.costoEmpaque == this.costoEmpaque &&
          other.total == this.total &&
          other.motivoAnulacion == this.motivoAnulacion);
}

class PedidosCompanion extends UpdateCompanion<Pedido> {
  final Value<String> id;
  final Value<String> idempotenciaKey;
  final Value<String> empleadoId;
  final Value<String> fechaLocal;
  final Value<String> horaLocal;
  final Value<DateTime> creadoEn;
  final Value<String> modalidad;
  final Value<String> metodoPago;
  final Value<String> estado;
  final Value<int> subtotal;
  final Value<int> costoEmpaque;
  final Value<int> total;
  final Value<String?> motivoAnulacion;
  final Value<int> rowid;
  const PedidosCompanion({
    this.id = const Value.absent(),
    this.idempotenciaKey = const Value.absent(),
    this.empleadoId = const Value.absent(),
    this.fechaLocal = const Value.absent(),
    this.horaLocal = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.modalidad = const Value.absent(),
    this.metodoPago = const Value.absent(),
    this.estado = const Value.absent(),
    this.subtotal = const Value.absent(),
    this.costoEmpaque = const Value.absent(),
    this.total = const Value.absent(),
    this.motivoAnulacion = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PedidosCompanion.insert({
    required String id,
    required String idempotenciaKey,
    required String empleadoId,
    required String fechaLocal,
    required String horaLocal,
    required DateTime creadoEn,
    required String modalidad,
    required String metodoPago,
    required String estado,
    required int subtotal,
    required int costoEmpaque,
    required int total,
    this.motivoAnulacion = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       idempotenciaKey = Value(idempotenciaKey),
       empleadoId = Value(empleadoId),
       fechaLocal = Value(fechaLocal),
       horaLocal = Value(horaLocal),
       creadoEn = Value(creadoEn),
       modalidad = Value(modalidad),
       metodoPago = Value(metodoPago),
       estado = Value(estado),
       subtotal = Value(subtotal),
       costoEmpaque = Value(costoEmpaque),
       total = Value(total);
  static Insertable<Pedido> custom({
    Expression<String>? id,
    Expression<String>? idempotenciaKey,
    Expression<String>? empleadoId,
    Expression<String>? fechaLocal,
    Expression<String>? horaLocal,
    Expression<DateTime>? creadoEn,
    Expression<String>? modalidad,
    Expression<String>? metodoPago,
    Expression<String>? estado,
    Expression<int>? subtotal,
    Expression<int>? costoEmpaque,
    Expression<int>? total,
    Expression<String>? motivoAnulacion,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (idempotenciaKey != null) 'idempotencia_key': idempotenciaKey,
      if (empleadoId != null) 'empleado_id': empleadoId,
      if (fechaLocal != null) 'fecha_local': fechaLocal,
      if (horaLocal != null) 'hora_local': horaLocal,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (modalidad != null) 'modalidad': modalidad,
      if (metodoPago != null) 'metodo_pago': metodoPago,
      if (estado != null) 'estado': estado,
      if (subtotal != null) 'subtotal': subtotal,
      if (costoEmpaque != null) 'costo_empaque': costoEmpaque,
      if (total != null) 'total': total,
      if (motivoAnulacion != null) 'motivo_anulacion': motivoAnulacion,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PedidosCompanion copyWith({
    Value<String>? id,
    Value<String>? idempotenciaKey,
    Value<String>? empleadoId,
    Value<String>? fechaLocal,
    Value<String>? horaLocal,
    Value<DateTime>? creadoEn,
    Value<String>? modalidad,
    Value<String>? metodoPago,
    Value<String>? estado,
    Value<int>? subtotal,
    Value<int>? costoEmpaque,
    Value<int>? total,
    Value<String?>? motivoAnulacion,
    Value<int>? rowid,
  }) {
    return PedidosCompanion(
      id: id ?? this.id,
      idempotenciaKey: idempotenciaKey ?? this.idempotenciaKey,
      empleadoId: empleadoId ?? this.empleadoId,
      fechaLocal: fechaLocal ?? this.fechaLocal,
      horaLocal: horaLocal ?? this.horaLocal,
      creadoEn: creadoEn ?? this.creadoEn,
      modalidad: modalidad ?? this.modalidad,
      metodoPago: metodoPago ?? this.metodoPago,
      estado: estado ?? this.estado,
      subtotal: subtotal ?? this.subtotal,
      costoEmpaque: costoEmpaque ?? this.costoEmpaque,
      total: total ?? this.total,
      motivoAnulacion: motivoAnulacion ?? this.motivoAnulacion,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (idempotenciaKey.present) {
      map['idempotencia_key'] = Variable<String>(idempotenciaKey.value);
    }
    if (empleadoId.present) {
      map['empleado_id'] = Variable<String>(empleadoId.value);
    }
    if (fechaLocal.present) {
      map['fecha_local'] = Variable<String>(fechaLocal.value);
    }
    if (horaLocal.present) {
      map['hora_local'] = Variable<String>(horaLocal.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (modalidad.present) {
      map['modalidad'] = Variable<String>(modalidad.value);
    }
    if (metodoPago.present) {
      map['metodo_pago'] = Variable<String>(metodoPago.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (subtotal.present) {
      map['subtotal'] = Variable<int>(subtotal.value);
    }
    if (costoEmpaque.present) {
      map['costo_empaque'] = Variable<int>(costoEmpaque.value);
    }
    if (total.present) {
      map['total'] = Variable<int>(total.value);
    }
    if (motivoAnulacion.present) {
      map['motivo_anulacion'] = Variable<String>(motivoAnulacion.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidosCompanion(')
          ..write('id: $id, ')
          ..write('idempotenciaKey: $idempotenciaKey, ')
          ..write('empleadoId: $empleadoId, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('horaLocal: $horaLocal, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('modalidad: $modalidad, ')
          ..write('metodoPago: $metodoPago, ')
          ..write('estado: $estado, ')
          ..write('subtotal: $subtotal, ')
          ..write('costoEmpaque: $costoEmpaque, ')
          ..write('total: $total, ')
          ..write('motivoAnulacion: $motivoAnulacion, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PedidoItemsTable extends PedidoItems
    with TableInfo<$PedidoItemsTable, PedidoItem> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidoItemsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pedidoIdMeta = const VerificationMeta(
    'pedidoId',
  );
  @override
  late final GeneratedColumn<String> pedidoId = GeneratedColumn<String>(
    'pedido_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pedidos (id)',
    ),
  );
  static const VerificationMeta _productoIdMeta = const VerificationMeta(
    'productoId',
  );
  @override
  late final GeneratedColumn<String> productoId = GeneratedColumn<String>(
    'producto_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES productos (id)',
    ),
  );
  static const VerificationMeta _nombreProductoMeta = const VerificationMeta(
    'nombreProducto',
  );
  @override
  late final GeneratedColumn<String> nombreProducto = GeneratedColumn<String>(
    'nombre_producto',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaNombreMeta = const VerificationMeta(
    'categoriaNombre',
  );
  @override
  late final GeneratedColumn<String> categoriaNombre = GeneratedColumn<String>(
    'categoria_nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modalidadMeta = const VerificationMeta(
    'modalidad',
  );
  @override
  late final GeneratedColumn<String> modalidad = GeneratedColumn<String>(
    'modalidad',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<int> precioUnitario = GeneratedColumn<int>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoEmpaqueUnitarioMeta =
      const VerificationMeta('costoEmpaqueUnitario');
  @override
  late final GeneratedColumn<int> costoEmpaqueUnitario = GeneratedColumn<int>(
    'costo_empaque_unitario',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtotalItemMeta = const VerificationMeta(
    'subtotalItem',
  );
  @override
  late final GeneratedColumn<int> subtotalItem = GeneratedColumn<int>(
    'subtotal_item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalItemMeta = const VerificationMeta(
    'totalItem',
  );
  @override
  late final GeneratedColumn<int> totalItem = GeneratedColumn<int>(
    'total_item',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pedidoId,
    productoId,
    nombreProducto,
    categoriaNombre,
    cantidad,
    modalidad,
    precioUnitario,
    costoEmpaqueUnitario,
    subtotalItem,
    totalItem,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedido_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<PedidoItem> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pedido_id')) {
      context.handle(
        _pedidoIdMeta,
        pedidoId.isAcceptableOrUnknown(data['pedido_id']!, _pedidoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pedidoIdMeta);
    }
    if (data.containsKey('producto_id')) {
      context.handle(
        _productoIdMeta,
        productoId.isAcceptableOrUnknown(data['producto_id']!, _productoIdMeta),
      );
    }
    if (data.containsKey('nombre_producto')) {
      context.handle(
        _nombreProductoMeta,
        nombreProducto.isAcceptableOrUnknown(
          data['nombre_producto']!,
          _nombreProductoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nombreProductoMeta);
    }
    if (data.containsKey('categoria_nombre')) {
      context.handle(
        _categoriaNombreMeta,
        categoriaNombre.isAcceptableOrUnknown(
          data['categoria_nombre']!,
          _categoriaNombreMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_categoriaNombreMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('modalidad')) {
      context.handle(
        _modalidadMeta,
        modalidad.isAcceptableOrUnknown(data['modalidad']!, _modalidadMeta),
      );
    } else if (isInserting) {
      context.missing(_modalidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    if (data.containsKey('costo_empaque_unitario')) {
      context.handle(
        _costoEmpaqueUnitarioMeta,
        costoEmpaqueUnitario.isAcceptableOrUnknown(
          data['costo_empaque_unitario']!,
          _costoEmpaqueUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoEmpaqueUnitarioMeta);
    }
    if (data.containsKey('subtotal_item')) {
      context.handle(
        _subtotalItemMeta,
        subtotalItem.isAcceptableOrUnknown(
          data['subtotal_item']!,
          _subtotalItemMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_subtotalItemMeta);
    }
    if (data.containsKey('total_item')) {
      context.handle(
        _totalItemMeta,
        totalItem.isAcceptableOrUnknown(data['total_item']!, _totalItemMeta),
      );
    } else if (isInserting) {
      context.missing(_totalItemMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PedidoItem map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PedidoItem(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pedidoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pedido_id'],
      )!,
      productoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}producto_id'],
      ),
      nombreProducto: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre_producto'],
      )!,
      categoriaNombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria_nombre'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
      modalidad: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modalidad'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}precio_unitario'],
      )!,
      costoEmpaqueUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}costo_empaque_unitario'],
      )!,
      subtotalItem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}subtotal_item'],
      )!,
      totalItem: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_item'],
      )!,
    );
  }

  @override
  $PedidoItemsTable createAlias(String alias) {
    return $PedidoItemsTable(attachedDatabase, alias);
  }
}

class PedidoItem extends DataClass implements Insertable<PedidoItem> {
  final String id;
  final String pedidoId;
  final String? productoId;
  final String nombreProducto;
  final String categoriaNombre;
  final int cantidad;
  final String modalidad;
  final int precioUnitario;
  final int costoEmpaqueUnitario;
  final int subtotalItem;
  final int totalItem;
  const PedidoItem({
    required this.id,
    required this.pedidoId,
    this.productoId,
    required this.nombreProducto,
    required this.categoriaNombre,
    required this.cantidad,
    required this.modalidad,
    required this.precioUnitario,
    required this.costoEmpaqueUnitario,
    required this.subtotalItem,
    required this.totalItem,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pedido_id'] = Variable<String>(pedidoId);
    if (!nullToAbsent || productoId != null) {
      map['producto_id'] = Variable<String>(productoId);
    }
    map['nombre_producto'] = Variable<String>(nombreProducto);
    map['categoria_nombre'] = Variable<String>(categoriaNombre);
    map['cantidad'] = Variable<int>(cantidad);
    map['modalidad'] = Variable<String>(modalidad);
    map['precio_unitario'] = Variable<int>(precioUnitario);
    map['costo_empaque_unitario'] = Variable<int>(costoEmpaqueUnitario);
    map['subtotal_item'] = Variable<int>(subtotalItem);
    map['total_item'] = Variable<int>(totalItem);
    return map;
  }

  PedidoItemsCompanion toCompanion(bool nullToAbsent) {
    return PedidoItemsCompanion(
      id: Value(id),
      pedidoId: Value(pedidoId),
      productoId: productoId == null && nullToAbsent
          ? const Value.absent()
          : Value(productoId),
      nombreProducto: Value(nombreProducto),
      categoriaNombre: Value(categoriaNombre),
      cantidad: Value(cantidad),
      modalidad: Value(modalidad),
      precioUnitario: Value(precioUnitario),
      costoEmpaqueUnitario: Value(costoEmpaqueUnitario),
      subtotalItem: Value(subtotalItem),
      totalItem: Value(totalItem),
    );
  }

  factory PedidoItem.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PedidoItem(
      id: serializer.fromJson<String>(json['id']),
      pedidoId: serializer.fromJson<String>(json['pedidoId']),
      productoId: serializer.fromJson<String?>(json['productoId']),
      nombreProducto: serializer.fromJson<String>(json['nombreProducto']),
      categoriaNombre: serializer.fromJson<String>(json['categoriaNombre']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      modalidad: serializer.fromJson<String>(json['modalidad']),
      precioUnitario: serializer.fromJson<int>(json['precioUnitario']),
      costoEmpaqueUnitario: serializer.fromJson<int>(
        json['costoEmpaqueUnitario'],
      ),
      subtotalItem: serializer.fromJson<int>(json['subtotalItem']),
      totalItem: serializer.fromJson<int>(json['totalItem']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pedidoId': serializer.toJson<String>(pedidoId),
      'productoId': serializer.toJson<String?>(productoId),
      'nombreProducto': serializer.toJson<String>(nombreProducto),
      'categoriaNombre': serializer.toJson<String>(categoriaNombre),
      'cantidad': serializer.toJson<int>(cantidad),
      'modalidad': serializer.toJson<String>(modalidad),
      'precioUnitario': serializer.toJson<int>(precioUnitario),
      'costoEmpaqueUnitario': serializer.toJson<int>(costoEmpaqueUnitario),
      'subtotalItem': serializer.toJson<int>(subtotalItem),
      'totalItem': serializer.toJson<int>(totalItem),
    };
  }

  PedidoItem copyWith({
    String? id,
    String? pedidoId,
    Value<String?> productoId = const Value.absent(),
    String? nombreProducto,
    String? categoriaNombre,
    int? cantidad,
    String? modalidad,
    int? precioUnitario,
    int? costoEmpaqueUnitario,
    int? subtotalItem,
    int? totalItem,
  }) => PedidoItem(
    id: id ?? this.id,
    pedidoId: pedidoId ?? this.pedidoId,
    productoId: productoId.present ? productoId.value : this.productoId,
    nombreProducto: nombreProducto ?? this.nombreProducto,
    categoriaNombre: categoriaNombre ?? this.categoriaNombre,
    cantidad: cantidad ?? this.cantidad,
    modalidad: modalidad ?? this.modalidad,
    precioUnitario: precioUnitario ?? this.precioUnitario,
    costoEmpaqueUnitario: costoEmpaqueUnitario ?? this.costoEmpaqueUnitario,
    subtotalItem: subtotalItem ?? this.subtotalItem,
    totalItem: totalItem ?? this.totalItem,
  );
  PedidoItem copyWithCompanion(PedidoItemsCompanion data) {
    return PedidoItem(
      id: data.id.present ? data.id.value : this.id,
      pedidoId: data.pedidoId.present ? data.pedidoId.value : this.pedidoId,
      productoId: data.productoId.present
          ? data.productoId.value
          : this.productoId,
      nombreProducto: data.nombreProducto.present
          ? data.nombreProducto.value
          : this.nombreProducto,
      categoriaNombre: data.categoriaNombre.present
          ? data.categoriaNombre.value
          : this.categoriaNombre,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      modalidad: data.modalidad.present ? data.modalidad.value : this.modalidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
      costoEmpaqueUnitario: data.costoEmpaqueUnitario.present
          ? data.costoEmpaqueUnitario.value
          : this.costoEmpaqueUnitario,
      subtotalItem: data.subtotalItem.present
          ? data.subtotalItem.value
          : this.subtotalItem,
      totalItem: data.totalItem.present ? data.totalItem.value : this.totalItem,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PedidoItem(')
          ..write('id: $id, ')
          ..write('pedidoId: $pedidoId, ')
          ..write('productoId: $productoId, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('categoriaNombre: $categoriaNombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('modalidad: $modalidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('costoEmpaqueUnitario: $costoEmpaqueUnitario, ')
          ..write('subtotalItem: $subtotalItem, ')
          ..write('totalItem: $totalItem')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    pedidoId,
    productoId,
    nombreProducto,
    categoriaNombre,
    cantidad,
    modalidad,
    precioUnitario,
    costoEmpaqueUnitario,
    subtotalItem,
    totalItem,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PedidoItem &&
          other.id == this.id &&
          other.pedidoId == this.pedidoId &&
          other.productoId == this.productoId &&
          other.nombreProducto == this.nombreProducto &&
          other.categoriaNombre == this.categoriaNombre &&
          other.cantidad == this.cantidad &&
          other.modalidad == this.modalidad &&
          other.precioUnitario == this.precioUnitario &&
          other.costoEmpaqueUnitario == this.costoEmpaqueUnitario &&
          other.subtotalItem == this.subtotalItem &&
          other.totalItem == this.totalItem);
}

class PedidoItemsCompanion extends UpdateCompanion<PedidoItem> {
  final Value<String> id;
  final Value<String> pedidoId;
  final Value<String?> productoId;
  final Value<String> nombreProducto;
  final Value<String> categoriaNombre;
  final Value<int> cantidad;
  final Value<String> modalidad;
  final Value<int> precioUnitario;
  final Value<int> costoEmpaqueUnitario;
  final Value<int> subtotalItem;
  final Value<int> totalItem;
  final Value<int> rowid;
  const PedidoItemsCompanion({
    this.id = const Value.absent(),
    this.pedidoId = const Value.absent(),
    this.productoId = const Value.absent(),
    this.nombreProducto = const Value.absent(),
    this.categoriaNombre = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.modalidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
    this.costoEmpaqueUnitario = const Value.absent(),
    this.subtotalItem = const Value.absent(),
    this.totalItem = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PedidoItemsCompanion.insert({
    required String id,
    required String pedidoId,
    this.productoId = const Value.absent(),
    required String nombreProducto,
    required String categoriaNombre,
    required int cantidad,
    required String modalidad,
    required int precioUnitario,
    required int costoEmpaqueUnitario,
    required int subtotalItem,
    required int totalItem,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pedidoId = Value(pedidoId),
       nombreProducto = Value(nombreProducto),
       categoriaNombre = Value(categoriaNombre),
       cantidad = Value(cantidad),
       modalidad = Value(modalidad),
       precioUnitario = Value(precioUnitario),
       costoEmpaqueUnitario = Value(costoEmpaqueUnitario),
       subtotalItem = Value(subtotalItem),
       totalItem = Value(totalItem);
  static Insertable<PedidoItem> custom({
    Expression<String>? id,
    Expression<String>? pedidoId,
    Expression<String>? productoId,
    Expression<String>? nombreProducto,
    Expression<String>? categoriaNombre,
    Expression<int>? cantidad,
    Expression<String>? modalidad,
    Expression<int>? precioUnitario,
    Expression<int>? costoEmpaqueUnitario,
    Expression<int>? subtotalItem,
    Expression<int>? totalItem,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pedidoId != null) 'pedido_id': pedidoId,
      if (productoId != null) 'producto_id': productoId,
      if (nombreProducto != null) 'nombre_producto': nombreProducto,
      if (categoriaNombre != null) 'categoria_nombre': categoriaNombre,
      if (cantidad != null) 'cantidad': cantidad,
      if (modalidad != null) 'modalidad': modalidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
      if (costoEmpaqueUnitario != null)
        'costo_empaque_unitario': costoEmpaqueUnitario,
      if (subtotalItem != null) 'subtotal_item': subtotalItem,
      if (totalItem != null) 'total_item': totalItem,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PedidoItemsCompanion copyWith({
    Value<String>? id,
    Value<String>? pedidoId,
    Value<String?>? productoId,
    Value<String>? nombreProducto,
    Value<String>? categoriaNombre,
    Value<int>? cantidad,
    Value<String>? modalidad,
    Value<int>? precioUnitario,
    Value<int>? costoEmpaqueUnitario,
    Value<int>? subtotalItem,
    Value<int>? totalItem,
    Value<int>? rowid,
  }) {
    return PedidoItemsCompanion(
      id: id ?? this.id,
      pedidoId: pedidoId ?? this.pedidoId,
      productoId: productoId ?? this.productoId,
      nombreProducto: nombreProducto ?? this.nombreProducto,
      categoriaNombre: categoriaNombre ?? this.categoriaNombre,
      cantidad: cantidad ?? this.cantidad,
      modalidad: modalidad ?? this.modalidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
      costoEmpaqueUnitario: costoEmpaqueUnitario ?? this.costoEmpaqueUnitario,
      subtotalItem: subtotalItem ?? this.subtotalItem,
      totalItem: totalItem ?? this.totalItem,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pedidoId.present) {
      map['pedido_id'] = Variable<String>(pedidoId.value);
    }
    if (productoId.present) {
      map['producto_id'] = Variable<String>(productoId.value);
    }
    if (nombreProducto.present) {
      map['nombre_producto'] = Variable<String>(nombreProducto.value);
    }
    if (categoriaNombre.present) {
      map['categoria_nombre'] = Variable<String>(categoriaNombre.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (modalidad.present) {
      map['modalidad'] = Variable<String>(modalidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<int>(precioUnitario.value);
    }
    if (costoEmpaqueUnitario.present) {
      map['costo_empaque_unitario'] = Variable<int>(costoEmpaqueUnitario.value);
    }
    if (subtotalItem.present) {
      map['subtotal_item'] = Variable<int>(subtotalItem.value);
    }
    if (totalItem.present) {
      map['total_item'] = Variable<int>(totalItem.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidoItemsCompanion(')
          ..write('id: $id, ')
          ..write('pedidoId: $pedidoId, ')
          ..write('productoId: $productoId, ')
          ..write('nombreProducto: $nombreProducto, ')
          ..write('categoriaNombre: $categoriaNombre, ')
          ..write('cantidad: $cantidad, ')
          ..write('modalidad: $modalidad, ')
          ..write('precioUnitario: $precioUnitario, ')
          ..write('costoEmpaqueUnitario: $costoEmpaqueUnitario, ')
          ..write('subtotalItem: $subtotalItem, ')
          ..write('totalItem: $totalItem, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GastosTable extends Gastos with TableInfo<$GastosTable, Gasto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GastosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valorMeta = const VerificationMeta('valor');
  @override
  late final GeneratedColumn<int> valor = GeneratedColumn<int>(
    'valor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaLocalMeta = const VerificationMeta(
    'fechaLocal',
  );
  @override
  late final GeneratedColumn<String> fechaLocal = GeneratedColumn<String>(
    'fecha_local',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _horaLocalMeta = const VerificationMeta(
    'horaLocal',
  );
  @override
  late final GeneratedColumn<String> horaLocal = GeneratedColumn<String>(
    'hora_local',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoriaMeta = const VerificationMeta(
    'categoria',
  );
  @override
  late final GeneratedColumn<String> categoria = GeneratedColumn<String>(
    'categoria',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _observacionesMeta = const VerificationMeta(
    'observaciones',
  );
  @override
  late final GeneratedColumn<String> observaciones = GeneratedColumn<String>(
    'observaciones',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    descripcion,
    valor,
    fechaLocal,
    horaLocal,
    categoria,
    observaciones,
    usuarioId,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'gastos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Gasto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('valor')) {
      context.handle(
        _valorMeta,
        valor.isAcceptableOrUnknown(data['valor']!, _valorMeta),
      );
    } else if (isInserting) {
      context.missing(_valorMeta);
    }
    if (data.containsKey('fecha_local')) {
      context.handle(
        _fechaLocalMeta,
        fechaLocal.isAcceptableOrUnknown(data['fecha_local']!, _fechaLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaLocalMeta);
    }
    if (data.containsKey('hora_local')) {
      context.handle(
        _horaLocalMeta,
        horaLocal.isAcceptableOrUnknown(data['hora_local']!, _horaLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_horaLocalMeta);
    }
    if (data.containsKey('categoria')) {
      context.handle(
        _categoriaMeta,
        categoria.isAcceptableOrUnknown(data['categoria']!, _categoriaMeta),
      );
    }
    if (data.containsKey('observaciones')) {
      context.handle(
        _observacionesMeta,
        observaciones.isAcceptableOrUnknown(
          data['observaciones']!,
          _observacionesMeta,
        ),
      );
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Gasto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Gasto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      valor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}valor'],
      )!,
      fechaLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_local'],
      )!,
      horaLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}hora_local'],
      )!,
      categoria: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}categoria'],
      ),
      observaciones: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}observaciones'],
      ),
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $GastosTable createAlias(String alias) {
    return $GastosTable(attachedDatabase, alias);
  }
}

class Gasto extends DataClass implements Insertable<Gasto> {
  final String id;
  final String descripcion;
  final int valor;
  final String fechaLocal;
  final String horaLocal;
  final String? categoria;
  final String? observaciones;
  final String usuarioId;
  final DateTime creadoEn;
  const Gasto({
    required this.id,
    required this.descripcion,
    required this.valor,
    required this.fechaLocal,
    required this.horaLocal,
    this.categoria,
    this.observaciones,
    required this.usuarioId,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['descripcion'] = Variable<String>(descripcion);
    map['valor'] = Variable<int>(valor);
    map['fecha_local'] = Variable<String>(fechaLocal);
    map['hora_local'] = Variable<String>(horaLocal);
    if (!nullToAbsent || categoria != null) {
      map['categoria'] = Variable<String>(categoria);
    }
    if (!nullToAbsent || observaciones != null) {
      map['observaciones'] = Variable<String>(observaciones);
    }
    map['usuario_id'] = Variable<String>(usuarioId);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  GastosCompanion toCompanion(bool nullToAbsent) {
    return GastosCompanion(
      id: Value(id),
      descripcion: Value(descripcion),
      valor: Value(valor),
      fechaLocal: Value(fechaLocal),
      horaLocal: Value(horaLocal),
      categoria: categoria == null && nullToAbsent
          ? const Value.absent()
          : Value(categoria),
      observaciones: observaciones == null && nullToAbsent
          ? const Value.absent()
          : Value(observaciones),
      usuarioId: Value(usuarioId),
      creadoEn: Value(creadoEn),
    );
  }

  factory Gasto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Gasto(
      id: serializer.fromJson<String>(json['id']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      valor: serializer.fromJson<int>(json['valor']),
      fechaLocal: serializer.fromJson<String>(json['fechaLocal']),
      horaLocal: serializer.fromJson<String>(json['horaLocal']),
      categoria: serializer.fromJson<String?>(json['categoria']),
      observaciones: serializer.fromJson<String?>(json['observaciones']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'descripcion': serializer.toJson<String>(descripcion),
      'valor': serializer.toJson<int>(valor),
      'fechaLocal': serializer.toJson<String>(fechaLocal),
      'horaLocal': serializer.toJson<String>(horaLocal),
      'categoria': serializer.toJson<String?>(categoria),
      'observaciones': serializer.toJson<String?>(observaciones),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  Gasto copyWith({
    String? id,
    String? descripcion,
    int? valor,
    String? fechaLocal,
    String? horaLocal,
    Value<String?> categoria = const Value.absent(),
    Value<String?> observaciones = const Value.absent(),
    String? usuarioId,
    DateTime? creadoEn,
  }) => Gasto(
    id: id ?? this.id,
    descripcion: descripcion ?? this.descripcion,
    valor: valor ?? this.valor,
    fechaLocal: fechaLocal ?? this.fechaLocal,
    horaLocal: horaLocal ?? this.horaLocal,
    categoria: categoria.present ? categoria.value : this.categoria,
    observaciones: observaciones.present
        ? observaciones.value
        : this.observaciones,
    usuarioId: usuarioId ?? this.usuarioId,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  Gasto copyWithCompanion(GastosCompanion data) {
    return Gasto(
      id: data.id.present ? data.id.value : this.id,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      valor: data.valor.present ? data.valor.value : this.valor,
      fechaLocal: data.fechaLocal.present
          ? data.fechaLocal.value
          : this.fechaLocal,
      horaLocal: data.horaLocal.present ? data.horaLocal.value : this.horaLocal,
      categoria: data.categoria.present ? data.categoria.value : this.categoria,
      observaciones: data.observaciones.present
          ? data.observaciones.value
          : this.observaciones,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Gasto(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('valor: $valor, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('horaLocal: $horaLocal, ')
          ..write('categoria: $categoria, ')
          ..write('observaciones: $observaciones, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    descripcion,
    valor,
    fechaLocal,
    horaLocal,
    categoria,
    observaciones,
    usuarioId,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Gasto &&
          other.id == this.id &&
          other.descripcion == this.descripcion &&
          other.valor == this.valor &&
          other.fechaLocal == this.fechaLocal &&
          other.horaLocal == this.horaLocal &&
          other.categoria == this.categoria &&
          other.observaciones == this.observaciones &&
          other.usuarioId == this.usuarioId &&
          other.creadoEn == this.creadoEn);
}

class GastosCompanion extends UpdateCompanion<Gasto> {
  final Value<String> id;
  final Value<String> descripcion;
  final Value<int> valor;
  final Value<String> fechaLocal;
  final Value<String> horaLocal;
  final Value<String?> categoria;
  final Value<String?> observaciones;
  final Value<String> usuarioId;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const GastosCompanion({
    this.id = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.valor = const Value.absent(),
    this.fechaLocal = const Value.absent(),
    this.horaLocal = const Value.absent(),
    this.categoria = const Value.absent(),
    this.observaciones = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GastosCompanion.insert({
    required String id,
    required String descripcion,
    required int valor,
    required String fechaLocal,
    required String horaLocal,
    this.categoria = const Value.absent(),
    this.observaciones = const Value.absent(),
    required String usuarioId,
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       descripcion = Value(descripcion),
       valor = Value(valor),
       fechaLocal = Value(fechaLocal),
       horaLocal = Value(horaLocal),
       usuarioId = Value(usuarioId),
       creadoEn = Value(creadoEn);
  static Insertable<Gasto> custom({
    Expression<String>? id,
    Expression<String>? descripcion,
    Expression<int>? valor,
    Expression<String>? fechaLocal,
    Expression<String>? horaLocal,
    Expression<String>? categoria,
    Expression<String>? observaciones,
    Expression<String>? usuarioId,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (descripcion != null) 'descripcion': descripcion,
      if (valor != null) 'valor': valor,
      if (fechaLocal != null) 'fecha_local': fechaLocal,
      if (horaLocal != null) 'hora_local': horaLocal,
      if (categoria != null) 'categoria': categoria,
      if (observaciones != null) 'observaciones': observaciones,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GastosCompanion copyWith({
    Value<String>? id,
    Value<String>? descripcion,
    Value<int>? valor,
    Value<String>? fechaLocal,
    Value<String>? horaLocal,
    Value<String?>? categoria,
    Value<String?>? observaciones,
    Value<String>? usuarioId,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return GastosCompanion(
      id: id ?? this.id,
      descripcion: descripcion ?? this.descripcion,
      valor: valor ?? this.valor,
      fechaLocal: fechaLocal ?? this.fechaLocal,
      horaLocal: horaLocal ?? this.horaLocal,
      categoria: categoria ?? this.categoria,
      observaciones: observaciones ?? this.observaciones,
      usuarioId: usuarioId ?? this.usuarioId,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (valor.present) {
      map['valor'] = Variable<int>(valor.value);
    }
    if (fechaLocal.present) {
      map['fecha_local'] = Variable<String>(fechaLocal.value);
    }
    if (horaLocal.present) {
      map['hora_local'] = Variable<String>(horaLocal.value);
    }
    if (categoria.present) {
      map['categoria'] = Variable<String>(categoria.value);
    }
    if (observaciones.present) {
      map['observaciones'] = Variable<String>(observaciones.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GastosCompanion(')
          ..write('id: $id, ')
          ..write('descripcion: $descripcion, ')
          ..write('valor: $valor, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('horaLocal: $horaLocal, ')
          ..write('categoria: $categoria, ')
          ..write('observaciones: $observaciones, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CierresDiariosTable extends CierresDiarios
    with TableInfo<$CierresDiariosTable, CierresDiario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CierresDiariosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _fechaLocalMeta = const VerificationMeta(
    'fechaLocal',
  );
  @override
  late final GeneratedColumn<String> fechaLocal = GeneratedColumn<String>(
    'fecha_local',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalPedidosMeta = const VerificationMeta(
    'totalPedidos',
  );
  @override
  late final GeneratedColumn<int> totalPedidos = GeneratedColumn<int>(
    'total_pedidos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalVentasMeta = const VerificationMeta(
    'totalVentas',
  );
  @override
  late final GeneratedColumn<int> totalVentas = GeneratedColumn<int>(
    'total_ventas',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalEfectivoMeta = const VerificationMeta(
    'totalEfectivo',
  );
  @override
  late final GeneratedColumn<int> totalEfectivo = GeneratedColumn<int>(
    'total_efectivo',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalTransferenciaMeta =
      const VerificationMeta('totalTransferencia');
  @override
  late final GeneratedColumn<int> totalTransferencia = GeneratedColumn<int>(
    'total_transferencia',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLlevarMeta = const VerificationMeta(
    'totalLlevar',
  );
  @override
  late final GeneratedColumn<int> totalLlevar = GeneratedColumn<int>(
    'total_llevar',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalLocalMeta = const VerificationMeta(
    'totalLocal',
  );
  @override
  late final GeneratedColumn<int> totalLocal = GeneratedColumn<int>(
    'total_local',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _totalEgresosMeta = const VerificationMeta(
    'totalEgresos',
  );
  @override
  late final GeneratedColumn<int> totalEgresos = GeneratedColumn<int>(
    'total_egresos',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _saldoNetoMeta = const VerificationMeta(
    'saldoNeto',
  );
  @override
  late final GeneratedColumn<int> saldoNeto = GeneratedColumn<int>(
    'saldo_neto',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cerradoPorMeta = const VerificationMeta(
    'cerradoPor',
  );
  @override
  late final GeneratedColumn<String> cerradoPor = GeneratedColumn<String>(
    'cerrado_por',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cerradoEnMeta = const VerificationMeta(
    'cerradoEn',
  );
  @override
  late final GeneratedColumn<DateTime> cerradoEn = GeneratedColumn<DateTime>(
    'cerrado_en',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    fechaLocal,
    estado,
    totalPedidos,
    totalVentas,
    totalEfectivo,
    totalTransferencia,
    totalLlevar,
    totalLocal,
    totalEgresos,
    saldoNeto,
    cerradoPor,
    creadoEn,
    cerradoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cierres_diarios';
  @override
  VerificationContext validateIntegrity(
    Insertable<CierresDiario> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('fecha_local')) {
      context.handle(
        _fechaLocalMeta,
        fechaLocal.isAcceptableOrUnknown(data['fecha_local']!, _fechaLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_fechaLocalMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    } else if (isInserting) {
      context.missing(_estadoMeta);
    }
    if (data.containsKey('total_pedidos')) {
      context.handle(
        _totalPedidosMeta,
        totalPedidos.isAcceptableOrUnknown(
          data['total_pedidos']!,
          _totalPedidosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalPedidosMeta);
    }
    if (data.containsKey('total_ventas')) {
      context.handle(
        _totalVentasMeta,
        totalVentas.isAcceptableOrUnknown(
          data['total_ventas']!,
          _totalVentasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalVentasMeta);
    }
    if (data.containsKey('total_efectivo')) {
      context.handle(
        _totalEfectivoMeta,
        totalEfectivo.isAcceptableOrUnknown(
          data['total_efectivo']!,
          _totalEfectivoMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalEfectivoMeta);
    }
    if (data.containsKey('total_transferencia')) {
      context.handle(
        _totalTransferenciaMeta,
        totalTransferencia.isAcceptableOrUnknown(
          data['total_transferencia']!,
          _totalTransferenciaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalTransferenciaMeta);
    }
    if (data.containsKey('total_llevar')) {
      context.handle(
        _totalLlevarMeta,
        totalLlevar.isAcceptableOrUnknown(
          data['total_llevar']!,
          _totalLlevarMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalLlevarMeta);
    }
    if (data.containsKey('total_local')) {
      context.handle(
        _totalLocalMeta,
        totalLocal.isAcceptableOrUnknown(data['total_local']!, _totalLocalMeta),
      );
    } else if (isInserting) {
      context.missing(_totalLocalMeta);
    }
    if (data.containsKey('total_egresos')) {
      context.handle(
        _totalEgresosMeta,
        totalEgresos.isAcceptableOrUnknown(
          data['total_egresos']!,
          _totalEgresosMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_totalEgresosMeta);
    }
    if (data.containsKey('saldo_neto')) {
      context.handle(
        _saldoNetoMeta,
        saldoNeto.isAcceptableOrUnknown(data['saldo_neto']!, _saldoNetoMeta),
      );
    } else if (isInserting) {
      context.missing(_saldoNetoMeta);
    }
    if (data.containsKey('cerrado_por')) {
      context.handle(
        _cerradoPorMeta,
        cerradoPor.isAcceptableOrUnknown(data['cerrado_por']!, _cerradoPorMeta),
      );
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    if (data.containsKey('cerrado_en')) {
      context.handle(
        _cerradoEnMeta,
        cerradoEn.isAcceptableOrUnknown(data['cerrado_en']!, _cerradoEnMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {fechaLocal},
  ];
  @override
  CierresDiario map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CierresDiario(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      fechaLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}fecha_local'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      totalPedidos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_pedidos'],
      )!,
      totalVentas: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_ventas'],
      )!,
      totalEfectivo: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_efectivo'],
      )!,
      totalTransferencia: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_transferencia'],
      )!,
      totalLlevar: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_llevar'],
      )!,
      totalLocal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_local'],
      )!,
      totalEgresos: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_egresos'],
      )!,
      saldoNeto: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}saldo_neto'],
      )!,
      cerradoPor: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cerrado_por'],
      ),
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
      cerradoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}cerrado_en'],
      ),
    );
  }

  @override
  $CierresDiariosTable createAlias(String alias) {
    return $CierresDiariosTable(attachedDatabase, alias);
  }
}

class CierresDiario extends DataClass implements Insertable<CierresDiario> {
  final String id;
  final String fechaLocal;
  final String estado;
  final int totalPedidos;
  final int totalVentas;
  final int totalEfectivo;
  final int totalTransferencia;
  final int totalLlevar;
  final int totalLocal;
  final int totalEgresos;
  final int saldoNeto;
  final String? cerradoPor;
  final DateTime creadoEn;
  final DateTime? cerradoEn;
  const CierresDiario({
    required this.id,
    required this.fechaLocal,
    required this.estado,
    required this.totalPedidos,
    required this.totalVentas,
    required this.totalEfectivo,
    required this.totalTransferencia,
    required this.totalLlevar,
    required this.totalLocal,
    required this.totalEgresos,
    required this.saldoNeto,
    this.cerradoPor,
    required this.creadoEn,
    this.cerradoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['fecha_local'] = Variable<String>(fechaLocal);
    map['estado'] = Variable<String>(estado);
    map['total_pedidos'] = Variable<int>(totalPedidos);
    map['total_ventas'] = Variable<int>(totalVentas);
    map['total_efectivo'] = Variable<int>(totalEfectivo);
    map['total_transferencia'] = Variable<int>(totalTransferencia);
    map['total_llevar'] = Variable<int>(totalLlevar);
    map['total_local'] = Variable<int>(totalLocal);
    map['total_egresos'] = Variable<int>(totalEgresos);
    map['saldo_neto'] = Variable<int>(saldoNeto);
    if (!nullToAbsent || cerradoPor != null) {
      map['cerrado_por'] = Variable<String>(cerradoPor);
    }
    map['creado_en'] = Variable<DateTime>(creadoEn);
    if (!nullToAbsent || cerradoEn != null) {
      map['cerrado_en'] = Variable<DateTime>(cerradoEn);
    }
    return map;
  }

  CierresDiariosCompanion toCompanion(bool nullToAbsent) {
    return CierresDiariosCompanion(
      id: Value(id),
      fechaLocal: Value(fechaLocal),
      estado: Value(estado),
      totalPedidos: Value(totalPedidos),
      totalVentas: Value(totalVentas),
      totalEfectivo: Value(totalEfectivo),
      totalTransferencia: Value(totalTransferencia),
      totalLlevar: Value(totalLlevar),
      totalLocal: Value(totalLocal),
      totalEgresos: Value(totalEgresos),
      saldoNeto: Value(saldoNeto),
      cerradoPor: cerradoPor == null && nullToAbsent
          ? const Value.absent()
          : Value(cerradoPor),
      creadoEn: Value(creadoEn),
      cerradoEn: cerradoEn == null && nullToAbsent
          ? const Value.absent()
          : Value(cerradoEn),
    );
  }

  factory CierresDiario.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CierresDiario(
      id: serializer.fromJson<String>(json['id']),
      fechaLocal: serializer.fromJson<String>(json['fechaLocal']),
      estado: serializer.fromJson<String>(json['estado']),
      totalPedidos: serializer.fromJson<int>(json['totalPedidos']),
      totalVentas: serializer.fromJson<int>(json['totalVentas']),
      totalEfectivo: serializer.fromJson<int>(json['totalEfectivo']),
      totalTransferencia: serializer.fromJson<int>(json['totalTransferencia']),
      totalLlevar: serializer.fromJson<int>(json['totalLlevar']),
      totalLocal: serializer.fromJson<int>(json['totalLocal']),
      totalEgresos: serializer.fromJson<int>(json['totalEgresos']),
      saldoNeto: serializer.fromJson<int>(json['saldoNeto']),
      cerradoPor: serializer.fromJson<String?>(json['cerradoPor']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
      cerradoEn: serializer.fromJson<DateTime?>(json['cerradoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'fechaLocal': serializer.toJson<String>(fechaLocal),
      'estado': serializer.toJson<String>(estado),
      'totalPedidos': serializer.toJson<int>(totalPedidos),
      'totalVentas': serializer.toJson<int>(totalVentas),
      'totalEfectivo': serializer.toJson<int>(totalEfectivo),
      'totalTransferencia': serializer.toJson<int>(totalTransferencia),
      'totalLlevar': serializer.toJson<int>(totalLlevar),
      'totalLocal': serializer.toJson<int>(totalLocal),
      'totalEgresos': serializer.toJson<int>(totalEgresos),
      'saldoNeto': serializer.toJson<int>(saldoNeto),
      'cerradoPor': serializer.toJson<String?>(cerradoPor),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
      'cerradoEn': serializer.toJson<DateTime?>(cerradoEn),
    };
  }

  CierresDiario copyWith({
    String? id,
    String? fechaLocal,
    String? estado,
    int? totalPedidos,
    int? totalVentas,
    int? totalEfectivo,
    int? totalTransferencia,
    int? totalLlevar,
    int? totalLocal,
    int? totalEgresos,
    int? saldoNeto,
    Value<String?> cerradoPor = const Value.absent(),
    DateTime? creadoEn,
    Value<DateTime?> cerradoEn = const Value.absent(),
  }) => CierresDiario(
    id: id ?? this.id,
    fechaLocal: fechaLocal ?? this.fechaLocal,
    estado: estado ?? this.estado,
    totalPedidos: totalPedidos ?? this.totalPedidos,
    totalVentas: totalVentas ?? this.totalVentas,
    totalEfectivo: totalEfectivo ?? this.totalEfectivo,
    totalTransferencia: totalTransferencia ?? this.totalTransferencia,
    totalLlevar: totalLlevar ?? this.totalLlevar,
    totalLocal: totalLocal ?? this.totalLocal,
    totalEgresos: totalEgresos ?? this.totalEgresos,
    saldoNeto: saldoNeto ?? this.saldoNeto,
    cerradoPor: cerradoPor.present ? cerradoPor.value : this.cerradoPor,
    creadoEn: creadoEn ?? this.creadoEn,
    cerradoEn: cerradoEn.present ? cerradoEn.value : this.cerradoEn,
  );
  CierresDiario copyWithCompanion(CierresDiariosCompanion data) {
    return CierresDiario(
      id: data.id.present ? data.id.value : this.id,
      fechaLocal: data.fechaLocal.present
          ? data.fechaLocal.value
          : this.fechaLocal,
      estado: data.estado.present ? data.estado.value : this.estado,
      totalPedidos: data.totalPedidos.present
          ? data.totalPedidos.value
          : this.totalPedidos,
      totalVentas: data.totalVentas.present
          ? data.totalVentas.value
          : this.totalVentas,
      totalEfectivo: data.totalEfectivo.present
          ? data.totalEfectivo.value
          : this.totalEfectivo,
      totalTransferencia: data.totalTransferencia.present
          ? data.totalTransferencia.value
          : this.totalTransferencia,
      totalLlevar: data.totalLlevar.present
          ? data.totalLlevar.value
          : this.totalLlevar,
      totalLocal: data.totalLocal.present
          ? data.totalLocal.value
          : this.totalLocal,
      totalEgresos: data.totalEgresos.present
          ? data.totalEgresos.value
          : this.totalEgresos,
      saldoNeto: data.saldoNeto.present ? data.saldoNeto.value : this.saldoNeto,
      cerradoPor: data.cerradoPor.present
          ? data.cerradoPor.value
          : this.cerradoPor,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
      cerradoEn: data.cerradoEn.present ? data.cerradoEn.value : this.cerradoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CierresDiario(')
          ..write('id: $id, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('estado: $estado, ')
          ..write('totalPedidos: $totalPedidos, ')
          ..write('totalVentas: $totalVentas, ')
          ..write('totalEfectivo: $totalEfectivo, ')
          ..write('totalTransferencia: $totalTransferencia, ')
          ..write('totalLlevar: $totalLlevar, ')
          ..write('totalLocal: $totalLocal, ')
          ..write('totalEgresos: $totalEgresos, ')
          ..write('saldoNeto: $saldoNeto, ')
          ..write('cerradoPor: $cerradoPor, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('cerradoEn: $cerradoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    fechaLocal,
    estado,
    totalPedidos,
    totalVentas,
    totalEfectivo,
    totalTransferencia,
    totalLlevar,
    totalLocal,
    totalEgresos,
    saldoNeto,
    cerradoPor,
    creadoEn,
    cerradoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CierresDiario &&
          other.id == this.id &&
          other.fechaLocal == this.fechaLocal &&
          other.estado == this.estado &&
          other.totalPedidos == this.totalPedidos &&
          other.totalVentas == this.totalVentas &&
          other.totalEfectivo == this.totalEfectivo &&
          other.totalTransferencia == this.totalTransferencia &&
          other.totalLlevar == this.totalLlevar &&
          other.totalLocal == this.totalLocal &&
          other.totalEgresos == this.totalEgresos &&
          other.saldoNeto == this.saldoNeto &&
          other.cerradoPor == this.cerradoPor &&
          other.creadoEn == this.creadoEn &&
          other.cerradoEn == this.cerradoEn);
}

class CierresDiariosCompanion extends UpdateCompanion<CierresDiario> {
  final Value<String> id;
  final Value<String> fechaLocal;
  final Value<String> estado;
  final Value<int> totalPedidos;
  final Value<int> totalVentas;
  final Value<int> totalEfectivo;
  final Value<int> totalTransferencia;
  final Value<int> totalLlevar;
  final Value<int> totalLocal;
  final Value<int> totalEgresos;
  final Value<int> saldoNeto;
  final Value<String?> cerradoPor;
  final Value<DateTime> creadoEn;
  final Value<DateTime?> cerradoEn;
  final Value<int> rowid;
  const CierresDiariosCompanion({
    this.id = const Value.absent(),
    this.fechaLocal = const Value.absent(),
    this.estado = const Value.absent(),
    this.totalPedidos = const Value.absent(),
    this.totalVentas = const Value.absent(),
    this.totalEfectivo = const Value.absent(),
    this.totalTransferencia = const Value.absent(),
    this.totalLlevar = const Value.absent(),
    this.totalLocal = const Value.absent(),
    this.totalEgresos = const Value.absent(),
    this.saldoNeto = const Value.absent(),
    this.cerradoPor = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.cerradoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CierresDiariosCompanion.insert({
    required String id,
    required String fechaLocal,
    required String estado,
    required int totalPedidos,
    required int totalVentas,
    required int totalEfectivo,
    required int totalTransferencia,
    required int totalLlevar,
    required int totalLocal,
    required int totalEgresos,
    required int saldoNeto,
    this.cerradoPor = const Value.absent(),
    required DateTime creadoEn,
    this.cerradoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       fechaLocal = Value(fechaLocal),
       estado = Value(estado),
       totalPedidos = Value(totalPedidos),
       totalVentas = Value(totalVentas),
       totalEfectivo = Value(totalEfectivo),
       totalTransferencia = Value(totalTransferencia),
       totalLlevar = Value(totalLlevar),
       totalLocal = Value(totalLocal),
       totalEgresos = Value(totalEgresos),
       saldoNeto = Value(saldoNeto),
       creadoEn = Value(creadoEn);
  static Insertable<CierresDiario> custom({
    Expression<String>? id,
    Expression<String>? fechaLocal,
    Expression<String>? estado,
    Expression<int>? totalPedidos,
    Expression<int>? totalVentas,
    Expression<int>? totalEfectivo,
    Expression<int>? totalTransferencia,
    Expression<int>? totalLlevar,
    Expression<int>? totalLocal,
    Expression<int>? totalEgresos,
    Expression<int>? saldoNeto,
    Expression<String>? cerradoPor,
    Expression<DateTime>? creadoEn,
    Expression<DateTime>? cerradoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (fechaLocal != null) 'fecha_local': fechaLocal,
      if (estado != null) 'estado': estado,
      if (totalPedidos != null) 'total_pedidos': totalPedidos,
      if (totalVentas != null) 'total_ventas': totalVentas,
      if (totalEfectivo != null) 'total_efectivo': totalEfectivo,
      if (totalTransferencia != null) 'total_transferencia': totalTransferencia,
      if (totalLlevar != null) 'total_llevar': totalLlevar,
      if (totalLocal != null) 'total_local': totalLocal,
      if (totalEgresos != null) 'total_egresos': totalEgresos,
      if (saldoNeto != null) 'saldo_neto': saldoNeto,
      if (cerradoPor != null) 'cerrado_por': cerradoPor,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (cerradoEn != null) 'cerrado_en': cerradoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CierresDiariosCompanion copyWith({
    Value<String>? id,
    Value<String>? fechaLocal,
    Value<String>? estado,
    Value<int>? totalPedidos,
    Value<int>? totalVentas,
    Value<int>? totalEfectivo,
    Value<int>? totalTransferencia,
    Value<int>? totalLlevar,
    Value<int>? totalLocal,
    Value<int>? totalEgresos,
    Value<int>? saldoNeto,
    Value<String?>? cerradoPor,
    Value<DateTime>? creadoEn,
    Value<DateTime?>? cerradoEn,
    Value<int>? rowid,
  }) {
    return CierresDiariosCompanion(
      id: id ?? this.id,
      fechaLocal: fechaLocal ?? this.fechaLocal,
      estado: estado ?? this.estado,
      totalPedidos: totalPedidos ?? this.totalPedidos,
      totalVentas: totalVentas ?? this.totalVentas,
      totalEfectivo: totalEfectivo ?? this.totalEfectivo,
      totalTransferencia: totalTransferencia ?? this.totalTransferencia,
      totalLlevar: totalLlevar ?? this.totalLlevar,
      totalLocal: totalLocal ?? this.totalLocal,
      totalEgresos: totalEgresos ?? this.totalEgresos,
      saldoNeto: saldoNeto ?? this.saldoNeto,
      cerradoPor: cerradoPor ?? this.cerradoPor,
      creadoEn: creadoEn ?? this.creadoEn,
      cerradoEn: cerradoEn ?? this.cerradoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (fechaLocal.present) {
      map['fecha_local'] = Variable<String>(fechaLocal.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (totalPedidos.present) {
      map['total_pedidos'] = Variable<int>(totalPedidos.value);
    }
    if (totalVentas.present) {
      map['total_ventas'] = Variable<int>(totalVentas.value);
    }
    if (totalEfectivo.present) {
      map['total_efectivo'] = Variable<int>(totalEfectivo.value);
    }
    if (totalTransferencia.present) {
      map['total_transferencia'] = Variable<int>(totalTransferencia.value);
    }
    if (totalLlevar.present) {
      map['total_llevar'] = Variable<int>(totalLlevar.value);
    }
    if (totalLocal.present) {
      map['total_local'] = Variable<int>(totalLocal.value);
    }
    if (totalEgresos.present) {
      map['total_egresos'] = Variable<int>(totalEgresos.value);
    }
    if (saldoNeto.present) {
      map['saldo_neto'] = Variable<int>(saldoNeto.value);
    }
    if (cerradoPor.present) {
      map['cerrado_por'] = Variable<String>(cerradoPor.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (cerradoEn.present) {
      map['cerrado_en'] = Variable<DateTime>(cerradoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CierresDiariosCompanion(')
          ..write('id: $id, ')
          ..write('fechaLocal: $fechaLocal, ')
          ..write('estado: $estado, ')
          ..write('totalPedidos: $totalPedidos, ')
          ..write('totalVentas: $totalVentas, ')
          ..write('totalEfectivo: $totalEfectivo, ')
          ..write('totalTransferencia: $totalTransferencia, ')
          ..write('totalLlevar: $totalLlevar, ')
          ..write('totalLocal: $totalLocal, ')
          ..write('totalEgresos: $totalEgresos, ')
          ..write('saldoNeto: $saldoNeto, ')
          ..write('cerradoPor: $cerradoPor, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('cerradoEn: $cerradoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CierreAuditoriasTable extends CierreAuditorias
    with TableInfo<$CierreAuditoriasTable, CierreAuditoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CierreAuditoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _cierreIdMeta = const VerificationMeta(
    'cierreId',
  );
  @override
  late final GeneratedColumn<String> cierreId = GeneratedColumn<String>(
    'cierre_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES cierres_diarios (id)',
    ),
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valoresAntesMeta = const VerificationMeta(
    'valoresAntes',
  );
  @override
  late final GeneratedColumn<String> valoresAntes = GeneratedColumn<String>(
    'valores_antes',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valoresDespuesMeta = const VerificationMeta(
    'valoresDespues',
  );
  @override
  late final GeneratedColumn<String> valoresDespues = GeneratedColumn<String>(
    'valores_despues',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    cierreId,
    motivo,
    valoresAntes,
    valoresDespues,
    usuarioId,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'cierre_auditorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<CierreAuditoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('cierre_id')) {
      context.handle(
        _cierreIdMeta,
        cierreId.isAcceptableOrUnknown(data['cierre_id']!, _cierreIdMeta),
      );
    } else if (isInserting) {
      context.missing(_cierreIdMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('valores_antes')) {
      context.handle(
        _valoresAntesMeta,
        valoresAntes.isAcceptableOrUnknown(
          data['valores_antes']!,
          _valoresAntesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_valoresAntesMeta);
    }
    if (data.containsKey('valores_despues')) {
      context.handle(
        _valoresDespuesMeta,
        valoresDespues.isAcceptableOrUnknown(
          data['valores_despues']!,
          _valoresDespuesMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_valoresDespuesMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CierreAuditoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CierreAuditoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      cierreId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}cierre_id'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      )!,
      valoresAntes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valores_antes'],
      )!,
      valoresDespues: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}valores_despues'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $CierreAuditoriasTable createAlias(String alias) {
    return $CierreAuditoriasTable(attachedDatabase, alias);
  }
}

class CierreAuditoria extends DataClass implements Insertable<CierreAuditoria> {
  final String id;
  final String cierreId;
  final String motivo;
  final String valoresAntes;
  final String valoresDespues;
  final String usuarioId;
  final DateTime creadoEn;
  const CierreAuditoria({
    required this.id,
    required this.cierreId,
    required this.motivo,
    required this.valoresAntes,
    required this.valoresDespues,
    required this.usuarioId,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['cierre_id'] = Variable<String>(cierreId);
    map['motivo'] = Variable<String>(motivo);
    map['valores_antes'] = Variable<String>(valoresAntes);
    map['valores_despues'] = Variable<String>(valoresDespues);
    map['usuario_id'] = Variable<String>(usuarioId);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  CierreAuditoriasCompanion toCompanion(bool nullToAbsent) {
    return CierreAuditoriasCompanion(
      id: Value(id),
      cierreId: Value(cierreId),
      motivo: Value(motivo),
      valoresAntes: Value(valoresAntes),
      valoresDespues: Value(valoresDespues),
      usuarioId: Value(usuarioId),
      creadoEn: Value(creadoEn),
    );
  }

  factory CierreAuditoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CierreAuditoria(
      id: serializer.fromJson<String>(json['id']),
      cierreId: serializer.fromJson<String>(json['cierreId']),
      motivo: serializer.fromJson<String>(json['motivo']),
      valoresAntes: serializer.fromJson<String>(json['valoresAntes']),
      valoresDespues: serializer.fromJson<String>(json['valoresDespues']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'cierreId': serializer.toJson<String>(cierreId),
      'motivo': serializer.toJson<String>(motivo),
      'valoresAntes': serializer.toJson<String>(valoresAntes),
      'valoresDespues': serializer.toJson<String>(valoresDespues),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  CierreAuditoria copyWith({
    String? id,
    String? cierreId,
    String? motivo,
    String? valoresAntes,
    String? valoresDespues,
    String? usuarioId,
    DateTime? creadoEn,
  }) => CierreAuditoria(
    id: id ?? this.id,
    cierreId: cierreId ?? this.cierreId,
    motivo: motivo ?? this.motivo,
    valoresAntes: valoresAntes ?? this.valoresAntes,
    valoresDespues: valoresDespues ?? this.valoresDespues,
    usuarioId: usuarioId ?? this.usuarioId,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  CierreAuditoria copyWithCompanion(CierreAuditoriasCompanion data) {
    return CierreAuditoria(
      id: data.id.present ? data.id.value : this.id,
      cierreId: data.cierreId.present ? data.cierreId.value : this.cierreId,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      valoresAntes: data.valoresAntes.present
          ? data.valoresAntes.value
          : this.valoresAntes,
      valoresDespues: data.valoresDespues.present
          ? data.valoresDespues.value
          : this.valoresDespues,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CierreAuditoria(')
          ..write('id: $id, ')
          ..write('cierreId: $cierreId, ')
          ..write('motivo: $motivo, ')
          ..write('valoresAntes: $valoresAntes, ')
          ..write('valoresDespues: $valoresDespues, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    cierreId,
    motivo,
    valoresAntes,
    valoresDespues,
    usuarioId,
    creadoEn,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CierreAuditoria &&
          other.id == this.id &&
          other.cierreId == this.cierreId &&
          other.motivo == this.motivo &&
          other.valoresAntes == this.valoresAntes &&
          other.valoresDespues == this.valoresDespues &&
          other.usuarioId == this.usuarioId &&
          other.creadoEn == this.creadoEn);
}

class CierreAuditoriasCompanion extends UpdateCompanion<CierreAuditoria> {
  final Value<String> id;
  final Value<String> cierreId;
  final Value<String> motivo;
  final Value<String> valoresAntes;
  final Value<String> valoresDespues;
  final Value<String> usuarioId;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const CierreAuditoriasCompanion({
    this.id = const Value.absent(),
    this.cierreId = const Value.absent(),
    this.motivo = const Value.absent(),
    this.valoresAntes = const Value.absent(),
    this.valoresDespues = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CierreAuditoriasCompanion.insert({
    required String id,
    required String cierreId,
    required String motivo,
    required String valoresAntes,
    required String valoresDespues,
    required String usuarioId,
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       cierreId = Value(cierreId),
       motivo = Value(motivo),
       valoresAntes = Value(valoresAntes),
       valoresDespues = Value(valoresDespues),
       usuarioId = Value(usuarioId),
       creadoEn = Value(creadoEn);
  static Insertable<CierreAuditoria> custom({
    Expression<String>? id,
    Expression<String>? cierreId,
    Expression<String>? motivo,
    Expression<String>? valoresAntes,
    Expression<String>? valoresDespues,
    Expression<String>? usuarioId,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (cierreId != null) 'cierre_id': cierreId,
      if (motivo != null) 'motivo': motivo,
      if (valoresAntes != null) 'valores_antes': valoresAntes,
      if (valoresDespues != null) 'valores_despues': valoresDespues,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CierreAuditoriasCompanion copyWith({
    Value<String>? id,
    Value<String>? cierreId,
    Value<String>? motivo,
    Value<String>? valoresAntes,
    Value<String>? valoresDespues,
    Value<String>? usuarioId,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return CierreAuditoriasCompanion(
      id: id ?? this.id,
      cierreId: cierreId ?? this.cierreId,
      motivo: motivo ?? this.motivo,
      valoresAntes: valoresAntes ?? this.valoresAntes,
      valoresDespues: valoresDespues ?? this.valoresDespues,
      usuarioId: usuarioId ?? this.usuarioId,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (cierreId.present) {
      map['cierre_id'] = Variable<String>(cierreId.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (valoresAntes.present) {
      map['valores_antes'] = Variable<String>(valoresAntes.value);
    }
    if (valoresDespues.present) {
      map['valores_despues'] = Variable<String>(valoresDespues.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CierreAuditoriasCompanion(')
          ..write('id: $id, ')
          ..write('cierreId: $cierreId, ')
          ..write('motivo: $motivo, ')
          ..write('valoresAntes: $valoresAntes, ')
          ..write('valoresDespues: $valoresDespues, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PedidoAuditoriasTable extends PedidoAuditorias
    with TableInfo<$PedidoAuditoriasTable, PedidoAuditoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PedidoAuditoriasTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _pedidoIdMeta = const VerificationMeta(
    'pedidoId',
  );
  @override
  late final GeneratedColumn<String> pedidoId = GeneratedColumn<String>(
    'pedido_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES pedidos (id)',
    ),
  );
  static const VerificationMeta _accionMeta = const VerificationMeta('accion');
  @override
  late final GeneratedColumn<String> accion = GeneratedColumn<String>(
    'accion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _motivoMeta = const VerificationMeta('motivo');
  @override
  late final GeneratedColumn<String> motivo = GeneratedColumn<String>(
    'motivo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _usuarioIdMeta = const VerificationMeta(
    'usuarioId',
  );
  @override
  late final GeneratedColumn<String> usuarioId = GeneratedColumn<String>(
    'usuario_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES usuarios (id)',
    ),
  );
  static const VerificationMeta _creadoEnMeta = const VerificationMeta(
    'creadoEn',
  );
  @override
  late final GeneratedColumn<DateTime> creadoEn = GeneratedColumn<DateTime>(
    'creado_en',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    pedidoId,
    accion,
    motivo,
    usuarioId,
    creadoEn,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pedido_auditorias';
  @override
  VerificationContext validateIntegrity(
    Insertable<PedidoAuditoria> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pedido_id')) {
      context.handle(
        _pedidoIdMeta,
        pedidoId.isAcceptableOrUnknown(data['pedido_id']!, _pedidoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_pedidoIdMeta);
    }
    if (data.containsKey('accion')) {
      context.handle(
        _accionMeta,
        accion.isAcceptableOrUnknown(data['accion']!, _accionMeta),
      );
    } else if (isInserting) {
      context.missing(_accionMeta);
    }
    if (data.containsKey('motivo')) {
      context.handle(
        _motivoMeta,
        motivo.isAcceptableOrUnknown(data['motivo']!, _motivoMeta),
      );
    } else if (isInserting) {
      context.missing(_motivoMeta);
    }
    if (data.containsKey('usuario_id')) {
      context.handle(
        _usuarioIdMeta,
        usuarioId.isAcceptableOrUnknown(data['usuario_id']!, _usuarioIdMeta),
      );
    } else if (isInserting) {
      context.missing(_usuarioIdMeta);
    }
    if (data.containsKey('creado_en')) {
      context.handle(
        _creadoEnMeta,
        creadoEn.isAcceptableOrUnknown(data['creado_en']!, _creadoEnMeta),
      );
    } else if (isInserting) {
      context.missing(_creadoEnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  PedidoAuditoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PedidoAuditoria(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      pedidoId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}pedido_id'],
      )!,
      accion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}accion'],
      )!,
      motivo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}motivo'],
      )!,
      usuarioId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}usuario_id'],
      )!,
      creadoEn: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}creado_en'],
      )!,
    );
  }

  @override
  $PedidoAuditoriasTable createAlias(String alias) {
    return $PedidoAuditoriasTable(attachedDatabase, alias);
  }
}

class PedidoAuditoria extends DataClass implements Insertable<PedidoAuditoria> {
  final String id;
  final String pedidoId;
  final String accion;
  final String motivo;
  final String usuarioId;
  final DateTime creadoEn;
  const PedidoAuditoria({
    required this.id,
    required this.pedidoId,
    required this.accion,
    required this.motivo,
    required this.usuarioId,
    required this.creadoEn,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['pedido_id'] = Variable<String>(pedidoId);
    map['accion'] = Variable<String>(accion);
    map['motivo'] = Variable<String>(motivo);
    map['usuario_id'] = Variable<String>(usuarioId);
    map['creado_en'] = Variable<DateTime>(creadoEn);
    return map;
  }

  PedidoAuditoriasCompanion toCompanion(bool nullToAbsent) {
    return PedidoAuditoriasCompanion(
      id: Value(id),
      pedidoId: Value(pedidoId),
      accion: Value(accion),
      motivo: Value(motivo),
      usuarioId: Value(usuarioId),
      creadoEn: Value(creadoEn),
    );
  }

  factory PedidoAuditoria.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PedidoAuditoria(
      id: serializer.fromJson<String>(json['id']),
      pedidoId: serializer.fromJson<String>(json['pedidoId']),
      accion: serializer.fromJson<String>(json['accion']),
      motivo: serializer.fromJson<String>(json['motivo']),
      usuarioId: serializer.fromJson<String>(json['usuarioId']),
      creadoEn: serializer.fromJson<DateTime>(json['creadoEn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'pedidoId': serializer.toJson<String>(pedidoId),
      'accion': serializer.toJson<String>(accion),
      'motivo': serializer.toJson<String>(motivo),
      'usuarioId': serializer.toJson<String>(usuarioId),
      'creadoEn': serializer.toJson<DateTime>(creadoEn),
    };
  }

  PedidoAuditoria copyWith({
    String? id,
    String? pedidoId,
    String? accion,
    String? motivo,
    String? usuarioId,
    DateTime? creadoEn,
  }) => PedidoAuditoria(
    id: id ?? this.id,
    pedidoId: pedidoId ?? this.pedidoId,
    accion: accion ?? this.accion,
    motivo: motivo ?? this.motivo,
    usuarioId: usuarioId ?? this.usuarioId,
    creadoEn: creadoEn ?? this.creadoEn,
  );
  PedidoAuditoria copyWithCompanion(PedidoAuditoriasCompanion data) {
    return PedidoAuditoria(
      id: data.id.present ? data.id.value : this.id,
      pedidoId: data.pedidoId.present ? data.pedidoId.value : this.pedidoId,
      accion: data.accion.present ? data.accion.value : this.accion,
      motivo: data.motivo.present ? data.motivo.value : this.motivo,
      usuarioId: data.usuarioId.present ? data.usuarioId.value : this.usuarioId,
      creadoEn: data.creadoEn.present ? data.creadoEn.value : this.creadoEn,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PedidoAuditoria(')
          ..write('id: $id, ')
          ..write('pedidoId: $pedidoId, ')
          ..write('accion: $accion, ')
          ..write('motivo: $motivo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, pedidoId, accion, motivo, usuarioId, creadoEn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PedidoAuditoria &&
          other.id == this.id &&
          other.pedidoId == this.pedidoId &&
          other.accion == this.accion &&
          other.motivo == this.motivo &&
          other.usuarioId == this.usuarioId &&
          other.creadoEn == this.creadoEn);
}

class PedidoAuditoriasCompanion extends UpdateCompanion<PedidoAuditoria> {
  final Value<String> id;
  final Value<String> pedidoId;
  final Value<String> accion;
  final Value<String> motivo;
  final Value<String> usuarioId;
  final Value<DateTime> creadoEn;
  final Value<int> rowid;
  const PedidoAuditoriasCompanion({
    this.id = const Value.absent(),
    this.pedidoId = const Value.absent(),
    this.accion = const Value.absent(),
    this.motivo = const Value.absent(),
    this.usuarioId = const Value.absent(),
    this.creadoEn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PedidoAuditoriasCompanion.insert({
    required String id,
    required String pedidoId,
    required String accion,
    required String motivo,
    required String usuarioId,
    required DateTime creadoEn,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       pedidoId = Value(pedidoId),
       accion = Value(accion),
       motivo = Value(motivo),
       usuarioId = Value(usuarioId),
       creadoEn = Value(creadoEn);
  static Insertable<PedidoAuditoria> custom({
    Expression<String>? id,
    Expression<String>? pedidoId,
    Expression<String>? accion,
    Expression<String>? motivo,
    Expression<String>? usuarioId,
    Expression<DateTime>? creadoEn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (pedidoId != null) 'pedido_id': pedidoId,
      if (accion != null) 'accion': accion,
      if (motivo != null) 'motivo': motivo,
      if (usuarioId != null) 'usuario_id': usuarioId,
      if (creadoEn != null) 'creado_en': creadoEn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PedidoAuditoriasCompanion copyWith({
    Value<String>? id,
    Value<String>? pedidoId,
    Value<String>? accion,
    Value<String>? motivo,
    Value<String>? usuarioId,
    Value<DateTime>? creadoEn,
    Value<int>? rowid,
  }) {
    return PedidoAuditoriasCompanion(
      id: id ?? this.id,
      pedidoId: pedidoId ?? this.pedidoId,
      accion: accion ?? this.accion,
      motivo: motivo ?? this.motivo,
      usuarioId: usuarioId ?? this.usuarioId,
      creadoEn: creadoEn ?? this.creadoEn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (pedidoId.present) {
      map['pedido_id'] = Variable<String>(pedidoId.value);
    }
    if (accion.present) {
      map['accion'] = Variable<String>(accion.value);
    }
    if (motivo.present) {
      map['motivo'] = Variable<String>(motivo.value);
    }
    if (usuarioId.present) {
      map['usuario_id'] = Variable<String>(usuarioId.value);
    }
    if (creadoEn.present) {
      map['creado_en'] = Variable<DateTime>(creadoEn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PedidoAuditoriasCompanion(')
          ..write('id: $id, ')
          ..write('pedidoId: $pedidoId, ')
          ..write('accion: $accion, ')
          ..write('motivo: $motivo, ')
          ..write('usuarioId: $usuarioId, ')
          ..write('creadoEn: $creadoEn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$BantuDatabase extends GeneratedDatabase {
  _$BantuDatabase(QueryExecutor e) : super(e);
  $BantuDatabaseManager get managers => $BantuDatabaseManager(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $ProductosTable productos = $ProductosTable(this);
  late final $PedidosTable pedidos = $PedidosTable(this);
  late final $PedidoItemsTable pedidoItems = $PedidoItemsTable(this);
  late final $GastosTable gastos = $GastosTable(this);
  late final $CierresDiariosTable cierresDiarios = $CierresDiariosTable(this);
  late final $CierreAuditoriasTable cierreAuditorias = $CierreAuditoriasTable(
    this,
  );
  late final $PedidoAuditoriasTable pedidoAuditorias = $PedidoAuditoriasTable(
    this,
  );
  late final UsuarioDao usuarioDao = UsuarioDao(this as BantuDatabase);
  late final CategoriaDao categoriaDao = CategoriaDao(this as BantuDatabase);
  late final ProductoDao productoDao = ProductoDao(this as BantuDatabase);
  late final PedidoDao pedidoDao = PedidoDao(this as BantuDatabase);
  late final GastoDao gastoDao = GastoDao(this as BantuDatabase);
  late final CierreDao cierreDao = CierreDao(this as BantuDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    usuarios,
    categorias,
    productos,
    pedidos,
    pedidoItems,
    gastos,
    cierresDiarios,
    cierreAuditorias,
    pedidoAuditorias,
  ];
}

typedef $$UsuariosTableCreateCompanionBuilder = UsuariosCompanion Function({
  required String id,
  required String nombre,
  required String pinHash,
  required String pinSalt,
  required String rol,
  Value<bool> puedeVerTodosPedidos,
  Value<bool> activo,
  required DateTime creadoEn,
  required DateTime actualizadoEn,
  Value<int> rowid,
});
typedef $$UsuariosTableUpdateCompanionBuilder = UsuariosCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<String> pinHash,
  Value<String> pinSalt,
  Value<String> rol,
  Value<bool> puedeVerTodosPedidos,
  Value<bool> activo,
  Value<DateTime> creadoEn,
  Value<DateTime> actualizadoEn,
  Value<int> rowid,
});

final class $$UsuariosTableReferences
    extends BaseReferences<_$BantuDatabase, $UsuariosTable, Usuario> {
  $$UsuariosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PedidosTable, List<Pedido>> _pedidosRefsTable(
    _$BantuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pedidos,
    aliasName: 'usuarios__id__pedidos__empleado_id',
  );

  $$PedidosTableProcessedTableManager get pedidosRefs {
    final manager = $$PedidosTableTableManager(
      $_db,
      $_db.pedidos,
    ).filter((f) => f.empleadoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pedidosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GastosTable, List<Gasto>> _gastosRefsTable(
    _$BantuDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.gastos,
    aliasName: 'usuarios__id__gastos__usuario_id',
  );

  $$GastosTableProcessedTableManager get gastosRefs {
    final manager = $$GastosTableTableManager(
      $_db,
      $_db.gastos,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_gastosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$CierreAuditoriasTable, List<CierreAuditoria>>
  _cierreAuditoriasRefsTable(_$BantuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cierreAuditorias,
        aliasName: 'usuarios__id__cierre_auditorias__usuario_id',
      );

  $$CierreAuditoriasTableProcessedTableManager get cierreAuditoriasRefs {
    final manager = $$CierreAuditoriasTableTableManager(
      $_db,
      $_db.cierreAuditorias,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cierreAuditoriasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PedidoAuditoriasTable, List<PedidoAuditoria>>
  _pedidoAuditoriasRefsTable(_$BantuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pedidoAuditorias,
        aliasName: 'usuarios__id__pedido_auditorias__usuario_id',
      );

  $$PedidoAuditoriasTableProcessedTableManager get pedidoAuditoriasRefs {
    final manager = $$PedidoAuditoriasTableTableManager(
      $_db,
      $_db.pedidoAuditorias,
    ).filter((f) => f.usuarioId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pedidoAuditoriasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$UsuariosTableFilterComposer
    extends Composer<_$BantuDatabase, $UsuariosTable> {
  $$UsuariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get pinSalt => $composableBuilder(
    column: $table.pinSalt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get puedeVerTodosPedidos => $composableBuilder(
    column: $table.puedeVerTodosPedidos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pedidosRefs(
    Expression<bool> Function($$PedidosTableFilterComposer f) f,
  ) {
    final $$PedidosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.empleadoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableFilterComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> gastosRefs(
    Expression<bool> Function($$GastosTableFilterComposer f) f,
  ) {
    final $$GastosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastos,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosTableFilterComposer(
            $db: $db,
            $table: $db.gastos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> cierreAuditoriasRefs(
    Expression<bool> Function($$CierreAuditoriasTableFilterComposer f) f,
  ) {
    final $$CierreAuditoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cierreAuditorias,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierreAuditoriasTableFilterComposer(
            $db: $db,
            $table: $db.cierreAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pedidoAuditoriasRefs(
    Expression<bool> Function($$PedidoAuditoriasTableFilterComposer f) f,
  ) {
    final $$PedidoAuditoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoAuditorias,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoAuditoriasTableFilterComposer(
            $db: $db,
            $table: $db.pedidoAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableOrderingComposer
    extends Composer<_$BantuDatabase, $UsuariosTable> {
  $$UsuariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinHash => $composableBuilder(
    column: $table.pinHash,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get pinSalt => $composableBuilder(
    column: $table.pinSalt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rol => $composableBuilder(
    column: $table.rol,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get puedeVerTodosPedidos => $composableBuilder(
    column: $table.puedeVerTodosPedidos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UsuariosTableAnnotationComposer
    extends Composer<_$BantuDatabase, $UsuariosTable> {
  $$UsuariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get pinHash =>
      $composableBuilder(column: $table.pinHash, builder: (column) => column);

  GeneratedColumn<String> get pinSalt =>
      $composableBuilder(column: $table.pinSalt, builder: (column) => column);

  GeneratedColumn<String> get rol =>
      $composableBuilder(column: $table.rol, builder: (column) => column);

  GeneratedColumn<bool> get puedeVerTodosPedidos => $composableBuilder(
    column: $table.puedeVerTodosPedidos,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  Expression<T> pedidosRefs<T extends Object>(
    Expression<T> Function($$PedidosTableAnnotationComposer a) f,
  ) {
    final $$PedidosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.empleadoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> gastosRefs<T extends Object>(
    Expression<T> Function($$GastosTableAnnotationComposer a) f,
  ) {
    final $$GastosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.gastos,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GastosTableAnnotationComposer(
            $db: $db,
            $table: $db.gastos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> cierreAuditoriasRefs<T extends Object>(
    Expression<T> Function($$CierreAuditoriasTableAnnotationComposer a) f,
  ) {
    final $$CierreAuditoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cierreAuditorias,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierreAuditoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.cierreAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pedidoAuditoriasRefs<T extends Object>(
    Expression<T> Function($$PedidoAuditoriasTableAnnotationComposer a) f,
  ) {
    final $$PedidoAuditoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoAuditorias,
      getReferencedColumn: (t) => t.usuarioId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoAuditoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidoAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$UsuariosTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $UsuariosTable,
          Usuario,
          $$UsuariosTableFilterComposer,
          $$UsuariosTableOrderingComposer,
          $$UsuariosTableAnnotationComposer,
          $$UsuariosTableCreateCompanionBuilder,
          $$UsuariosTableUpdateCompanionBuilder,
          (Usuario, $$UsuariosTableReferences),
          Usuario,
          PrefetchHooks Function({
            bool pedidosRefs,
            bool gastosRefs,
            bool cierreAuditoriasRefs,
            bool pedidoAuditoriasRefs,
          })
        > {
  $$UsuariosTableTableManager(_$BantuDatabase db, $UsuariosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UsuariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UsuariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UsuariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> pinHash = const Value.absent(),
                Value<String> pinSalt = const Value.absent(),
                Value<String> rol = const Value.absent(),
                Value<bool> puedeVerTodosPedidos = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion(
                id: id,
                nombre: nombre,
                pinHash: pinHash,
                pinSalt: pinSalt,
                rol: rol,
                puedeVerTodosPedidos: puedeVerTodosPedidos,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                required String pinHash,
                required String pinSalt,
                required String rol,
                Value<bool> puedeVerTodosPedidos = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                required DateTime creadoEn,
                required DateTime actualizadoEn,
                Value<int> rowid = const Value.absent(),
              }) => UsuariosCompanion.insert(
                id: id,
                nombre: nombre,
                pinHash: pinHash,
                pinSalt: pinSalt,
                rol: rol,
                puedeVerTodosPedidos: puedeVerTodosPedidos,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UsuariosTable, Usuario>(table),
                  $$UsuariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pedidosRefs = false,
                gastosRefs = false,
                cierreAuditoriasRefs = false,
                pedidoAuditoriasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pedidosRefs) db.pedidos,
                    if (gastosRefs) db.gastos,
                    if (cierreAuditoriasRefs) db.cierreAuditorias,
                    if (pedidoAuditoriasRefs) db.pedidoAuditorias,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pedidosRefs)
                        await $_getPrefetchedDataByColumns<
                          Usuario,
                          $UsuariosTable,
                          Pedido,
                          $PedidosTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._pedidosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).pedidosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'empleado_id',
                          typedResults: items,
                        ),
                      if (gastosRefs)
                        await $_getPrefetchedDataByColumns<
                          Usuario,
                          $UsuariosTable,
                          Gasto,
                          $GastosTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._gastosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).gastosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'usuario_id',
                          typedResults: items,
                        ),
                      if (cierreAuditoriasRefs)
                        await $_getPrefetchedDataByColumns<
                          Usuario,
                          $UsuariosTable,
                          CierreAuditoria,
                          $CierreAuditoriasTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._cierreAuditoriasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).cierreAuditoriasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'usuario_id',
                          typedResults: items,
                        ),
                      if (pedidoAuditoriasRefs)
                        await $_getPrefetchedDataByColumns<
                          Usuario,
                          $UsuariosTable,
                          PedidoAuditoria,
                          $PedidoAuditoriasTable
                        >(
                          currentTable: table,
                          referencedTable: $$UsuariosTableReferences
                              ._pedidoAuditoriasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$UsuariosTableReferences(
                                db,
                                table,
                                p0,
                              ).pedidoAuditoriasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'usuario_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$UsuariosTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $UsuariosTable,
      Usuario,
      $$UsuariosTableFilterComposer,
      $$UsuariosTableOrderingComposer,
      $$UsuariosTableAnnotationComposer,
      $$UsuariosTableCreateCompanionBuilder,
      $$UsuariosTableUpdateCompanionBuilder,
      (Usuario, $$UsuariosTableReferences),
      Usuario,
      PrefetchHooks Function({
        bool pedidosRefs,
        bool gastosRefs,
        bool cierreAuditoriasRefs,
        bool pedidoAuditoriasRefs,
      })
    >;
typedef $$CategoriasTableCreateCompanionBuilder = CategoriasCompanion Function({
  required String id,
  required String nombre,
  Value<bool> activa,
  Value<int> orden,
  required DateTime creadoEn,
  Value<int> rowid,
});
typedef $$CategoriasTableUpdateCompanionBuilder = CategoriasCompanion Function({
  Value<String> id,
  Value<String> nombre,
  Value<bool> activa,
  Value<int> orden,
  Value<DateTime> creadoEn,
  Value<int> rowid,
});

final class $$CategoriasTableReferences
    extends BaseReferences<_$BantuDatabase, $CategoriasTable, Categoria> {
  $$CategoriasTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$ProductosTable, List<Producto>>
  _productosRefsTable(_$BantuDatabase db) => MultiTypedResultKey.fromTable(
    db.productos,
    aliasName: 'categorias__id__productos__categoria_id',
  );

  $$ProductosTableProcessedTableManager get productosRefs {
    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.categoriaId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_productosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CategoriasTableFilterComposer
    extends Composer<_$BantuDatabase, $CategoriasTable> {
  $$CategoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activa => $composableBuilder(
    column: $table.activa,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> productosRefs(
    Expression<bool> Function($$ProductosTableFilterComposer f) f,
  ) {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableOrderingComposer
    extends Composer<_$BantuDatabase, $CategoriasTable> {
  $$CategoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activa => $composableBuilder(
    column: $table.activa,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get orden => $composableBuilder(
    column: $table.orden,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CategoriasTableAnnotationComposer
    extends Composer<_$BantuDatabase, $CategoriasTable> {
  $$CategoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<bool> get activa =>
      $composableBuilder(column: $table.activa, builder: (column) => column);

  GeneratedColumn<int> get orden =>
      $composableBuilder(column: $table.orden, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  Expression<T> productosRefs<T extends Object>(
    Expression<T> Function($$ProductosTableAnnotationComposer a) f,
  ) {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.categoriaId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CategoriasTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $CategoriasTable,
          Categoria,
          $$CategoriasTableFilterComposer,
          $$CategoriasTableOrderingComposer,
          $$CategoriasTableAnnotationComposer,
          $$CategoriasTableCreateCompanionBuilder,
          $$CategoriasTableUpdateCompanionBuilder,
          (Categoria, $$CategoriasTableReferences),
          Categoria,
          PrefetchHooks Function({bool productosRefs})
        > {
  $$CategoriasTableTableManager(_$BantuDatabase db, $CategoriasTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CategoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CategoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CategoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<bool> activa = const Value.absent(),
                Value<int> orden = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CategoriasCompanion(
                id: id,
                nombre: nombre,
                activa: activa,
                orden: orden,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String nombre,
                Value<bool> activa = const Value.absent(),
                Value<int> orden = const Value.absent(),
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => CategoriasCompanion.insert(
                id: id,
                nombre: nombre,
                activa: activa,
                orden: orden,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CategoriasTable, Categoria>(table),
                  $$CategoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({productosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (productosRefs) db.productos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (productosRefs)
                    await $_getPrefetchedDataByColumns<
                      Categoria,
                      $CategoriasTable,
                      Producto,
                      $ProductosTable
                    >(
                      currentTable: table,
                      referencedTable: $$CategoriasTableReferences
                          ._productosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CategoriasTableReferences(
                            db,
                            table,
                            p0,
                          ).productosRefs,
                      currentColumn: 'id',
                      referencedColumn: 'categoria_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CategoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $CategoriasTable,
      Categoria,
      $$CategoriasTableFilterComposer,
      $$CategoriasTableOrderingComposer,
      $$CategoriasTableAnnotationComposer,
      $$CategoriasTableCreateCompanionBuilder,
      $$CategoriasTableUpdateCompanionBuilder,
      (Categoria, $$CategoriasTableReferences),
      Categoria,
      PrefetchHooks Function({bool productosRefs})
    >;
typedef $$ProductosTableCreateCompanionBuilder = ProductosCompanion Function({
  required String id,
  required String categoriaId,
  required String nombre,
  Value<String?> descripcion,
  required int precioLocal,
  Value<int?> precioLlevar,
  Value<int> costoEmpaque,
  required String estrategiaLlevar,
  Value<String?> imagenPath,
  Value<bool> activo,
  required DateTime creadoEn,
  required DateTime actualizadoEn,
  Value<int> rowid,
});
typedef $$ProductosTableUpdateCompanionBuilder = ProductosCompanion Function({
  Value<String> id,
  Value<String> categoriaId,
  Value<String> nombre,
  Value<String?> descripcion,
  Value<int> precioLocal,
  Value<int?> precioLlevar,
  Value<int> costoEmpaque,
  Value<String> estrategiaLlevar,
  Value<String?> imagenPath,
  Value<bool> activo,
  Value<DateTime> creadoEn,
  Value<DateTime> actualizadoEn,
  Value<int> rowid,
});

final class $$ProductosTableReferences
    extends BaseReferences<_$BantuDatabase, $ProductosTable, Producto> {
  $$ProductosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $CategoriasTable _categoriaIdTable(_$BantuDatabase db) =>
      db.categorias.createAlias('productos__categoria_id__categorias__id');

  $$CategoriasTableProcessedTableManager get categoriaId {
    final $_column = $_itemColumn<String>('categoria_id')!;

    final manager = $$CategoriasTableTableManager(
      $_db,
      $_db.categorias,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_categoriaIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PedidoItemsTable, List<PedidoItem>>
  _pedidoItemsRefsTable(_$BantuDatabase db) => MultiTypedResultKey.fromTable(
    db.pedidoItems,
    aliasName: 'productos__id__pedido_items__producto_id',
  );

  $$PedidoItemsTableProcessedTableManager get pedidoItemsRefs {
    final manager = $$PedidoItemsTableTableManager(
      $_db,
      $_db.pedidoItems,
    ).filter((f) => f.productoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pedidoItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ProductosTableFilterComposer
    extends Composer<_$BantuDatabase, $ProductosTable> {
  $$ProductosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioLocal => $composableBuilder(
    column: $table.precioLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioLlevar => $composableBuilder(
    column: $table.precioLlevar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estrategiaLlevar => $composableBuilder(
    column: $table.estrategiaLlevar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get imagenPath => $composableBuilder(
    column: $table.imagenPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$CategoriasTableFilterComposer get categoriaId {
    final $$CategoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableFilterComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pedidoItemsRefs(
    Expression<bool> Function($$PedidoItemsTableFilterComposer f) f,
  ) {
    final $$PedidoItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoItems,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoItemsTableFilterComposer(
            $db: $db,
            $table: $db.pedidoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableOrderingComposer
    extends Composer<_$BantuDatabase, $ProductosTable> {
  $$ProductosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioLocal => $composableBuilder(
    column: $table.precioLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioLlevar => $composableBuilder(
    column: $table.precioLlevar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estrategiaLlevar => $composableBuilder(
    column: $table.estrategiaLlevar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get imagenPath => $composableBuilder(
    column: $table.imagenPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get activo => $composableBuilder(
    column: $table.activo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$CategoriasTableOrderingComposer get categoriaId {
    final $$CategoriasTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableOrderingComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ProductosTableAnnotationComposer
    extends Composer<_$BantuDatabase, $ProductosTable> {
  $$ProductosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioLocal => $composableBuilder(
    column: $table.precioLocal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get precioLlevar => $composableBuilder(
    column: $table.precioLlevar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estrategiaLlevar => $composableBuilder(
    column: $table.estrategiaLlevar,
    builder: (column) => column,
  );

  GeneratedColumn<String> get imagenPath => $composableBuilder(
    column: $table.imagenPath,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get activo =>
      $composableBuilder(column: $table.activo, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get actualizadoEn => $composableBuilder(
    column: $table.actualizadoEn,
    builder: (column) => column,
  );

  $$CategoriasTableAnnotationComposer get categoriaId {
    final $$CategoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.categoriaId,
      referencedTable: $db.categorias,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CategoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.categorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pedidoItemsRefs<T extends Object>(
    Expression<T> Function($$PedidoItemsTableAnnotationComposer a) f,
  ) {
    final $$PedidoItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoItems,
      getReferencedColumn: (t) => t.productoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ProductosTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $ProductosTable,
          Producto,
          $$ProductosTableFilterComposer,
          $$ProductosTableOrderingComposer,
          $$ProductosTableAnnotationComposer,
          $$ProductosTableCreateCompanionBuilder,
          $$ProductosTableUpdateCompanionBuilder,
          (Producto, $$ProductosTableReferences),
          Producto,
          PrefetchHooks Function({bool categoriaId, bool pedidoItemsRefs})
        > {
  $$ProductosTableTableManager(_$BantuDatabase db, $ProductosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ProductosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ProductosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ProductosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> categoriaId = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String?> descripcion = const Value.absent(),
                Value<int> precioLocal = const Value.absent(),
                Value<int?> precioLlevar = const Value.absent(),
                Value<int> costoEmpaque = const Value.absent(),
                Value<String> estrategiaLlevar = const Value.absent(),
                Value<String?> imagenPath = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime> actualizadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ProductosCompanion(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                descripcion: descripcion,
                precioLocal: precioLocal,
                precioLlevar: precioLlevar,
                costoEmpaque: costoEmpaque,
                estrategiaLlevar: estrategiaLlevar,
                imagenPath: imagenPath,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String categoriaId,
                required String nombre,
                Value<String?> descripcion = const Value.absent(),
                required int precioLocal,
                Value<int?> precioLlevar = const Value.absent(),
                Value<int> costoEmpaque = const Value.absent(),
                required String estrategiaLlevar,
                Value<String?> imagenPath = const Value.absent(),
                Value<bool> activo = const Value.absent(),
                required DateTime creadoEn,
                required DateTime actualizadoEn,
                Value<int> rowid = const Value.absent(),
              }) => ProductosCompanion.insert(
                id: id,
                categoriaId: categoriaId,
                nombre: nombre,
                descripcion: descripcion,
                precioLocal: precioLocal,
                precioLlevar: precioLlevar,
                costoEmpaque: costoEmpaque,
                estrategiaLlevar: estrategiaLlevar,
                imagenPath: imagenPath,
                activo: activo,
                creadoEn: creadoEn,
                actualizadoEn: actualizadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ProductosTable, Producto>(table),
                  $$ProductosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({categoriaId = false, pedidoItemsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pedidoItemsRefs) db.pedidoItems,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (categoriaId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.categoriaId,
                            referencedTable: $$ProductosTableReferences
                                ._categoriaIdTable(db),
                            referencedColumn: $$ProductosTableReferences
                                ._categoriaIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pedidoItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Producto,
                          $ProductosTable,
                          PedidoItem,
                          $PedidoItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$ProductosTableReferences
                              ._pedidoItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$ProductosTableReferences(
                                db,
                                table,
                                p0,
                              ).pedidoItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'producto_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$ProductosTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $ProductosTable,
      Producto,
      $$ProductosTableFilterComposer,
      $$ProductosTableOrderingComposer,
      $$ProductosTableAnnotationComposer,
      $$ProductosTableCreateCompanionBuilder,
      $$ProductosTableUpdateCompanionBuilder,
      (Producto, $$ProductosTableReferences),
      Producto,
      PrefetchHooks Function({bool categoriaId, bool pedidoItemsRefs})
    >;
typedef $$PedidosTableCreateCompanionBuilder = PedidosCompanion Function({
  required String id,
  required String idempotenciaKey,
  required String empleadoId,
  required String fechaLocal,
  required String horaLocal,
  required DateTime creadoEn,
  required String modalidad,
  required String metodoPago,
  required String estado,
  required int subtotal,
  required int costoEmpaque,
  required int total,
  Value<String?> motivoAnulacion,
  Value<int> rowid,
});
typedef $$PedidosTableUpdateCompanionBuilder = PedidosCompanion Function({
  Value<String> id,
  Value<String> idempotenciaKey,
  Value<String> empleadoId,
  Value<String> fechaLocal,
  Value<String> horaLocal,
  Value<DateTime> creadoEn,
  Value<String> modalidad,
  Value<String> metodoPago,
  Value<String> estado,
  Value<int> subtotal,
  Value<int> costoEmpaque,
  Value<int> total,
  Value<String?> motivoAnulacion,
  Value<int> rowid,
});

final class $$PedidosTableReferences
    extends BaseReferences<_$BantuDatabase, $PedidosTable, Pedido> {
  $$PedidosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _empleadoIdTable(_$BantuDatabase db) =>
      db.usuarios.createAlias('pedidos__empleado_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get empleadoId {
    final $_column = $_itemColumn<String>('empleado_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_empleadoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$PedidoItemsTable, List<PedidoItem>>
  _pedidoItemsRefsTable(_$BantuDatabase db) => MultiTypedResultKey.fromTable(
    db.pedidoItems,
    aliasName: 'pedidos__id__pedido_items__pedido_id',
  );

  $$PedidoItemsTableProcessedTableManager get pedidoItemsRefs {
    final manager = $$PedidoItemsTableTableManager(
      $_db,
      $_db.pedidoItems,
    ).filter((f) => f.pedidoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pedidoItemsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$PedidoAuditoriasTable, List<PedidoAuditoria>>
  _pedidoAuditoriasRefsTable(_$BantuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.pedidoAuditorias,
        aliasName: 'pedidos__id__pedido_auditorias__pedido_id',
      );

  $$PedidoAuditoriasTableProcessedTableManager get pedidoAuditoriasRefs {
    final manager = $$PedidoAuditoriasTableTableManager(
      $_db,
      $_db.pedidoAuditorias,
    ).filter((f) => f.pedidoId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _pedidoAuditoriasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$PedidosTableFilterComposer
    extends Composer<_$BantuDatabase, $PedidosTable> {
  $$PedidosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get idempotenciaKey => $composableBuilder(
    column: $table.idempotenciaKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get horaLocal => $composableBuilder(
    column: $table.horaLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modalidad => $composableBuilder(
    column: $table.modalidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivoAnulacion => $composableBuilder(
    column: $table.motivoAnulacion,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get empleadoId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.empleadoId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> pedidoItemsRefs(
    Expression<bool> Function($$PedidoItemsTableFilterComposer f) f,
  ) {
    final $$PedidoItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoItems,
      getReferencedColumn: (t) => t.pedidoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoItemsTableFilterComposer(
            $db: $db,
            $table: $db.pedidoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> pedidoAuditoriasRefs(
    Expression<bool> Function($$PedidoAuditoriasTableFilterComposer f) f,
  ) {
    final $$PedidoAuditoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoAuditorias,
      getReferencedColumn: (t) => t.pedidoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoAuditoriasTableFilterComposer(
            $db: $db,
            $table: $db.pedidoAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PedidosTableOrderingComposer
    extends Composer<_$BantuDatabase, $PedidosTable> {
  $$PedidosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get idempotenciaKey => $composableBuilder(
    column: $table.idempotenciaKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaLocal => $composableBuilder(
    column: $table.horaLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modalidad => $composableBuilder(
    column: $table.modalidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotal => $composableBuilder(
    column: $table.subtotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get total => $composableBuilder(
    column: $table.total,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivoAnulacion => $composableBuilder(
    column: $table.motivoAnulacion,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get empleadoId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.empleadoId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidosTableAnnotationComposer
    extends Composer<_$BantuDatabase, $PedidosTable> {
  $$PedidosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get idempotenciaKey => $composableBuilder(
    column: $table.idempotenciaKey,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get horaLocal =>
      $composableBuilder(column: $table.horaLocal, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<String> get modalidad =>
      $composableBuilder(column: $table.modalidad, builder: (column) => column);

  GeneratedColumn<String> get metodoPago => $composableBuilder(
    column: $table.metodoPago,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<int> get subtotal =>
      $composableBuilder(column: $table.subtotal, builder: (column) => column);

  GeneratedColumn<int> get costoEmpaque => $composableBuilder(
    column: $table.costoEmpaque,
    builder: (column) => column,
  );

  GeneratedColumn<int> get total =>
      $composableBuilder(column: $table.total, builder: (column) => column);

  GeneratedColumn<String> get motivoAnulacion => $composableBuilder(
    column: $table.motivoAnulacion,
    builder: (column) => column,
  );

  $$UsuariosTableAnnotationComposer get empleadoId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.empleadoId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> pedidoItemsRefs<T extends Object>(
    Expression<T> Function($$PedidoItemsTableAnnotationComposer a) f,
  ) {
    final $$PedidoItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoItems,
      getReferencedColumn: (t) => t.pedidoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidoItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> pedidoAuditoriasRefs<T extends Object>(
    Expression<T> Function($$PedidoAuditoriasTableAnnotationComposer a) f,
  ) {
    final $$PedidoAuditoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pedidoAuditorias,
      getReferencedColumn: (t) => t.pedidoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidoAuditoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidoAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$PedidosTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $PedidosTable,
          Pedido,
          $$PedidosTableFilterComposer,
          $$PedidosTableOrderingComposer,
          $$PedidosTableAnnotationComposer,
          $$PedidosTableCreateCompanionBuilder,
          $$PedidosTableUpdateCompanionBuilder,
          (Pedido, $$PedidosTableReferences),
          Pedido,
          PrefetchHooks Function({
            bool empleadoId,
            bool pedidoItemsRefs,
            bool pedidoAuditoriasRefs,
          })
        > {
  $$PedidosTableTableManager(_$BantuDatabase db, $PedidosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> idempotenciaKey = const Value.absent(),
                Value<String> empleadoId = const Value.absent(),
                Value<String> fechaLocal = const Value.absent(),
                Value<String> horaLocal = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<String> modalidad = const Value.absent(),
                Value<String> metodoPago = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<int> subtotal = const Value.absent(),
                Value<int> costoEmpaque = const Value.absent(),
                Value<int> total = const Value.absent(),
                Value<String?> motivoAnulacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PedidosCompanion(
                id: id,
                idempotenciaKey: idempotenciaKey,
                empleadoId: empleadoId,
                fechaLocal: fechaLocal,
                horaLocal: horaLocal,
                creadoEn: creadoEn,
                modalidad: modalidad,
                metodoPago: metodoPago,
                estado: estado,
                subtotal: subtotal,
                costoEmpaque: costoEmpaque,
                total: total,
                motivoAnulacion: motivoAnulacion,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String idempotenciaKey,
                required String empleadoId,
                required String fechaLocal,
                required String horaLocal,
                required DateTime creadoEn,
                required String modalidad,
                required String metodoPago,
                required String estado,
                required int subtotal,
                required int costoEmpaque,
                required int total,
                Value<String?> motivoAnulacion = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PedidosCompanion.insert(
                id: id,
                idempotenciaKey: idempotenciaKey,
                empleadoId: empleadoId,
                fechaLocal: fechaLocal,
                horaLocal: horaLocal,
                creadoEn: creadoEn,
                modalidad: modalidad,
                metodoPago: metodoPago,
                estado: estado,
                subtotal: subtotal,
                costoEmpaque: costoEmpaque,
                total: total,
                motivoAnulacion: motivoAnulacion,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PedidosTable, Pedido>(table),
                  $$PedidosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                empleadoId = false,
                pedidoItemsRefs = false,
                pedidoAuditoriasRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pedidoItemsRefs) db.pedidoItems,
                    if (pedidoAuditoriasRefs) db.pedidoAuditorias,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (empleadoId) {
                          state = state.withJoin(
                            currentTable: table,
                            currentColumn: table.empleadoId,
                            referencedTable: $$PedidosTableReferences
                                ._empleadoIdTable(db),
                            referencedColumn: $$PedidosTableReferences
                                ._empleadoIdTable(db)
                                .id,
                          ) as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pedidoItemsRefs)
                        await $_getPrefetchedDataByColumns<
                          Pedido,
                          $PedidosTable,
                          PedidoItem,
                          $PedidoItemsTable
                        >(
                          currentTable: table,
                          referencedTable: $$PedidosTableReferences
                              ._pedidoItemsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PedidosTableReferences(
                                db,
                                table,
                                p0,
                              ).pedidoItemsRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pedido_id',
                          typedResults: items,
                        ),
                      if (pedidoAuditoriasRefs)
                        await $_getPrefetchedDataByColumns<
                          Pedido,
                          $PedidosTable,
                          PedidoAuditoria,
                          $PedidoAuditoriasTable
                        >(
                          currentTable: table,
                          referencedTable: $$PedidosTableReferences
                              ._pedidoAuditoriasRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$PedidosTableReferences(
                                db,
                                table,
                                p0,
                              ).pedidoAuditoriasRefs,
                          currentColumn: 'id',
                          referencedColumn: 'pedido_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$PedidosTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $PedidosTable,
      Pedido,
      $$PedidosTableFilterComposer,
      $$PedidosTableOrderingComposer,
      $$PedidosTableAnnotationComposer,
      $$PedidosTableCreateCompanionBuilder,
      $$PedidosTableUpdateCompanionBuilder,
      (Pedido, $$PedidosTableReferences),
      Pedido,
      PrefetchHooks Function({
        bool empleadoId,
        bool pedidoItemsRefs,
        bool pedidoAuditoriasRefs,
      })
    >;
typedef $$PedidoItemsTableCreateCompanionBuilder =
    PedidoItemsCompanion Function({
      required String id,
      required String pedidoId,
      Value<String?> productoId,
      required String nombreProducto,
      required String categoriaNombre,
      required int cantidad,
      required String modalidad,
      required int precioUnitario,
      required int costoEmpaqueUnitario,
      required int subtotalItem,
      required int totalItem,
      Value<int> rowid,
    });
typedef $$PedidoItemsTableUpdateCompanionBuilder =
    PedidoItemsCompanion Function({
      Value<String> id,
      Value<String> pedidoId,
      Value<String?> productoId,
      Value<String> nombreProducto,
      Value<String> categoriaNombre,
      Value<int> cantidad,
      Value<String> modalidad,
      Value<int> precioUnitario,
      Value<int> costoEmpaqueUnitario,
      Value<int> subtotalItem,
      Value<int> totalItem,
      Value<int> rowid,
    });

final class $$PedidoItemsTableReferences
    extends BaseReferences<_$BantuDatabase, $PedidoItemsTable, PedidoItem> {
  $$PedidoItemsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $PedidosTable _pedidoIdTable(_$BantuDatabase db) =>
      db.pedidos.createAlias('pedido_items__pedido_id__pedidos__id');

  $$PedidosTableProcessedTableManager get pedidoId {
    final $_column = $_itemColumn<String>('pedido_id')!;

    final manager = $$PedidosTableTableManager(
      $_db,
      $_db.pedidos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pedidoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $ProductosTable _productoIdTable(_$BantuDatabase db) =>
      db.productos.createAlias('pedido_items__producto_id__productos__id');

  $$ProductosTableProcessedTableManager? get productoId {
    final $_column = $_itemColumn<String>('producto_id');
    if ($_column == null) return null;
    final manager = $$ProductosTableTableManager(
      $_db,
      $_db.productos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_productoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PedidoItemsTableFilterComposer
    extends Composer<_$BantuDatabase, $PedidoItemsTable> {
  $$PedidoItemsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoriaNombre => $composableBuilder(
    column: $table.categoriaNombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modalidad => $composableBuilder(
    column: $table.modalidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get costoEmpaqueUnitario => $composableBuilder(
    column: $table.costoEmpaqueUnitario,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get subtotalItem => $composableBuilder(
    column: $table.subtotalItem,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalItem => $composableBuilder(
    column: $table.totalItem,
    builder: (column) => ColumnFilters(column),
  );

  $$PedidosTableFilterComposer get pedidoId {
    final $$PedidosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableFilterComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableFilterComposer get productoId {
    final $$ProductosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableFilterComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoItemsTableOrderingComposer
    extends Composer<_$BantuDatabase, $PedidoItemsTable> {
  $$PedidoItemsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoriaNombre => $composableBuilder(
    column: $table.categoriaNombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modalidad => $composableBuilder(
    column: $table.modalidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get costoEmpaqueUnitario => $composableBuilder(
    column: $table.costoEmpaqueUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get subtotalItem => $composableBuilder(
    column: $table.subtotalItem,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalItem => $composableBuilder(
    column: $table.totalItem,
    builder: (column) => ColumnOrderings(column),
  );

  $$PedidosTableOrderingComposer get pedidoId {
    final $$PedidosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableOrderingComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableOrderingComposer get productoId {
    final $$ProductosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableOrderingComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoItemsTableAnnotationComposer
    extends Composer<_$BantuDatabase, $PedidoItemsTable> {
  $$PedidoItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombreProducto => $composableBuilder(
    column: $table.nombreProducto,
    builder: (column) => column,
  );

  GeneratedColumn<String> get categoriaNombre => $composableBuilder(
    column: $table.categoriaNombre,
    builder: (column) => column,
  );

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<String> get modalidad =>
      $composableBuilder(column: $table.modalidad, builder: (column) => column);

  GeneratedColumn<int> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<int> get costoEmpaqueUnitario => $composableBuilder(
    column: $table.costoEmpaqueUnitario,
    builder: (column) => column,
  );

  GeneratedColumn<int> get subtotalItem => $composableBuilder(
    column: $table.subtotalItem,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalItem =>
      $composableBuilder(column: $table.totalItem, builder: (column) => column);

  $$PedidosTableAnnotationComposer get pedidoId {
    final $$PedidosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$ProductosTableAnnotationComposer get productoId {
    final $$ProductosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.productoId,
      referencedTable: $db.productos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ProductosTableAnnotationComposer(
            $db: $db,
            $table: $db.productos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoItemsTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $PedidoItemsTable,
          PedidoItem,
          $$PedidoItemsTableFilterComposer,
          $$PedidoItemsTableOrderingComposer,
          $$PedidoItemsTableAnnotationComposer,
          $$PedidoItemsTableCreateCompanionBuilder,
          $$PedidoItemsTableUpdateCompanionBuilder,
          (PedidoItem, $$PedidoItemsTableReferences),
          PedidoItem,
          PrefetchHooks Function({bool pedidoId, bool productoId})
        > {
  $$PedidoItemsTableTableManager(_$BantuDatabase db, $PedidoItemsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidoItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidoItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidoItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pedidoId = const Value.absent(),
                Value<String?> productoId = const Value.absent(),
                Value<String> nombreProducto = const Value.absent(),
                Value<String> categoriaNombre = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<String> modalidad = const Value.absent(),
                Value<int> precioUnitario = const Value.absent(),
                Value<int> costoEmpaqueUnitario = const Value.absent(),
                Value<int> subtotalItem = const Value.absent(),
                Value<int> totalItem = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PedidoItemsCompanion(
                id: id,
                pedidoId: pedidoId,
                productoId: productoId,
                nombreProducto: nombreProducto,
                categoriaNombre: categoriaNombre,
                cantidad: cantidad,
                modalidad: modalidad,
                precioUnitario: precioUnitario,
                costoEmpaqueUnitario: costoEmpaqueUnitario,
                subtotalItem: subtotalItem,
                totalItem: totalItem,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pedidoId,
                Value<String?> productoId = const Value.absent(),
                required String nombreProducto,
                required String categoriaNombre,
                required int cantidad,
                required String modalidad,
                required int precioUnitario,
                required int costoEmpaqueUnitario,
                required int subtotalItem,
                required int totalItem,
                Value<int> rowid = const Value.absent(),
              }) => PedidoItemsCompanion.insert(
                id: id,
                pedidoId: pedidoId,
                productoId: productoId,
                nombreProducto: nombreProducto,
                categoriaNombre: categoriaNombre,
                cantidad: cantidad,
                modalidad: modalidad,
                precioUnitario: precioUnitario,
                costoEmpaqueUnitario: costoEmpaqueUnitario,
                subtotalItem: subtotalItem,
                totalItem: totalItem,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PedidoItemsTable, PedidoItem>(table),
                  $$PedidoItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pedidoId = false, productoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pedidoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pedidoId,
                        referencedTable: $$PedidoItemsTableReferences
                            ._pedidoIdTable(db),
                        referencedColumn: $$PedidoItemsTableReferences
                            ._pedidoIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (productoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.productoId,
                        referencedTable: $$PedidoItemsTableReferences
                            ._productoIdTable(db),
                        referencedColumn: $$PedidoItemsTableReferences
                            ._productoIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PedidoItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $PedidoItemsTable,
      PedidoItem,
      $$PedidoItemsTableFilterComposer,
      $$PedidoItemsTableOrderingComposer,
      $$PedidoItemsTableAnnotationComposer,
      $$PedidoItemsTableCreateCompanionBuilder,
      $$PedidoItemsTableUpdateCompanionBuilder,
      (PedidoItem, $$PedidoItemsTableReferences),
      PedidoItem,
      PrefetchHooks Function({bool pedidoId, bool productoId})
    >;
typedef $$GastosTableCreateCompanionBuilder = GastosCompanion Function({
  required String id,
  required String descripcion,
  required int valor,
  required String fechaLocal,
  required String horaLocal,
  Value<String?> categoria,
  Value<String?> observaciones,
  required String usuarioId,
  required DateTime creadoEn,
  Value<int> rowid,
});
typedef $$GastosTableUpdateCompanionBuilder = GastosCompanion Function({
  Value<String> id,
  Value<String> descripcion,
  Value<int> valor,
  Value<String> fechaLocal,
  Value<String> horaLocal,
  Value<String?> categoria,
  Value<String?> observaciones,
  Value<String> usuarioId,
  Value<DateTime> creadoEn,
  Value<int> rowid,
});

final class $$GastosTableReferences
    extends BaseReferences<_$BantuDatabase, $GastosTable, Gasto> {
  $$GastosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $UsuariosTable _usuarioIdTable(_$BantuDatabase db) =>
      db.usuarios.createAlias('gastos__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GastosTableFilterComposer
    extends Composer<_$BantuDatabase, $GastosTable> {
  $$GastosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get horaLocal => $composableBuilder(
    column: $table.horaLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosTableOrderingComposer
    extends Composer<_$BantuDatabase, $GastosTable> {
  $$GastosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valor => $composableBuilder(
    column: $table.valor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get horaLocal => $composableBuilder(
    column: $table.horaLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get categoria => $composableBuilder(
    column: $table.categoria,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosTableAnnotationComposer
    extends Composer<_$BantuDatabase, $GastosTable> {
  $$GastosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get valor =>
      $composableBuilder(column: $table.valor, builder: (column) => column);

  GeneratedColumn<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get horaLocal =>
      $composableBuilder(column: $table.horaLocal, builder: (column) => column);

  GeneratedColumn<String> get categoria =>
      $composableBuilder(column: $table.categoria, builder: (column) => column);

  GeneratedColumn<String> get observaciones => $composableBuilder(
    column: $table.observaciones,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GastosTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $GastosTable,
          Gasto,
          $$GastosTableFilterComposer,
          $$GastosTableOrderingComposer,
          $$GastosTableAnnotationComposer,
          $$GastosTableCreateCompanionBuilder,
          $$GastosTableUpdateCompanionBuilder,
          (Gasto, $$GastosTableReferences),
          Gasto,
          PrefetchHooks Function({bool usuarioId})
        > {
  $$GastosTableTableManager(_$BantuDatabase db, $GastosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GastosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GastosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GastosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<int> valor = const Value.absent(),
                Value<String> fechaLocal = const Value.absent(),
                Value<String> horaLocal = const Value.absent(),
                Value<String?> categoria = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GastosCompanion(
                id: id,
                descripcion: descripcion,
                valor: valor,
                fechaLocal: fechaLocal,
                horaLocal: horaLocal,
                categoria: categoria,
                observaciones: observaciones,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String descripcion,
                required int valor,
                required String fechaLocal,
                required String horaLocal,
                Value<String?> categoria = const Value.absent(),
                Value<String?> observaciones = const Value.absent(),
                required String usuarioId,
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => GastosCompanion.insert(
                id: id,
                descripcion: descripcion,
                valor: valor,
                fechaLocal: fechaLocal,
                horaLocal: horaLocal,
                categoria: categoria,
                observaciones: observaciones,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GastosTable, Gasto>(table),
                  $$GastosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (usuarioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.usuarioId,
                        referencedTable: $$GastosTableReferences
                            ._usuarioIdTable(db),
                        referencedColumn: $$GastosTableReferences
                            ._usuarioIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$GastosTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $GastosTable,
      Gasto,
      $$GastosTableFilterComposer,
      $$GastosTableOrderingComposer,
      $$GastosTableAnnotationComposer,
      $$GastosTableCreateCompanionBuilder,
      $$GastosTableUpdateCompanionBuilder,
      (Gasto, $$GastosTableReferences),
      Gasto,
      PrefetchHooks Function({bool usuarioId})
    >;
typedef $$CierresDiariosTableCreateCompanionBuilder =
    CierresDiariosCompanion Function({
      required String id,
      required String fechaLocal,
      required String estado,
      required int totalPedidos,
      required int totalVentas,
      required int totalEfectivo,
      required int totalTransferencia,
      required int totalLlevar,
      required int totalLocal,
      required int totalEgresos,
      required int saldoNeto,
      Value<String?> cerradoPor,
      required DateTime creadoEn,
      Value<DateTime?> cerradoEn,
      Value<int> rowid,
    });
typedef $$CierresDiariosTableUpdateCompanionBuilder =
    CierresDiariosCompanion Function({
      Value<String> id,
      Value<String> fechaLocal,
      Value<String> estado,
      Value<int> totalPedidos,
      Value<int> totalVentas,
      Value<int> totalEfectivo,
      Value<int> totalTransferencia,
      Value<int> totalLlevar,
      Value<int> totalLocal,
      Value<int> totalEgresos,
      Value<int> saldoNeto,
      Value<String?> cerradoPor,
      Value<DateTime> creadoEn,
      Value<DateTime?> cerradoEn,
      Value<int> rowid,
    });

final class $$CierresDiariosTableReferences
    extends
        BaseReferences<_$BantuDatabase, $CierresDiariosTable, CierresDiario> {
  $$CierresDiariosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$CierreAuditoriasTable, List<CierreAuditoria>>
  _cierreAuditoriasRefsTable(_$BantuDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.cierreAuditorias,
        aliasName: 'cierres_diarios__id__cierre_auditorias__cierre_id',
      );

  $$CierreAuditoriasTableProcessedTableManager get cierreAuditoriasRefs {
    final manager = $$CierreAuditoriasTableTableManager(
      $_db,
      $_db.cierreAuditorias,
    ).filter((f) => f.cierreId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _cierreAuditoriasRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$CierresDiariosTableFilterComposer
    extends Composer<_$BantuDatabase, $CierresDiariosTable> {
  $$CierresDiariosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalPedidos => $composableBuilder(
    column: $table.totalPedidos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalVentas => $composableBuilder(
    column: $table.totalVentas,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalEfectivo => $composableBuilder(
    column: $table.totalEfectivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalTransferencia => $composableBuilder(
    column: $table.totalTransferencia,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLlevar => $composableBuilder(
    column: $table.totalLlevar,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalLocal => $composableBuilder(
    column: $table.totalLocal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get totalEgresos => $composableBuilder(
    column: $table.totalEgresos,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get saldoNeto => $composableBuilder(
    column: $table.saldoNeto,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get cerradoPor => $composableBuilder(
    column: $table.cerradoPor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get cerradoEn => $composableBuilder(
    column: $table.cerradoEn,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> cierreAuditoriasRefs(
    Expression<bool> Function($$CierreAuditoriasTableFilterComposer f) f,
  ) {
    final $$CierreAuditoriasTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cierreAuditorias,
      getReferencedColumn: (t) => t.cierreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierreAuditoriasTableFilterComposer(
            $db: $db,
            $table: $db.cierreAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CierresDiariosTableOrderingComposer
    extends Composer<_$BantuDatabase, $CierresDiariosTable> {
  $$CierresDiariosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalPedidos => $composableBuilder(
    column: $table.totalPedidos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalVentas => $composableBuilder(
    column: $table.totalVentas,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalEfectivo => $composableBuilder(
    column: $table.totalEfectivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalTransferencia => $composableBuilder(
    column: $table.totalTransferencia,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLlevar => $composableBuilder(
    column: $table.totalLlevar,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalLocal => $composableBuilder(
    column: $table.totalLocal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalEgresos => $composableBuilder(
    column: $table.totalEgresos,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get saldoNeto => $composableBuilder(
    column: $table.saldoNeto,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get cerradoPor => $composableBuilder(
    column: $table.cerradoPor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get cerradoEn => $composableBuilder(
    column: $table.cerradoEn,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CierresDiariosTableAnnotationComposer
    extends Composer<_$BantuDatabase, $CierresDiariosTable> {
  $$CierresDiariosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fechaLocal => $composableBuilder(
    column: $table.fechaLocal,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<int> get totalPedidos => $composableBuilder(
    column: $table.totalPedidos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalVentas => $composableBuilder(
    column: $table.totalVentas,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalEfectivo => $composableBuilder(
    column: $table.totalEfectivo,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalTransferencia => $composableBuilder(
    column: $table.totalTransferencia,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLlevar => $composableBuilder(
    column: $table.totalLlevar,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalLocal => $composableBuilder(
    column: $table.totalLocal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get totalEgresos => $composableBuilder(
    column: $table.totalEgresos,
    builder: (column) => column,
  );

  GeneratedColumn<int> get saldoNeto =>
      $composableBuilder(column: $table.saldoNeto, builder: (column) => column);

  GeneratedColumn<String> get cerradoPor => $composableBuilder(
    column: $table.cerradoPor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  GeneratedColumn<DateTime> get cerradoEn =>
      $composableBuilder(column: $table.cerradoEn, builder: (column) => column);

  Expression<T> cierreAuditoriasRefs<T extends Object>(
    Expression<T> Function($$CierreAuditoriasTableAnnotationComposer a) f,
  ) {
    final $$CierreAuditoriasTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.cierreAuditorias,
      getReferencedColumn: (t) => t.cierreId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierreAuditoriasTableAnnotationComposer(
            $db: $db,
            $table: $db.cierreAuditorias,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$CierresDiariosTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $CierresDiariosTable,
          CierresDiario,
          $$CierresDiariosTableFilterComposer,
          $$CierresDiariosTableOrderingComposer,
          $$CierresDiariosTableAnnotationComposer,
          $$CierresDiariosTableCreateCompanionBuilder,
          $$CierresDiariosTableUpdateCompanionBuilder,
          (CierresDiario, $$CierresDiariosTableReferences),
          CierresDiario,
          PrefetchHooks Function({bool cierreAuditoriasRefs})
        > {
  $$CierresDiariosTableTableManager(
    _$BantuDatabase db,
    $CierresDiariosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CierresDiariosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CierresDiariosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CierresDiariosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> fechaLocal = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<int> totalPedidos = const Value.absent(),
                Value<int> totalVentas = const Value.absent(),
                Value<int> totalEfectivo = const Value.absent(),
                Value<int> totalTransferencia = const Value.absent(),
                Value<int> totalLlevar = const Value.absent(),
                Value<int> totalLocal = const Value.absent(),
                Value<int> totalEgresos = const Value.absent(),
                Value<int> saldoNeto = const Value.absent(),
                Value<String?> cerradoPor = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<DateTime?> cerradoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CierresDiariosCompanion(
                id: id,
                fechaLocal: fechaLocal,
                estado: estado,
                totalPedidos: totalPedidos,
                totalVentas: totalVentas,
                totalEfectivo: totalEfectivo,
                totalTransferencia: totalTransferencia,
                totalLlevar: totalLlevar,
                totalLocal: totalLocal,
                totalEgresos: totalEgresos,
                saldoNeto: saldoNeto,
                cerradoPor: cerradoPor,
                creadoEn: creadoEn,
                cerradoEn: cerradoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String fechaLocal,
                required String estado,
                required int totalPedidos,
                required int totalVentas,
                required int totalEfectivo,
                required int totalTransferencia,
                required int totalLlevar,
                required int totalLocal,
                required int totalEgresos,
                required int saldoNeto,
                Value<String?> cerradoPor = const Value.absent(),
                required DateTime creadoEn,
                Value<DateTime?> cerradoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CierresDiariosCompanion.insert(
                id: id,
                fechaLocal: fechaLocal,
                estado: estado,
                totalPedidos: totalPedidos,
                totalVentas: totalVentas,
                totalEfectivo: totalEfectivo,
                totalTransferencia: totalTransferencia,
                totalLlevar: totalLlevar,
                totalLocal: totalLocal,
                totalEgresos: totalEgresos,
                saldoNeto: saldoNeto,
                cerradoPor: cerradoPor,
                creadoEn: creadoEn,
                cerradoEn: cerradoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CierresDiariosTable, CierresDiario>(table),
                  $$CierresDiariosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cierreAuditoriasRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (cierreAuditoriasRefs) db.cierreAuditorias,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (cierreAuditoriasRefs)
                    await $_getPrefetchedDataByColumns<
                      CierresDiario,
                      $CierresDiariosTable,
                      CierreAuditoria,
                      $CierreAuditoriasTable
                    >(
                      currentTable: table,
                      referencedTable: $$CierresDiariosTableReferences
                          ._cierreAuditoriasRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CierresDiariosTableReferences(
                            db,
                            table,
                            p0,
                          ).cierreAuditoriasRefs,
                      currentColumn: 'id',
                      referencedColumn: 'cierre_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$CierresDiariosTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $CierresDiariosTable,
      CierresDiario,
      $$CierresDiariosTableFilterComposer,
      $$CierresDiariosTableOrderingComposer,
      $$CierresDiariosTableAnnotationComposer,
      $$CierresDiariosTableCreateCompanionBuilder,
      $$CierresDiariosTableUpdateCompanionBuilder,
      (CierresDiario, $$CierresDiariosTableReferences),
      CierresDiario,
      PrefetchHooks Function({bool cierreAuditoriasRefs})
    >;
typedef $$CierreAuditoriasTableCreateCompanionBuilder =
    CierreAuditoriasCompanion Function({
      required String id,
      required String cierreId,
      required String motivo,
      required String valoresAntes,
      required String valoresDespues,
      required String usuarioId,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$CierreAuditoriasTableUpdateCompanionBuilder =
    CierreAuditoriasCompanion Function({
      Value<String> id,
      Value<String> cierreId,
      Value<String> motivo,
      Value<String> valoresAntes,
      Value<String> valoresDespues,
      Value<String> usuarioId,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

final class $$CierreAuditoriasTableReferences
    extends
        BaseReferences<
          _$BantuDatabase,
          $CierreAuditoriasTable,
          CierreAuditoria
        > {
  $$CierreAuditoriasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CierresDiariosTable _cierreIdTable(_$BantuDatabase db) => db
      .cierresDiarios
      .createAlias('cierre_auditorias__cierre_id__cierres_diarios__id');

  $$CierresDiariosTableProcessedTableManager get cierreId {
    final $_column = $_itemColumn<String>('cierre_id')!;

    final manager = $$CierresDiariosTableTableManager(
      $_db,
      $_db.cierresDiarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_cierreIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _usuarioIdTable(_$BantuDatabase db) =>
      db.usuarios.createAlias('cierre_auditorias__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$CierreAuditoriasTableFilterComposer
    extends Composer<_$BantuDatabase, $CierreAuditoriasTable> {
  $$CierreAuditoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valoresAntes => $composableBuilder(
    column: $table.valoresAntes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get valoresDespues => $composableBuilder(
    column: $table.valoresDespues,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$CierresDiariosTableFilterComposer get cierreId {
    final $$CierresDiariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cierreId,
      referencedTable: $db.cierresDiarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierresDiariosTableFilterComposer(
            $db: $db,
            $table: $db.cierresDiarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CierreAuditoriasTableOrderingComposer
    extends Composer<_$BantuDatabase, $CierreAuditoriasTable> {
  $$CierreAuditoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valoresAntes => $composableBuilder(
    column: $table.valoresAntes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get valoresDespues => $composableBuilder(
    column: $table.valoresDespues,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$CierresDiariosTableOrderingComposer get cierreId {
    final $$CierresDiariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cierreId,
      referencedTable: $db.cierresDiarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierresDiariosTableOrderingComposer(
            $db: $db,
            $table: $db.cierresDiarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CierreAuditoriasTableAnnotationComposer
    extends Composer<_$BantuDatabase, $CierreAuditoriasTable> {
  $$CierreAuditoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<String> get valoresAntes => $composableBuilder(
    column: $table.valoresAntes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get valoresDespues => $composableBuilder(
    column: $table.valoresDespues,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$CierresDiariosTableAnnotationComposer get cierreId {
    final $$CierresDiariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.cierreId,
      referencedTable: $db.cierresDiarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CierresDiariosTableAnnotationComposer(
            $db: $db,
            $table: $db.cierresDiarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$CierreAuditoriasTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $CierreAuditoriasTable,
          CierreAuditoria,
          $$CierreAuditoriasTableFilterComposer,
          $$CierreAuditoriasTableOrderingComposer,
          $$CierreAuditoriasTableAnnotationComposer,
          $$CierreAuditoriasTableCreateCompanionBuilder,
          $$CierreAuditoriasTableUpdateCompanionBuilder,
          (CierreAuditoria, $$CierreAuditoriasTableReferences),
          CierreAuditoria,
          PrefetchHooks Function({bool cierreId, bool usuarioId})
        > {
  $$CierreAuditoriasTableTableManager(
    _$BantuDatabase db,
    $CierreAuditoriasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CierreAuditoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CierreAuditoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CierreAuditoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> cierreId = const Value.absent(),
                Value<String> motivo = const Value.absent(),
                Value<String> valoresAntes = const Value.absent(),
                Value<String> valoresDespues = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CierreAuditoriasCompanion(
                id: id,
                cierreId: cierreId,
                motivo: motivo,
                valoresAntes: valoresAntes,
                valoresDespues: valoresDespues,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String cierreId,
                required String motivo,
                required String valoresAntes,
                required String valoresDespues,
                required String usuarioId,
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => CierreAuditoriasCompanion.insert(
                id: id,
                cierreId: cierreId,
                motivo: motivo,
                valoresAntes: valoresAntes,
                valoresDespues: valoresDespues,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CierreAuditoriasTable, CierreAuditoria>(table),
                  $$CierreAuditoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({cierreId = false, usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (cierreId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.cierreId,
                        referencedTable: $$CierreAuditoriasTableReferences
                            ._cierreIdTable(db),
                        referencedColumn: $$CierreAuditoriasTableReferences
                            ._cierreIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (usuarioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.usuarioId,
                        referencedTable: $$CierreAuditoriasTableReferences
                            ._usuarioIdTable(db),
                        referencedColumn: $$CierreAuditoriasTableReferences
                            ._usuarioIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$CierreAuditoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $CierreAuditoriasTable,
      CierreAuditoria,
      $$CierreAuditoriasTableFilterComposer,
      $$CierreAuditoriasTableOrderingComposer,
      $$CierreAuditoriasTableAnnotationComposer,
      $$CierreAuditoriasTableCreateCompanionBuilder,
      $$CierreAuditoriasTableUpdateCompanionBuilder,
      (CierreAuditoria, $$CierreAuditoriasTableReferences),
      CierreAuditoria,
      PrefetchHooks Function({bool cierreId, bool usuarioId})
    >;
typedef $$PedidoAuditoriasTableCreateCompanionBuilder =
    PedidoAuditoriasCompanion Function({
      required String id,
      required String pedidoId,
      required String accion,
      required String motivo,
      required String usuarioId,
      required DateTime creadoEn,
      Value<int> rowid,
    });
typedef $$PedidoAuditoriasTableUpdateCompanionBuilder =
    PedidoAuditoriasCompanion Function({
      Value<String> id,
      Value<String> pedidoId,
      Value<String> accion,
      Value<String> motivo,
      Value<String> usuarioId,
      Value<DateTime> creadoEn,
      Value<int> rowid,
    });

final class $$PedidoAuditoriasTableReferences
    extends
        BaseReferences<
          _$BantuDatabase,
          $PedidoAuditoriasTable,
          PedidoAuditoria
        > {
  $$PedidoAuditoriasTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $PedidosTable _pedidoIdTable(_$BantuDatabase db) =>
      db.pedidos.createAlias('pedido_auditorias__pedido_id__pedidos__id');

  $$PedidosTableProcessedTableManager get pedidoId {
    final $_column = $_itemColumn<String>('pedido_id')!;

    final manager = $$PedidosTableTableManager(
      $_db,
      $_db.pedidos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_pedidoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $UsuariosTable _usuarioIdTable(_$BantuDatabase db) =>
      db.usuarios.createAlias('pedido_auditorias__usuario_id__usuarios__id');

  $$UsuariosTableProcessedTableManager get usuarioId {
    final $_column = $_itemColumn<String>('usuario_id')!;

    final manager = $$UsuariosTableTableManager(
      $_db,
      $_db.usuarios,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_usuarioIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PedidoAuditoriasTableFilterComposer
    extends Composer<_$BantuDatabase, $PedidoAuditoriasTable> {
  $$PedidoAuditoriasTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnFilters(column),
  );

  $$PedidosTableFilterComposer get pedidoId {
    final $$PedidosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableFilterComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableFilterComposer get usuarioId {
    final $$UsuariosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableFilterComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoAuditoriasTableOrderingComposer
    extends Composer<_$BantuDatabase, $PedidoAuditoriasTable> {
  $$PedidoAuditoriasTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get accion => $composableBuilder(
    column: $table.accion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get motivo => $composableBuilder(
    column: $table.motivo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get creadoEn => $composableBuilder(
    column: $table.creadoEn,
    builder: (column) => ColumnOrderings(column),
  );

  $$PedidosTableOrderingComposer get pedidoId {
    final $$PedidosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableOrderingComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableOrderingComposer get usuarioId {
    final $$UsuariosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableOrderingComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoAuditoriasTableAnnotationComposer
    extends Composer<_$BantuDatabase, $PedidoAuditoriasTable> {
  $$PedidoAuditoriasTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get accion =>
      $composableBuilder(column: $table.accion, builder: (column) => column);

  GeneratedColumn<String> get motivo =>
      $composableBuilder(column: $table.motivo, builder: (column) => column);

  GeneratedColumn<DateTime> get creadoEn =>
      $composableBuilder(column: $table.creadoEn, builder: (column) => column);

  $$PedidosTableAnnotationComposer get pedidoId {
    final $$PedidosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.pedidoId,
      referencedTable: $db.pedidos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PedidosTableAnnotationComposer(
            $db: $db,
            $table: $db.pedidos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$UsuariosTableAnnotationComposer get usuarioId {
    final $$UsuariosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.usuarioId,
      referencedTable: $db.usuarios,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$UsuariosTableAnnotationComposer(
            $db: $db,
            $table: $db.usuarios,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PedidoAuditoriasTableTableManager
    extends
        RootTableManager<
          _$BantuDatabase,
          $PedidoAuditoriasTable,
          PedidoAuditoria,
          $$PedidoAuditoriasTableFilterComposer,
          $$PedidoAuditoriasTableOrderingComposer,
          $$PedidoAuditoriasTableAnnotationComposer,
          $$PedidoAuditoriasTableCreateCompanionBuilder,
          $$PedidoAuditoriasTableUpdateCompanionBuilder,
          (PedidoAuditoria, $$PedidoAuditoriasTableReferences),
          PedidoAuditoria,
          PrefetchHooks Function({bool pedidoId, bool usuarioId})
        > {
  $$PedidoAuditoriasTableTableManager(
    _$BantuDatabase db,
    $PedidoAuditoriasTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PedidoAuditoriasTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PedidoAuditoriasTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PedidoAuditoriasTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> pedidoId = const Value.absent(),
                Value<String> accion = const Value.absent(),
                Value<String> motivo = const Value.absent(),
                Value<String> usuarioId = const Value.absent(),
                Value<DateTime> creadoEn = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PedidoAuditoriasCompanion(
                id: id,
                pedidoId: pedidoId,
                accion: accion,
                motivo: motivo,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String pedidoId,
                required String accion,
                required String motivo,
                required String usuarioId,
                required DateTime creadoEn,
                Value<int> rowid = const Value.absent(),
              }) => PedidoAuditoriasCompanion.insert(
                id: id,
                pedidoId: pedidoId,
                accion: accion,
                motivo: motivo,
                usuarioId: usuarioId,
                creadoEn: creadoEn,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$PedidoAuditoriasTable, PedidoAuditoria>(table),
                  $$PedidoAuditoriasTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({pedidoId = false, usuarioId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (pedidoId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.pedidoId,
                        referencedTable: $$PedidoAuditoriasTableReferences
                            ._pedidoIdTable(db),
                        referencedColumn: $$PedidoAuditoriasTableReferences
                            ._pedidoIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (usuarioId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.usuarioId,
                        referencedTable: $$PedidoAuditoriasTableReferences
                            ._usuarioIdTable(db),
                        referencedColumn: $$PedidoAuditoriasTableReferences
                            ._usuarioIdTable(db)
                            .id,
                      ) as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PedidoAuditoriasTableProcessedTableManager =
    ProcessedTableManager<
      _$BantuDatabase,
      $PedidoAuditoriasTable,
      PedidoAuditoria,
      $$PedidoAuditoriasTableFilterComposer,
      $$PedidoAuditoriasTableOrderingComposer,
      $$PedidoAuditoriasTableAnnotationComposer,
      $$PedidoAuditoriasTableCreateCompanionBuilder,
      $$PedidoAuditoriasTableUpdateCompanionBuilder,
      (PedidoAuditoria, $$PedidoAuditoriasTableReferences),
      PedidoAuditoria,
      PrefetchHooks Function({bool pedidoId, bool usuarioId})
    >;

class $BantuDatabaseManager {
  final _$BantuDatabase _db;
  $BantuDatabaseManager(this._db);
  $$UsuariosTableTableManager get usuarios =>
      $$UsuariosTableTableManager(_db, _db.usuarios);
  $$CategoriasTableTableManager get categorias =>
      $$CategoriasTableTableManager(_db, _db.categorias);
  $$ProductosTableTableManager get productos =>
      $$ProductosTableTableManager(_db, _db.productos);
  $$PedidosTableTableManager get pedidos =>
      $$PedidosTableTableManager(_db, _db.pedidos);
  $$PedidoItemsTableTableManager get pedidoItems =>
      $$PedidoItemsTableTableManager(_db, _db.pedidoItems);
  $$GastosTableTableManager get gastos =>
      $$GastosTableTableManager(_db, _db.gastos);
  $$CierresDiariosTableTableManager get cierresDiarios =>
      $$CierresDiariosTableTableManager(_db, _db.cierresDiarios);
  $$CierreAuditoriasTableTableManager get cierreAuditorias =>
      $$CierreAuditoriasTableTableManager(_db, _db.cierreAuditorias);
  $$PedidoAuditoriasTableTableManager get pedidoAuditorias =>
      $$PedidoAuditoriasTableTableManager(_db, _db.pedidoAuditorias);
}
