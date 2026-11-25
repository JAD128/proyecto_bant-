# Arquitectura

## Capas

```text
lib/presentacion  → lib/estado → lib/dominio → lib/datos/repositorios → lib/datos/bd
                          ↘ lib/exportacion ↗
```

- `presentacion`: pantallas y widgets. No ejecuta SQL ni calcula totales.
- `estado`: `ChangeNotifier` con `provider`. Expone operaciones a la UI.
- `dominio`: entidades, enums, validadores y servicios puros. No depende de Flutter ni de Drift.
- `datos`: tablas Drift, DAOs, implementaciones de repositorios y sesión.
- `exportacion`: generación de XLSX y PDF a partir de datos ya calculados.
- `configuracion`: inyección de dependencias y rutas.

## Regla de dependencia

La UI depende de providers; los providers dependen de servicios o repositorios de dominio; los repositorios definen interfaces y la implementación Drift se inyecta. Para incorporar sincronización en la nube se agregará una nueva implementación de repositorio y un servicio de sincronización sin tocar pantallas.

## Persistencia

Drift se eligió sobre `sqflite` directo porque ofrece consultas tipadas, DAOs, migraciones, transacciones y detección de errores en compile time. El costo es ejecutar:

```bash
dart run build_runner build --force-jit
```

después de cualquier cambio en `lib/datos/bd/tablas.dart` o en la clase de base de datos.

## Sesión y seguridad

- PIN hasheado con PBKDF2-HMAC-SHA256 y salt aleatorio.
- `flutter_secure_storage` guarda solo el ID de usuario activo y la marca de configuración inicial.
- Los permisos se validan en `dominio/servicios/servicio_permisos.dart` y otra vez en operaciones sensibles de repositorios.

## Verificación

Tras cada fase: codegen si aplica, `dart analyze`, `flutter test`, y actualizar `docs/PROGRESO.md`.
