package com.dental.clinic.model;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
public class Visit {
    private String id;
    private String patientId;
    private String dentistId;
    private LocalDateTime dateTime;
    private String reason;
    private VisitStatus status;
    private String notes;
    private String patientEmail;
    
    public enum VisitStatus {
        PENDING,    // Nueva solicitud pendiente de confirmación
        CONFIRMED,  // Visita confirmada
        COMPLETED,  // Visita completada
        CANCELLED   // Visita cancelada
    }
    
    public Visit() {
        this.id = UUID.randomUUID().toString();
        this.status = VisitStatus.PENDING;
    }
    
    public Visit(String patientId, String dentistId, LocalDateTime dateTime, String reason) {
        this();
        this.patientId = patientId;
        this.dentistId = dentistId;
        this.dateTime = dateTime;
        this.reason = reason;
    }
    
    public boolean isWeekend() {
        int dayOfWeek = dateTime.getDayOfWeek().getValue();
        return dayOfWeek == 6 || dayOfWeek == 7; // Saturday or Sunday
    }

    public String getPatientEmail() {
        return patientEmail;
    }

    public void setPatientEmail(String patientEmail) {
        this.patientEmail = patientEmail;
    }
} 