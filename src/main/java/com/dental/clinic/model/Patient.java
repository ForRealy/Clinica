package com.dental.clinic.model;

import lombok.Data;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.util.UUID;
import org.springframework.format.annotation.DateTimeFormat;

@Data
public class Patient {
    private String id;
    private String fullName;
    
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate dateOfBirth;
    
    private String phone;
    private String email;
    private PaymentMethod paymentMethod;
    private String visitReason;
    private String legalTutorName;
    private String legalTutorPhone;
    
    private static final DateTimeFormatter DATE_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd");
    
    public Patient() {
        this.id = UUID.randomUUID().toString();
    }
    
    public Patient(String fullName, LocalDate dateOfBirth, String phone, String email, PaymentMethod paymentMethod, String visitReason) {
        this();
        this.fullName = fullName;
        this.dateOfBirth = dateOfBirth;
        this.phone = phone;
        this.email = email;
        this.paymentMethod = paymentMethod;
        this.visitReason = visitReason;
    }
    
    public boolean requiresLegalTutor() {
        return getAge() < 18;
    }
    
    public int getAge() {
        if (dateOfBirth == null) {
            return 0;
        }
        return LocalDate.now().getYear() - dateOfBirth.getYear();
    }
    
    public String getFormattedDateOfBirth() {
        return dateOfBirth != null ? dateOfBirth.format(DATE_FORMATTER) : "";
    }
    
    public enum PaymentMethod {
        PRIVATE,
        MUTUAL
    }
} 