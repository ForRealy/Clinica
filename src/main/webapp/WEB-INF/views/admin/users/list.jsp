<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="/WEB-INF/views/layout/header.jsp" />

<div class="row mb-4">
    <div class="col-md-6">
        <h2>User Management</h2>
    </div>
    <div class="col-md-6 text-end">
        <button type="button" class="btn btn-primary" data-bs-toggle="modal" data-bs-target="#newUserModal">
            Add New User
        </button>
    </div>
</div>

<div class="table-responsive">
    <table class="table table-striped">
        <thead>
            <tr>
                <th>Username</th>
                <th>Role</th>
                <th>Associated ID</th>
                <th>Actions</th>
            </tr>
        </thead>
        <tbody>
            <c:forEach items="${users}" var="user">
                <tr>
                    <td>${user.username}</td>
                    <td>${user.role}</td>
                    <td>
                        <c:choose>
                            <c:when test="${not empty user.associatedDentistId}">
                                Dentist ID: ${user.associatedDentistId}
                            </c:when>
                            <c:when test="${not empty user.associatedPatientId}">
                                Patient ID: ${user.associatedPatientId}
                            </c:when>
                            <c:otherwise>
                                -
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td>
                        <a href="/admin/users/${user.id}/edit" class="btn btn-sm btn-warning">Edit</a>
                        <form action="/admin/users/${user.id}/delete" method="post" class="d-inline">
                            <button type="submit" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?')">Delete</button>
                        </form>
                    </td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
</div>

<!-- New User Modal -->
<div class="modal fade" id="newUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Add New User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form action="/admin/users" method="post" id="newUserForm">
                    <div class="mb-3">
                        <label for="username" class="form-label">Username</label>
                        <input type="text" class="form-control" id="username" name="username" required>
                    </div>
                    <div class="mb-3">
                        <label for="password" class="form-label">Password</label>
                        <input type="password" class="form-control" id="password" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="role" class="form-label">Role</label>
                        <select class="form-select" id="role" name="role" required>
                            <option value="">Select a role</option>
                            <option value="DENTIST">Dentist</option>
                            <option value="PATIENT">Patient</option>
                        </select>
                    </div>
                    <div class="mb-3" id="associatedIdGroup" style="display: none;">
                        <label for="associatedId" class="form-label">Associated ID</label>
                        <select class="form-select" id="associatedId" name="associatedId">
                            <option value="">Select an ID</option>
                        </select>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                <button type="submit" form="newUserForm" class="btn btn-primary">Create User</button>
            </div>
        </div>
    </div>
</div>

<script>
document.getElementById('role').addEventListener('change', function() {
    var associatedIdGroup = document.getElementById('associatedIdGroup');
    var associatedId = document.getElementById('associatedId');
    
    if (this.value) {
        associatedIdGroup.style.display = 'block';
        // Here you would typically make an AJAX call to fetch the list of dentists or patients
        // For now, we'll just show/hide the field
    } else {
        associatedIdGroup.style.display = 'none';
    }
});
</script>

<jsp:include page="/WEB-INF/views/layout/footer.jsp" /> 