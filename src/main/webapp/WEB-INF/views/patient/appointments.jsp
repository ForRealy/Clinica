<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>My Appointment</h2>
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success">${successMessage}</div>
    </c:if>
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger">${errorMessage}</div>
    </c:if>
    <c:choose>
        <c:when test="${not empty appointments}">
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
                            <td>${visit.dateTime}</td>
                            <td>${visit.dentistId}</td>
                            <td>${visit.status}</td>
                            <td>${visit.reason}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </c:when>
        <c:otherwise>
            <div class="alert alert-info">You have no appointments scheduled.</div>
            <a href="/dental-clinic/visits/schedule" class="btn btn-primary">Request Appointment</a>
        </c:otherwise>
    </c:choose>
</div>
<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 