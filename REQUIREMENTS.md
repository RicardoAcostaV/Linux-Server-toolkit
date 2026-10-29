# Linux Server Toolkit — Especificación de requisitos

**Versión:** 1.0.0  
**Estado:** Propuesta inicial  
**Tipo:** Proyecto académico y de portafolio  
**Asignatura:** Gestión de Servidores y Seguridad  
**Plataforma objetivo:** Linux (laboratorio con Arch Linux, Ubuntu Server y/o Rocky Linux)  
**Tecnología principal:** Bash

## 1. Propósito

Desarrollar una herramienta modular de línea de comandos que permita practicar y demostrar tareas fundamentales de administración de servidores Linux mediante scripts Bash. El proyecto sirve tanto para preparar evaluaciones prácticas como para presentar evidencias técnicas reproducibles en GitHub.

## 2. Objetivos

- Automatizar tareas frecuentes de consulta, administración y respaldo en Linux.
- Aplicar programación Bash: variables, argumentos, condicionales, ciclos, funciones y códigos de salida.
- Practicar rutas, permisos, usuarios, grupos, inodes, enlaces, filtros y redirecciones.
- Operar un laboratorio cliente-servidor con SSH y SCP.
- Documentar comandos, decisiones, pruebas y limitaciones.
- Implementar primero una versión mínima viable (MVP), luego extensiones.

## 3. Alcance

### Incluido

- Menú interactivo de terminal y módulos Bash independientes.
- Consultas de usuarios, grupos y permisos; cambios administrativos controlados.
- Respaldos `.tar.gz`, inspección y prueba de extracción.
- Diagnóstico básico de red, acceso SSH y transferencia SCP.
- Búsqueda y filtrado de archivos, inspección de inodes y enlaces.
- Monitoreo básico del servidor y generación de reportes.
- Pruebas sobre archivos ficticios en un entorno de laboratorio.

### Excluido en la versión 1.0

- Interfaz web o gráfica.
- Despliegue público en Internet y administración de infraestructura productiva.
- Almacenamiento de contraseñas, claves privadas o secretos en el repositorio.
- Gestión automatizada de firewalls, bases de datos o configuración de servicios web.
- Soporte garantizado para todas las distribuciones Linux.

## 4. Usuarios y entorno

**Usuario principal:** estudiante o administrador principiante que ejecuta el toolkit desde una terminal Linux.  
**Entorno recomendado:** máquina virtual Ubuntu Server o Rocky Linux y cliente Arch Linux en red local o virtual aislada.  
**Privilegios:** ejecución normal sin root; elevación con `sudo` solo para acciones concretas y justificadas.

## 5. Requisitos funcionales

Cada requisito tiene un identificador estable para relacionarlo con pruebas y evidencias.

### RF-01 — Menú principal

- **RF-01.1:** El sistema mostrará un menú numerado con opciones de módulos y salida.
- **RF-01.2:** Leerá la selección del usuario y ejecutará el módulo correspondiente.
- **RF-01.3:** Permanecerá activo hasta que el usuario seleccione salir.
- **RF-01.4:** Informará cuando una opción sea inválida, sin terminar inesperadamente.


-**EJEMPLO**: 
  [1] Usuarios y permisos
  [2] Crear y verificar respaldos
  [3] Conexiones SSH / SCP
  [4] Buscar archivos y enlaces
  [5] Monitorear servidor
  [6] Generar reporte
  [0] Sali


**Aceptación:** una secuencia de opciones válidas e inválidas no interrumpe el programa; la opción de salida termina con código `0`.

### RF-02 — Usuarios y permisos

- **RF-02.1:** Consultará el usuario actual, UID, grupos y directorio personal.
- **RF-02.2:** Mostrará permisos y propietario de un archivo o directorio indicado.
- **RF-02.3:** Permitirá modificar permisos con `chmod`, previa validación de ruta y confirmación.
- **RF-02.4:** Permitirá modificar usuario y grupo con `chown` únicamente cuando el operador tenga permisos suficientes, previa confirmación.
- **RF-02.5:** Distinguirá los propósitos de `/etc/passwd`, `/etc/group` y `/etc/shadow`, sin imprimir hashes de contraseñas.

**Aceptación:** el usuario puede consultar permisos y modificar los de un archivo de prueba; las operaciones no autorizadas informan el error sin fingir éxito.

### RF-03 — Respaldos

- **RF-03.1:** Solicitará un directorio fuente existente y legible.
- **RF-03.2:** Generará un respaldo `.tar.gz` con nombre que incluya fecha y hora.
- **RF-03.3:** Guardará el respaldo en un directorio configurable distinto de la fuente, evitando incluir el archivo de respaldo dentro de sí mismo.
- **RF-03.4:** Permitirá listar el contenido del archivo generado.
- **RF-03.5:** Verificará que el respaldo se puede extraer en un directorio temporal o de pruebas, sin sobrescribir archivos del usuario.
- **RF-03.6:** Informará la ruta del respaldo y el resultado real de cada operación.

