package com.dental.clinic.controller;

import com.dental.clinic.model.Patient;
import com.dental.clinic.model.User;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import org.springframework.security.core.Authentication;
import java.util.List;
import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;

@Controller
@RequestMapping("/admin/patients")
@PreAuthorize("hasRole('ADMIN')")
public class PatientController {
    
    private final PatientService patientService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;
    private final VisitService visitService;
    
    @Autowired
    public PatientController(PatientService patientService, UserService userService, PasswordEncoder passwordEncoder, VisitService visitService) {
        this.patientService = patientService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
        this.visitService = visitService;
    }
    
    @GetMapping
    public String listPatients(Model model) {
        model.addAttribute("patients", patientService.findAll());
        model.addAttribute("now", java.time.LocalDate.now());
        return "patient/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("patient", new Patient());
        model.addAttribute("paymentMethods", Patient.PaymentMethod.values());
        return "patient/form";
    }
    
    @PostMapping
    public String createPatient(@ModelAttribute Patient patient, @RequestParam String password, RedirectAttributes redirectAttributes) {
        try {
            // Check if patient is 18 or older and clear tutor data if true
            if (patient.getAge() >= 18) {
                patient.setLegalTutorName(null);
                patient.setLegalTutorPhone(null);
            }
            
            // Save the patient first
            patientService.saveWithGuardianValidation(patient);
            
            // Check if a user with this email already exists
            if (userService.findByUsername(patient.getEmail()).isEmpty()) {
                // Create a user account for the patient
                User user = new User();
                user.setUsername(patient.getEmail());
                user.setPassword(passwordEncoder.encode(password));
                user.setRole(User.UserRole.PATIENT);
                user.setAssociatedPatientId(patient.getId());
                userService.save(user);
            }
            
            redirectAttributes.addFlashAttribute("successMessage", "Patient created successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/patients";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        patientService.findById(id).ifPresent(patient -> {
            model.addAttribute("patient", patient);
            model.addAttribute("paymentMethods", Patient.PaymentMethod.values());
        });
        return "patient/form";
    }
    
    @PostMapping("/{id}")
    public String updatePatient(@PathVariable String id, @ModelAttribute Patient patient, 
                              @RequestParam(required = false) String password,
                              RedirectAttributes redirectAttributes) {
        try {
            patient.setId(id);
            
            // Check if patient is 18 or older and clear tutor data if true
            if (patient.getAge() >= 18) {
                patient.setLegalTutorName(null);
                patient.setLegalTutorPhone(null);
            }
            
            // Save the patient
            patientService.saveWithGuardianValidation(patient);
            
            // Find the existing user associated with this patient
            userService.findAll().stream()
                .filter(user -> id.equals(user.getAssociatedPatientId()))
                .findFirst()
                .ifPresent(user -> {
                    // Update the user's email if it has changed
                    if (!user.getUsername().equals(patient.getEmail())) {
                        user.setUsername(patient.getEmail());
                    }
                    // Update password if provided
                    if (password != null && !password.trim().isEmpty()) {
                        user.setPassword(passwordEncoder.encode(password));
                    }
                    userService.save(user);
                });
            
            redirectAttributes.addFlashAttribute("successMessage", "Patient updated successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/admin/patients";
    }
    
    @PostMapping("/{id}/delete")
    public String deletePatient(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            // Find and delete the associated user first
            userService.findAll().stream()
                .filter(user -> id.equals(user.getAssociatedPatientId()))
                .findFirst()
                .ifPresent(user -> userService.delete(user.getId()));
            
            // Then delete the patient
            patientService.delete(id);
            redirectAttributes.addFlashAttribute("successMessage", "Patient deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error deleting patient: " + e.getMessage());
        }
        return "redirect:/admin/patients";
    }

    @GetMapping("/patient/appointments")
    @PreAuthorize("hasRole('PATIENT')")
    public String viewAppointments(Authentication authentication, Model model) {
        String patientId = authentication.getName();
        List<Visit> appointments = visitService.findByPatientId(patientId);
        model.addAttribute("appointments", appointments);
        return "patient/appointments";
    }

    @PostMapping("/appointments/request")
    @PreAuthorize("hasRole('PATIENT')")
    public String requestAppointment(@ModelAttribute Visit visit, Authentication authentication, RedirectAttributes redirectAttributes) {
        String patientId = authentication.getName();
        if (visitService.findByPatientId(patientId).size() > 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "You already have an appointment.");
            return "redirect:/patient/appointments";
        }
        visit.setPatientId(patientId);
        visit.setStatus(Visit.VisitStatus.PENDING);
        visitService.save(visit);
        redirectAttributes.addFlashAttribute("successMessage", "Appointment requested successfully.");
        return "redirect:/patient/appointments";
    }
} 