# Semperti DevOps/SRE Bootcamp - Journal Management System

Este repositorio contiene una aplicación Spring Boot utilizada para el bootcamp de DevOps/SRE en Semperti. El sistema permite la gestión de journals académicos con capacidad de carga y visualización de PDFs.

## 🚀 Quick Start

### Prerequisites

- Java 8
- Maven 3.3+
- MySQL 5.6+
- Docker (opcional)
- Internet connection

### Instalación y Ejecución Local

1. **Clonar el repositorio**
   ```bash
   git clone https://github.com/semperti-bootcamp/sre-bootcamp-[nombre]-[fecha].git
   cd sre-bootcamp-[nombre]-[fecha]
   ```

2. **Configurar la base de datos**
   ```bash
   # Editar la configuración de MySQL
   vim Code/src/main/resources/application.properties
   
   # Configurar las siguientes propiedades:
   # spring.datasource.url=jdbc:mysql://localhost:3306/journals
   # spring.datasource.username=root
   # spring.datasource.password=your_password
   ```

3. **Compilar y ejecutar la aplicación**
   ```bash
   cd Code
   mvn clean install
   mvn spring-boot:run
   ```

4. **Acceder a la aplicación**
   - URL: http://localhost:8080
   - Ver credenciales de acceso más abajo

### 🐳 Ejecución con Docker

```bash
# Construir la imagen
docker build -t journals-app:latest .

# Ejecutar el contenedor
docker run -d -p 8080:8080 \
  -e MYSQL_HOST=mysql \
  -e MYSQL_USER=root \
  -e MYSQL_PASSWORD=password \
  journals-app:latest
```

## 📋 Credenciales de Acceso

El sistema incluye 4 usuarios pre-configurados:

### Publishers (pueden crear y gestionar journals)
- **Usuario:** publisher1 / **Contraseña:** publisher1
- **Usuario:** publisher2 / **Contraseña:** publisher2

### Usuarios Públicos (solo lectura)
- **Usuario:** user1 / **Contraseña:** user1
- **Usuario:** user2 / **Contraseña:** user2

## 🏗️ Arquitectura de la Aplicación

### Stack Tecnológico
- **Backend:** Spring Boot 1.3.3
- **Frontend:** Thymeleaf + AngularJS
- **Base de Datos:** MySQL 5.6+
- **Seguridad:** Spring Security
- **Build Tool:** Maven

### Estructura del Proyecto
```
Code/
├── pom.xml                          # Configuración Maven
└── src/
    ├── main/
    │   ├── java/                    # Código fuente Java
    │   │   └── com/semperti/trial/journals/
    │   │       ├── config/          # Configuración Spring
    │   │       ├── controller/      # Controladores MVC
    │   │       ├── model/           # Entidades JPA
    │   │       ├── repository/      # Repositorios
    │   │       ├── rest/            # APIs REST
    │   │       └── service/         # Lógica de negocio
    │   └── resources/
    │       ├── application.properties
    │       ├── static/              # Assets (CSS, JS)
    │       └── templates/           # Vistas Thymeleaf
    └── test/                        # Tests unitarios
```

## 🧪 Testing

```bash
# Ejecutar todos los tests
mvn test

# Ejecutar un test específico
mvn test -Dtest=CategoryRestServiceTest

# Generar reporte de cobertura
mvn jacoco:report
```

## 📦 Gestión de PDFs

- **Directorio por defecto:** `~/upload`
- **Cambiar directorio:** `-Dupload-dir=/path/to/directory`
- **PDFs de ejemplo:** Disponibles en la carpeta `PDFs/`

Para usar los PDFs de ejemplo:
```bash
cp -r PDFs/* ~/upload/
```

## 🔧 Configuración Avanzada

### Variables de Entorno
- `MYSQL_HOST`: Host de MySQL (default: localhost)
- `MYSQL_PORT`: Puerto de MySQL (default: 3306)
- `MYSQL_DATABASE`: Nombre de la base de datos (default: journals)
- `MYSQL_USER`: Usuario de MySQL
- `MYSQL_PASSWORD`: Contraseña de MySQL
- `UPLOAD_DIR`: Directorio para almacenar PDFs

### Propiedades de la Aplicación
Editar `Code/src/main/resources/application.properties`:
- `spring.jpa.hibernate.ddl-auto`: Estrategia de creación de esquema
- `multipart.maxFileSize`: Tamaño máximo de archivo (default: 1MB)
- `spring.jpa.show-sql`: Mostrar queries SQL en logs

## 📞 Contacto y Soporte

