package com.dental.clinic.controller;

import com.dental.clinic.model.Dentist;
import com.dental.clinic.model.User;
import com.dental.clinic.model.User.UserRole;
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
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("dentist", new Dentist());
        return "dentist/form";
    }
    
    @PostMapping
    public String createDentist(@ModelAttribute Dentist dentist, @RequestParam String username, @RequestParam String password) {
        // Save the dentist first
        Dentist savedDentist = dentistService.save(dentist);
        
        // Create and save the user account
        User user = new User();
        user.setUsername(username);
        user.setPassword(passwordEncoder.encode(password));
        user.setRole(UserRole.DENTIST);
        user.setAssociatedDentistId(savedDentist.getId());
        userService.save(user);
        
        return "redirect:/admin/dentists";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        dentistService.findById(id).ifPresent(dentist -> model.addAttribute("dentist", dentist));
        return "dentist/form";
    }
    
    @PostMapping("/{id}")
    public String updateDentist(@PathVariable String id, @ModelAttribute Dentist dentist) {
        dentist.setId(id);
        dentistService.save(dentist);
        return "redirect:/admin/dentists";
    }
    
    @PostMapping("/{id}/delete")
    public String deleteDentist(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            // Find and delete the associated user first
            userService.findAll().stream()
                .filter(user -> id.equals(user.getAssociatedDentistId()))
                .findFirst()
                .ifPresent(user -> userService.delete(user.getId()));
            
            // Then delete the dentist
            dentistService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Dentist deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting dentist: " + e.getMessage());
        }
        return "redirect:/admin/dentists";
    }
} 