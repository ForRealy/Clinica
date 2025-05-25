<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Panel de Administración - Clínica Dental</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <h1>Panel de Administración</h1>
        
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <h2>Gestión de Usuarios</h2>
                <p>Gestionar todos los usuarios del sistema</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="button">Ver Usuarios</a>
            </div>
            
            <div class="dashboard-card">
                <h2>Gestión de Dentistas</h2>
                <p>Gestionar perfiles y horarios de dentistas</p>
                <a href="${pageContext.request.contextPath}/admin/dentists" class="button">Ver Dentistas</a>
            </div>
            
            <div class="dashboard-card">
                <h2>Gestión de Pacientes</h2>
                <p>Gestionar registros y citas de pacientes</p>
                <a href="${pageContext.request.contextPath}/admin/patients" class="button">Ver Pacientes</a>
            </div>
        </div>
    </div>
</body>
</html> 