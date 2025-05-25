<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>My Appointments</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newAppointmentModal">
            Schedule New Appointment
        </button>
    </div>

    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>

    <c:choose>
        <c:when test="${not empty appointments}">
            <div class="table-responsive">
                <table class="table">
                    <thead>
                        <tr>
                            <th>Date & Time</th>
                            <th>Dentist</th>
                            <th>Status</th>
                            <th>Reason</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${appointments}" var="visit">
                            <tr>
                                <td>
                                    <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                    <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                </td>
                                <td>${visit.dentistId}</td>
                                <td>
                                    <span class="badge ${visit.status == 'COMPLETED' ? 'bg-success' : 
                                                      visit.status == 'CONFIRMED' ? 'bg-primary' : 
                                                      visit.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                        ${visit.status}
                                    </span>
                                </td>
                                <td>${visit.reason}</td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">You have no appointments scheduled.</div>
        </c:otherwise>
    </c:choose>
</div>

<!-- New Appointment Modal -->
<div class="modal fade" id="newAppointmentModal" tabindex="-1" aria-labelledby="newAppointmentModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="newAppointmentModalLabel">Schedule New Appointment</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <form action="appointments/request" method="post">
                <div class="modal-body">
                    <div class="mb-3">
                        <label for="dateTime" class="form-label">Date & Time</label>
                        <input type="datetime-local" class="form-control" id="dateTime" name="dateTimeStr" required>
                        <small class="text-muted">Appointments are available Monday to Friday, 9:00 AM to 5:00 PM</small>
                    </div>
                    
                    <div class="mb-3">
                        <label for="reason" class="form-label">Reason for Visit</label>
                        <textarea class="form-control" id="reason" name="reason" rows="3" required 
                                  placeholder="Please describe the reason for your visit..."></textarea>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Request Appointment</button>
                </div>
            </form>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const dateTimeInput = document.getElementById('dateTime');
    
    // Set min and max dates (next 30 days)
    const today = new Date();
    const minDate = new Date(today);
    minDate.setHours(9, 0, 0, 0); // Set to 9:00 AM
    
    const maxDate = new Date(today);
    maxDate.setDate(maxDate.getDate() + 30);
    maxDate.setHours(17, 0, 0, 0); // Set to 5:00 PM
    
    // Format dates for input min/max
    const formatDate = (date) => {
        return date.toISOString().slice(0, 16); // Format: YYYY-MM-DDTHH:mm
    };
    
    dateTimeInput.min = formatDate(minDate);
    dateTimeInput.max = formatDate(maxDate);
    
    // Validate date and time when input changes
    dateTimeInput.addEventListener('change', function() {
        const selectedDate = new Date(this.value);
        const day = selectedDate.getDay();
        const hours = selectedDate.getHours();
        
        if (day === 0 || day === 6) {
            alert('Appointments are not available on weekends.');
            this.value = '';
        } else if (hours < 9 || hours >= 17) {
            alert('Appointments are only available between 9 AM and 5 PM.');
            this.value = '';
        }
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 