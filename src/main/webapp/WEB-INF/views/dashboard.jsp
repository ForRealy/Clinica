<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layout/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h2>Bienvenido al Sistema de Gestión de Clínica Dental</h2>
        <hr>
    </div>
</div>

<c:if test="${pageContext.request.userPrincipal.authorities.contains('ROLE_ADMIN')}">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Dentistas</h5>
                    <p class="card-text">Gestionar el personal dental y sus horarios.</p>
                    <a href="${pageContext.request.contextPath}/admin/dentists" class="btn btn-primary">Gestionar Dentistas</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Pacientes</h5>
                    <p class="card-text">Gestionar registros e información de pacientes.</p>
                    <a href="${pageContext.request.contextPath}/admin/patients" class="btn btn-primary">Gestionar Pacientes</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Citas</h5>
                    <p class="card-text">Programar y gestionar visitas de pacientes.</p>
                    <a href="${pageContext.request.contextPath}/admin/visits" class="btn btn-primary">Gestionar Citas</a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${pageContext.request.userPrincipal.authorities.contains('ROLE_DENTIST')}">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Mis Citas</h5>
                    <p class="card-text">Ver y gestionar tus citas programadas.</p>
                    <a href="${pageContext.request.contextPath}/dentist/appointments" class="btn btn-primary">Ver Citas</a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="layout/footer.jsp" /> 