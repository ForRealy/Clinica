<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Patients</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#patientModal">
            Add New Patient
        </button>
    </div>

    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Age</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Payment Method</th>
                    <th>Has Legal Tutor</th>
                    <th>Legal Tutor Name</th>
                    <th>Legal Tutor Phone</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${patients}" var="patient">
                    <tr>
                        <td>${patient.fullName}</td>
                        <td>${patient.age}</td>
                        <td>${patient.phone}</td>
                        <td>${patient.email}</td>
                        <td>${patient.paymentMethod}</td>
                        <td>${not empty patient.legalTutorName ? 'Yes' : 'No'}</td>
                        <td>${patient.legalTutorName}</td>
                        <td>${patient.legalTutorPhone}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary edit-patient" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#patientModal"
                                    data-patient-id="${patient.id}"
                                    data-patient-name="${patient.fullName}"
                                    data-patient-dob="${patient.dateOfBirth}"
                                    data-patient-phone="${patient.phone}"
                                    data-patient-email="${patient.email}"
                                    data-patient-payment="${patient.paymentMethod}"
                                    data-patient-tutor-name="${patient.legalTutorName}"
                                    data-patient-tutor-phone="${patient.legalTutorPhone}">
                                Edit
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Patient Modal -->
<div class="modal fade" id="patientModal" tabindex="-1" aria-labelledby="patientModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="patientModalLabel">Add New Patient</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="patientForm" action="<c:url value='/admin/patients'/>" method="post">
                    <input type="hidden" id="patientId" name="id">
                    
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" 
                               pattern="[A-Za-zÀ-ÿ\s]+" 
                               title="Please enter a valid name (letters and spaces only)"
                               required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="dateOfBirth" class="form-label">Date of Birth</label>
                        <input type="date" class="form-control" id="dateOfBirth" name="dateOfBirth" 
                               max="${now}"
                               required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="phone" class="form-label">Phone</label>
                        <input type="tel" class="form-control" id="phone" name="phone" 
                               maxlength="9" 
                               minlength="9"
                               title="Please enter a 9-digit phone number"
                               required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="email" class="form-label">Email</label>
                        <input type="email" class="form-control" id="email" name="email" 
                               pattern="[a-z0-9._%+-]+@[a-z0-9.-]+\.[a-z]{2,}$" 
                               title="Please enter a valid email address"
                               required>
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
                            <input type="text" class="form-control" id="legalTutorName" name="legalTutorName" 
                                   pattern="[A-Za-zÀ-ÿ\s]+" 
                                   title="Please enter a valid name (letters and spaces only)">
                        </div>
                        <div class="mb-3">
                            <label for="legalTutorPhone" class="form-label">Legal Tutor Phone</label>
                            <input type="tel" class="form-control" id="legalTutorPhone" name="legalTutorPhone" 
                                   maxlength="9"
                                   minlength="9"
                                   title="Please enter a 9-digit phone number">
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="patientForm" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('patientModal');
    const modalTitle = modal.querySelector('.modal-title');
    const form = document.getElementById('patientForm');
    
    // Handle edit button clicks
    document.querySelectorAll('.edit-patient').forEach(button => {
        button.addEventListener('click', function() {
            const patientId = this.dataset.patientId;
            modalTitle.textContent = 'Edit Patient';
            form.action = `/dental-clinic/admin/patients/${patientId}`;
            
            // Fill form with patient data
            document.getElementById('patientId').value = patientId;
            document.getElementById('fullName').value = this.dataset.patientName;
            document.getElementById('dateOfBirth').value = this.dataset.patientDob;
            document.getElementById('phone').value = this.dataset.patientPhone;
            document.getElementById('email').value = this.dataset.patientEmail;
            document.getElementById('paymentMethod').value = this.dataset.patientPayment;
            document.getElementById('legalTutorName').value = this.dataset.patientTutorName;
            document.getElementById('legalTutorPhone').value = this.dataset.patientTutorPhone;
            
            // Trigger age check
            document.getElementById('dateOfBirth').dispatchEvent(new Event('change'));
        });
    });
    
    // Handle new patient button click
    document.querySelector('[data-bs-target="#patientModal"]').addEventListener('click', function() {
        modalTitle.textContent = 'Add New Patient';
        form.reset();
        form.action = '/dental-clinic/admin/patients';
        document.getElementById('legalTutorGroup').style.display = 'none';
    });
    
    // Age check for legal tutor
    document.getElementById('dateOfBirth').addEventListener('change', function() {
        const legalTutorGroup = document.getElementById('legalTutorGroup');
        const legalTutorName = document.getElementById('legalTutorName');
        const legalTutorPhone = document.getElementById('legalTutorPhone');
        
        const birthDate = new Date(this.value);
        const today = new Date();
        let age = today.getFullYear() - birthDate.getFullYear();
        const monthDiff = today.getMonth() - birthDate.getMonth();
        
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
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 