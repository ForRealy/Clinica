package com.dental.clinic.service;

import com.dental.clinic.model.Dentist;
import com.dental.clinic.repository.DentistRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class DentistService implements BaseService<Dentist> {
    private final DentistRepository dentistRepository;
    
    @Autowired
    public DentistService(DentistRepository dentistRepository) {
        this.dentistRepository = dentistRepository;
    }
    
    @Override
    public Dentist save(Dentist dentist) {
        return dentistRepository.save(dentist);
    }
    
    @Override
    public Optional<Dentist> findById(String id) {
        return dentistRepository.findById(id);
    }
    
    @Override
    public List<Dentist> findAll() {
        return dentistRepository.findAll();
    }
    
    @Override
    public void delete(String id) {
        dentistRepository.delete(id);
    }
    
    @Override
    public boolean exists(String id) {
        return dentistRepository.exists(id);
    }
} 