Para dudas o consultas sobre el bootcamp:
- **Slack:** [Semperti Workspace](https://semperti.slack.com)
- **Canal:** #bootcamp-devops-sre


---

# 📚 Guía del Bootcamp DevOps/SRE

## 🎯 Objetivos del Bootcamp

Este bootcamp está diseñado para introducir a nuevos miembros del equipo DevOps/SRE en las prácticas y herramientas utilizadas en Semperti. A través de ejercicios prácticos con esta aplicación, los participantes aprenderán:

- Infrastructure as Code (Terraform)
- Configuration Management (Ansible)
- Containerización (Docker)
- CI/CD Pipelines (Jenkins)
- Gestión de artefactos (Nexus)
- GitOps y mejores prácticas

## 📋 Metodología de Trabajo

### Nomenclatura y Organización
- **Repositorio:** `sre-bootcamp-[nombre]-[YYMMDD]`
- **Branches:** `task[número]-[descripción]`
- **PRs:** Solo archivos modificados, nunca el repo completo
- **Documentación:** README.md en cada branch con detalles de implementación

### Flujo de Trabajo
1. Fork del repositorio base
2. Crear branch para cada tarea
3. Implementar cambios
4. Documentar en README
5. Crear PR
6. Marcar como resuelto en Zoho Sprint

## 🚀 Tareas del Bootcamp

### Task 1: Crear VM con Terraform
**Objetivo:** Provisionar infraestructura en la nube usando IaC

**Requisitos:**
- VM con máximo 2 cores y 2GB RAM
- Sistema operativo CentOS 7
- Accesible por VPN
- Conectividad a Internet

**Entregables:**
- Archivos de Terraform (.tf)
- Plan de ejecución
- Output de terraform apply
- Documentación de pasos

### Task 2: Configurar VM con Ansible
**Objetivo:** Automatizar la configuración del servidor

**Requisitos:**
- Instalar Java 8, Maven 3.3+, MySQL 5.6+
- Configurar servicios necesarios
- Preparar ambiente para la aplicación

**Entregables:**
- Playbooks de Ansible
- Inventory files
- Screenshots de verificación
- Guía de ejecución

### Task 3: Probar Aplicación Java
**Objetivo:** Desplegar y validar la aplicación

**Requisitos:**
- Aplicación 100% funcional
- Crear y visualizar journals/PDFs
- Pasar todos los tests de Maven

**Entregables:**
- URL de acceso público
- Evidencia de funcionalidad
- Resultados de tests

### Task 4: Cargar en Nexus
**Objetivo:** Gestión de artefactos

**Requisitos:**
- Subir snapshot a Nexus
- Subir release a Nexus
- Automatizar con Ansible

**Entregables:**
- Scripts de Ansible
- URLs de artefactos en Nexus
- Documentación del proceso

### Task 5: Dockerizar Aplicación
**Objetivo:** Containerización de la aplicación

**Requisitos:**
- Crear Dockerfile optimizado
- Container funcional
- Exponer puertos necesarios

**Entregables:**
- Dockerfile
- docker-compose.yml (opcional)
- URL de aplicación en container

### Task 6: Subir Imagen a Registry
**Objetivo:** Gestión de imágenes Docker

**Requisitos:**
- Push a Docker Hub/Nexus
- Sistema de versionado
- Documentar proceso

**Entregables:**
- URL de imagen en registry
- Esquema de tagging
- Comandos de pull/run

### Task 7: Pipeline CI
**Objetivo:** Automatización de integración continua

**Requisitos:**
- Trigger en PRs
- Stages: build, test, package
- Upload a Nexus
- Jenkins slave dedicado

**Entregables:**
- Jenkinsfile
- Configuración de job
- Evidencia de ejecución

### Task 8: Pipeline CD
**Objetivo:** Automatización de despliegue

**Requisitos:**
- Deploy automático
- Health checks
- Rollback capability

**Entregables:**
- Pipeline de deployment
- Estrategia de despliegue
- Logs de ejecución

### Task 9: GitOps
**Objetivo:** Implementar GitOps workflow

**Requisitos:**
- Manifests en GitHub
- Múltiples ambientes (staging/prod)
- Deploy basado en commits

**Entregables:**
- Estructura de manifests
- Configuración por ambiente
- Documentación de workflow

## 📊 Criterios de Evaluación

### Aspectos Técnicos
- ✅ Funcionalidad completa
- ✅ Código limpio y documentado
- ✅ Mejores prácticas aplicadas
- ✅ Automatización efectiva

### Aspectos Profesionales
- ✅ Comunicación clara
- ✅ Resolución de problemas
- ✅ Trabajo independiente
- ✅ Documentación completa

## 🛠️ Herramientas y Recursos

### Herramientas Requeridas
- Git
- Docker Desktop
- Terraform CLI
- Ansible
- Maven
- IDE (IntelliJ IDEA, VS Code)

### Recursos Útiles
- [Spring Boot Documentation](https://spring.io/projects/spring-boot)
- [Terraform Azure Provider](https://registry.terraform.io/providers/hashicorp/azurerm/latest)
- [Ansible Documentation](https://docs.ansible.com/)
- [Jenkins Pipeline Syntax](https://www.jenkins.io/doc/book/pipeline/syntax/)

## 💡 Tips para el Éxito

1. **Planifica antes de ejecutar:** Lee todos los requisitos antes de comenzar
2. **Documenta todo:** Incluye comandos, outputs y decisiones tomadas
3. **Testea localmente:** Valida cambios antes de hacer push
4. **Pide ayuda:** Usa Slack cuando te bloquees
5. **Aprende de errores:** Los logs son tus amigos

## 🏆 Siguientes Pasos

Una vez completado el bootcamp:
1. Review session con el equipo
2. Asignación a proyecto real
3. Mentoría continua
4. Certificación en herramientas específicas

---

# Historial de Actividades Completadas

## General
- 0.0	Generar un repositorio dentro de https://github.com/semperti-bootcamp y generar un commit con los archivos iniciales del repo original SIN MODIFICACIONES
- 0.1	El nombre debe respetar la siguiente nomenclatura: sre-bootcamp-name-<YYMMDD>  --> La fecha debe ser el día de inicio del Bootcamp
- 0.2	Se debe generar un branch por cada assignment
- 0.3	Sólo deben generarse PRs con los archivos MODIFICADOS contra el repositorio generado en el punto 0.0
- 0.4	Se debe setear como resuelto en Zoho Sprint con el vínculo al PR
- 0.5	Siempre se debe incluir un Readme.md con toda la información necesaria para evaluar el trabajo realizado [pasos para probar, inconvenientes encontrados, etc.]

Resultado
> Se creo el repositorio https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107		

## Crear VM con Terraform
-  1.0	La VM no debe tener más que 2 cores y 2 GB de RAM
-  1.1	La VM debe tener CentOS7
-  1.2	La VM debe ser accesible mediante VPN
-  1.3	La VM debe poder conectarse a internet

Resultado
> Ya se solicito un PR, https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/pull/1 .

> Plan de terraform -> https://drive.google.com/file/d/1fbmAgi8BrPLOCbP7nhOMJEbl2PeN59KM/view?usp=sharing .

> Output de terraform -> https://drive.google.com/file/d/1j8OukUsEymJ9K3Nfq-DKJJT6jNSKSX5L/view?usp=sharing .

**Informaación Adicional**
> Readme.md del branch :  [/TF/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task2-terraform-vm/TF/README.md).


## Configurar VM con Ansible
-  2.0	Deben configurarse todos los elementos solicitados [Java 8, Maven, MySQL, etc.]
-  2.1	Deben proveerse screenshots validando los paquetes instalados
-  2.2	Deben proveerse los scripts de configuración
-  2.3	Deben describirse todos los pasos y requerimientos para ejecutar el script de Ansible

Resultado
> Se genero el branch task3-ansible con los cambios solicitados.

> Ya se solicito un PR, https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/pull/2

> Tambien existe un nuevo archivo readme.md dentro de la carpeta Ansible con la informacion necesaria para ejecutar este caso.

> Output -> https://drive.google.com/file/d/15sIBrs36nlZuypMtIM_65khMlzROQZQE/view?usp=sharing

> Output -> https://drive.google.com/file/d/1zRLInrXsy5xACLKNGu7x8mS8vw5X9XPM/view?usp=sharing

> Checking del software instalado -> https://drive.google.com/file/d/1zEoJ2M7w7jSiD7UTpKvfDl72iAii7f_4/view?usp=sharing

> Operacion completa -> https://drive.google.com/file/d/1G1L5c_oAB0BQD8cT1XvRacE6J06dbBz1/view?usp=sharing

> Se hizo un commit adicional, por un problema con la version de maven. Se sube evidencia adicional https://drive.google.com/file/d/1mm8AGcIiH9Ci6nD_2UKlpqeKIVHYmu_M/view?usp=sharing

**Informaación Adicional**
> Readme.md del branch :  [/Ansible/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task3-ansible/Ansible/README.md).

## Probar aplicación Java
-  3.0	Se debe proveer un link de acceso a la aplicación
-  3.1	Debe quedar 100% funcional [crear un jornal (PDF), ver PDFs previos, etc]
-  3.2	Debe pasar el testeo de Maven

Resultado
> La aplicacion quedo disponible en http://vmbootcamp2020.eastus.cloudapp.azure.com:8080

> Se detecto que por el tamaño de maquina que se eligio para el script de tf, no permitia levantar por mvn la aplicacion.

> Se adjunta evidencia del build -> https://drive.google.com/file/d/1pK0Axedv7nowF8_Si-0fADO3byWRu-7j/view?usp=sharing

> Se adjunto evidencia del test ->  https://drive.google.com/file/d/13nsI-LJ0NR9ffWE18qWNs-BEKWTbMoYs/view?usp=sharing

> Compilacion local -> https://drive.google.com/file/d/1EAjYDkfAQKQHkssbLH3qtzgrxqC8zATb/view?usp=sharing

> Testing local -> https://drive.google.com/file/d/1IXGTQS1Agol7p4WCXsL_Pp-cqsQqgs06/view?usp=sharing

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task4-appjava/README.md).

## Cargar Aplicación Java en repositorio Nexus
-  4.0	Se debe cargar en Nexus un snapshot de la aplicación Java
-  4.1	Se debe cargar en Nexus un release de la aplicación Java
-  4.2	Se deben realizar mediante un script de Ansible
-  4.3	Se debe proveer todos los archivos necesarios para realizar estas tareas

Resultado
> Se genero el branch task5-ansible con los cambios solicitados.		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task5-nexus/README.md).

## Dockerizar aplicación Java
-  5.0	Se debe proveer el Dockerfile y los archivos necesarios para generar la imagen
-  5.1	Debe quedar corriendo el container
-  5.2	Debe proveerse un link para probar el funcionamiento del contenedor

Resultado
> Se genero el branch task6-docker con los cambios solicitados.		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task6-docker/README.md).

## Subir Docker Image a Nexus
-  6.0	La imagen de Docker debe quedar accesible desde Nexus
-  6.1	Se debe proveer el comando para subir una imagen a Nexus junto con un comando para descargar la imagen y correr el contenedor
-  6.2	Debe proveerse el sistema lógico de taggeo de imágenes

Resultado
> Evidencia de publicacion de imagen en Docker Hub -> https://hub.docker.com/layers/jsfrnc/semperti-bootcamp/firsttry/images/sha256-8376360c4a63a30e65a9a0abda9871e2db7e05127929bccfe7e30973f4817351

> Output de publicacion -> https://drive.google.com/file/d/1KMfY5dYV0ILR1gJUsSI482ggYua18cex/view?usp=sharing

> Descarga y ejecucion de imagen -> https://drive.google.com/file/d/10QQ9dqkUTd1jAC3n9H289haYkj2xz1Ev/view?usp=sharing

> Script de Ansible -> https://drive.google.com/file/d/1sDRquwKhaKKhQBtqzG-dTUyBVnBwByTb/view?usp=sharing

> Repo con los distintos tags -> https://hub.docker.com/repository/docker/jsfrnc/bootcamp-journals/tags?page=1
		
**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task7-publish-dockerhub/README.md).

## Crear Pipeline de CI
-  7.0	Debe encontrarse dentro de un folder con el nombre bc-username
-  7.1	Debe ejecutarse el build cada vez que se realice un PR
-  7.2	Debe contener al menos, las etapas de configuración, unit testing, snapshot, release, upload a Nexus del artefacto de Maven y de la imagen de Docker
-  7.3	Debe ejecutarse en un Jenkins slave propio

Resultado
> Se genero el Pipeline y se uso como slave la maquina que se levanto en azure. 

>  Resultado del build -> https://drive.google.com/file/d/1OfvvhFAOncbLZ9ueIkYqB01FtJLCw7rb/view?usp=sharing

>  El mismo genera una nueva version del snapshot y release, sube los artefactos a Nexus.

>  Arme una api para generar el id autoincremental.

> Jenkins http://10.252.7.162:8080/job/bc-jfranco/"		

**Informaación Adicional**
> Readme.md del branch :  [/README.md](https://github.com/semperti-bootcamp/sre-bootcamp-jfranco-200107/blob/task8-jenkins/README.md).

## Crear Pipeline de CD
-  8.0	Debe encontrarse dentro de un folder con el nombre bc-username
-  8.1	Debe ejecutarse el build cada vez que se realice un PR
-  8.2	Debe contener al menos las etapas de descarga de imagen, ejecución de contenedor y prueba de acceso a la aplicación mediante un curl y su output

Resultado
> Se creo una task para el CD en journals-CD.

> A traves de la API obtiene el numero de version, baja esa imagen y hace las pruebas correspondientes.

> Jenkins http://10.252.7.162:8080/job/bc-jfranco/.	

**Informaación Adicional**
> N/A

## GitOps
-  9.0	Se debe realizar la configuración de un Manifest en GitHub
-  9.1	La modificación del Manifest, sólo deberá afectar el ambiente elegido [tiene que haber, al menos, dos ambientes distintos (staging/prod)]
-  9.2	Debe ejecutarse automáticamente, tras únicamente, la modificación del Manifest y SOLO del ambiente elegido

Resultado
> **En curso**

**Informaación Adicional**
> TBD.