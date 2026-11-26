# Lógica financiera

## Dinero

Todos los valores se almacenan y calculan como `int` en pesos colombianos. No se usa `double` para evitar errores de punto flotante. La presentación usa formato `es_CO` sin decimales.

## Precio de pedido

Para cada línea:

```text
subtotalItem = cantidad × precioUnitario
costoEmpaqueItem = cantidad × costoEmpaqueUnitario
totalItem = subtotalItem + costoEmpaqueItem
```

```text
subtotalPedido = Σ subtotalItem
costoEmpaquePedido = Σ costoEmpaqueItem
totalPedido = subtotalPedido + costoEmpaquePedido
```

### Consumo en establecimiento

- `precioUnitario = producto.precioLocal`
- `costoEmpaqueUnitario = 0`

### Para llevar

- `estrategiaLlevar = precioFijo`: `precioUnitario = producto.precioLlevar`, `costoEmpaqueUnitario = 0`. El empaque ya está incluido; no se cobra dos veces.
- `estrategiaLlevar = baseMasEmpaque`: `precioUnitario = producto.precioLocal`, `costoEmpaqueUnitario = producto.costoEmpaque`.

Si `precioLlevar` es `null` con estrategia `precioFijo`, el pedido se rechaza.

### Modalidad del pedido

La modalidad se define por el carrito completo: si cualquier línea tiene `ModalidadPedido.llevar`, el pedido se guarda como `llevar`; si todas son `local`, se guarda como `local`. Cada `pedido_items` conserva la modalidad de su línea y los precios calculados para esa línea, aunque el pedido global sea `llevar` por otra línea.

## Ingresos, egresos y balance

```text
ingresos = Σ total de pedidos confirmados
egresos = Σ valor de gastos
saldoNeto = ingresos − egresos
```

Desgloses: efectivo, transferencia, para llevar y consumo en establecimiento.

### Caja

```text
efectivoEnCaja = Σ total de pedidos confirmados pagados en efectivo
```

Los gastos no tienen método de pago y no se restan de la caja; solo afectan `saldoNeto`. Esta decisión es explícita para evitar interpretaciones contradictorias.

## Histórico

Cada `pedido_items` guarda nombre, categoría, precio unitario y empaque unitario vigentes al confirmar. Editar o desactivar un producto nunca cambia pedidos anteriores.

## Duplicados

`PedidoProveedor` genera una `idempotenciaKey` al iniciar un pedido y la renueva al reiniciar; después de confirmar se prepara un pedido nuevo con otra clave. `ServicioPedidos` valida la clave, consulta `PedidoRepositorio.obtenerPorIdempotenciaKey` antes de guardar y, si ya existe, devuelve ese pedido sin calcular ni insertar otro. La columna `idempotencia_key` es `UNIQUE`, de modo que un intento directo de inserción duplicada falla en la base de datos. Confirmar dos veces el mismo carrito no crea dos pedidos.

## Cierres diarios

- Existe un único cierre por `fechaLocal`. `ServicioCierres.cerrarDia` rechaza un segundo cierre para la misma fecha con `StateError('Ya existe un cierre para esa fecha.')`; nunca se sobrescribe sin auditoría.
- Solo cuentan los pedidos `confirmado` y los gastos de esa fecha. `CalculadorFinanzas.calcular` produce `totalPedidos`, `totalVentas`, `totalEfectivo`, `totalTransferencia`, `totalLlevar`, `totalLocal`, `totalEgresos` y `saldoNeto`.
- Al cerrar se guarda un snapshot con `estado: cerrado`, `cerradoPor`, `creadoEn` y `cerradoEn`, y se devuelve el registro releído por fecha.
- Cerrar y corregir requiere administrador con `Accion.cerrarDia`. Consultar cierres y auditorías acepta `Accion.verFinanzas` o `Accion.cerrarDia`.
- Una corrección recalcula el snapshot con los datos vigentes conservando `id`, `fechaLocal`, `creadoEn`, `cerradoEn` y `cerradoPor`. Antes de `actualizar` se llama a `auditar`, guardando `CierreAuditoria` con motivo, usuario y `valoresAntes`/`valoresDespues` como `jsonEncode` de un mapa simple de totales, sin secretos.
- El original queda preservado en `cierre_auditorias`: la corrección no pierde el snapshot previo ni simula que nunca existió.
- Los informes de una fecha cerrada usan el snapshot; los de un día abierto calculan en vivo.
