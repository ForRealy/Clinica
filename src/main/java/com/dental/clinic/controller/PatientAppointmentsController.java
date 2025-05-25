package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;
import com.dental.clinic.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.util.List;

@Controller
@RequestMapping("/patient")
@PreAuthorize("hasRole('PATIENT')")
public class PatientAppointmentsController {
    private final VisitService visitService;
    private final PatientService patientService;

    @Autowired
    public PatientAppointmentsController(VisitService visitService, PatientService patientService) {
        this.visitService = visitService;
        this.patientService = patientService;
    }

    @GetMapping("/appointments")
    public String viewAppointments(Authentication authentication, Model model) {
        String patientEmail = authentication.getName();
        List<Visit> appointments = visitService.findByPatientEmail(patientEmail);
        model.addAttribute("appointments", appointments);
        
        // Add min and max dates for the date picker
        LocalDateTime now = LocalDateTime.now();
        model.addAttribute("minDate", now);
        model.addAttribute("maxDate", now.plusDays(30));
        
        return "patient/appointments";
    }

    @PostMapping("/appointments/request")
    public String requestAppointment(
            @RequestParam("dateTimeStr") String dateTimeStr,
            @RequestParam String reason,
            Authentication authentication,
            RedirectAttributes redirectAttributes) {
        try {
            String patientEmail = authentication.getName();
            
            // Check if patient already has a pending appointment
            if (visitService.findByPatientEmail(patientEmail).stream()
                    .anyMatch(v -> v.getStatus() == Visit.VisitStatus.PENDING)) {
                redirectAttributes.addFlashAttribute("errorMessage", "You already have a pending appointment.");
                return "redirect:/patient/appointments";
            }
            
            // Parse the date string to LocalDateTime
            LocalDateTime dateTime = LocalDateTime.parse(dateTimeStr.replace(" ", "T"));
            
            // Create and save the visit
            Visit visit = new Visit();
            visit.setPatientEmail(patientEmail);
            visit.setDateTime(dateTime);
            visit.setReason(reason);
            visit.setStatus(Visit.VisitStatus.PENDING);
            
            // Set a default dentist (you might want to modify this based on your requirements)
            visit.setDentistId("1"); // Using Sarah's ID as default
            
            // Set patient name from the patient service
            patientService.findByEmail(patientEmail).ifPresent(patient -> {
                visit.setPatientId(patient.getId());
                visit.setPatientName(patient.getFullName());
            });
            
            visitService.save(visit);
            redirectAttributes.addFlashAttribute("successMessage", "Appointment requested successfully.");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Error requesting appointment: " + e.getMessage());
        }
        return "redirect:/patient/appointments";
    }
} 