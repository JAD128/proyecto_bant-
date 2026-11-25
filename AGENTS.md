# AGENTS.md — Bantú (Flutter)

App Flutter/Dart offline para administración interna del restaurante Bantú. Android e iOS. No es una app de clientes ni de domicilios.

## Antes de trabajar

Lee `docs/PROGRESO.md`: fase actual, decisiones y deudas. Actualízalo al cerrar cada avance.

## Comandos

```bash
flutter pub get
dart run build_runner build --force-jit
dart analyze
flutter test
flutter test test/dominio/calculador_pedido_test.dart
flutter build apk --debug
flutter build ios --release --no-codesign   # solo macOS/Xcode
```

Tras tocar `pubspec.yaml` o cualquier tabla Drift: `flutter pub get`, codegen, `dart analyze`, `flutter test`, en ese orden. No hay CI.

En este entorno Windows, `dart run build_runner build --delete-conflicting-outputs` falla al escribir `.dart_tool/build/entrypoint/build.dart.aot`; usar siempre `--force-jit`. Tampoco usar `flutter analyze`: falla con `FormatException: Unexpected end of input` en el LSP por la ruta con acento; `dart analyze` verifica el mismo código. `pdf` está fijado a `>=3.12.0 <3.13.0` por incompatibilidad con `excel ^4.0.6`.

## Arquitectura

```text
Pantallas → Providers → Servicios de dominio → Repositorios → Drift/SQLite
```

La UI nunca ejecuta SQL. Los repositorios son interfaces; la implementación Drift se inyecta en `lib/configuracion/dependencias.dart`. Para futura sincronización se agregará otra implementación, no se reescribirán pantallas.

## Decisiones financieras verificadas

- Todo el dinero es `int` COP; nunca `double`.
- `subtotal = Σ(cantidad × precioUnitario)`; `costoEmpaque = Σ(cantidad × costoEmpaqueUnitario)`; `total = subtotal + costoEmpaque`.
- Modalidad local: precio normal, sin empaque. Modalidad llevar: `precioFijo` (empaque ya incluido, no se suma) o `baseMasEmpaque` (precio local + empaque). Nunca ambos.
- Cada ítem de pedido guarda nombre, categoría, precio y empaque al momento de confirmar; cambios del menú no alteran el histórico.
- `idempotenciaKey` única evita pedidos duplicados.
- Efectivo en caja = ingresos en efectivo. Los gastos no registran método de pago y solo afectan el balance global.
- `saldoNeto = ingresos − egresos`.
- Cierres diarios: snapshot por `fechaLocal`; una vez cerrados se corrigen con auditoría, nunca sobrescribiendo.
- No se borran productos/categorías referenciados: se desactivan.

## Convenciones

- Código, nombres de archivos y documentación en español, con `snake_case` en Dart.
- Primer arranque: asistente crea administrador con PIN; sesión en `flutter_secure_storage`.
- Empleado ve solo sus pedidos salvo `puedeVerTodosPedidos`.
- Permisos se validan en servicios/repositorios, no solo en la UI.
- No hacer commit salvo petición explícita.
