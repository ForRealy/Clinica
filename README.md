# Clinica Web Application

Clinica is a web application designed for managing dental clinic operations, including user management, patient records, and appointment scheduling.

## Table of Contents

- [Clinica Web Application](#clinica-web-application)
  - [Table of Contents](#table-of-contents)
  - [Installation](#installation)
  - [Usage](#usage)
  - [Dependencies](#dependencies)
  - [License](#license)

## Installation

To get started with this project, clone the repository and install the necessary dependencies:

```bash
git clone https://github.com/tu_nombre/tu_repositorio.git
cd tu_repositorio
# Ensure you have Maven installed
mvn clean install
```

## Usage

To run the application, you can deploy it on a servlet container like Apache Tomcat. Make sure to configure your database connection in `src/main/resources/META-INF/persistence.xml`.

1. Start your database server (e.g., MySQL).
2. Deploy the generated WAR file located in the `target` directory to your servlet container.
3. Access the application at `http://localhost:8080/clinica`.

## Dependencies

This project uses the following key dependencies:

- **Hibernate**: For ORM (Object-Relational Mapping).
- **MySQL Connector**: For database connectivity.
- **JUnit**: For testing purposes.
- **Jakarta Servlet API**: For building web applications.

You can find the complete list of dependencies in the `pom.xml` file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.