**Aceptación:** un conjunto de archivos de prueba puede respaldarse, listarse y recuperarse con el mismo contenido.

### RF-04 — Acceso remoto y transferencia

- **RF-04.1:** Mostrará interfaces y direcciones IP mediante herramientas disponibles del sistema.
- **RF-04.2:** Permitirá probar conectividad hacia un host autorizado.
- **RF-04.3:** Facilitará una conexión SSH indicando usuario y host.
- **RF-04.4:** Permitirá subir y descargar un archivo de prueba mediante SCP.
- **RF-04.5:** Validará entradas básicas y reportará errores de conexión o transferencia.
- **RF-04.6:** No desactivará la verificación de claves de host SSH ni solicitará almacenar contraseñas en texto plano.

**Aceptación:** en una red de laboratorio, el operador puede transferir un archivo entre cliente y servidor y verificar su integridad.

### RF-05 — Archivos, búsquedas y enlaces

- **RF-05.1:** Buscará archivos por nombre o extensión en un directorio indicado.
- **RF-05.2:** Filtrará líneas de archivos de texto con `grep`, con opción de ignorar mayúsculas y mostrar números de línea.
- **RF-05.3:** Mostrará inode, tipo y permisos de archivos seleccionados.
- **RF-05.4:** Creará enlaces físicos y simbólicos sobre archivos de prueba cuando sea válido.
- **RF-05.5:** Permitirá demostrar el comportamiento de ambos tipos de enlace cuando se elimina el nombre original, sin borrar archivos personales.

**Aceptación:** las búsquedas devuelven resultados esperados y una demostración permite observar qué enlaces comparten inode y cuál puede quedar roto.

### RF-06 — Monitoreo e informes

- **RF-06.1:** Consultará fecha, hostname, usuario actual y tiempo de actividad.
- **RF-06.2:** Consultará uso de disco y memoria con comandos disponibles.
- **RF-06.3:** Consultará el estado de un servicio cuando el sistema utilice `systemd`.
- **RF-06.4:** Generará un informe de texto con marca de tiempo, separando resultados de mensajes de error.

**Aceptación:** el informe contiene información real del equipo y puede revisarse con `cat` o `less`.

### RF-07 — Manejo de errores y registro

- **RF-07.1:** Las operaciones comprobarán sus precondiciones (rutas, herramientas, permisos y parámetros).
- **RF-07.2:** Los módulos devolverán códigos de salida coherentes y mensajes comprensibles.
- **RF-07.3:** Se registrarán operaciones relevantes sin almacenar contraseñas, tokens o claves privadas.
- **RF-07.4:** Las rutas se tratarán con comillas adecuadas para admitir espacios y reducir errores de expansión.

**Aceptación:** rutas inexistentes, opciones inválidas y permisos insuficientes producen errores controlados.

## 6. Requisitos no funcionales

| ID | Requisito | Criterio de verificación |
|---|---|---|
| RNF-01 | Portabilidad | Bash como intérprete; documentar diferencias entre distribuciones y dependencias externas. |
| RNF-02 | Modularidad | Cada módulo reside en `modules/` y el menú principal solo coordina operaciones. |
| RNF-03 | Seguridad | Sin `sudo` global; confirmar cambios, no exponer secretos y usar laboratorio aislado. |
| RNF-04 | Usabilidad | Menús claros, mensajes legibles, opción de regresar y errores explicativos. |
| RNF-05 | Mantenibilidad | Funciones con nombres descriptivos, código legible y validación con `bash -n`. |
| RNF-06 | Verificabilidad | Cada RF tendrá al menos una prueba o evidencia documentada. |
| RNF-07 | Documentación | README con instalación, uso, estructura, requisitos, capturas y limitaciones. |
| RNF-08 | Integridad de datos | Los respaldos se verifican y las pruebas destructivas se limitan a directorios temporales. |

## 7. Arquitectura propuesta

```text
linux-server-toolkit/
├── README.md
├── REQUIREMENTS.md
├── LICENSE
├── .gitignore
├── main.sh
├── modules/
│   ├── users.sh
│   ├── backups.sh
│   ├── remote.sh
│   ├── files.sh
│   └── monitoring.sh
├── config/
│   └── example.conf
├── tests/
│   └── test_backups.sh
├── docs/
│   ├── architecture.md
│   └── commands.md
└── screenshots/
```

Los nombres representan la estructura prevista, no archivos ya implementados. El script `main.sh` presenta el menú y delega tareas a funciones de los módulos. Las configuraciones de ejemplo no contienen credenciales reales.

## 8. Matriz de trazabilidad académica

