# Progreso

## Estado actual

Fase 9 completada: UI final, accesibilidad y responsive. `ContenidoResponsive` limita el ancho a 960, centra y aplica padding de 16 en móvil y 24 en tablet; se aplicó al cuerpo de las diez pantallas funcionales. `PanelPagina` usa `NavigationBar` bajo 900 y `NavigationRail` extendido desde 900, con los mismos destinos y guardias. Se añadieron etiquetas `Semantics`/tooltips y objetivos táctiles mínimos, sin tocar servicios, providers, esquema Drift ni `pubspec.yaml`. El texto del PDF se convierte a ASCII para Helvetica; el XLSX y los nombres de archivo no cambian. `dart analyze` sin issues y `flutter test` en verde (117 pruebas). Siguiente: Fase 10 (documentación final y builds). Se mantiene `codemagic.yaml` con el workflow `ios-sideloadly`, que genera un IPA sin firma para Sideloadly.

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
- [x] Fase 7 — finanzas y gastos.
- [x] Fase 8 — exportación XLSX/PDF.
- [x] Fase 9 — UI final, accesibilidad y responsive.
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
- La Fase 7 tampoco tocó tablas Drift ni `pubspec.yaml`: reutiliza `GastoRepositorio`, `PedidoRepositorio`, `CalculadorFinanzas` y `ServicioPermisos`.
- Consultar el resumen y los gastos exige `Accion.verFinanzas`; registrar y actualizar gastos exige `Accion.registrarGasto`.
- El rango `desde`/`hasta` usa fechas locales `YYYY-MM-DD` validadas con `Validadores`; un rango invertido se rechaza con `ArgumentError`.
- Los gastos no tienen método de pago y nunca se eliminan: solo se registran y se actualizan. El concepto se guarda recortado en `descripcion`, con valor entero positivo; `id`, `horaLocal`, `usuarioId` y `creadoEn` se conservan al editar.
- El resumen filtra pedidos y gastos por el mismo rango; los pedidos anulados no aportan ingresos y los gastos solo reducen `saldoNeto`, nunca `efectivoEnCaja`.
- La Fase 8 tampoco tocó tablas Drift ni `pubspec.yaml`: reutiliza los servicios de historial y finanzas y el repositorio de cierres.
- Exportar exige `Accion.exportarInformes`; los pedidos se obtienen con `ServicioHistorial.consultar`, por lo que un empleado autorizado solo exporta los suyos salvo `verTodosPedidos`.
- El rango `desde`/`hasta` se valida con `Validadores` y con los servicios de historial/finanzas; los cierres se filtran por `fechaLocal` sin recalcular snapshots.
- Los archivos se nombran `bantu_<tipo>_<desde>_<hasta>.<formato>`; un extremo ausente se sustituye por `todo`.
- El XLSX lleva encabezados en español, cantidades numéricas y los ítems de cada pedido como texto con cantidad, modalidad, precio y total. El PDF lleva título Bantú, rango, resumen financiero y la tabla de datos.
- La Fase 9 no tocó servicios financieros, repositorios ni `pubspec.yaml`: `ContenidoResponsive` es solo presentación y `_textoPdf` convierte a ASCII únicamente el texto del PDF. El XLSX y los nombres de archivo conservan los caracteres originales.

## Deudas / pendientes

- iOS no se compila en Windows; usar el workflow `ios-sideloadly` de `codemagic.yaml` en Codemagic.
- `flutter analyze` falla por LSP con la ruta acentuada; usar `dart analyze`.
- Codegen requiere `--force-jit` en Windows; `--delete-conflicting-outputs` ya no tiene efecto.
- La exportación guarda el archivo localmente; compartirlo desde la app queda para una fase posterior.
- La generación de PDF usa la fuente Helvetica incluida en `pdf`; no se descargan fuentes en tiempo de ejecución. `_textoPdf` ya elimina tildes, `ñ` y signos de apertura del texto, pero `pdf-3.12.0` imprime el aviso Type1 de forma incondicional en debug al construir Helvetica; el archivo se genera correctamente.
- Accesibilidad: validar con TalkBack/VoiceOver y escalado de texto en dispositivo.
