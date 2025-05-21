package com.dental.clinic.repository;

import com.dental.clinic.model.Dentist;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Repository
public class DentistRepository implements BaseRepository<Dentist> {
    private final ConcurrentHashMap<String, Dentist> dentists = new ConcurrentHashMap<>();
    
    @Override
    public Dentist save(Dentist dentist) {
        dentists.put(dentist.getId(), dentist);
        return dentist;
    }
    
    @Override
    public Optional<Dentist> findById(String id) {
        return Optional.ofNullable(dentists.get(id));
    }
    
    @Override
    public List<Dentist> findAll() {
        return dentists.values().stream().collect(Collectors.toList());
    }
    
    @Override
    public void delete(String id) {
        dentists.remove(id);
    }
    
    @Override
    public boolean exists(String id) {
        return dentists.containsKey(id);
    }
} 