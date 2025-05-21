package com.dental.clinic.service;

import java.util.List;
import java.util.Optional;

public interface BaseService<T> {
    T save(T entity);
    Optional<T> findById(String id);
    List<T> findAll();
    void delete(String id);
    boolean exists(String id);
} 