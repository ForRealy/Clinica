<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard - Dental Clinic</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>
<body>
    <jsp:include page="/WEB-INF/views/common/header.jsp" />
    
    <div class="container">
        <h1>Admin Dashboard</h1>
        
        <div class="dashboard-grid">
            <div class="dashboard-card">
                <h2>User Management</h2>
                <p>Manage all users in the system</p>
                <a href="${pageContext.request.contextPath}/admin/users" class="button">View Users</a>
            </div>
            
            <div class="dashboard-card">
                <h2>Dentist Management</h2>
                <p>Manage dentist profiles and schedules</p>
                <a href="${pageContext.request.contextPath}/admin/dentists" class="button">View Dentists</a>
            </div>
            
            <div class="dashboard-card">
                <h2>Patient Management</h2>
                <p>Manage patient records and appointments</p>
                <a href="${pageContext.request.contextPath}/admin/patients" class="button">View Patients</a>
            </div>
        </div>
    </div>
</body>
</html> 