| Tema del curso | Requisitos relacionados | Evidencia sugerida |
|---|---|---|
| Prompt, rutas, `pwd`, `cd`, `ls` | RF-01, RF-05 | Navegación y resolución de rutas |
| Usuarios, grupos, `sudo`, `chmod`, `chown` | RF-02 | Antes/después de permisos |
| `find`, `grep`, pipes y redirecciones | RF-05, RF-06 | Búsqueda y reporte filtrado |
| `stdin`, `stdout`, `stderr` | RF-01, RF-06, RF-07 | Registro de salida y errores |
| Inodes, hard links, symlinks | RF-05 | Comparación con `ls -li` |
| TAR y gzip | RF-03 | Respaldo y restauración |
| IP, SSH, SCP, cliente-servidor | RF-04 | Transferencia entre equipos |
| Bash: variables, funciones, `case`, ciclos | RF-01 a RF-07 | Código y ejecución de módulos |
| DNS, DHCP, HTTP | RF-04 y documentación | Explicación de protocolos y diagnóstico |
| Virtualización y gestores de paquetes | Entorno y documentación | Preparación del laboratorio |

## 9. Casos de prueba mínimos

| ID | Escenario | Resultado esperado | RF |
|---|---|---|---|
| CP-01 | Seleccionar opción inválida | Se informa el error y reaparece el menú | RF-01 |
| CP-02 | Consultar archivo de prueba | Se muestran permisos y propietario | RF-02 |
| CP-03 | Intentar cambiar propietario sin privilegios | Se informa fallo sin indicar éxito | RF-02 |
| CP-04 | Respaldar carpeta con varios archivos | Se genera un `.tar.gz` válido | RF-03 |
| CP-05 | Restaurar respaldo en carpeta temporal | Archivos recuperados correctamente | RF-03 |
| CP-06 | Conectar a host no disponible | Se informa el fallo sin bloquear indefinidamente | RF-04 |
| CP-07 | Transferir archivo por SCP en laboratorio | Archivo recibido e integridad verificada | RF-04 |
| CP-08 | Comparar enlaces físico y simbólico | Se observa comportamiento esperado | RF-05 |
| CP-09 | Buscar texto con `grep -in` | Coincidencias con número de línea | RF-05 |
| CP-10 | Generar reporte | Archivo con fecha, host, usuario y recursos | RF-06 |

## 10. Plan de entregas

### Fase 1 — MVP para repaso del examen

- [ ] Crear repositorio, estructura y `main.sh`.
- [ ] Implementar menú con `while`, `case`, funciones y validación.
- [ ] Crear práctica de archivos, permisos y enlaces.
- [ ] Crear respaldo `.tar.gz` y verificar extracción.
- [ ] Realizar una transferencia SSH/SCP en laboratorio.
- [ ] Generar un reporte básico del servidor.

### Fase 2 — Consolidación posterior al examen

- [ ] Completar administración controlada de usuarios y permisos.
- [ ] Robustecer validaciones, manejo de errores y logs.
- [ ] Incorporar pruebas automatizadas y ShellCheck.
- [ ] Documentar diferencias Arch/Ubuntu/Rocky.
- [ ] Añadir capturas y ejemplos de ejecución al README.
- [ ] Publicar una versión etiquetada `v1.0.0` cuando cumpla sus criterios.

## 11. Definición de terminado

Una funcionalidad se considera terminada solo cuando: (1) cumple su requisito, (2) maneja entradas inválidas, (3) se probó en el laboratorio, (4) tiene evidencia o prueba reproducible y (5) está documentada. No se marcará como terminada por el solo hecho de escribir el script.

## 12. Consideraciones de seguridad

- Ejecutar pruebas de cambios de permisos, enlaces y borrado solo en carpetas creadas para el laboratorio.
- No publicar direcciones privadas sensibles, nombres de usuario personales, contraseñas, claves SSH ni contenido de `/etc/shadow`.
- No utilizar `rm -rf` sobre rutas proporcionadas por el usuario sin controles estrictos; preferir operaciones seguras en directorios temporales.
- No ejecutar todo el programa como root; elevar privilegios únicamente para operaciones específicas.
- Validar el destino antes de restaurar archivos o copiar datos por SCP.
- Mantener la verificación normal de identidad de servidores SSH.

## 13. Documentación y presentación en GitHub

El README deberá explicar el problema que resuelve el toolkit, el entorno del laboratorio, los comandos de instalación y ejecución, las funcionalidades terminadas, una demostración breve y las limitaciones. Las capturas deberán corresponder a ejecuciones reales. Las afirmaciones sobre compatibilidad y pruebas deberán sustentarse en evidencia.

---

**Nota:** este documento define los requisitos planificados; no implica que el software ya esté implementado. Las ampliaciones deberán registrarse mediante cambios de versión y commits descriptivos.
