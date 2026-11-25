# Flujos y permisos

## Roles

### Administrador

Acceso completo: menú (crear/editar/desactivar), categorías, todos los pedidos, historial, cierres, finanzas, gastos, exportación y configuración de usuarios.

### Empleado

Puede consultar el menú disponible, armar pedidos, registrar pago, confirmar y consultar historial. Por defecto ve solo sus pedidos. El administrador puede activar `puedeVerTodosPedidos` para autorizar la vista global. No puede modificar catálogo, finanzas, cierres ni exportar.

## Flujos

### Primer arranque

1. No existe administrador.
2. Pantalla `ConfiguracionInicial`: nombre + PIN de 4 a 6 dígitos + confirmación.
3. Se guarda hash PBKDF2 y salt.
4. Se marca la configuración inicial como completa.

### Inicio de sesión

1. Usuario escribe nombre y PIN.
2. Se recalcula el hash con el salt guardado.
3. Si coincide, se guarda el ID de usuario en almacenamiento seguro.
4. La app abre el panel según el rol.

### Nuevo pedido

1. Empleado ve productos activos.
2. Selecciona productos, cantidades y modalidad.
3. La app calcula subtotal, empaque y total en vivo.
4. Elige método de pago (efectivo o transferencia).
5. Confirma: se valida rol, datos e `idempotenciaKey`; se guarda pedido con snapshot de ítems.

### Cierre diario

1. Admin abre el “cajón” de una fecha.
2. Consulta pedidos y totales de esa fecha.
3. Confirma el cierre: se guarda snapshot.
4. Correcciones posteriores se registran como auditoría.

## Aplicación de permisos

- `GuardiaRol` evita abrir rutas no autorizadas.
- `ServicioPermisos` es la fuente de verdad.
- Los repositorios con operaciones sensibles validan el usuario activo antes de escribir.

## Exportación

Solo el administrador puede generar XLSX/PDF para un día o periodo. Los archivos se escriben en el directorio de documentos de la app y se comparten con `share_plus`.
