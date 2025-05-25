<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Mis Pacientes</h2>
    
    <div class="card">
        <div class="card-body">
            <c:if test="${empty visits}">
                <p class="text-muted">No se encontraron pacientes.</p>
            </c:if>
            <c:if test="${not empty visits}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>ID del Paciente</th>
                                <th>Última Visita</th>
                                <th>Estado</th>
                                <th>Notas</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${visits}" var="visit">
                                <tr>
                                    <td>${visit.patientId}</td>
                                    <td>
                                        <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>
                                        <span class="badge ${visit.status == 'COMPLETED' ? 'bg-success' : 
                                                          visit.status == 'CONFIRMED' ? 'bg-primary' : 
                                                          visit.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                            ${visit.status == 'COMPLETED' ? 'COMPLETADA' : 
                                              visit.status == 'CONFIRMED' ? 'CONFIRMADA' : 
                                              visit.status == 'PENDING' ? 'PENDIENTE' : 'CANCELADA'}
                                        </span>
                                    </td>
                                    <td>${visit.notes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 