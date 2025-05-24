package com.dental.clinic.service;

import com.dental.clinic.model.Visit;
import com.dental.clinic.repository.VisitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.time.LocalDateTime;
import java.util.*;
import java.util.stream.Collectors;

@Service
public class VisitService {
    private final VisitRepository visitRepository;
    private final DentistService dentistService;
    
    @Autowired
    public VisitService(DentistService dentistService, VisitRepository visitRepository) {
        this.dentistService = dentistService;
        this.visitRepository = visitRepository;
    }
    
    public Visit save(Visit visit) {
        return visitRepository.save(visit);
    }
    
    public Optional<Visit> findById(String id) {
        return visitRepository.findById(id);
    }
    
    public List<Visit> findAll() {
        return visitRepository.findAll();
    }
    
    public List<Visit> findByDentistId(String dentistId) {
        return visitRepository.findByDentistId(dentistId);
    }
    
    public List<Visit> findByPatientId(String patientId) {
        return visitRepository.findByPatientId(patientId);
    }
    
    public List<Visit> findPendingByDentistId(String dentistId) {
        return visitRepository.findPendingByDentistId(dentistId);
    }
    
    public void delete(String id) {
        visitRepository.delete(id);
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
        return !visitRepository.hasOverlappingAppointment(new Visit(null, dentistId, dateTime, null));
    }
    
    public List<Visit> findByPatientEmail(String patientEmail) {
        return visitRepository.findByPatientEmail(patientEmail);
    }
} 