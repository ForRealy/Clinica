package com.dental.clinic.controller;

import com.dental.clinic.model.Patient;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/admin/patients")
@PreAuthorize("hasRole('ADMIN')")
public class PatientController {
    
    private final PatientService patientService;
    private final UserService userService;
    
    @Autowired
    public PatientController(PatientService patientService, UserService userService) {
        this.patientService = patientService;
        this.userService = userService;
    }
    
    @GetMapping
    public String listPatients(Model model) {
        model.addAttribute("patients", patientService.findAll());
        return "patient/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("patient", new Patient());
        model.addAttribute("paymentMethods", Patient.PaymentMethod.values());
        return "patient/form";
    }
    
    @PostMapping
    public String createPatient(@ModelAttribute Patient patient, RedirectAttributes redirectAttributes) {
        try {
            patientService.saveWithGuardianValidation(patient);
            redirectAttributes.addFlashAttribute("successMessage", "Patient created successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/patients/new";
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
    public String updatePatient(@PathVariable String id, @ModelAttribute Patient patient, RedirectAttributes redirectAttributes) {
        try {
            patient.setId(id);
            patientService.saveWithGuardianValidation(patient);
            redirectAttributes.addFlashAttribute("successMessage", "Patient updated successfully");
        } catch (IllegalArgumentException e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
            return "redirect:/admin/patients/" + id + "/edit";
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
} 