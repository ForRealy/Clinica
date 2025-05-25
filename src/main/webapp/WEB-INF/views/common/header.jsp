<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header class="main-header">
    <div class="header-content">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">Clínica Dental</a>
        </div>
        <div class="user-info">
            <sec:authorize access="isAuthenticated()">
                <span class="welcome">Bienvenido, <sec:authentication property="name"/></span>
                <div class="user-role">
                    <sec:authorize access="hasRole('ADMIN')">
                        <span class="role-badge admin">Administrador</span>
                    </sec:authorize>
                    <sec:authorize access="hasRole('DENTIST')">
                        <span class="role-badge dentist">Dentista</span>
                    </sec:authorize>
                    <sec:authorize access="hasRole('PATIENT')">
                        <span class="role-badge patient">Paciente</span>
                    </sec:authorize>
                </div>
            </sec:authorize>
        </div>
    </div>
    <nav class="main-nav">
        <sec:authorize access="hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Panel de Control</a>
            <a href="${pageContext.request.contextPath}/admin/users">Gestión de Usuarios</a>
            <a href="${pageContext.request.contextPath}/admin/dentists">Dentistas</a>
            <a href="${pageContext.request.contextPath}/admin/patients">Pacientes</a>
        </sec:authorize>
        <sec:authorize access="hasRole('DENTIST')">
            <a href="${pageContext.request.contextPath}/dentist/dashboard">Panel de Control</a>
            <a href="${pageContext.request.contextPath}/dentist/appointments">Citas</a>
            <a href="${pageContext.request.contextPath}/dentist/patients">Mis Pacientes</a>
        </sec:authorize>
        <sec:authorize access="hasRole('PATIENT')">
            <a href="${pageContext.request.contextPath}/patient/dashboard">Panel de Control</a>
            <a href="${pageContext.request.contextPath}/patient/appointments">Mis Citas</a>
            <a href="${pageContext.request.contextPath}/patient/profile">Mi Perfil</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a href="${pageContext.request.contextPath}/logout" class="logout">Cerrar Sesión</a>
        </sec:authorize>
    </nav>
</header> 