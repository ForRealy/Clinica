package com.dental.clinic.repository;

import com.dental.clinic.model.Visit;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Repository
public class VisitRepository implements BaseRepository<Visit> {
    private final ConcurrentHashMap<String, Visit> visits = new ConcurrentHashMap<>();
    
    @Override
    public Visit save(Visit visit) {
        visits.put(visit.getId(), visit);
        return visit;
    }
    
    @Override
    public Optional<Visit> findById(String id) {
        return Optional.ofNullable(visits.get(id));
    }
    
    @Override
    public List<Visit> findAll() {
        return visits.values().stream().collect(Collectors.toList());
    }
    
    @Override
    public void delete(String id) {
        visits.remove(id);
    }
    
    @Override
    public boolean exists(String id) {
        return visits.containsKey(id);
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
    
    public boolean hasOverlappingAppointment(Visit visit) {
        return visits.values().stream()
                .filter(v -> v.getDentistId().equals(visit.getDentistId()))
                .filter(v -> v.getDateTime().equals(visit.getDateTime()))
                .filter(v -> v.getStatus() != Visit.VisitStatus.CANCELLED)
                .anyMatch(v -> !v.getId().equals(visit.getId()));
    }
    
    public List<Visit> findByPatientEmail(String patientEmail) {
        return visits.values().stream()
                .filter(visit -> visit.getPatientEmail().equals(patientEmail))
                .collect(Collectors.toList());
    }
} 