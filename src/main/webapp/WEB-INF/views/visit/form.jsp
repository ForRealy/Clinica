<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="row">
    <div class="col-md-6 offset-md-3">
        <h2>${visit.id == null ? 'Programar Nueva' : 'Editar'} Cita</h2>
        <hr>
        
        <form action="${visit.id == null ? '/admin/visits' : '/admin/visits/' + visit.id}" method="post">
            <div class="mb-3">
                <label for="dateTime" class="form-label">Fecha y Hora</label>
                <input type="datetime-local" class="form-control" id="dateTime" name="dateTime" 
                       value="${visit.dateTime}" required>
            </div>
            
            <div class="mb-3">
                <label for="dentist" class="form-label">Dentista</label>
                <select class="form-select" id="dentist" name="dentist.id" required>
                    <option value="">Seleccionar un dentista</option>
                    <c:forEach items="${dentists}" var="dentist">
                        <option value="${dentist.id}" ${visit.dentist.id == dentist.id ? 'selected' : ''}>
                            ${dentist.fullName} (${dentist.specialty})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="patient" class="form-label">Paciente</label>
                <select class="form-select" id="patient" name="patient.id" required>
                    <option value="">Seleccionar un paciente</option>
                    <c:forEach items="${patients}" var="patient">
                        <option value="${patient.id}" ${visit.patient.id == patient.id ? 'selected' : ''}>
                            ${patient.name} (${patient.visitReason})
                        </option>
                    </c:forEach>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="purpose" class="form-label">Motivo de la Visita</label>
                <input type="text" class="form-control" id="purpose" name="purpose" 
                       value="${visit.purpose}" required>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Guardar</button>
                <a href="/admin/visits" class="btn btn-secondary">Cancelar</a>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('dateTime').addEventListener('change', function() {
    var date = new Date(this.value);
    var day = date.getDay();
    var hours = date.getHours();
    
    if (day === 0 || day === 6) {
        alert('No hay citas disponibles los fines de semana.');
        this.value = '';
    } else if (hours < 8 || hours >= 15) {
        alert('Las citas solo están disponibles entre las 8 AM y las 3 PM.');
        this.value = '';
    }
});
</script>

<jsp:include page="../layout/footer.jsp" /> 