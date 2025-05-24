<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dental Clinic Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .feature-card {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
        }
        .welcome-section {
            padding: 40px 0;
        }
        .quick-actions {
            margin-top: 30px;
        }
        .action-buttons {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 20px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <jsp:include page="/WEB-INF/views/layout/header.jsp" />
    
    <div class="container mt-4">
        <sec:authorize access="isAuthenticated()">
            <div class="welcome-section">
                <h1 class="mb-4">Welcome to Dental Clinic Management System</h1>
                <p class="lead">You are logged in as <strong><sec:authentication property="name"/></strong></p>
                
                <sec:authorize access="hasRole('ADMIN')">
                    <div class="quick-actions">
                        <h2 class="mb-4">Quick Actions</h2>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/admin/users" class="btn btn-primary">Manage Users</a>
                            <a href="${pageContext.request.contextPath}/admin/dentists" class="btn btn-primary">Manage Dentists</a>
                            <a href="${pageContext.request.contextPath}/admin/patients" class="btn btn-primary">Manage Patients</a>
                        </div>
                    </div>
                </sec:authorize>
                
                <sec:authorize access="hasRole('DENTIST')">
                    <div class="quick-actions">
                        <h2 class="mb-4">Quick Actions</h2>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/dentist/appointments" class="btn btn-primary">View Appointments</a>
                            <a href="${pageContext.request.contextPath}/dentist/patients" class="btn btn-primary">View Patients</a>
                        </div>
                    </div>
                </sec:authorize>
                
                <sec:authorize access="hasRole('PATIENT')">
                    <div class="quick-actions">
                        <h2 class="mb-4">Quick Actions</h2>
                        <div class="action-buttons">
                            <a href="${pageContext.request.contextPath}/patient/appointments" class="btn btn-primary">My Appointments</a>
                            <a href="${pageContext.request.contextPath}/patient/profile" class="btn btn-primary">My Profile</a>
                        </div>
                    </div>
                </sec:authorize>
            </div>
        </sec:authorize>
        
        <sec:authorize access="!isAuthenticated()">
            <div class="welcome-section">
                <h1 class="mb-4">Welcome to Dental Clinic Management System</h1>
                <p class="lead mb-5">Your trusted partner in dental care</p>
                
                <div class="row">
                    <div class="col-md-4">
                        <div class="feature-card">
                            <h3>Professional Care</h3>
                            <p>Expert dental care from qualified professionals</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <h3>Easy Scheduling</h3>
                            <p>Book and manage your appointments online</p>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="feature-card">
                            <h3>Patient Portal</h3>
                            <p>Access your dental records and history</p>
                        </div>
                    </div>
                </div>
                
                <div class="text-center mt-5">
                    <h2 class="mb-4">Get Started Today</h2>
                    <div class="d-grid gap-2 d-md-flex justify-content-md-center">
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-primary btn-lg me-md-2">Login</a>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-outline-primary btn-lg">Register</a>
                    </div>
                </div>
            </div>
        </sec:authorize>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 