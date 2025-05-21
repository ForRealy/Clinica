<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="row mb-4">
    <div class="col-md-6">
        <h2>Patients</h2>
    </div>
    <div class="col-md-6 text-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newPatientModal">
            Add New Patient
        </button>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Name</th>
                <th>Date of Birth</th>
                <th>Phone</th>
                <th>Email</th>
                <th>Payment Method</th>
                <th>Legal Tutor</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${patients}" var="patient">
                <tr>
                    <td>${patient.fullName}</td>
                    <td>${patient.formattedDateOfBirth}</td>
                    <td>${patient.phone}</td>
                    <td>${patient.email}</td>
                    <td>${patient.paymentMethod}</td>
                    <td>
                        <c:if test="${patient.requiresLegalTutor()}">
                            ${patient.legalTutorName}<br>
                            <small class="text-muted">${patient.legalTutorPhone}</small>
                        </c:if>
                    </td>
                    <td>
                        <a href="<c:url value='/admin/patients/${patient.id}/edit'/>" class="btn btn-sm btn-warning">Edit</a>
                        <form action="<c:url value='/admin/patients/${patient.id}/delete'/>" method="post" class="d-inline">
                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- New Patient Modal -->
<div class="modal fade" id="newPatientModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="<c:url value='/admin/patients'/>" method="post" id="newPatientForm">
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dateOfBirth" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" name="phone" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="paymentMethod" class="form-label">Payment Method</label>
                        <select class="form-select" id="paymentMethod" name="paymentMethod" required>
                            <option value="">Select payment method</option>
                            <option value="PRIVATE">Private</option>
                            <option value="MUTUAL">Mutual</option>
                        </select>
                    </div>

                    <div id="legalTutorGroup" style="display: none;">
                        <hr>
                        <h4 class="mb-3">Legal Tutor Information</h4>
                        <div class="mb-3">
                            <label for="legalTutorName" class="form-label">Legal Tutor Name</label>
                            <input type="text" class="form-control" id="legalTutorName" name="legalTutorName">
                        </div>
                        <div class="mb-3">
                            <label for="legalTutorPhone" class="form-label">Legal Tutor Phone</label>
                            <input type="tel" class="form-control" id="legalTutorPhone" name="legalTutorPhone">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="newPatientForm" class="btn btn-primary">Create Patient</button>
            </div>
        </div>
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
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 