<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>${usuario == null ? 'Nuevo' : 'Editar'} Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>${usuario == null ? 'Nuevo' : 'Editar'} Usuario</h2>
        <form action="save" method="post" class="col-md-6">
            <input type="hidden" name="id" value="${usuario.id}">
            
            <div class="mb-3">
                <label for="username" class="form-label">Username:</label>
                <input type="text" class="form-control" id="username" name="username" value="${usuario.username}" required>
            </div>
            
            <div class="mb-3">
                <label for="password" class="form-label">Password:</label>
                <input type="password" class="form-control" id="password" name="password" ${usuario == null ? 'required' : ''}>
                <c:if test="${usuario != null}">
                    <small class="text-muted">Dejar en blanco para mantener la contraseña actual</small>
                </c:if>
            </div>
            
            <div class="mb-3">
                <label for="rol" class="form-label">Rol:</label>
                <select class="form-select" id="rol" name="rol" required>
                    <option value="ADMIN" ${usuario.rol == 'ADMIN' ? 'selected' : ''}>Administrador</option>
                    <option value="ODONTO" ${usuario.rol == 'ODONTO' ? 'selected' : ''}>Odontólogo</option>
                </select>
            </div>
            
            <button type="submit" class="btn btn-primary">Guardar</button>
            <a href="../usuarios" class="btn btn-secondary">Cancelar</a>
</form>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
