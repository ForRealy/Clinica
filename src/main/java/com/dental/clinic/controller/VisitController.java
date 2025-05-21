package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.DentistService;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/admin/visits")
@PreAuthorize("hasRole('ADMIN')")
public class VisitController {
    
    private final VisitService visitService;
    private final DentistService dentistService;
    private final PatientService patientService;
    
    @Autowired
    public VisitController(VisitService visitService, DentistService dentistService, PatientService patientService) {
        this.visitService = visitService;
        this.dentistService = dentistService;
        this.patientService = patientService;
    }
    
    @GetMapping
    public String listVisits(Model model) {
        model.addAttribute("visits", visitService.findAll());
        return "visit/list";
    }
    
    @GetMapping("/new")
    public String showCreateForm(Model model) {
        model.addAttribute("visit", new Visit());
        model.addAttribute("dentists", dentistService.findAll());
        model.addAttribute("patients", patientService.findAll());
        return "visit/form";
    }
    
    @PostMapping
    public String createVisit(@ModelAttribute Visit visit) {
        visitService.save(visit);
        return "redirect:/admin/visits";
    }
    
    @GetMapping("/{id}/edit")
    public String showEditForm(@PathVariable String id, Model model) {
        visitService.findById(id).ifPresent(visit -> {
            model.addAttribute("visit", visit);
            model.addAttribute("dentists", dentistService.findAll());
            model.addAttribute("patients", patientService.findAll());
        });
        return "visit/form";
    }
    
    @PostMapping("/{id}")
    public String updateVisit(@PathVariable String id, @ModelAttribute Visit visit) {
        visit.setId(id);
        visitService.save(visit);
        return "redirect:/admin/visits";
    }
    
    @PostMapping("/{id}/delete")
    public String deleteVisit(@PathVariable String id) {
        visitService.delete(id);
        return "redirect:/admin/visits";
    }
    
    @GetMapping("/{id}/notes")
    public String showNotesForm(@PathVariable String id, Model model) {
        visitService.findById(id).ifPresent(visit -> model.addAttribute("visit", visit));
        return "visit/notes";
    }
    
    @PostMapping("/{id}/notes")
    public String addNotes(@PathVariable String id, @RequestParam String observations, @RequestParam String prescribedTreatments) {
        visitService.addPostVisitNotes(id, observations, prescribedTreatments);
        return "redirect:/admin/visits";
    }
} 