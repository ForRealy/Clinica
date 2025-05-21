package com.dental.clinic.service;

import com.dental.clinic.model.Visit;
import com.dental.clinic.repository.VisitRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class VisitService implements BaseService<Visit> {
    private final VisitRepository visitRepository;
    
    @Autowired
    public VisitService(VisitRepository visitRepository) {
        this.visitRepository = visitRepository;
    }
    
    @Override
    public Visit save(Visit visit) {
        validateVisit(visit);
        return visitRepository.save(visit);
    }
    
    @Override
    public Optional<Visit> findById(String id) {
        return visitRepository.findById(id);
    }
    
    @Override
    public List<Visit> findAll() {
        return visitRepository.findAll();
    }
    
    @Override
    public void delete(String id) {
        visitRepository.delete(id);
    }
    
    @Override
    public boolean exists(String id) {
        return visitRepository.exists(id);
    }
    
    public List<Visit> findByDentistId(String dentistId) {
        return visitRepository.findByDentistId(dentistId);
    }
    
    private void validateVisit(Visit visit) {
        if (!visit.isValidAppointment()) {
            throw new IllegalArgumentException("Invalid appointment time: must be during working hours and not on weekends");
        }
        
        if (visitRepository.hasOverlappingAppointment(visit)) {
            throw new IllegalArgumentException("Dentist already has an appointment at this time");
        }
    }
    
    public Visit addPostVisitNotes(String visitId, String observations, String prescribedTreatments) {
        Visit visit = findById(visitId)
                .orElseThrow(() -> new IllegalArgumentException("Visit not found"));
        
        visit.setObservations(observations);
        visit.setPrescribedTreatments(prescribedTreatments);
        
        return visitRepository.save(visit);
    }
} 