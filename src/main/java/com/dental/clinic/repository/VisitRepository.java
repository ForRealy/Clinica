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
                .filter(visit -> visit.getDentist().getId().equals(dentistId))
                .collect(Collectors.toList());
    }
    
    public boolean hasOverlappingAppointment(Visit visit) {
        return visits.values().stream()
                .filter(v -> v.getDentist().getId().equals(visit.getDentist().getId()))
                .filter(v -> v.getDateTime().equals(visit.getDateTime()))
                .anyMatch(v -> !v.getId().equals(visit.getId()));
    }
} 