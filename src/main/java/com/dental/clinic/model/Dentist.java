package com.dental.clinic.model;

import lombok.Data;
import java.time.LocalTime;
import java.util.UUID;

@Data
public class Dentist {
    private String id;
    private String fullName;
    private String specialty;
    private LocalTime startTime;
    private LocalTime endTime;
    
    public Dentist() {
        this.id = UUID.randomUUID().toString();
        this.startTime = LocalTime.of(8, 0); // 8 AM
        this.endTime = LocalTime.of(15, 0);  // 3 PM
    }
    
    public Dentist(String fullName, String specialty) {
        this();
        this.fullName = fullName;
        this.specialty = specialty;
    }
    
    public boolean isWorkingHour(LocalTime time) {
        return !time.isBefore(startTime) && !time.isAfter(endTime);
    }
} 