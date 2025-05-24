<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>My Profile</h2>
    <div class="card mb-4">
        <div class="card-body">
            <h5 class="card-title">Personal Details</h5>
            <ul class="list-group list-group-flush">
                <li class="list-group-item"><strong>Name:</strong> ${patient.fullName}</li>
                <li class="list-group-item"><strong>Email:</strong> ${patient.email}</li>
                <li class="list-group-item"><strong>Phone:</strong> ${patient.phone}</li>
                <li class="list-group-item"><strong>Birthdate:</strong> ${patient.dateOfBirth}</li>
                <li class="list-group-item"><strong>Payment Method:</strong> ${patient.paymentMethod}</li>
            </ul>
        </div>
    </div>
    <div class="card">
        <div class="card-body">
            <h5 class="card-title">Completed Visits & Prescriptions</h5>
            <c:choose>
                <c:when test="${not empty completedVisits}">
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Dentist</th>
                                <th>Reason</th>
                                <th>Prescription/Notes</th>
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
                    <div class="alert alert-info">No completed visits yet.</div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 