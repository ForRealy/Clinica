<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <h2>Schedule a Visit</h2>
    
    <c:if test="${not empty successMessage}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ${successMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <c:if test="${not empty errorMessage}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ${errorMessage}
            <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
        </div>
    </c:if>
    
    <div class="card">
        <div class="card-body">
            <form action="<c:url value='/visits/schedule'/>" method="post">
                <div class="mb-3">
                    <label for="dateTime" class="form-label">Select Date and Time</label>
                    <select class="form-select" id="dateTime" name="dateTime" required>
                        <option value="">Choose a time slot...</option>
                        <c:forEach items="${availableSlots}" var="slot">
                            <fmt:parseDate value="${slot}" pattern="yyyy-MM-dd'T'HH:mm:ss" var="parsedDate" type="both" />
                            <option value="${slot}">
                                <fmt:formatDate value="${parsedDate}" pattern="EEEE, MMMM d, yyyy 'at' HH:mm"/>
                            </option>
                        </c:forEach>
                    </select>
                </div>
                
                <div class="mb-3">
                    <label for="reason" class="form-label">Reason for Visit</label>
                    <textarea class="form-control" id="reason" name="reason" rows="3" required 
                              placeholder="Please describe the reason for your visit..."></textarea>
                </div>
                
                <button type="submit" class="btn btn-primary">Schedule Visit</button>
            </form>
        </div>
    </div>
    
    <!-- Available Time Slots Information -->
    <div class="card mt-4">
        <div class="card-header">
            <h5 class="card-title mb-0">Available Time Slots Information</h5>
        </div>
        <div class="card-body">
            <ul class="list-unstyled">
                <li><i class="bi bi-clock"></i> Clinic hours: 9:00 AM - 5:00 PM</li>
                <li><i class="bi bi-calendar"></i> Monday to Friday only</li>
                <li><i class="bi bi-clock-history"></i> 30-minute appointment slots</li>
                <li><i class="bi bi-info-circle"></i> Please arrive 10 minutes before your appointment</li>
            </ul>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    // Add some basic validation
    const form = document.querySelector('form');
    form.addEventListener('submit', function(event) {
        const dateTime = document.getElementById('dateTime').value;
        const reason = document.getElementById('reason').value.trim();
        
        if (!dateTime) {
            event.preventDefault();
            alert('Please select a date and time for your visit.');
        } else if (!reason) {
            event.preventDefault();
            alert('Please provide a reason for your visit.');
        }
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 