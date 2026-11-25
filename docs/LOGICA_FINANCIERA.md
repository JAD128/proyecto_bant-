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

Cada carrito genera una `idempotenciaKey`. La base de datos la declara única. Confirmar dos veces el mismo carrito no crea dos pedidos.

## Cierres diarios

- Un cierre por `fechaLocal`.
- Solo cuenta pedidos `confirmado` y gastos de esa fecha.
- Al cerrar se guarda un snapshot de totales.
- Una corrección crea un registro en `cierre_auditorias` con motivo, usuario y valores antes/después. El cierre original no se sobrescribe.
- Los informes de una fecha cerrada usan el snapshot; los de un día abierto calculan en vivo.
