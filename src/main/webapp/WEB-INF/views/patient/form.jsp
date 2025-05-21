<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="../layout/header.jsp" />

<div class="row">
    <div class="col-md-6 offset-md-3">
        <h2>${patient.id == null ? 'Add New' : 'Edit'} Patient</h2>
        <hr>
        
        <form action="<c:url value='${patient.id == null ? "/admin/patients" : "/admin/patients/" += patient.id}'/>" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" 
                       value="${patient.fullName}" 
                       pattern="[A-Za-zÀ-ÿ\s]+" 
                       title="Please enter a valid name (letters and spaces only)"
                       required>
            </div>
            
            <div class="mb-3">
                <label for="dateOfBirth" class="form-label">Date of Birth</label>
                <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" 
                       value="<fmt:formatDate value='${patient.dateOfBirth}' pattern='yyyy-MM-dd'/>" 
                       max="<fmt:formatDate value='${now}' pattern='yyyy-MM-dd'/>"
                       required>
            </div>
            
            <div class="mb-3">
                <label for="phone" class="form-label">Phone</label>
                <input type="tel" class="form-control" id="phone" name="phone" 
                       value="${patient.phone}" 
                       pattern="[0-9]{9}" 
                       title="Please enter a valid 9-digit phone number"
                       required>
            </div>
            
            <div class="mb-3">
                <label for="email" class="form-label">Email</label>
                <input type="email" class="form-control" id="email" name="email" 
                       value="${patient.email}" 
                       pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
                       title="Please enter a valid email address"
                       required>
            </div>
            
            <div class="mb-3">
                <label for="paymentMethod" class="form-label">Payment Method</label>
                <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                    <option value="">Select payment method</option>
                    <option value="PRIVATE" ${patient.paymentMethod == 'PRIVATE' ? 'selected' : ''}>Private</option>
                    <option value="MUTUAL" ${patient.paymentMethod == 'MUTUAL' ? 'selected' : ''}>Mutual</option>
                </select>
            </div>
            
            <div class="mb-3">
                <label for="visitReason" class="form-label">Visit Reason</label>
                <input type="text" class="form-control" id="visitReason" name="visitReason" value="${patient.visitReason}" required>
            </div>
            
            <div id="legalTutorGroup" style="display: none;">
                <hr>
                <h4 class="mb-3">Legal Tutor Information</h4>
                <div class="mb-3">
                    <label for="legalTutorName" class="form-label">Legal Tutor Name</label>
                    <input type="text" class="form-control" id="legalTutorName" name="legalTutorName" 
                           value="${patient.legalTutorName}" 
                           pattern="[A-Za-zÀ-ÿ\s]+" 
                           title="Please enter a valid name (letters and spaces only)">
                </div>
                <div class="mb-3">
                    <label for="legalTutorPhone" class="form-label">Legal Tutor Phone</label>
                    <input type="tel" class="form-control" id="legalTutorPhone" name="legalTutorPhone" 
                           value="${patient.legalTutorPhone}" 
                           pattern="[0-9]{9}" 
                           title="Please enter a valid 9-digit phone number">
                </div>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Save</button>
                <a href="<c:url value='/admin/patients'/>" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script>
document.getElementById('dateOfBirth').addEventListener('change', function() {
    var legalTutorGroup = document.getElementById('legalTutorGroup');
    var legalTutorName = document.getElementById('legalTutorName');
    var legalTutorPhone = document.getElementById('legalTutorPhone');
    
    var birthDate = new Date(this.value);
    var today = new Date();
    var age = today.getFullYear() - birthDate.getFullYear();
    var monthDiff = today.getMonth() - birthDate.getMonth();
    
    if (monthDiff < 0 || (monthDiff === 0 && today.getDate() < birthDate.getDate())) {
        age--;
    }
    
    if (age < 18) {
        legalTutorGroup.style.display = 'block';
        legalTutorName.required = true;
        legalTutorPhone.required = true;
    } else {
        legalTutorGroup.style.display = 'none';
        legalTutorName.required = false;
        legalTutorPhone.required = false;
    }
});

// Trigger the change event on page load
document.getElementById('dateOfBirth').dispatchEvent(new Event('change'));
</script>

<jsp:include page="../layout/footer.jsp" /> 