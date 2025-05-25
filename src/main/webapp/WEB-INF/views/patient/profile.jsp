<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Mi Perfil</h2>
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Datos Personales</h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Nombre:</strong> ${patient.fullName}</li>
                <li class="list-group-item"><strong>Correo:</strong> ${patient.email}</li>
                <li class="list-group-item"><strong>Teléfono:</strong> ${patient.phone}</li>
                <li class="list-group-item"><strong>Fecha de Nacimiento:</strong> ${patient.dateOfBirth}</li>
                <li class="list-group-item"><strong>Método de Pago:</strong> ${patient.paymentMethod}</li>
            </ul>
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Visitas Completadas y Recetas</h5>
            <c:choose>
                <c:when test="${not empty completedVisits}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Fecha y Hora</th>
                                <th>Dentista</th>
                                <th>Motivo</th>
                                <th>Receta/Notas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${completedVisits}" var="visit">
                                <tr>
                                    <td>${visit.dateTime}</td>
                                    <td>${visit.dentistId}</td>
                                    <td>${visit.reason}</td>
                                    <td>${visit.notes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:when>
                <c:otherwise>
                    <div class="alert alert-info">Aún no hay visitas completadas.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 