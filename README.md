# Sistema de Gestión de Clínica Dental

Una aplicación web completa para gestionar una clínica dental, construida con Spring Boot y JSP.

## Características

### Gestión de Usuarios
- Sistema multi-rol (Administrador, Dentista, Paciente)
- Autenticación y autorización segura
- Control de acceso basado en roles
- Gestión de perfiles de usuario

### Características del Administrador
- Panel de control con visión general de las operaciones de la clínica
- Gestionar dentistas (agregar, editar, eliminar)
- Gestionar pacientes (agregar, editar, eliminar)
- Ver todas las citas y visitas
- Gestión de usuarios (crear cuentas, asignar roles)

### Características del Dentista
- Panel de control con visión general de citas
- Ver y gestionar citas
- Manejar solicitudes de citas
- Confirmar o cancelar citas
- Completar visitas con notas
- Ver historial de pacientes
- Gestionar su agenda

### Características del Paciente
- Panel de control con visión general de citas
- Solicitar nuevas citas
- Ver historial de citas
- Ver notas de visitas completadas
- Gestionar información del perfil
- Ver próximas citas

### Gestión de Citas
- Programación de citas en tiempo real
- Seguimiento del estado de las citas (Pendiente, Confirmada, Completada, Cancelada)
- Cumplimiento de horario laboral (Lunes-Viernes, 9 AM - 5 PM)
- Prevención de citas en fin de semana
- Espacios de cita de 30 minutos
- Asociación automática del nombre del paciente
- Notas de visita y seguimiento de finalización

### Características de Seguridad
- Integración con Spring Security
- Encriptación de contraseñas
- Gestión de sesiones
- Protección CSRF
- Seguridad de URL
- Control de acceso basado en roles

## Stack Tecnológico

### Backend
- Java 17
- Spring Boot 2.7.0
- Spring Security
- Spring MVC
- JSP/JSTL

### Frontend
- Bootstrap 5
- JavaScript
- JSP/JSTL
- CSS

### Base de Datos
- Almacenamiento de datos en memoria (ConcurrentHashMap)
- Identificación de entidades basada en UUID

## Comenzando

### Prerrequisitos
- Java 17 o superior
- Maven 3.6 o superior
- Navegador web moderno

### Instalación
1. Clonar el repositorio
```bash
git clone [url-del-repositorio]
```

2. Navegar al directorio del proyecto
```bash
cd dental-clinic
```

3. Construir el proyecto
```bash
mvn clean install
```

4. Ejecutar la aplicación
```bash
mvn spring-boot:run
```

5. Acceder a la aplicación en `http://localhost:8080/dental-clinic`

### Usuarios por Defecto
- Administrador: usuario: `admin`, contraseña: `admin`
- Dentista: usuario: `sarah`, contraseña: `password`
- Paciente: Crear una nueva cuenta a través del proceso de registro

## Uso

### Acceso de Administrador
1. Iniciar sesión como administrador
2. Acceder al panel de control en `/admin/dashboard`
3. Gestionar usuarios, dentistas y pacientes
4. Monitorear todas las citas

### Acceso de Dentista
1. Iniciar sesión como dentista
2. Acceder al panel de control en `/dentist/dashboard`
3. Ver y gestionar citas
4. Completar visitas con notas

### Acceso de Paciente
1. Iniciar sesión como paciente
2. Acceder al panel de control en `/patient/dashboard`
3. Solicitar nuevas citas
4. Ver historial de citas

## Reglas de Programación de Citas
- Las citas están disponibles de lunes a viernes
- Horario laboral: 9:00 AM a 5:00 PM
- Espacios de cita de 30 minutos
- No hay citas en fin de semana
- Los pacientes solo pueden tener una cita pendiente a la vez
- Las citas deben ser confirmadas por un dentista
- Las citas completadas incluyen notas de visita

## Notas de Seguridad
- Todas las contraseñas están encriptadas
- Las URLs están protegidas contra patrones maliciosos
- Se aplica gestión de sesiones
- La protección CSRF está habilitada
- Se implementa control de acceso basado en roles

## Contribuir
1. Hacer fork del repositorio
2. Crear una rama de características
3. Hacer commit de los cambios
4. Subir a la rama
5. Crear una Pull Request

## Licencia
Este proyecto está licenciado bajo la Licencia MIT - ver el archivo LICENSE para más detalles. 