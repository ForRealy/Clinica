<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp" />

<div class="row">
    <div class="col-md-6 offset-md-3">
        <h2>Notas de la Visita</h2>
        <hr>
        
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Detalles de la Cita</h5>
                <p><strong>Paciente:</strong> ${visit.patient.name}</p>
                <p><strong>Dentista:</strong> ${visit.dentist.fullName}</p>
                <p><strong>Fecha y Hora:</strong> 
                    <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                    <fmt:formatDate value="${parsedDate}" pattern="dd MMM, yyyy HH:mm" />
                </p>
                <p><strong>Motivo:</strong> ${visit.purpose}</p>
            </div>
        </div>
        
        <form action="/admin/visits/${visit.id}/notes" method="post">
            <div class="mb-3">
                <label for="observations" class="form-label">Observaciones</label>
                <textarea class="form-control" id="observations" name="observations" rows="4" required>${visit.observations}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="prescribedTreatments" class="form-label">Tratamientos Prescritos</label>
                <textarea class="form-control" id="prescribedTreatments" name="prescribedTreatments" rows="4" required>${visit.prescribedTreatments}</textarea>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Guardar Notas</button>
                <a href="/admin/visits" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" /> 