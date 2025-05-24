<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<header class="main-header">
    <div class="header-content">
        <div class="logo">
            <a href="${pageContext.request.contextPath}/">Dental Clinic</a>
        </div>
        <div class="user-info">
            <sec:authorize access="isAuthenticated()">
                <span class="welcome">Welcome, <sec:authentication property="name"/></span>
                <div class="user-role">
                    <sec:authorize access="hasRole('ADMIN')">
                        <span class="role-badge admin">Administrator</span>
                    </sec:authorize>
                    <sec:authorize access="hasRole('DENTIST')">
                        <span class="role-badge dentist">Dentist</span>
                    </sec:authorize>
                    <sec:authorize access="hasRole('PATIENT')">
                        <span class="role-badge patient">Patient</span>
                    </sec:authorize>
                </div>
            </sec:authorize>
        </div>
    </div>
    <nav class="main-nav">
        <sec:authorize access="hasRole('ADMIN')">
            <a href="${pageContext.request.contextPath}/admin/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/admin/users">User Management</a>
            <a href="${pageContext.request.contextPath}/admin/dentists">Dentists</a>
            <a href="${pageContext.request.contextPath}/admin/patients">Patients</a>
        </sec:authorize>
        <sec:authorize access="hasRole('DENTIST')">
            <a href="${pageContext.request.contextPath}/dentist/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/dentist/appointments">Appointments</a>
            <a href="${pageContext.request.contextPath}/dentist/patients">My Patients</a>
        </sec:authorize>
        <sec:authorize access="hasRole('PATIENT')">
            <a href="${pageContext.request.contextPath}/patient/dashboard">Dashboard</a>
            <a href="${pageContext.request.contextPath}/patient/appointments">My Appointments</a>
            <a href="${pageContext.request.contextPath}/patient/profile">My Profile</a>
        </sec:authorize>
        <sec:authorize access="isAuthenticated()">
            <a href="${pageContext.request.contextPath}/logout" class="logout">Logout</a>
        </sec:authorize>
    </nav>
</header> 