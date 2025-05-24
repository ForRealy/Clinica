package com.dental.clinic.repository;

import com.dental.clinic.model.Patient;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Repository
public class PatientRepository implements BaseRepository<Patient> {
    private final ConcurrentHashMap<String, Patient> patients = new ConcurrentHashMap<>();
    
    @Override
    public Patient save(Patient patient) {
        patients.put(patient.getId(), patient);
        return patient;
    }
    
    @Override
    public Optional<Patient> findById(String id) {
        return Optional.ofNullable(patients.get(id));
    }
    
    @Override
    public List<Patient> findAll() {
        return patients.values().stream().collect(Collectors.toList());
    }
    
    @Override
    public void delete(String id) {
        patients.remove(id);
    }
    
    @Override
    public boolean exists(String id) {
        return patients.containsKey(id);
    }
    
    public Optional<Patient> findByEmail(String email) {
        return patients.values().stream()
                .filter(patient -> patient.getEmail().equalsIgnoreCase(email))
                .findFirst();
    }
} 