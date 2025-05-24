<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>All Visits</h2>
    </div>

    <div class="card">
        <div class="card-body">
            <c:if test="${empty visits}">
                <p class="text-muted">No visits found.</p>
            </c:if>
            <c:if test="${not empty visits}">
                <div class="table-responsive">
                    <table class="table table-striped">
                        <thead>
                            <tr>
                                <th>Date & Time</th>
                                <th>Patient</th>
                                <th>Dentist</th>
                                <th>Reason</th>
                                <th>Status</th>
                                <th>Notes</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach items="${visits}" var="visit">
                                <tr>
                                    <td>
                                        <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both"/>
                                        <fmt:formatDate value="${parsedDate}" pattern="dd/MM/yyyy HH:mm"/>
                                    </td>
                                    <td>${visit.patientEmail}</td>
                                    <td>${visit.dentistId}</td>
                                    <td>${visit.reason}</td>
                                    <td>
                                        <span class="badge ${visit.status == 'COMPLETED' ? 'bg-success' : 
                                                          visit.status == 'CONFIRMED' ? 'bg-primary' : 
                                                          visit.status == 'PENDING' ? 'bg-warning' : 'bg-danger'}">
                                            ${visit.status}
                                        </span>
                                    </td>
                                    <td>${visit.notes}</td>
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