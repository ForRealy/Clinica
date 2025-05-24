<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Welcome, ${dentist.fullName}</h2>
    
    <!-- Pending Appointments Section -->
    <div class="card mb-4">
        <div class="card-header">
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
                                        <fmt:formatDate value="${appointment.dateTime}" pattern="dd/MM/yyyy HH:mm"/>
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
    
    <!-- Upcoming Appointments Section -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>Upcoming Appointments</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty upcomingAppointments}">
                <p class="text-muted">No upcoming appointments.</p>
            </c:if>
            <c:if test="${not empty upcomingAppointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Reason</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${upcomingAppointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${appointment.dateTime}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.patientName}</td>
                                    <td>${appointment.reason}</td>
                                    <td>
                                        <span class="badge bg-${appointment.status == 'CONFIRMED' ? 'success' : 'warning'}">
                                            ${appointment.status}
                                        </span>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>
        </div>
    </div>
    
    <!-- My Patients Section -->
    <div class="card">
        <div class="card-header">
            <h4>My Patients</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty patients}">
                <p class="text-muted">No patients assigned.</p>
            </c:if>
            <c:if test="${not empty patients}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Name</th>
                                <th>Phone</th>
                                <th>Email</th>
                                <th>Last Visit</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${patients}" var="patient">
                                <tr>
                                    <td>${patient.fullName}</td>
                                    <td>${patient.phone}</td>
                                    <td>${patient.email}</td>
                                    <td>
                                        <fmt:formatDate value="${patient.lastVisit}" pattern="dd/MM/yyyy"/>
                                    </td>
                                    <td>
                                        <button type="button" class="btn btn-sm btn-primary view-patient"
                                                data-patient-id="${patient.id}">
                                            View History
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
    
    // Handle patient history view
    document.querySelectorAll('.view-patient').forEach(button => {
        button.addEventListener('click', function() {
            const patientId = this.dataset.patientId;
            window.location.href = `/dental-clinic/dentist/patients/${patientId}/history`;
        });
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 