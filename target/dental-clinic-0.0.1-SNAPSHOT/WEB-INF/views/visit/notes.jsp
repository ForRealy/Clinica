<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp" />

<div class="row">
    <div class="col-md-6 offset-md-3">
        <h2>Visit Notes</h2>
        <hr>
        
        <div class="card mb-4">
            <div class="card-body">
                <h5 class="card-title">Appointment Details</h5>
                <p><strong>Patient:</strong> ${visit.patient.name}</p>
                <p><strong>Dentist:</strong> ${visit.dentist.fullName}</p>
                <p><strong>Date & Time:</strong> 
                    <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                    <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
                </p>
                <p><strong>Purpose:</strong> ${visit.purpose}</p>
            </div>
        </div>
        
        <form action="/admin/visits/${visit.id}/notes" method="post">
            <div class="mb-3">
                <label for="observations" class="form-label">Observations</label>
                <textarea class="form-control" id="observations" name="observations" rows="4" required>${visit.observations}</textarea>
            </div>
            
            <div class="mb-3">
                <label for="prescribedTreatments" class="form-label">Prescribed Treatments</label>
                <textarea class="form-control" id="prescribedTreatments" name="prescribedTreatments" rows="4" required>${visit.prescribedTreatments}</textarea>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Save Notes</button>
                <a href="/admin/visits" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" /> 