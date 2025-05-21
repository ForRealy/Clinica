<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="layout/header.jsp" />

<div class="row">
    <div class="col-md-12">
        <h2>Welcome to Dental Clinic Management System</h2>
        <hr>
    </div>
</div>

<c:if test="${pageContext.request.userPrincipal.authorities.contains('ROLE_ADMIN')}">
    <div class="row">
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Dentists</h5>
                    <p class="card-text">Manage dental staff and their schedules.</p>
                    <a href="${pageContext.request.contextPath}/admin/dentists" class="btn btn-primary">Manage Dentists</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Patients</h5>
                    <p class="card-text">Manage patient records and information.</p>
                    <a href="${pageContext.request.contextPath}/admin/patients" class="btn btn-primary">Manage Patients</a>
                </div>
            </div>
        </div>
        
        <div class="col-md-4">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">Appointments</h5>
                    <p class="card-text">Schedule and manage patient visits.</p>
                    <a href="${pageContext.request.contextPath}/admin/visits" class="btn btn-primary">Manage Appointments</a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<c:if test="${pageContext.request.userPrincipal.authorities.contains('ROLE_DENTIST')}">
    <div class="row">
        <div class="col-md-12">
            <div class="card">
                <div class="card-body">
                    <h5 class="card-title">My Appointments</h5>
                    <p class="card-text">View and manage your scheduled appointments.</p>
                    <a href="${pageContext.request.contextPath}/dentist/appointments" class="btn btn-primary">View Appointments</a>
                </div>
            </div>
        </div>
    </div>
</c:if>

<jsp:include page="layout/footer.jsp" /> 