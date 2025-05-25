<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Sistema de Gestión de Clínica Dental</title>
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
                <h1 class="mb-4">Bienvenido al Sistema de Gestión de Clínica Dental</h1>
                <p class="lead">Has iniciado sesión como <strong><sec:authentication property="name"/></strong></p>
            </div>
        </sec:authorize>
        
        <sec:authorize access="!isAuthenticated()">
            <div class="welcome-section">
                <h1 class="mb-4">Bienvenido al Sistema de Gestión de Clínica Dental</h1>
                <p class="lead mb-5">Tu socio de confianza en el cuidado dental</p> 
            </div>
        </sec:authorize>
    </div>

    <!-- Sección Hero -->
    <div class="hero-section position-relative">
        <div class="hero-image" style="background-image: url('${pageContext.request.contextPath}/images/dental-hero.jpg');">
            <div class="overlay"></div>
            <div class="container position-relative">
                <div class="row min-vh-75 align-items-center">
                    <div class="col-md-8 text-white">
                        <h1 class="display-4 fw-bold mb-4">Bienvenido a Nuestra Clínica Dental</h1>
                        <p class="lead mb-4">Experimenta un cuidado dental excepcional en un ambiente cómodo y moderno. Nuestro equipo de profesionales calificados está dedicado a tu salud bucal.</p>
                        <div class="d-flex gap-3">
                            <a href="#services" class="btn btn-outline-light btn-lg">Nuestros Servicios</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <!-- Sección de Servicios -->
    <section id="services" class="py-5">
        <div class="container">
            <h2 class="text-center mb-5">Nuestros Servicios</h2>
            <div class="row g-4">
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/general-dentistry.jpg" class="card-img-top" alt="Odontología General">
                        <div class="card-body text-center">
                            <h5 class="card-title">Odontología General</h5>
                            <p class="card-text">Cuidado dental integral que incluye revisiones, limpiezas y tratamientos preventivos.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/cosmetic-dentistry.jpg" class="card-img-top" alt="Odontología Estética">
                        <div class="card-body text-center">
                            <h5 class="card-title">Odontología Estética</h5>
                            <p class="card-text">Transforma tu sonrisa con nuestra gama de procedimientos dentales estéticos.</p>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="card h-100 border-0 shadow-sm">
                        <img src="${pageContext.request.contextPath}/images/orthodontics.jpg" class="card-img-top" alt="Ortodoncia">
                        <div class="card-body text-center">
                            <h5 class="card-title">Ortodoncia</h5>
                            <p class="card-text">Soluciones ortodónticas modernas para una sonrisa perfectamente alineada.</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- Sección Por Qué Elegirnos -->
    <section class="bg-light py-5">
        <div class="container">
            <h2 class="text-center mb-5">Por Qué Elegirnos</h2>
            <div class="row g-4">
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-user-md fa-3x text-primary mb-3"></i>
                        <h5>Equipo Experto</h5>
                        <p>Profesionales dentales altamente calificados y con experiencia</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-clock fa-3x text-primary mb-3"></i>
                        <h5>Horarios Flexibles</h5>
                        <p>Horarios de cita convenientes que se adaptan a tu agenda</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-tooth fa-3x text-primary mb-3"></i>
                        <h5>Equipamiento Moderno</h5>
                        <p>Tecnología dental y instalaciones de última generación</p>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="text-center">
                        <i class="fas fa-heart fa-3x text-primary mb-3"></i>
                        <h5>Atención al Paciente</h5>
                        <p>Atención personalizada y experiencia cómoda</p>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html> 