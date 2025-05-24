package com.dental.clinic.service;

import com.dental.clinic.model.Patient;
import com.dental.clinic.repository.PatientRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class PatientService implements BaseService<Patient> {
    private final PatientRepository patientRepository;
    
    @Autowired
    public PatientService(PatientRepository patientRepository) {
        this.patientRepository = patientRepository;
    }
    
    @Override
    public Patient save(Patient patient) {
        return patientRepository.save(patient);
    }
    
    @Override
    public Optional<Patient> findById(String id) {
        return patientRepository.findById(id);
    }
    
    @Override
    public List<Patient> findAll() {
        return patientRepository.findAll();
    }
    
    @Override
    public void delete(String id) {
        patientRepository.delete(id);
    }
    
    @Override
    public boolean exists(String id) {
        return patientRepository.exists(id);
    }
    
    public Patient saveWithGuardianValidation(Patient patient) {
        if (patient.requiresLegalTutor()) {
            if (patient.getLegalTutorName() == null || patient.getLegalTutorName().trim().isEmpty()) {
                throw new IllegalArgumentException("Legal tutor name is required for patients under 18 years old");
            }
            if (patient.getLegalTutorPhone() == null || patient.getLegalTutorPhone().trim().isEmpty()) {
                throw new IllegalArgumentException("Legal tutor phone is required for patients under 18 years old");
            }
        }
        return save(patient);
    }
    
    public Optional<Patient> findByEmail(String email) {
        return patientRepository.findByEmail(email);
    }
} 