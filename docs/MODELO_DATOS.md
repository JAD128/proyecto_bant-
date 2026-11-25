# Modelo de datos

Base de datos SQLite local gestionada por Drift. Esquema inicial: versión 1.

## Tablas

| Tabla | Propósito | Campos clave |
|---|---|---|
| `usuarios` | Acceso y roles | `id`, `nombre`, `pinHash`, `salt`, `rol`, `puedeVerTodosPedidos`, `activo` |
| `categorias` | Categorías del menú | `id`, `nombre` único, `activa`, `orden` |
| `productos` | Catálogo | `id`, `categoriaId`, `nombre`, `precioLocal`, `precioLlevar`, `costoEmpaque`, `estrategiaLlevar`, `imagenPath`, `activo` |
| `pedidos` | Comprobantes confirmados | `id`, `idempotenciaKey` única, `fechaLocal`, `horaLocal`, `empleadoId`, `modalidad`, `metodoPago`, `estado`, `subtotal`, `costoEmpaque`, `total` |
| `pedido_items` | Copia histórica de cada línea | `id`, `pedidoId`, `productoId`, `nombreProducto`, `categoriaNombre`, `cantidad`, `precioUnitario`, `costoEmpaqueUnitario`, `totalItem` |
| `gastos` | Egresos manuales | `id`, `descripcion`, `valor`, `fechaLocal`, `horaLocal`, `categoria`, `observaciones`, `usuarioId` |
| `cierres_diarios` | Snapshot por fecha | `id`, `fechaLocal` única, `estado`, totales, `cerradoPor` |
| `cierre_auditorias` | Trazabilidad de correcciones | `id`, `cierreId`, `motivo`, `valoresAntes`, `valoresDespues`, `usuarioId` |
| `pedido_auditorias` | Anulaciones/correcciones | `id`, `pedidoId`, `accion`, `motivo`, `usuarioId` |

## Relaciones

- `productos.categoriaId → categorias.id` con `restrict`.
- `pedidos.empleadoId → usuarios.id` con `restrict`.
- `pedido_items.pedidoId → pedidos.id` con `restrict`.
- `pedido_items.productoId → productos.id` nullable con `restrict` para no perder la referencia si el producto sigue existiendo.
- `gastos.usuarioId → usuarios.id` con `restrict`.
- `cierre_auditorias.cierreId → cierres_diarios.id` con `restrict`.

## Integridad

- IDs UUID en texto.
- Dinero como `int` COP.
- Fechas de negocio en `fechaLocal` (`YYYY-MM-DD`) y `horaLocal` (`HH:mm`); `creadoEn` se guarda como `DateTime`.
- No se eliminan productos o categorías referenciados: se desactivan.
- Los ítems de pedido no releen el catálogo: guardan snapshot.

## Migraciones

Los cambios de esquema deben aumentar `schemaVersion` y generar/verificar migración con Drift. Nunca se debe alterar una base de datos ya publicada sin migración probada.
