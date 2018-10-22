# PHP-CRUD-API (v2)

Script PHP 7 de un solo archivo que agrega una API REST a una base de datos MySQL 5.5 InnoDB. PostgreSQL 9.1 y MS SQL Server 2012 son totalmente compatibles.

NB: Esta es la implementación de referencia [TreeQL] (https://treeql.org) en PHP.

NB: ¿Estás buscando v1? Está aquí: https://github.com/mevdschee/php-crud-api/tree/v1

Proyectos relacionados:

  - [PHP-API-AUTH] (https://github.com/mevdschee/php-api-auth): secuencia de comandos PHP de un solo archivo que es un proveedor de autenticación para PHP-CRUD-API (v2)
  - [PHP-SP-API] (https://github.com/mevdschee/php-sp-api): secuencia de comandos PHP de un solo archivo que agrega una API REST a una base de datos SQL.
  - [PHP-CRUD-UI] (https://github.com/mevdschee/PHP-crud-ui): secuencia de comandos PHP de un solo archivo que agrega una UI a un proyecto PHP-CRUD-API (v1).
  - [VUE-CRUD-UI] (https://github.com/nlware/vue-crud-ui): script Vue.js de un solo archivo que agrega una IU a un proyecto PHP-CRUD-API (v1).
  
También hay puertos de este script en:

- [Java JDBC por Ivan Kolchagov] (https://github.com/kolchagov/java-crud-api) (v1)
- [Java Spring Boot + jOOQ] (https://github.com/mevdschee/java-crud-api/tree/master/full) (v2: trabajo en progreso)

También hay puertos de prueba de concepto de este script que solo admiten la funcionalidad REST CRUD básica en:
[PHP] (https://github.com/mevdschee/php-crud-api/blob/master/extras/core.php),
[Java] (https://github.com/mevdschee/java-crud-api/blob/master/core/src/main/java/com/tqdev/CrudApiHandler.java),
[Ir] (https://github.com/mevdschee/go-crud-api/blob/master/api.go),
[C # .net core] (https://github.com/mevdschee/core-data-api/blob/master/Program.cs),
[Node.js] (https://github.com/mevdschee/js-crud-api/blob/master/app.js) y
[Python] (https://github.com/mevdschee/py-crud-api/blob/master/api.py).

## Requisitos

  - PHP 7.0 o superior con controladores PDO para MySQL, PgSQL o SqlSrv habilitados
  - MySQL 5.6 / MariaDB 10.0 o superior para características espaciales en MySQL
  - PostGIS 2.0 o superior para características espaciales en PostgreSQL 9.1 o superior
  - SQL Server 2012 o superior (2017 para soporte de Linux)

## Instalación

Esta es una aplicación de un solo archivo! ¡Sube "` api.php` "a algún lugar y disfruta!

Para el desarrollo local, puede ejecutar el servidor web incorporado de PHP:

    php -S localhost: 8080

Pruebe el script abriendo la siguiente URL:

    http: // localhost: 8080 / api.php / records / posts / 1

No olvide modificar la configuración en la parte inferior del archivo.

## Configuración

Edite las siguientes líneas en la parte inferior del archivo "` api.php` ":

    $ config = new Config ([
        'username' => 'xxx',
        'contraseña' => 'xxx',
        'database' => 'xxx',
    ]);

Estas son todas las opciones de configuración y su valor predeterminado entre paréntesis:

- "driver": `mysql`,` pgsql` o `sqlsrv` (` mysql`)
- "dirección": Nombre de host del servidor de base de datos (`localhost`)
- "puerto": puerto TCP del servidor de la base de datos (predeterminado en el controlador predeterminado)
- "nombre de usuario": nombre de usuario del usuario que se conecta a la base de datos (no predeterminado)
- "contraseña": contraseña del usuario que se conecta a la base de datos (no predeterminada)
- "base de datos": Base de datos a la que se realiza la conexión (no predeterminada)
- "middlewares": Lista de middlewares para cargar (`cors`)
- "controladores": lista de controladores para cargar (`registros, openapi`)
- "openApiBase": información de OpenAPI (`{" info ": {" title ":" PHP-CRUD-API "," version ":" 1.0.0 "}}`)
- "cacheType": `TempFile`,` Redis`, `Memcache`,` Memcached` o `NoCache` (` TempFile`)
- "cachePath": ruta / dirección del caché (por defecto al directorio temporal del sistema)
- "cacheTime": número de segundos que la caché es válida (`10`)
- "debug": muestra los errores en el encabezado "X-Debug-Info" (`false ')

## Compilacion

El código reside en el directorio "` src` ". Puedes acceder a ella en la URL:

    http: // localhost: 8080 / src / records / posts / 1

Puedes compilar todos los archivos en un solo archivo "` api.php` "usando:

    php build.php

NB: El script agrega las clases en orden alfabético (primero los directorios).

## Limitaciones

Estas limitaciones también estaban presentes en v1:

  - Las claves primarias deben ser de incremento automático (de 1 a 2 ^ 53) o UUID
  - Las claves primarias o externas compuestas no son compatibles
  - Escrituras complejas (transacciones) no son compatibles
  - Las consultas complejas que llaman a funciones (como "concat" o "sum") no son compatibles
  - La base de datos debe soportar y definir restricciones de clave externa.

## Caracteristicas

Estas características coinciden con las características en v1 (ver rama "v1"):

  - [x] Un solo archivo PHP, fácil de implementar.
  - [x] Muy poco código, fácil de adaptar y mantener.
  - [] ~~ Datos de transmisión, espacio de memoria bajo ~~
  - [x] Admite variables POST como entrada (x-www-form-urlencoded)
  - [x] Soporta un objeto JSON como entrada
  - [x] Admite una matriz JSON como entrada (inserción por lotes)
  - [] ~~ Admite la carga de archivos desde formularios web (multipart / form-data) ~~
  - [] ~~ Salida JSON condensada: la primera fila contiene nombres de campo ~~
  - [x] Desinfectar y validar la entrada utilizando devoluciones de llamada
  - [x] Sistema de permisos para bases de datos, tablas, columnas y registros.
  - [x] Los diseños de bases de datos multi-tenant son compatibles
  - [x] Soporte de CORS de múltiples dominios para solicitudes de varios dominios
  - [x] Soporte para leer resultados combinados de tablas múltiples
  - [x] Soporte de búsqueda en múltiples criterios
  - [x] Paginación, búsqueda, clasificación y selección de columnas.
  - [x] Detección de relaciones con resultados anidados (belongsTo, hasMany y HABTM)
  - [] ~~ Relación "transforma" (de JSON condensado) para PHP y JavaScript ~~
  - [x] Soporte de incremento atómico a través de PATCH (para contadores)
  - [x] Campos binarios soportados con codificación base64
  - [x] Campos y filtros espaciales / GIS compatibles con WKT
  - [] ~~ Soporte de datos no estructurados a través de JSON / JSONB ~~
  - [x] Genera documentación de API usando herramientas OpenAPI
  - [x] Autenticación mediante token JWT o nombre de usuario / contraseña
  - [] ~~ SQLite support ~~

 NB: Sin marca significa: aún no implementado. Striken significa: no será implementado.

### Características adicionales

Estas características son nuevas y no se incluyeron en v1.

  - No refleja en cada solicitud (mejor rendimiento)
  - Los filtros complejos (con "y" y "o") son compatibles
  - Soporte para salida de estructura de base de datos en JSON.
  - Soporte para datos booleanos y binarios en todos los motores de bases de datos.
  - Soporte para datos relacionales en lectura (no solo en operación de lista)
  - Soporte para middleware para modificar todas las operaciones (también lista)
  - Informe de errores en JSON con el estado HTTP correspondiente
  - Soporte para autenticación básica y vía proveedor de autenticación (JWT).
  - Soporte para funcionalidades básicas de firewall.

## Middleware

Puede habilitar el siguiente middleware utilizando el parámetro de configuración "middlewares":

- "firewall": limita el acceso a direcciones IP específicas
- "cors": soporte para solicitudes CORS (habilitado por defecto)
- "xsrf": Bloquee los ataques XSRF usando el método 'Double Submit Cookie'
- "ajaxOnly": restringe las solicitudes que no son AJAX para evitar ataques XSRF
- "jwtAuth": Soporte para "Autenticación JWT"
- "basicAuth": Soporte para "Autenticación básica"
- "autorización": restringir el acceso a ciertas tablas o columnas
- "validación": devuelve errores de validación de entrada para reglas personalizadas
- "saneamiento": aplicar saneamiento de entrada en crear y actualizar
- "multiTenancy": restringe el acceso de los inquilinos en un escenario con múltiples inquilinos
- "personalización": proporciona controladores para la personalización de solicitudes y respuestas

El parámetro de configuración "middlewares" es una lista separada por comas de middlewares habilitados.
Puede ajustar el comportamiento del middleware utilizando parámetros de configuración específicos del middleware:

- "firewall.reverseProxy": se establece en "true" cuando se utiliza un proxy inverso ("")
- "firewall.allowedIpAddresses": lista de direcciones IP que pueden conectarse ("")
- "cors.allowedOrigins": los orígenes permitidos en los encabezados CORS ("*")
- "cors.allowHeaders": los encabezados permitidos en la solicitud CORS ("Content-Type, X-XSRF-TOKEN")
- "cors.allowMethods": los métodos permitidos en la solicitud CORS ("OPTIONS, GET, PUT, POST, DELETE, PATCH")
- "cors.allowCredentials": para permitir credenciales en la solicitud CORS ("true")
- "cors.exposeHeaders": encabezados de lista blanca a los que los navegadores pueden acceder ("")
- "cors.maxAge": el tiempo que la concesión de CORS es válida en segundos ("1728000")
- "xsrf.excludeMethods": los métodos que no requieren la protección XSRF ("OPTIONS, GET")
- "xsrf.cookieName": el nombre de la cookie de protección XSRF ("XSRF-TOKEN")
- "xsrf.headerName": el nombre del encabezado de protección XSRF ("X-XSRF-TOKEN")
- "ajaxOnly.excludeMethods": los métodos que no requieren AJAX ("OPTIONS, GET")
- "ajaxOnly.headerName": el nombre del encabezado requerido ("X-Request-With")
- "ajaxOnly.headerValue": el valor del encabezado requerido ("XMLHttpRequest")
- "jwtAuth.mode": configúrelo como "opcional" si desea permitir el acceso anónimo ("requerido")
- "jwtAuth.header": nombre del encabezado que contiene el token JWT ("X-Autorización")
- "jwtAuth.leeway": el número aceptable de segundos de desviación del reloj ("5")
- "jwtAuth.ttl": el número de segundos que el token es válido ("30")
- "jwtAuth.secret": el secreto compartido utilizado para firmar el token JWT con ("")
- "jwtAuth.algorithms": los algoritmos que se permiten, vacío significa "todos" ("")
- "jwtAuth.audiences": las audiencias permitidas, vacío significa "todos" ("")
- "jwtAuth.issuers": los emisores que están permitidos, vacío significa 'todos' ("")
- "basicAuth.mode": configúrelo como "opcional" si desea permitir el acceso anónimo ("requerido")
- "basicAuth.realm": texto que se le solicitará al mostrar el inicio de sesión ("Se requieren nombre de usuario y contraseña")
- "basicAuth.passwordFile": el archivo a leer para las combinaciones de nombre de usuario / contraseña (".htpasswd")
- "permission.tableHandler": controlador para implementar las reglas de autorización de tablas ("")
- "permission.columnHandler": controlador para implementar las reglas de autorización de columna ("")
- "authority.recordHandler": controlador para implementar reglas de filtro de autorización de registros ("")
- "validation.handler": controlador para implementar reglas de validación para valores de entrada ("")
- "sanitation.handler": controlador para implementar reglas de saneamiento para valores de entrada ("")
- "multiTenancy.handler": controlador para implementar reglas simples de tenencia múltiple ("")
- "customization.beforeHandler": controlador para implementar la personalización de la solicitud ("")
- "customization.afterHandler": controlador para implementar la personalización de la respuesta ("")

Si no especifica estos parámetros en la configuración, se utilizan los valores predeterminados (entre paréntesis).

## TreeQL, un GraphQL pragmático

TreeQL le permite crear un "árbol" de objetos JSON en función de la estructura de la base de datos SQL (relaciones) y su consulta.

Se basa libremente en el estándar REST y también está inspirado en json: api.

### CRUD + Lista

La tabla de publicaciones de ejemplo tiene solo unos pocos campos:

    puestos
    =======
    carné de identidad
    título
    contenido
    creado

Las siguientes operaciones de la lista CRUD + actúan en esta tabla.

#### Crear

Si desea crear un registro, la solicitud se puede escribir en formato de URL como:

    POST / registros / mensajes

Tienes que enviar un cuerpo que contiene:

    {
        "título": "negro es el nuevo rojo",
        "contenido": "Este es el segundo post".
        "creado": "2018-03-06T21: 34: 01Z"
    }

Y devolverá el valor de la clave principal del registro recién creado:

    2

#### Leer

Para leer un registro de esta tabla, la solicitud se puede escribir en formato de URL como:

    GET / records / posts / 1

Donde "1" es el valor de la clave principal del registro que desea leer. Volverá

    {
        "id": 1
        "título": "¡Hola mundo!",
        "contenido": "Bienvenido al primer post".
        "created": "2018-03-05T20: 12: 56Z"
    }

En las operaciones de lectura puede aplicar uniones.

#### Actualizar

Para actualizar un registro en esta tabla, la solicitud se puede escribir en formato de URL como:

    PUT / registros / mensajes / 1

Donde "1" es el valor de la clave principal del registro que desea actualizar. Enviar como un cuerpo:

    {
        "título": "título ajustado!"
    }

Esto ajusta el título del post. Y el valor de retorno es el número de filas que se establecen:

    1

#### Borrar

Si desea eliminar un registro de esta tabla, la solicitud se puede escribir en formato de URL como:

    ELIMINAR / registros / mensajes / 1

Y devolverá el número de filas eliminadas:

    1

#### Lista

Para listar los registros de esta tabla, la solicitud se puede escribir en formato de URL como:

    GET / registros / mensajes

Volverá

    {
        "archivos":[
            {
                "id": 1,
                "título": "¡Hola mundo!",
                "contenido": "Bienvenido al primer post".
                "created": "2018-03-05T20: 12: 56Z"
            }
        ]
    }

En las operaciones de lista puede aplicar filtros y uniones.

### Filtros

Los filtros proporcionan la funcionalidad de búsqueda, en la lista de llamadas, usando el parámetro "filtro". Necesitas especificar la columna.
nombre, una coma, el tipo de coincidencia, otra coma y el valor que desea filtrar. Estos son tipos de concordancia soportados:

  - "cs": contiene cadena (cadena contiene valor)
  - "sw": comienza con (la cadena comienza con el valor)
  - "ew": termina con (final de cadena con valor)
  - "eq": igual (la cadena o el número coinciden exactamente)
  - "lt": menor que (el número es menor que el valor)
  - "le": menor o igual (el número es menor o igual al valor)
  - "ge": mayor o igual (el número es mayor o igual que el valor)
  - "gt": mayor que (el número es mayor que el valor)
  - "bt": entre (el número está entre dos valores separados por comas)
  - "in": in (el número o la cadena está en una lista de valores separados por comas)
  - "is": es nulo (el campo contiene el valor "NULL")

Puede negar todos los filtros al anteponer un carácter "n", de modo que "eq" se convierta en "neq".
Ejemplos de uso del filtro son:

    GET / records / categories? Filter = nombre, eq, internet
    GET / records / categories? Filter = nombre, sw, Inter
    GET / records / categories? Filter = id, le, 1
    GET / records / categories? Filter = id, ngt, 2
    GET / records / categories? Filter = id, bt, 1,1

Salida:

    {
        "archivos":[
            {
                "id": 1
                "nombre": "internet"
            }
        ]
    }

En la siguiente sección profundizaremos en cómo puede aplicar varios filtros en una sola llamada de lista.

### Múltiples filtros

Los filtros pueden aplicarse aplicando el parámetro "filtro" en la URL. Por ejemplo la siguiente URL:

    GET / records / categories? Filter = id, gt, 1 & filter = id, lt, 3

solicitará todas las categorías "donde id> 1 e id <3". Si desea "where id = 2 o id = 4" debe escribir:

    GET / records / categories? Filter1 = id, eq, 2 & filter2 = id, eq, 4
    
Como ve, agregamos un número al parámetro "filtro" para indicar que se debe aplicar "OR" en lugar de "AND".
Tenga en cuenta que también puede repetir "filter1" y crear un "AND" dentro de un "OR". Ya que también puedes ir un nivel más profundo.
al agregar una letra (a-f) puede crear casi cualquier árbol de condiciones razonablemente complejo.

NB: solo puede filtrar en la tabla solicitada (no incluida en ella) y los filtros solo se aplican en la lista de llamadas.

### Selección de columna

Por defecto, todas las columnas están seleccionadas. Con el parámetro "incluir" puede seleccionar columnas específicas.
Puede usar un punto para separar el nombre de la tabla del nombre de la columna. Las columnas múltiples deben estar separadas por comas.
Se puede utilizar un asterisco ("*") como comodín para indicar "todas las columnas". Similar a "incluir" puede usar el parámetro "excluir" para eliminar ciertas columnas:

`` `
GET / records / categories / 1? Include = name
GET /records/categories/1?include=categories.name
GET /records/categories/1?exclude=categories.id
`` `

Salida:

`` `
    {
        "nombre": "internet"
    }
`` `

NB: las columnas que se utilizan para incluir entidades relacionadas se agregan automáticamente y no se pueden dejar fuera de la salida.

### pedidos

Con el parámetro "orden" se puede ordenar. De forma predeterminada, la clasificación está en orden ascendente, pero al especificar "desc" esto se puede revertir:

`` `
GET / records / categories? Order = name, desc
GET / records / categories? Order = id, desc & order = name
`` `

Salida:

`` `
    {
        "archivos":[
            {
                "id": 3
                "nombre": "desarrollo web"
            }
            {
                "id": 1
                "nombre": "internet"
            }
        ]
    }
`` `

NB: puede ordenar en múltiples campos utilizando múltiples parámetros de "orden". No se puede ordenar en columnas "unidas".

### Paginación

El parámetro "página" contiene la página solicitada. El tamaño de página predeterminado es 20, pero se puede ajustar (por ejemplo, a 50):

`` `
GET / records / categories? Order = id & page = 1
GET / records / categories? Order = id & page = 1,50
`` `

Salida:

`` `
    {
        "archivos":[
            {
                "id": 1
                "nombre": "internet"
            }
            {
                "id": 3
                "nombre": "desarrollo web"
            }
        ]
        "resultados": 2
    }
`` `

NB: las páginas que no están ordenadas no pueden paginarse.

### se une

Supongamos que tiene una tabla de publicaciones que tiene comentarios (realizados por usuarios) y que las publicaciones pueden tener etiquetas.

    publica comentarios usuarios post_tags etiquetas
    ======= ======== ======= ========= =======
    id id id id id
    título post_id nombre de usuario post_id nombre
    contenido user_id teléfono tag_id
    mensaje creado

Cuando desee enumerar las publicaciones con sus usuarios y etiquetas de comentarios, puede solicitar dos rutas de "árbol":

    mensajes -> comentarios -> usuarios
    mensajes -> post_tags -> etiquetas

Estas rutas tienen la misma raíz y esta solicitud se puede escribir en formato de URL como:

    GET / records / posts? Join = comentarios, usuarios y join = etiquetas

Aquí puede omitir la tabla intermedia que vincula las publicaciones a las etiquetas. En este ejemplo
ve los tres tipos de relaciones de tabla (hasMany, belongsTo y hasAndBelongsToMany) en efecto:

- "post" tiene muchos "comentarios"
- "comentario" pertenece a "usuario"
- "publicar" tiene y pertenece a muchas "etiquetas"

Esto puede llevar a los siguientes datos JSON:

    {
        "archivos":[
            {
                "id": 1,
                "título": "¡Hola mundo!",
                "contenido": "Bienvenido al primer post".
                "created": "2018-03-05T20: 12: 56Z",
                "comentarios": [
                    {
                        ID: 1,
                        post_id: 1,
                        id_usuario: {
                            ID: 1,
                            nombre de usuario: "mevdschee",
                            teléfono: nulo,
                        }
                        mensaje: "Hola!"
                    }
                    {
                        ID: 2,
                        post_id: 1,
                        id_usuario: {
                            ID: 1,
                            nombre de usuario: "mevdschee",
                            teléfono: nulo,
                        }
                        mensaje: "Hola de nuevo!"
                    }
                ]
                "etiquetas": []
            }
            {
                "id": 2,
                "título": "negro es el nuevo rojo",
                "contenido": "Este es el segundo post".
                "creado": "2018-03-06T21: 34: 01Z",
                "comentarios": [],
                "etiquetas": [
                    {
                        ID: 1,
                        mensaje: "divertido"
                    }
                    {
                        ID: 2,
                        mensaje: "informativo"
                    }
                ]
            }
        ]
    }

Verá que se detectan las relaciones "belongsTo" y el valor al que se hace referencia reemplaza el valor de la clave externa.
En el caso de "hasMany" y "hasAndBelongsToMany", el nombre de la tabla se utiliza una nueva propiedad en el objeto.

### operaciones por lotes

Cuando desee crear, leer, actualizar o eliminar, puede especificar varios valores de clave principal en la URL.
También debe enviar una matriz en lugar de un objeto en el cuerpo de la solicitud para crear y actualizar.

Para leer un registro de esta tabla, la solicitud se puede escribir en formato de URL como:

    GET / records / posts / 1,2

El resultado puede ser:

    El
            {
                "id": 1,
                "título": "¡Hola mundo!",
                "contenido": "Bienvenido al primer post".
                "created": "2018-03-05T20: 12: 56Z"
            }
            {
                "id": 2,
                "título": "negro es el nuevo rojo",
                "contenido": "Este es el segundo post".
                "creado": "2018-03-06T21: 34: 01Z"
            }
    ]

Del mismo modo, cuando desea realizar una actualización por lotes, la solicitud en formato de URL se escribe como:

    PUT / records / posts / 1,2

Donde "1" y "2" son los valores de las claves primarias de los registros que desea actualizar. El cuerpo debe
contiene el mismo número de objetos, ya que hay claves primarias en la URL:

    El
        {
            "title": "Título ajustado para ID 1"
        }
        {
            "title": "Título ajustado para ID 2"
        }
    ]

Esto ajusta los títulos de los mensajes. Y los valores de retorno son el número de filas que se establecen:

    1,1

Lo que significa que había dos operaciones de actualización y cada una de ellas había establecido una fila. Base de datos de uso de operaciones por lotes
transacciones, para que todos tengan éxito o todos fracasen (los exitosos se recuperan).

### Soporte espacial

Para el soporte espacial hay un conjunto adicional de filtros que se pueden aplicar en columnas de geometría y que comienzan con una "s":

  - "sco": contiene espacial (la geometría contiene otra)
  - "scr": cruces espaciales (la geometría cruza otra)
  - "sdi": separación espacial (la geometría es diferente de otra)
  - "seq": espacial igual (la geometría es igual a otra)
  - "pecado": intersecciones espaciales (la geometría se interseca con otra)
  - "sov": superposiciones espaciales (la geometría se superpone a otra)
  - "sto": toques espaciales (la geometría toca a otra)
  - "swi": espacial dentro (la geometría está dentro de otra)
  - "sic": espacial está cerrada (la geometría es cerrada y simple)
  - "sis": espacial es simple (la geometría es simple)
  - "siv": el espacio es válido (la geometría es válida)

Estos filtros se basan en los estándares OGC y también lo es la especificación WKT en la que se representan las columnas de geometría.

### autenticación

La autenticación se realiza mediante el envío de un encabezado de "Autorización". Identifica al usuario y lo almacena en el súper global `$ _SESSION`.
Esta variable se puede usar en los controladores de autorización para decidir si o no sombeody debería tener acceso de lectura o escritura a ciertas tablas, columnas o registros.
Actualmente hay dos tipos de autenticación admitidos: "Básico" y "JWT". Esta funcionalidad se habilita agregando el middleware 'basicAuth' y / o 'jwtAuth'.

#### autenticación básica

El tipo Básico admite un archivo que contiene a los usuarios y sus contraseñas (con hash) separadas por dos puntos (':').
Cuando las contraseñas se introducen en texto sin formato, se rellenan automáticamente.
El nombre de usuario autenticado se almacenará en la variable `$ _SESSION ['username']`.
Debe enviar un encabezado de "Autorización" que contenga un nombre de usuario y una contraseña codificados en base64 url ​​y separados por dos puntos después de la palabra "Básico".

    Autorización: Basic dXNlcm5hbWUxOnBhc3N3b3JkMQ

Este ejemplo envía la cadena "username1: password1".

#### autenticación JWT

El tipo JWT requiere que otro servidor (SSO / Identity) firme un token que contiene notificaciones.
Ambos servidores comparten un secreto para que puedan firmar o verificar que la firma es válida.
Las reclamaciones se almacenan en la variable `$ _SESSION ['reclamaciones']`. Necesitas enviar una "X-Autorización"
encabezado que contiene una url base64 codificada y un encabezado de token separado, cuerpo y firma después
la palabra "Portador" ([lea más sobre JWT aquí] (https://jwt.io/)). El estándar dice que necesitas
use el encabezado "Autorización", pero esto es problemático en Apache y PHP.

    X-Autorización: Portador eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiYWRtaW4iOnRydWUsImlhdCI6IjE1MzgyMDc2MDUiLCJleHAiOjE1MzgyMDc2MzV9.Z5px_GT15TRKhJCTHhDt5Z6K6LRDSFnLj8U5ok9l7gw

Este ejemplo envía los reclamos firmados:

    {
      "sub": "1234567890",
      "nombre": "John Doe",
      "admin": verdadero,
      "iat": "1538207605",
      "exp": 1538207635
    }

NB: La implementación de JWT solo admite los algoritmos basados ​​en hash HS256, HS384 y HS512.

## Operaciones de autorización

El modelo de Autorización actúa sobre "operaciones". Los más importantes se enumeran aquí:

    ruta del método - operación - descripción
    -------------------------------------------------- --------------------------------------
    GET / records / {table} - list - listas de registros
    POST / records / {table} - create - crea registros
    GET / records / {table} / {id} - read - lee un registro por clave principal
    PUT / records / {table} / {id} - update - actualiza las columnas de un registro por clave principal
    DELETE / records / {table} / {id} - delete - borra un registro por clave principal
    PATCH / records / {table} / {id} - incrementa - incrementa las columnas de un registro por clave principal

El punto final "` / openapi` "solo mostrará lo que está permitido en su sesión. También tiene un especial.
Operación de "documento" para permitirle ocultar tablas y columnas de la documentación.
    
Para los puntos finales que comienzan con "` / columns` "están las operaciones" reflejar "y" remodelar ".
Estas operaciones pueden mostrar o cambiar la definición de la base de datos, tabla o columna.
Esta funcionalidad está desactivada por defecto y por una buena razón (¡cuidado!).
Agregue el controlador de "columnas" en la configuración para habilitar esta funcionalidad.

### Autorizando tablas, columnas y registros

Por defecto, todas las tablas y columnas son accesibles. Si desea restringir el acceso a algunas tablas, puede agregar el middleware de 'autorización'
y defina una función 'authority.tableHandler' que devuelva 'false' para estas tablas.

~~~php
'authorization.tableHandler' => function ($operation, $tableName) {
    return $tableName != 'license_keys';
},
~~~

El ejemplo anterior restringirá el acceso a la tabla 'license_keys' para todas las operaciones.

~~~php
'authorization.columnHandler' => function ($operation, $tableName, $columnName) {
    return !($tableName == 'users' && $columnName == 'password');
},
~~~

El ejemplo anterior restringirá el acceso al campo 'contraseña' de la tabla 'usuarios' para todas las operaciones.

~~~php
'authorization.recordHandler' => function ($operation, $tableName) {
    return ($tableName == 'users') ? 'filter=username,neq,admin' : '';
},
~~~

El ejemplo anterior no permitirá el acceso a los registros de usuarios donde el nombre de usuario es "admin".
Esta construcción agrega un filtro a cada consulta ejecutada.

NB: debe manejar la creación de registros no válidos con un controlador de validación (o saneamiento).

### Entrada de desinfección

Por defecto, todas las entradas son aceptadas y enviadas a la base de datos. Si desea eliminar (ciertas) etiquetas HTML antes de almacenarlas, puede agregar
el middleware 'saneamiento' y defina una función 'sanitation.handler' que devuelve el valor ajustado.

~~~php
'sanitation.handler' => function ($operation, $tableName, $column, $value) {
    return is_string($value) ? strip_tags($value) : $value;
},
~~~

El ejemplo anterior eliminará todas las etiquetas HTML de las cadenas en la entrada.

### Validando entrada

Por defecto se acepta toda la entrada. Si desea validar la entrada, puede agregar el middleware de 'validación' y definir un
La función 'validation.handler' que devuelve un valor booleano que indica si el valor es válido o no.

~~~php
'validation.handler' => function ($operation, $tableName, $column, $value, $context) {
    return ($column['name'] == 'post_id' && !is_numeric($value)) ? 'must be numeric' : true;
},
~~~

Cuando editas un comentario con id 4 usando:

    PUT / registros / comentarios / 4

Y envías como cuerpo:

    {"post_id": "dos"}

Luego, el servidor devolverá un código de estado HTTP '422' y un mensaje de error agradable:

    {
        "código": 1013,
        "mensaje": "Error de validación de entrada para 'comentarios'",
        "detalles": {
            "post_id": "debe ser numérico"
        }
    }

Puede analizar esta salida para que los campos de formulario aparezcan con un borde rojo y su mensaje de error correspondiente.

### Soporte multi-tenancy

Puede usar el middleware "multiTenancy" cuando tenga una base de datos de múltiples inquilinos.
Si sus inquilinos están identificados por la columna "customer_id", puede usar el siguiente controlador:

    'multiTenancy.handler' => function ($ operation, $ tableName) {
        return ['customer_id' => 12];
    }

Esta construcción agrega un filtro que requiere que "customer_id" sea "12" a cada operación (excepto para "crear").
También establece la columna "customer_id" en "crear" a "12" y elimina la columna de cualquier otra operación de escritura.

### Controladores de personalización

Puede utilizar el middleware de "personalización" para modificar la solicitud y la respuesta e implementar cualquier otra funcionalidad.

    'customization.beforeHandler' => function ($ operation, $ tableName, $ request, $ environment) {
        $ environment-> start = microtime (true);
    }
    'customización.afterHandler' => función ($ operación, $ tableName, $ respuesta, $ entorno) {
        $ response-> addHeader ('X-Time-Taken', microtime (true) - $ environment-> start);
    }

El ejemplo anterior agregará un encabezado "X-Time-Taken" con el número de segundos que ha tomado la llamada a la API.

### Archivos subidos

Las cargas de archivos se admiten a través de [FileReader API] (https://caniuse.com/#feat=filereader).

## especificación de OpenAPI

En el punto final "/ openapi" se sirve la especificación OpenAPI 3.0 (anteriormente llamada "Swagger").
Es una documentación instantánea legible por máquina de su API. Para obtener más información, echa un vistazo a estos enlaces:

- [Swagger Editor] (https://editor.swagger.io/) se puede usar para ver y depurar la especificación generada.
- [Especificación de OpenAPI] (https://swagger.io/specification/) es un manual para crear una especificación de OpenAPI.
- [Swagger Petstore] (https://petstore.swagger.io/) es una documentación de ejemplo que se genera utilizando OpenAPI.

## caché

Hay 4 motores de caché que pueden configurarse mediante el parámetro de configuración "cacheType":

- TempFile (por defecto)
- Redis
- Memcache
- Memcached

Puede instalar las dependencias para los últimos tres motores ejecutando:

    sudo apt instalar php-redis redis
    sudo apt install php-memcache memcached
    sudo apt install php-memcached memcached

El motor predeterminado no tiene dependencias y usará archivos temporales en la ruta "temporal" del sistema.

Puede usar el parámetro de configuración "cachePath" para especificar la ruta del sistema de archivos para los archivos temporales o
en caso de que utilice un "tipo de caché" no predeterminado, el nombre de host (opcionalmente con puerto) del servidor de caché.

## tipos

Estos son los tipos admitidos con su longitud / precisión / escala predeterminadas:

tipos de personajes
- varchar (255)
- clob

tipos booleanos:
booleano

tipos enteros:
- entero
- Bigint

tipos de punto flotante:
- flotar
- doble

tipos decimales:
- decimal (19,4)

tipos de fecha / hora:
- fecha
- hora
- marca de tiempo

tipos binarios:
- varbinary (255)
- blob

otros tipos:
- geometría / * tipo no jdbc, extensión con soporte limitado * /

## enteros de 64 bits en JavaScript

JavaScript no es compatible con enteros de 64 bits. Todos los números se almacenan como valores de punto flotante de 64 bits. La mantisa de un número de punto flotante de 64 bits es solo de 53 bits y es por eso que todos los números enteros mayores a 53 bits pueden causar problemas en JavaScript.

## Errores

Los siguientes errores pueden ser reportados:

- 1000: Ruta no encontrada (404 NO ENCONTRADA)
- 1001: Tabla no encontrada (404 NO ENCONTRADA)
- 1002: Discrepancia en el recuento de argumentos (422 ENTIDAD IMPROCESABLE)
- 1003: Registro no encontrado (404 NO ENCONTRADO)
- 1004: el origen está prohibido (403 PROHIBIDO)
- 1005: Columna no encontrada (404 NO ENCONTRADA)
- 1006: la tabla ya existe (409 CONFLICTO)
- 1007: la columna ya existe (409 CONFLICTO)
- 1008: No se puede leer el mensaje HTTP (422 ENTIDAD IMPROCESABLE)
- 1009: Excepción de clave duplicada (409 CONFLICTO)
- 1010: Violación de integridad de datos (409 CONFLICTO)
- 1011: se requiere autenticación (401 NO AUTORIZADO)
- 1012: Falló la autenticación (403 PROHIBIDO)
- 1013: error de validación de entrada (422 ENTIDAD IMPROCESABLE)
- 1014: Operación prohibida (403 PROHIBIDO)
- 1015: operación no admitida (405 MÉTODO NO PERMITIDO)
- 1016: Temporal o permanentemente bloqueado (403 PROHIBIDO)
- 1017: token XSRF incorrecto o faltante (403 PROHIBIDO)
- 1018: solo se permiten solicitudes AJAX (403 PROHIBIDAS)
- 1019: Falló la carga del archivo (422 ENTIDAD IMPROCESABLE)
- 9999: Error desconocido (500: ERROR DE SERVIDOR INTERNO)

Se utiliza la siguiente estructura JSON:

    {
        "código": 1002,
        "mensaje": "Discrepancia en el recuento de argumentos en '1'"
    }

NB: Cualquier respuesta que no sea de error tendrá un estado: 200 OK

## pruebas

Estoy probando principalmente en Ubuntu y tengo las siguientes configuraciones de prueba:

  - (Docker) Debian 9 con PHP 7.0, MariaDB 10.1, PostgreSQL 9.6 (PostGIS 2.3)
  - (Docker) Ubuntu 16.04 con PHP 7.0, MariaDB 10.0, PostgreSQL 9.5 (PostGIS 2.2) y SQL Server 2017
  - (Docker) Ubuntu 18.04 con PHP 7.2, MySQL 5.7, PostgreSQL 10.4 (PostGIS 2.4)

Esto no cubre todos los entornos (todavía), así que notifíqueme sobre las pruebas fallidas e informe su entorno.
Intentaré cubrir las configuraciones más relevantes en la carpeta "docker" del proyecto.

### Corriendo

Para ejecutar las pruebas funcionales localmente, puede ejecutar el siguiente comando:

    php test.php

Esto ejecuta las pruebas funcionales desde el directorio de "pruebas". Utiliza los volcados de base de datos (fixtures) y
Configuración de la base de datos (config) desde los subdirectorios correspondientes.

### Docker

Instale la ventana acoplable utilizando los siguientes comandos y luego cierre sesión e inicie sesión para que los cambios surtan efecto:

    sudo apt install docker.io
    sudo usermod -aG docker $ {USUARIO}

Para ejecutar las pruebas de la ventana acoplable, ejecute "build_all.sh" y "run_all.sh" desde el directorio de la ventana acoplable. La salida debe ser:

    ================================================
    Debian 9 (PHP 7.0)
    ================================================
    [1/4] Iniciando MariaDB 10.1 ..... hecho
    [2/4] Iniciando PostgreSQL 9.6 ... listo
    [3/4] Iniciando SQLServer 2017 ... omitido
    [4/4] Clonación de PHP-CRUD-API v2 ... omitida
    ------------------------------------------------
    mysql: 83 pruebas ejecutadas en 378 ms, 0 fallidas
    pgsql: 83 pruebas ejecutadas en 284 ms, 0 fallaron
    sqlsrv: omitido, controlador no cargado
    ================================================
    Ubuntu 16.04 (PHP 7.0)
    ================================================
    [1/4] Iniciando MariaDB 10.0 ..... hecho
    [2/4] Iniciando PostgreSQL 9.5 ... hecho
    [3/4] Iniciando SQLServer 2017 ... hecho
    [4/4] Clonación de PHP-CRUD-API v2 ... omitida
    ------------------------------------------------
    mysql: 83 pruebas ejecutadas en 381 ms, 0 fallidas
    pgsql: 83 pruebas ejecutadas en 290 ms, 0 fallidas
    sqlsrv: 83 pruebas ejecutadas en 4485 ms, 0 fallaron
    ================================================
    Ubuntu 18.04 (PHP 7.2)
    ================================================
    [1/4] Iniciando MySQL 5.7 ........ hecho
    [2/4] Iniciando PostgreSQL 10.4 .. hecho
    [3/4] Iniciando SQLServer 2017 ... omitido
    [4/4] Clonación de PHP-CRUD-API v2 ... omitida
    ------------------------------------------------
    mysql: 83 pruebas ejecutadas en 364 ms, 0 fallidas
    pgsql: 83 pruebas ejecutadas en 294 ms, 0 fallaron
    sqlsrv: omitido, controlador no cargado

La ejecución de prueba anterior (incluido el inicio de las bases de datos) lleva menos de un minuto en mi máquina.

     $ ./run.sh
     1) debian9
     2) ubuntu16
     3) ubuntu18
     > 3
     ================================================
     Ubuntu 18.04 (PHP 7.2)
     ================================================
     [1/4] Iniciando MySQL 5.7 ........ hecho
     [2/4] Iniciando PostgreSQL 10.4 .. hecho
     [3/4] Iniciando SQLServer 2017 ... omitido
     [4/4] Clonación de PHP-CRUD-API v2 ... omitida
     ------------------------------------------------
     mysql: 83 pruebas ejecutadas en 364 ms, 0 fallidas
     pgsql: 83 pruebas ejecutadas en 294 ms, 0 fallaron
     sqlsrv: omitido, controlador no cargado
     root @ b7ab9472e08f: / php-crud-api #

Como puede ver, la secuencia de comandos "run.sh" le da acceso a un aviso en un entorno de docker elegido.
En este entorno se montan los archivos locales. Esto permite una fácil depuración en diferentes entornos.
Puede escribir "salir" cuando haya terminado.