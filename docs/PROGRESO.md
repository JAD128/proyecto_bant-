# Progreso

## Estado actual

Fase 6 completada: cierres diarios con snapshot por `fechaLocal` y correcciones auditadas. `ServicioCierres` valida permisos, calcula totales con `CalculadorFinanzas`, rechaza duplicados y registra `CierreAuditoria` antes de actualizar. UI y provider conectados en el panel. `dart analyze` sin issues y `flutter test` en verde (88 pruebas). Siguiente: Fase 7 (finanzas y gastos). Se agregó `codemagic.yaml` con el workflow `ios-sideloadly`, que genera un IPA sin firma para Sideloadly.

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
- [x] Fase 3 — menú y categorías con CRUD admin.
- [x] Fase 4 — pedidos, cálculo financiero e idempotencia.
- [x] Fase 5 — historial y filtros.
- [x] Fase 6 — cierres diarios y auditoría.
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
- En el menú, `baseMasEmpaque` guarda `precioLlevar = null` (acepta 0 y lo normaliza); `precioFijo` exige un precio de llevar.
- Si cualquier línea del carrito es `llevar`, el pedido se guarda como `llevar`; si no, como `local`. Cada línea conserva su propia modalidad y precios.
- `idempotenciaKey` la genera `PedidoProveedor` al iniciar un pedido; el servicio la consulta antes de guardar y devuelve el pedido existente si ya está registrada.
- Anular pedidos es una acción exclusiva de administrador; el repo registra auditoría con motivo y usuario.
- El historial valida `verHistorial` y `verTodosPedidos` en el servicio: empleados sin ese permiso solo ven sus propios pedidos y no pueden filtrar por otro empleado.
- Los filtros del historial se combinan (rango local, empleado, estado y modalidad); el detalle muestra únicamente los snapshots guardados.
- La Fase 5 no requirió codegen: no se tocaron tablas Drift ni `pubspec.yaml`.
- La Fase 6 tampoco tocó tablas Drift ni `pubspec.yaml`: reutiliza `CierreRepositorio`, `PedidoRepositorio`, `GastoRepositorio` y `CalculadorFinanzas`.
- Existe un único cierre por `fechaLocal`; `cerrarDia` rechaza duplicados con `StateError` y nunca sobrescribe sin auditoría.
- Una corrección recalcula el snapshot con los datos vigentes de esa fecha y llama a `auditar` antes de `actualizar`. `valoresAntes` y `valoresDespues` son `jsonEncode` de un mapa simple; el original queda preservado en la auditoría, no se pierde.
- Cerrar y corregir exige administrador con `Accion.cerrarDia`; consultar cierres y auditorías acepta `Accion.verFinanzas` o `Accion.cerrarDia`.

## Deudas / pendientes

- iOS no se compila en Windows; usar el workflow `ios-sideloadly` de `codemagic.yaml` en Codemagic.
- `flutter analyze` falla por LSP con la ruta acentuada; usar `dart analyze`.
- Codegen requiere `--force-jit` en Windows; `--delete-conflicting-outputs` ya no tiene efecto.
- Finanzas y exportación permanecen como tarjetas deshabilitadas en el panel; se implementan en las fases 7 y 8.
