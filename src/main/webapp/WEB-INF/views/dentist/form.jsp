<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<jsp:include page="../layout/header.jsp" />

<div class="row">
    <div class="col-md-6 offset-md-3">
        <h2>${dentist.id == null ? 'Add New' : 'Edit'} Dentist</h2>
        <hr>
        
        <form action="${dentist.id == null ? '/admin/dentists' : '/admin/dentists/' + dentist.id}" method="post">
            <div class="mb-3">
                <label for="fullName" class="form-label">Full Name</label>
                <input type="text" class="form-control" id="fullName" name="fullName" value="${dentist.fullName}" required>
            </div>
            
            <div class="mb-3">
                <label for="specialty" class="form-label">Specialty</label>
                <input type="text" class="form-control" id="specialty" name="specialty" value="${dentist.specialty}" required>
            </div>
            
            <div class="mb-3">
                <label for="startTime" class="form-label">Start Time</label>
                <input type="time" class="form-control" id="startTime" name="startTime" value="${dentist.startTime}" required>
            </div>
            
            <div class="mb-3">
                <label for="endTime" class="form-label">End Time</label>
                <input type="time" class="form-control" id="endTime" name="endTime" value="${dentist.endTime}" required>
            </div>
            
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Save</button>
                <a href="/admin/dentists" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<jsp:include page="../layout/footer.jsp" /> 