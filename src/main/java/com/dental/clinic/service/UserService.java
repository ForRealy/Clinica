package com.dental.clinic.service;

import com.dental.clinic.model.User;
import com.dental.clinic.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.Optional;

@Service
public class UserService implements BaseService<User> {
    private final UserRepository userRepository;
    private PasswordEncoder passwordEncoder;
    
    @Autowired
    public UserService(UserRepository userRepository) {
        this.userRepository = userRepository;
    }
    
    @Autowired
    public void setPasswordEncoder(PasswordEncoder passwordEncoder) {
        this.passwordEncoder = passwordEncoder;
    }
    
    @Override
    public User save(User user) {
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        return userRepository.save(user);
    }
    
    @Override
    public Optional<User> findById(String id) {
        return userRepository.findById(id);
    }
    
    @Override
    public List<User> findAll() {
        return userRepository.findAll();
    }
    
    @Override
    public void delete(String id) {
        userRepository.delete(id);
    }
    
    @Override
    public boolean exists(String id) {
        return userRepository.exists(id);
    }
    
    public Optional<User> findByUsername(String username) {
        return userRepository.findByUsername(username);
    }
    
    public User createDentistUser(String username, String password, String dentistId) {
        User user = new User(username, password, User.UserRole.DENTIST);
        user.setAssociatedDentistId(dentistId);
        return save(user);
    }
    
    public User createAdminUser(String username, String password) {
        User user = new User(username, password, User.UserRole.ADMIN);
        return save(user);
    }
} 