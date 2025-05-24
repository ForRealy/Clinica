package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@Controller
@RequestMapping("/admin")
@PreAuthorize("hasRole('ADMIN')")
public class AdminDashboardController {

    private final VisitService visitService;

    @Autowired
    public AdminDashboardController(VisitService visitService) {
        this.visitService = visitService;
    }

    @GetMapping("/dashboard")
    public String dashboard() {
        return "admin/dashboard";
    }

    @GetMapping("/visits")
    public String listAllVisits(Model model) {
        List<Visit> visits = visitService.findAll();
        model.addAttribute("visits", visits);
        return "admin/visits/list";
    }
} 