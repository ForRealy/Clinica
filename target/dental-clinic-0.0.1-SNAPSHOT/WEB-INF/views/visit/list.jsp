<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp" />

<div class="row mb-4">
    <div class="col-md-6">
        <h2>Appointments</h2>
    </div>
    <div class="col-md-6 text-end">
        <a href="/admin/visits/new" class="btn btn-primary">Schedule New Appointment</a>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Date & Time</th>
                <th>Patient</th>
                <th>Dentist</th>
                <th>Purpose</th>
                <th>Status</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${visits}" var="visit">
                <tr>
                    <td>
                        <fmt:parseDate value="${visit.dateTime}" pattern="yyyy-MM-dd'T'HH:mm" var="parsedDate" type="both" />
                        <fmt:formatDate value="${parsedDate}" pattern="MMM dd, yyyy HH:mm" />
                    </td>
                    <td>${visit.patient.name}</td>
                    <td>${visit.dentist.fullName}</td>
                    <td>${visit.purpose}</td>
                    <td>
                        <c:choose>
                            <c:when test="${empty visit.observations}">
                                <span class="badge bg-warning">Pending</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-success">Completed</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/admin/visits/${visit.id}/edit" class="btn btn-sm btn-warning">Edit</a>
                        <c:if test="${empty visit.observations}">
                            <a href="/admin/visits/${visit.id}/notes" class="btn btn-sm btn-info">Add Notes</a>
                        </c:if>
                        <form action="/admin/visits/${visit.id}/delete" method="post" class="d-inline">
                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<jsp:include page="../layout/footer.jsp" /> 