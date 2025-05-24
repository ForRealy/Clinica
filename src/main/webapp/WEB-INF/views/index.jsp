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
        .hero-section {
            margin-top: -1.5rem;
        }
        .hero-image {
            background-size: cover;
            background-position: center;
            position: relative;
            min-height: 75vh;
        }
        .overlay {
            position: absolute;
            top: 0;
            left: 0;
            right: 0;
            bottom: 0;
            background: rgba(0, 0, 0, 0.5);
        }
        .card-img-top {
            height: 200px;
            object-fit: cover;
        }
        .min-vh-75 {
            min-height: 75vh;
        }
        .fa-3x {
            font-size: 3em;
        }
        .text-primary {
            color: #0d6efd !important;
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
            </div>
        </sec:authorize>
        
        <sec:authorize access="!isAuthenticated()">
            <div class="welcome-section">
                <h1 class="mb-4">Welcome to Dental Clinic Management System</h1>
                <p class="lead mb-5">Your trusted partner in dental care</p> 
            </div>
        </sec:authorize>
    </div>

    <!-- Hero Section -->
    <div class="hero-section position-relative">
        <div class="hero-image" style="background-image: url('${pageContext.request.contextPath}/images/dental-hero.jpg');">
            <div class="overlay"></div>
            <div class="container position-relative">
                <div class="row min-vh-75 align-items-center">
                    <div class="col-md-8 text-white">
                        <h1 class="display-4 fw-bold mb-4">Welcome to Our Dental Clinic</h1>
                        <p class="lead mb-4">Experience exceptional dental care in a comfortable and modern environment. Our team of skilled professionals is dedicated to your oral health.</p>
                        <div class="d-flex gap-3">
                            <a href="#services" class="btn btn-outline-light btn-lg">Our Services</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Services Section -->
    <section id="services" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Our Services</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/general-dentistry.jpg" class="card-img-top" alt="General Dentistry">
                        <div class="card-body text-center">
                            <h5 class="card-title">General Dentistry</h5>
                            <p class="card-text">Comprehensive dental care including check-ups, cleanings, and preventive treatments.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/cosmetic-dentistry.jpg" class="card-img-top" alt="Cosmetic Dentistry">
                        <div class="card-body text-center">
                            <h5 class="card-title">Cosmetic Dentistry</h5>
                            <p class="card-text">Transform your smile with our range of cosmetic dental procedures.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/orthodontics.jpg" class="card-img-top" alt="Orthodontics">
                        <div class="card-body text-center">
                            <h5 class="card-title">Orthodontics</h5>
                            <p class="card-text">Modern orthodontic solutions for a perfectly aligned smile.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Why Choose Us Section -->
    <section class="bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-5">Why Choose Us</h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-user-md fa-3x text-primary mb-3"></i>
                        <h5>Expert Team</h5>
                        <p>Highly qualified and experienced dental professionals</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-clock fa-3x text-primary mb-3"></i>
                        <h5>Flexible Hours</h5>
                        <p>Convenient appointment times to fit your schedule</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-tooth fa-3x text-primary mb-3"></i>
                        <h5>Modern Equipment</h5>
                        <p>State-of-the-art dental technology and facilities</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-heart fa-3x text-primary mb-3"></i>
                        <h5>Patient Care</h5>
                        <p>Personalized attention and comfortable experience</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 