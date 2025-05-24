package com.dental.clinic.service;

import com.dental.clinic.model.Visit;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class VisitService {
    private final Map<String, Visit> visits = new HashMap<>();
    private final DentistService dentistService;
    
    @Autowired
    public VisitService(DentistService dentistService) {
        this.dentistService = dentistService;
    }
    
    public Visit save(Visit visit) {
        visits.put(visit.getId(), visit);
        return visit;
    }
    
    public Optional<Visit> findById(String id) {
        return Optional.ofNullable(visits.get(id));
    }
    
    public List<Visit> findAll() {
        return new ArrayList<>(visits.values());
    }
    
    public List<Visit> findByDentistId(String dentistId) {
        return visits.values().stream()
                .filter(visit -> visit.getDentistId().equals(dentistId))
                .collect(Collectors.toList());
    }
    
    public List<Visit> findByPatientId(String patientId) {
        return visits.values().stream()
                .filter(visit -> visit.getPatientId().equals(patientId))
                .collect(Collectors.toList());
    }
    
    public List<Visit> findPendingByDentistId(String dentistId) {
        return visits.values().stream()
                .filter(visit -> visit.getDentistId().equals(dentistId) 
                        && visit.getStatus() == Visit.VisitStatus.PENDING)
                .collect(Collectors.toList());
    }
    
    public void delete(String id) {
        visits.remove(id);
    }
    
    public boolean isTimeSlotAvailable(String dentistId, LocalDateTime dateTime) {
        // Check if it's a weekend
        if (dateTime.getDayOfWeek().getValue() >= 6) {
            return false;
        }
        
        // Check if it's within working hours
        if (!dentistService.isWorkingHour(dentistId, dateTime.toLocalTime())) {
            return false;
        }
        
        // Check if the time slot is already booked
        return visits.values().stream()
                .filter(visit -> visit.getDentistId().equals(dentistId))
                .filter(visit -> visit.getStatus() != Visit.VisitStatus.CANCELLED)
                .noneMatch(visit -> visit.getDateTime().equals(dateTime));
    }
    
    public List<Visit> findByPatientEmail(String patientEmail) {
        return visits.values().stream()
                .filter(visit -> visit.getPatientEmail().equals(patientEmail))
                .collect(Collectors.toList());
    }
} 