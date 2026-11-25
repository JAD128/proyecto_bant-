# Bantú

Aplicación móvil Flutter/Dart para la administración interna del restaurante Bantú: menú, pedidos, historial, cierres diarios, finanzas y exportación de informes. Funciona 100% sin conexión; la información se conserva en SQLite local.

## Requisitos

- Flutter 3.47.6 / Dart 3.13.5 o superiores compatibles.
- Android e iOS. La compilación de iOS requiere macOS/Xcode o Codemagic.

## Configuración

```bash
flutter pub get
dart run build_runner build --force-jit
dart analyze
flutter test
flutter run
```

`--force-jit` evita un fallo AOT de `build_runner` en Windows. Se usa `dart analyze` en vez de `flutter analyze` porque este último falla en el LSP con la ruta acentuada del proyecto. `pdf` está fijado a `>=3.12.0 <3.13.0` por incompatibilidad con `excel ^4.0.6`.

Para un solo archivo de pruebas:

```bash
flutter test test/dominio/calculador_pedido_test.dart
```

Para generar el APK de depuración:

```bash
flutter build apk --debug
```

## iOS ad hoc en Codemagic

`codemagic.yaml` define el workflow `ios-adhoc` para generar un `.ipa` instalable en iPhones registrados.

Antes de ejecutarlo:

1. Registrar el App ID `com.bantu.restaurante` y los UDID de los iPhones de prueba en Apple Developer.
2. Guardar en Codemagic una integración de App Store Connect con el nombre `APP_STORE_CONNECT_API_KEY`.
3. Ejecutar el workflow `ios-adhoc`.

El `.ipa` queda en `build/ios/ipa/`. El workflow usa `distribution_type: ad_hoc`, así que el perfil de aprovisionamiento debe incluir cada dispositivo. Para TestFlight, cambiar `distribution_type` a `app_store`.

## Estado

El proyecto se construye por fases. El estado actual está en `docs/PROGRESO.md`.

## Documentación

- `docs/ARQUITECTURA.md`: capas, dependencias y extensibilidad.
- `docs/MODELO_DATOS.md`: tablas, relaciones e integridad.
- `docs/LOGICA_FINANCIERA.md`: precios, empaques, caja, balance y cierres.
- `docs/FLUJOS_Y_PERMISOS.md`: navegación y permisos por rol.
- `docs/PROGRESO.md`: fases entregadas y pendientes.

## Decisiones clave

- Persistencia con Drift sobre SQLite, con codegen vía `build_runner`.
- Dinero como `int` COP. Nunca `double`.
- Los pedidos históricos guardan copias de producto y precio.
- El primer arranque crea al administrador; los empleados son creados por él.
- Los gastos no tienen método de pago: afectan el balance global, no el efectivo en caja.
