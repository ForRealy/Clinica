package com.dental.clinic.model;

import lombok.Data;
import java.util.UUID;

@Data
public class User {
    private String id;
    private String username;
    private String password;
    private UserRole role;
    private String associatedDentistId; // For dentist users
    private String associatedPatientId;
    
    public User() {
        this.id = UUID.randomUUID().toString();
    }
    
    public User(String username, String password, UserRole role) {
        this();
        this.username = username;
        this.password = password;
        this.role = role;
    }
    
    public enum UserRole {
        ADMIN,
        DENTIST,
        PATIENT
    }

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public UserRole getRole() {
        return role;
    }

    public void setRole(UserRole role) {
        this.role = role;
    }

    public String getAssociatedDentistId() {
        return associatedDentistId;
    }

    public void setAssociatedDentistId(String associatedDentistId) {
        this.associatedDentistId = associatedDentistId;
    }

    public String getAssociatedPatientId() {
        return associatedPatientId;
    }

    public void setAssociatedPatientId(String associatedPatientId) {
        this.associatedPatientId = associatedPatientId;
    }
} 