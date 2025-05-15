<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>Lista de Usuarios</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Lista de Usuarios</h2>
        <a href="usuario/form" class="btn btn-primary mb-3">Nuevo Usuario</a>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Username</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${usuarios}" var="u">
    <tr>
      <td>${u.id}</td>
      <td>${u.username}</td>
      <td>${u.rol}</td>
      <td>
                            <a href="usuario/form?id=${u.id}" class="btn btn-sm btn-warning">Editar</a>
                            <a href="usuario/delete?id=${u.id}" class="btn btn-sm btn-danger" onclick="return confirm('¿Está seguro?')">Eliminar</a>
      </td>
    </tr>
  </c:forEach>
            </tbody>
</table>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
