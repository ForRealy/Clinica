package com.dental.clinic.model;

import lombok.Data;
import java.time.LocalDateTime;
import java.util.UUID;

@Data
public class Visit {
    private String id;
    private LocalDateTime dateTime;
    private Dentist dentist;
    private Patient patient;
    private String purpose;
    private String observations;
    private String prescribedTreatments;
    
    public Visit() {
        this.id = UUID.randomUUID().toString();
    }
    
    public Visit(LocalDateTime dateTime, Dentist dentist, Patient patient, String purpose) {
        this();
        this.dateTime = dateTime;
        this.dentist = dentist;
        this.patient = patient;
        this.purpose = purpose;
    }
    
    public boolean isWeekend() {
        int dayOfWeek = dateTime.getDayOfWeek().getValue();
        return dayOfWeek == 6 || dayOfWeek == 7; // Saturday or Sunday
    }
    
    public boolean isWithinWorkingHours() {
        return dentist.isWorkingHour(dateTime.toLocalTime());
    }
    
    public boolean isValidAppointment() {
        return !isWeekend() && isWithinWorkingHours();
    }
} 