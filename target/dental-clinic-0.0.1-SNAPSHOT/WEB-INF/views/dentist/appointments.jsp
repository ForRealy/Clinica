<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Appointments Management</h2>
        <a href="<c:url value='/dentist/dashboard'/>" class="btn btn-secondary">Back to Dashboard</a>
    </div>
    
    <!-- Pending Appointments -->
    <div class="card mb-4">
        <div class="card-header bg-warning text-white">
            <h4>Pending Appointments</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty pendingAppointments}">
                <p class="text-muted">No pending appointments.</p>
            </c:if>
            <c:if test="${not empty pendingAppointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Reason</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${pendingAppointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${appointment.dateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.patientName}</td>
                                    <td>${appointment.reason}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-success confirm-appointment" 
                                                data-appointment-id="${appointment.id}">
                                            Confirm
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger cancel-appointment"
                                                data-appointment-id="${appointment.id}">
                                            Cancel
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Confirmed Appointments -->
    <div class="card mb-4">
        <div class="card-header bg-primary text-white">
            <h4>Confirmed Appointments</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty confirmedAppointments}">
                <p class="text-muted">No confirmed appointments.</p>
            </c:if>
            <c:if test="${not empty confirmedAppointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Reason</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${confirmedAppointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${appointment.dateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.patientName}</td>
                                    <td>${appointment.reason}</td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-success complete-appointment"
                                                data-appointment-id="${appointment.id}">
                                            Complete
                                        </button>
                                        <button type="button" class="btn btn-sm btn-danger cancel-appointment"
                                                data-appointment-id="${appointment.id}">
                                            Cancel
                                        </button>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Completed Appointments -->
    <div class="card mb-4">
        <div class="card-header bg-success text-white">
            <h4>Completed Appointments</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty completedAppointments}">
                <p class="text-muted">No completed appointments.</p>
            </c:if>
            <c:if test="${not empty completedAppointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Reason</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${completedAppointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${appointment.dateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.patientName}</td>
                                    <td>${appointment.reason}</td>
                                    <td>${appointment.notes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- Cancelled Appointments -->
    <div class="card">
        <div class="card-header bg-danger text-white">
            <h4>Cancelled Appointments</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty cancelledAppointments}">
                <p class="text-muted">No cancelled appointments.</p>
            </c:if>
            <c:if test="${not empty cancelledAppointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Reason</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${cancelledAppointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${appointment.dateTime}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.patientName}</td>
                                    <td>${appointment.reason}</td>
                                    <td>${appointment.notes}</td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Handle appointment confirmation
    document.querySelectorAll('.confirm-appointment').forEach(button => {
        button.addEventListener('click', function() {
            const appointmentId = this.dataset.appointmentId;
            fetch(`/dental-clinic/dentist/appointments/${appointmentId}/confirm`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (response.ok) {
                    window.location.reload();
                }
            });
        });
    });
    
    // Handle appointment cancellation
    document.querySelectorAll('.cancel-appointment').forEach(button => {
        button.addEventListener('click', function() {
            const appointmentId = this.dataset.appointmentId;
            fetch(`/dental-clinic/dentist/appointments/${appointmentId}/cancel`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (response.ok) {
                    window.location.reload();
                }
            });
        });
    });
    
    // Handle appointment completion
    document.querySelectorAll('.complete-appointment').forEach(button => {
        button.addEventListener('click', function() {
            const appointmentId = this.dataset.appointmentId;
            fetch(`/dental-clinic/dentist/appointments/${appointmentId}/complete`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            })
            .then(response => {
                if (response.ok) {
                    window.location.reload();
                }
            });
        });
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 