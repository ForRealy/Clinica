package com.dental.clinic.repository;

import com.dental.clinic.model.User;
import org.springframework.stereotype.Repository;
import java.util.List;
import java.util.Optional;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Repository
public class UserRepository implements BaseRepository<User> {
    private final ConcurrentHashMap<String, User> users = new ConcurrentHashMap<>();
    
    @Override
    public User save(User user) {
        users.put(user.getId(), user);
        return user;
    }
    
    @Override
    public Optional<User> findById(String id) {
        return Optional.ofNullable(users.get(id));
    }
    
    @Override
    public List<User> findAll() {
        return users.values().stream().collect(Collectors.toList());
    }
    
    @Override
    public void delete(String id) {
        users.remove(id);
    }
    
    @Override
    public boolean exists(String id) {
        return users.containsKey(id);
    }
    
    public Optional<User> findByUsername(String username) {
        return users.values().stream()
                .filter(user -> user.getUsername().equals(username))
                .findFirst();
    }
} 