<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Patient History - ${patient.fullName}</h2>
        <a href="<c:url value='/dentist/dashboard'/>" class="btn btn-secondary">Back to Dashboard</a>
    </div>
    
    <!-- Patient Information -->
    <div class="card mb-4">
        <div class="card-header">
            <h4>Patient Information</h4>
        </div>
        <div class="card-body">
            <div class="row">
                <div class="col-md-6">
                    <p><strong>Name:</strong> ${patient.fullName}</p>
                    <p><strong>Phone:</strong> ${patient.phone}</p>
                </div>
                <div class="col-md-6">
                    <p><strong>Email:</strong> ${patient.email}</p>
                    <p><strong>Payment Method:</strong> ${patient.paymentMethod}</p>
                </div>
            </div>
        </div>
    </div>
    
    <!-- Appointment History -->
    <div class="card">
        <div class="card-header">
            <h4>Appointment History</h4>
        </div>
        <div class="card-body">
            <c:if test="${empty appointments}">
                <p class="text-muted">No appointment history available.</p>
            </c:if>
            <c:if test="${not empty appointments}">
                <div class="table-responsive">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${appointments}" var="appointment">
                                <tr>
                                    <td>
                                        <fmt:formatDate value="${appointment.dateTime}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${appointment.reason}</td>
                                    <td>
                                        <span class="badge bg-${appointment.status == 'COMPLETED' ? 'success' : 
                                                             appointment.status == 'CANCELLED' ? 'danger' : 
                                                             appointment.status == 'CONFIRMED' ? 'primary' : 'warning'}">
                                            ${appointment.status}
                                        </span>
                                    </td>
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

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 