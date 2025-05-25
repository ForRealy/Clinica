<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Mis Visitas</h2>
    
    <!-- Visitas Pendientes -->
    <div class="card mb-4">
        <div class="card-header">
            <h3 class="card-title">Solicitudes de Visita Pendientes</h3>
        </div>
        <div class="card-body">
            <c:if test="${empty pendingVisits}">
                <p class="text-muted">No hay solicitudes de visita pendientes.</p>
            </c:if>
            <c:if test="${not empty pendingVisits}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Fecha y Hora</th>
                                <th>Paciente</th>
                                <th>Motivo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pendingVisits}" var="visit">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${visit.patientId}</td>
                                    <td>${visit.reason}</td>
                                    <td>
                                        <form action="<c:url value='/visits/${visit.id}/confirm'/>" method="post" class="d-inline">
                                            <button type="submit" class="btn btn-success btn-sm">Confirmar</button>
                                        </form>
                                        <form action="<c:url value='/visits/${visit.id}/cancel'/>" method="post" class="d-inline">
                                            <button type="submit" class="btn btn-danger btn-sm">Cancelar</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Visitas Confirmadas -->
    <div class="card">
        <div class="card-header">
            <h3 class="card-title">Visitas Confirmadas</h3>
        </div>
        <div class="card-body">
            <c:if test="${empty confirmedVisits}">
                <p class="text-muted">No hay visitas confirmadas.</p>
            </c:if>
            <c:if test="${not empty confirmedVisits}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Fecha y Hora</th>
                                <th>Paciente</th>
                                <th>Motivo</th>
                                <th>Acciones</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${confirmedVisits}" var="visit">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${visit.patientId}</td>
                                    <td>${visit.reason}</td>
                                    <td>
                                        <button type="button" class="btn btn-primary btn-sm" 
                                                data-bs-toggle="modal" 
                                                data-bs-target="#completeVisitModal"
                                                data-visit-id="${visit.id}">
                                            Completar
                                        </button>
                                        <form action="<c:url value='/visits/${visit.id}/cancel'/>" method="post" class="d-inline">
                                            <button type="submit" class="btn btn-danger btn-sm">Cancelar</button>
                                        </form>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<!-- Modal Completar Visita -->
<div class="modal fade" id="completeVisitModal" tabindex="-1" aria-labelledby="completeVisitModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="completeVisitModalLabel">Completar Visita</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Cerrar"></button>
            </div>
            <form id="completeVisitForm" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="notes" class="form-label">Notas de la Visita</label>
                        <textarea class="form-control" id="notes" name="notes" rows="4" required></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancelar</button>
                    <button type="submit" class="btn btn-primary">Completar Visita</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const completeVisitModal = document.getElementById('completeVisitModal');
    const completeVisitForm = document.getElementById('completeVisitForm');
    
    completeVisitModal.addEventListener('show.bs.modal', function(event) {
        const button = event.relatedTarget;
        const visitId = button.getAttribute('data-visit-id');
        completeVisitForm.action = '${pageContext.request.contextPath}/visits/' + visitId + '/complete';
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 