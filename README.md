## mi-app-astro — Documentación rápida

Este README resume el comportamiento recientemente implementado alrededor de la "Tasa (BCV)", cómo se persiste en la base de datos, los cambios en la UI y cómo probarlo localmente.

### Resumen del comportamiento BCV
- Cuando en el formulario de `Crear documento` la `Moneda` es `VES` (BCV): la aplicación cliente realiza automáticamente una consulta al endpoint `/api/bcv` para obtener la "Tasa (BCV)".
- El input `Tasa (BCV)` se rellena con el valor devuelto por la API y queda bloqueado para edición manual.
- Al guardar el documento, el payload incluirá `bcv_rate` con el valor exacto que devolvió la API (campo numérico con 6 decimales).
- En la base de datos el valor se guarda en la columna `documents.bcv_rate` (DECIMAL(18,6)). Si por alguna razón no hay un `bcv_rate` explícito, el servidor persiste `exchange_rate` como fallback para documentos en VES.

### Cambios importantes en el código
- Frontend: `src/pages/dashboard.astro`
  - Se eliminó la casilla `Usar tasa BCV` (ahora la obtención es automática).
  - Se añadió `bcvRateDisplay` (indicador junto al input) y comportamiento que obtiene y bloquea la tasa al seleccionar `VES`.
  - Al crear un documento, el payload contiene `bcv_rate` cuando `currency === 'VES'`.
  - Lista de documentos: aparece un badge amarillo `BCV` si `bcv_rate` está presente y un badge verde `USD` si la moneda es USD.
  - Tooltip en badge `BCV` que muestra fecha y valor exacto al pasar el cursor.
  - En el modal detalle: los precios en Bs.F (cuando corresponda) se muestran con 2 decimales.

- Backend:
  - `src/pages/api/documentos.js` ahora acepta `bcv_rate` y lo persiste en `documents.bcv_rate`. Además, si `currency === 'VES'` y no se proporciona `bcv_rate`, se usa `exchange_rate` como fallback.
  - `src/pages/api/documentos` (GET) incluye `bcv_rate` en el listado para que la UI pueda renderizar los badges.
  - Nuevo endpoint proxy: `src/pages/api/bcv.js` (consulta externa para obtener la tasa BCV) — la UI lo consume.

### Base de datos
- Nueva columna en `documents`: `bcv_rate DECIMAL(18,6) DEFAULT NULL`.
- El script de migración idempotente está en `scripts/migrate-add-bsf-columns.js` y ya incluye la lógica para añadir `bcv_rate` si falta.

Para añadir la columna manualmente (si hace falta):

```sql
ALTER TABLE documents ADD COLUMN bcv_rate DECIMAL(18,6) DEFAULT NULL;
```

O ejecuta el migrator desde la raíz del proyecto (PowerShell):

```powershell
node scripts/migrate-add-bsf-columns.js
```

### Endpoints relevantes
- GET /api/bcv — devuelve JSON con `{ ok:true, price, raw }`.
- GET /api/documentos — lista documentos (incluye `bcv_rate`).
- POST /api/documentos — crea documento (envía `bcv_rate` en el body para VES o se usa `exchange_rate`).
- GET /api/documentos/:id — detalle del documento (incluye `bcv_rate` y items con `unit_price_bsf`, `total_bsf`).

### Comandos de prueba útiles
- Insertar un documento de prueba que usa BCV (ya incluido en scripts):

```powershell
node scripts/test-bcv-fetch-and-post.js
```

- Insertar un documento USD + un documento BCV (prueba de badges):

```powershell
node scripts/test-insert-usd-and-bcv.js
```

- Crear documento de ejemplo (genérico):

```powershell
node scripts/test-create-doc.js
```

- Ver lista de documentos (ver `bcv_rate`):

```powershell
node -e "fetch('http://localhost:3000/api/documentos').then(r=>r.json()).then(j=>console.log(JSON.stringify(j,null,2)))"
```

### Cómo verificar en la BD
Ejemplo para ver últimas filas y su `bcv_rate`:

```sql
SELECT id, doc_number, currency, exchange_rate, bcv_rate FROM documents ORDER BY created_at DESC LIMIT 10;
```

### Notas y recomendaciones
- El valor `bcv_rate` se guarda con 6 decimales para precisión (DECIMAL(18,6)). Para vistas públicas o facturas se redondea a 2 decimales cuando se muestra en Bs.F.
- Si quieres forzar que el servidor valide `bcv_rate` en ciertos flujos (por ejemplo, que sea obligatorio si currency=VES), se puede añadir una validación extra en `src/pages/api/documentos.js`.
- Si necesitas que la preferencia de usar BCV sea persistente por usuario, se puede guardar como setting en la tabla `usuarios` o en `localStorage` del navegador.

---

Si quieres, puedo añadir una sección de changelog con diffs o preparar un PR con estos cambios ya listos para revisión.
# Mi App Astro

Proyecto mínimo creado e inicializado con Astro.

Cómo usar:

1. Instalar dependencias: `npm install`
2. Ejecutar en desarrollo: `npm run dev`
3. Construir para producción: `npm run build`
4. Servir la build: `npm run start`
