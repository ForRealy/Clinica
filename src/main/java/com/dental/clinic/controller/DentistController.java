package com.dental.clinic.controller;

import com.dental.clinic.model.Dentist;
import com.dental.clinic.model.User;
import com.dental.clinic.service.DentistService;
import com.dental.clinic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/dentists")
@PreAuthorize("hasRole('ADMIN')")
public class DentistController {
    
    private final DentistService dentistService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    
    @Autowired
    public DentistController(DentistService dentistService, UserService userService, PasswordEncoder passwordEncoder) {
        this.dentistService = dentistService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }
    
    @GetMapping
    public String listDentists(Model model) {
        model.addAttribute("dentists", dentistService.findAll());
        return "dentist/list";
    }
    
    @PostMapping
    public String createDentist(@ModelAttribute Dentist dentist, RedirectAttributes redirectAttributes) {
        try {
            // Save the dentist first
            dentistService.save(dentist);
            
            // Check if a user with this email already exists
            if (userService.findByUsername(dentist.getEmail()).isEmpty()) {
                // Create a user account for the dentist
                User user = new User();
                user.setUsername(dentist.getEmail());
                user.setPassword(passwordEncoder.encode(dentist.getPhone()));
                user.setRole(User.UserRole.DENTIST);
                user.setAssociatedDentistId(dentist.getId());
                userService.save(user);
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Dentist created successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/dentists";
    }
    
    @PostMapping("/{id}")
    public String updateDentist(@PathVariable String id, @ModelAttribute Dentist dentist, RedirectAttributes redirectAttributes) {
        try {
            dentist.setId(id);
            
            // Save the dentist
            dentistService.save(dentist);
            
            // Find the existing user associated with this dentist
            userService.findAll().stream()
                .filter(user -> id.equals(user.getAssociatedDentistId()))
                .findFirst()
                .ifPresent(user -> {
                    // Update the user's email if it has changed
                    if (!user.getUsername().equals(dentist.getEmail())) {
                        user.setUsername(dentist.getEmail());
                        userService.save(user);
                    }
                });
            
            redirectAttributes.addFlashAttribute("successMessage", "Dentist updated successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/dentists";
    }
} 