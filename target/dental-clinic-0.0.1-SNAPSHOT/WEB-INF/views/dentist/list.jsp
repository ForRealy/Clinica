<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="container mt-4">
    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2>Dentists</h2>
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#dentistModal">
            Add New Dentist
        </button>
    </div>

    <div class="table-responsive">
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>Name</th>
                    <th>Phone</th>
                    <th>Email</th>
                    <th>Specialty</th>
                    <th>Actions</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach items="${dentists}" var="dentist">
                    <tr>
                        <td>${dentist.fullName}</td>
                        <td>${dentist.phone}</td>
                        <td>${dentist.email}</td>
                        <td>${dentist.specialty}</td>
                        <td>
                            <button type="button" class="btn btn-sm btn-primary edit-dentist" 
                                    data-bs-toggle="modal" 
                                    data-bs-target="#dentistModal"
                                    data-dentist-id="${dentist.id}"
                                    data-dentist-name="${dentist.fullName}"
                                    data-dentist-phone="${dentist.phone}"
                                    data-dentist-email="${dentist.email}"
                                    data-dentist-specialty="${dentist.specialty}">
                                Edit
                            </button>
                        </td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>
</div>

<!-- Dentist Modal -->
<div class="modal fade" id="dentistModal" tabindex="-1" aria-labelledby="dentistModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="dentistModalLabel">Add New Dentist</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
            </div>
            <div class="modal-body">
                <form id="dentistForm" action="<c:url value='/admin/dentists'/>" method="post">
                    <input type="hidden" id="dentistId" name="id">
                    
                    <div class="mb-3">
                        <label for="fullName" class="form-label">Full Name</label>
                        <input type="text" class="form-control" id="fullName" name="fullName" 
                               pattern="[A-Za-zÀ-ÿ\s]+" 
                               title="Please enter a valid name (letters and spaces only)"
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
                        <label for="specialty" class="form-label">Specialty</label>
                        <select class="form-select" id="specialty" name="specialty" required>
                            <option value="">Select specialty</option>
                            <option value="GENERAL">General Dentistry</option>
                            <option value="ORTHODONTIST">Orthodontist</option>
                            <option value="PEDIATRIC">Pediatric Dentistry</option>
                            <option value="ENDODONTIST">Endodontist</option>
                            <option value="PERIODONTIST">Periodontist</option>
                            <option value="PROSTHODONTIST">Prosthodontist</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="dentistForm" class="btn btn-primary">Save</button>
            </div>
        </div>
    </div>
</div>

<script>
document.addEventListener('DOMContentLoaded', function() {
    const modal = document.getElementById('dentistModal');
    const modalTitle = modal.querySelector('.modal-title');
    const form = document.getElementById('dentistForm');
    
    // Handle edit button clicks
    document.querySelectorAll('.edit-dentist').forEach(button => {
        button.addEventListener('click', function() {
            const dentistId = this.dataset.dentistId;
            modalTitle.textContent = 'Edit Dentist';
            form.action = `/dental-clinic/admin/dentists/${dentistId}`;
            
            // Fill form with dentist data
            document.getElementById('dentistId').value = dentistId;
            document.getElementById('fullName').value = this.dataset.dentistName;
            document.getElementById('phone').value = this.dataset.dentistPhone;
            document.getElementById('email').value = this.dataset.dentistEmail;
            document.getElementById('specialty').value = this.dataset.dentistSpecialty;
        });
    });
    
    // Handle new dentist button click
    document.querySelector('[data-bs-target="#dentistModal"]').addEventListener('click', function() {
        modalTitle.textContent = 'Add New Dentist';
        form.reset();
        form.action = '/dental-clinic/admin/dentists';
    });
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 