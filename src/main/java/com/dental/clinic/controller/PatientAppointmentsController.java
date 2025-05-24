package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
@RequestMapping("/patient")
@PreAuthorize("hasRole('PATIENT')")
public class PatientAppointmentsController {
    private final VisitService visitService;

    @Autowired
    public PatientAppointmentsController(VisitService visitService) {
        this.visitService = visitService;
    }

    @GetMapping("/appointments")
    public String viewAppointments(Authentication authentication, Model model) {
        String patientEmail = authentication.getName();
        List<Visit> appointments = visitService.findByPatientEmail(patientEmail);
        model.addAttribute("appointments", appointments);
        return "patient/appointments";
    }

    @PostMapping("/appointments/request")
    public String requestAppointment(@ModelAttribute Visit visit, Authentication authentication, RedirectAttributes redirectAttributes) {
        String patientEmail = authentication.getName();
        if (visitService.findByPatientEmail(patientEmail).size() > 0) {
            redirectAttributes.addFlashAttribute("errorMessage", "You already have an appointment.");
            return "redirect:/patient/appointments";
        }
        visit.setPatientEmail(patientEmail);
        visit.setStatus(Visit.VisitStatus.PENDING);
        visitService.save(visit);
        redirectAttributes.addFlashAttribute("successMessage", "Appointment requested successfully.");
        return "redirect:/patient/appointments";
    }
} 