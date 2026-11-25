# Progreso

## Estado actual

Fase 2 completada: primer arranque, PIN, sesión segura, administración de empleados y `GuardiaRol`. `dart analyze` sin issues y `flutter test` en verde (45 pruebas). Siguiente: Fase 3 (menú y categorías). Se agregó `codemagic.yaml` con el workflow `ios-adhoc` para generar `.ipa`; requiere integración de App Store Connect y dispositivos registrados.

## Convención por fase

Cada fase termina con:

```bash
dart run build_runner build --force-jit
dart analyze
flutter test
```

y una actualización de este archivo.

## Fases

- [x] Fase 0 — scaffold, dependencias, codegen y documentación base.
- [x] Fase 1 — dominio, esquema Drift, DAOs/repositorios y pruebas.
- [x] Fase 2 — usuarios, PIN, sesión y permisos.
- [ ] Fase 3 — menú y categorías con CRUD admin.
- [ ] Fase 4 — pedidos, cálculo financiero e idempotencia.
- [ ] Fase 5 — historial y filtros.
- [ ] Fase 6 — cierres diarios y auditoría.
- [ ] Fase 7 — finanzas y gastos.
- [ ] Fase 8 — exportación XLSX/PDF.
- [ ] Fase 9 — UI final, accesibilidad y responsive.
- [ ] Fase 10 — documentación final y builds.

## Decisiones registradas

- Proyecto en `poryecto_Bantú/`, paquete `bantu`, ID `com.bantu.restaurante`.
- Persistencia Drift/SQLite; sin Firebase ni red.
- Primer arranque crea administrador con PIN.
- Precio de llevar configurable por producto.
- Gastos sin método de pago; solo afectan balance global, no caja.
- Dinero `int` COP; snapshots históricos en pedidos.

## Deudas / pendientes

- iOS no se compila en Windows; usar el workflow `ios-adhoc` de `codemagic.yaml` en Codemagic.
- `flutter analyze` falla por LSP con la ruta acentuada; usar `dart analyze`.
- Codegen requiere `--force-jit` en Windows; `--delete-conflicting-outputs` ya no tiene efecto.
- Menú, pedidos, cierres, finanzas y exportación aún no tienen pantalla.
