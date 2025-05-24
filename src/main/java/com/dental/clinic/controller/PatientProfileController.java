package com.dental.clinic.controller;

import com.dental.clinic.model.Patient;
import com.dental.clinic.model.Visit;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/patient/profile")
@PreAuthorize("hasRole('PATIENT')")
public class PatientProfileController {
    private final PatientService patientService;
    private final VisitService visitService;

    @Autowired
    public PatientProfileController(PatientService patientService, VisitService visitService) {
        this.patientService = patientService;
        this.visitService = visitService;
    }

    @GetMapping
    public String profile(Authentication authentication, Model model) {
        String patientEmail = authentication.getName();
        Patient patient = patientService.findByEmail(patientEmail).orElse(null);
        List<Visit> completedVisits = visitService.findByPatientEmail(patientEmail).stream()
                .filter(v -> v.getStatus() == Visit.VisitStatus.COMPLETED)
                .toList();
        model.addAttribute("patient", patient);
        model.addAttribute("completedVisits", completedVisits);
        return "patient/profile";
    }
} 