package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;
import com.dental.clinic.service.DentistService;
import com.dental.clinic.service.PatientService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/visits")
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
    
    @GetMapping("/dentist/{dentistId}")
    @PreAuthorize("hasRole('DENTIST')")
    public String listDentistVisits(@PathVariable String dentistId, Model model) {
        List<Visit> pendingVisits = visitService.findPendingByDentistId(dentistId);
        List<Visit> confirmedVisits = visitService.findByDentistId(dentistId).stream()
                .filter(v -> v.getStatus() == Visit.VisitStatus.CONFIRMED)
                .toList();
        
        model.addAttribute("pendingVisits", pendingVisits);
        model.addAttribute("confirmedVisits", confirmedVisits);
        return "visit/dentist-list";
    }
    
    @PostMapping("/request")
    @PreAuthorize("hasRole('PATIENT')")
    public String requestVisit(@ModelAttribute Visit visit, RedirectAttributes redirectAttributes) {
        try {
            if (!visitService.isTimeSlotAvailable(visit.getDentistId(), visit.getDateTime())) {
                redirectAttributes.addFlashAttribute("errorMessage", "This time slot is not available");
                return "redirect:/patients/appointments";
            }
            
            visitService.save(visit);
            redirectAttributes.addFlashAttribute("successMessage", "Visit request submitted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/patients/appointments";
    }
    
    @PostMapping("/{id}/confirm")
    @PreAuthorize("hasRole('DENTIST')")
    public String confirmVisit(@PathVariable String id, RedirectAttributes redirectAttributes) {
        String dentistId = null;
        try {
            Visit visit = visitService.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Visit not found"));
            
            visit.setStatus(Visit.VisitStatus.CONFIRMED);
            visitService.save(visit);
            dentistId = visit.getDentistId();
            
            redirectAttributes.addFlashAttribute("successMessage", "Visit confirmed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/visits/dentist/" + dentistId;
    }
    
    @PostMapping("/{id}/cancel")
    @PreAuthorize("hasAnyRole('DENTIST', 'PATIENT')")
    public String cancelVisit(@PathVariable String id, RedirectAttributes redirectAttributes) {
        String dentistId = null;
        try {
            Visit visit = visitService.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Visit not found"));
            
            visit.setStatus(Visit.VisitStatus.CANCELLED);
            visitService.save(visit);
            dentistId = visit.getDentistId();
            
            redirectAttributes.addFlashAttribute("successMessage", "Visit cancelled successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/visits/dentist/" + dentistId;
    }
    
    @PostMapping("/{id}/complete")
    @PreAuthorize("hasRole('DENTIST')")
    public String completeVisit(@PathVariable String id, @RequestParam String notes, RedirectAttributes redirectAttributes) {
        String dentistId = null;
        try {
            Visit visit = visitService.findById(id)
                    .orElseThrow(() -> new IllegalArgumentException("Visit not found"));
            
            visit.setStatus(Visit.VisitStatus.COMPLETED);
            visit.setNotes(notes);
            visitService.save(visit);
            dentistId = visit.getDentistId();
            
            redirectAttributes.addFlashAttribute("successMessage", "Visit completed successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", e.getMessage());
        }
        return "redirect:/visits/dentist/" + dentistId;
    }
    
    @GetMapping("/schedule")
    @PreAuthorize("hasRole('PATIENT')")
    public String showScheduleForm(Model model) {
        // Get available time slots for the next 7 days
        List<LocalDateTime> availableSlots = generateAvailableSlots();
        model.addAttribute("availableSlots", availableSlots);
        return "visits/schedule";
    }
    
    @PostMapping("/schedule")
    @PreAuthorize("hasRole('PATIENT')")
    public String scheduleVisit(@RequestParam LocalDateTime dateTime,
                              @RequestParam String reason,
                              Authentication authentication,
                              RedirectAttributes redirectAttributes) {
        try {
            Visit visit = new Visit();
            visit.setPatientId(authentication.getName());
            visit.setDateTime(dateTime);
            visit.setReason(reason);
            visit.setStatus(Visit.VisitStatus.PENDING);
            
            visitService.save(visit);
            redirectAttributes.addFlashAttribute("successMessage", "Visit scheduled successfully!");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("errorMessage", "Could not schedule visit: " + e.getMessage());
        }
        return "redirect:/visits/schedule";
    }
    
    private List<LocalDateTime> generateAvailableSlots() {
        List<LocalDateTime> slots = new ArrayList<>();
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime startTime = now.withHour(9).withMinute(0).withSecond(0).withNano(0);
        
        // Generate slots for the next 7 days
        for (int day = 0; day < 7; day++) {
            LocalDateTime currentDay = startTime.plusDays(day);
            
            // Skip weekends
            if (currentDay.getDayOfWeek().getValue() > 5) {
                continue;
            }
            
            // Generate slots from 9 AM to 5 PM with 30-minute intervals
            for (int hour = 9; hour < 17; hour++) {
                for (int minute = 0; minute < 60; minute += 30) {
                    LocalDateTime slot = currentDay.withHour(hour).withMinute(minute);
                    if (slot.isAfter(now)) {
                        slots.add(slot);
                    }
                }
            }
        }
        
        return slots;
    }
} 