package com.dental.clinic.controller;

import com.dental.clinic.model.Visit;
import com.dental.clinic.service.VisitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.security.core.Authentication;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/dentist")
@PreAuthorize("hasRole('DENTIST')")
public class DentistDashboardController {
    
    private final VisitService visitService;
    private static final List<Visit> SAMPLE_VISITS = new ArrayList<>();
    private static final String SARAH_ID = "1"; // Sarah's ID
    
    static {
        // Create some sample visits with proper scheduling
        LocalDateTime now = LocalDateTime.now();
        LocalDateTime tomorrow = now.plusDays(1).withHour(10).withMinute(0); // 10:00 AM tomorrow
        LocalDateTime dayAfterTomorrow = now.plusDays(2).withHour(14).withMinute(30); // 2:30 PM day after tomorrow
        LocalDateTime threeDaysLater = now.plusDays(3).withHour(11).withMinute(0); // 11:00 AM three days later
        LocalDateTime yesterday = now.minusDays(1).withHour(15).withMinute(0); // 3:00 PM yesterday
        LocalDateTime fiveDaysAgo = now.minusDays(5).withHour(9).withMinute(30); // 9:30 AM five days ago
        
        // Pending visit for tomorrow morning
        Visit visit1 = new Visit();
        visit1.setId("1");
        visit1.setPatientId("P001");
        visit1.setDentistId(SARAH_ID);
        visit1.setDateTime(tomorrow);
        visit1.setReason("Regular checkup");
        visit1.setStatus(Visit.VisitStatus.PENDING);
        
        // Pending visit for day after tomorrow afternoon
        Visit visit2 = new Visit();
        visit2.setId("2");
        visit2.setPatientId("P002");
        visit2.setDentistId(SARAH_ID);
        visit2.setDateTime(dayAfterTomorrow);
        visit2.setReason("Tooth pain");
        visit2.setStatus(Visit.VisitStatus.PENDING);
        
        // Confirmed visit for three days later
        Visit visit3 = new Visit();
        visit3.setId("3");
        visit3.setPatientId("P001");
        visit3.setDentistId(SARAH_ID);
        visit3.setDateTime(threeDaysLater);
        visit3.setReason("Cleaning");
        visit3.setStatus(Visit.VisitStatus.CONFIRMED);
        
        // Completed visit from yesterday
        Visit visit4 = new Visit();
        visit4.setId("4");
        visit4.setPatientId("P002");
        visit4.setDentistId(SARAH_ID);
        visit4.setDateTime(yesterday);
        visit4.setReason("Cavity filling");
        visit4.setStatus(Visit.VisitStatus.COMPLETED);
        visit4.setNotes("Patient had a cavity in molar #3. Filling completed successfully.");
        
        // Completed visit from five days ago
        Visit visit5 = new Visit();
        visit5.setId("5");
        visit5.setPatientId("P001");
        visit5.setDentistId(SARAH_ID);
        visit5.setDateTime(fiveDaysAgo);
        visit5.setReason("Root canal");
        visit5.setStatus(Visit.VisitStatus.COMPLETED);
        visit5.setNotes("Root canal procedure completed. Patient scheduled for follow-up in 2 weeks.");
        
        SAMPLE_VISITS.add(visit1);
        SAMPLE_VISITS.add(visit2);
        SAMPLE_VISITS.add(visit3);
        SAMPLE_VISITS.add(visit4);
        SAMPLE_VISITS.add(visit5);
    }
    
    @Autowired
    public DentistDashboardController(VisitService visitService) {
        this.visitService = visitService;
    }
    
    @GetMapping("/appointments")
    public String viewAppointments(Authentication authentication, Model model) {
        // For testing, we'll use Sarah's ID directly
        String dentistId = SARAH_ID;
        List<Visit> pendingVisits = SAMPLE_VISITS.stream()
                .filter(v -> v.getDentistId().equals(dentistId) && v.getStatus() == Visit.VisitStatus.PENDING)
                .toList();
        List<Visit> confirmedVisits = SAMPLE_VISITS.stream()
                .filter(v -> v.getDentistId().equals(dentistId) && v.getStatus() == Visit.VisitStatus.CONFIRMED)
                .toList();
        
        model.addAttribute("pendingVisits", pendingVisits);
        model.addAttribute("confirmedVisits", confirmedVisits);
        return "dentist/appointments";
    }
    
    @GetMapping("/patients")
    public String viewPatients(Authentication authentication, Model model) {
        // For testing, we'll use Sarah's ID directly
        String dentistId = SARAH_ID;
        List<Visit> visits = SAMPLE_VISITS.stream()
                .filter(v -> v.getDentistId().equals(dentistId))
                .toList();
        
        model.addAttribute("visits", visits);
        return "dentist/patients";
    }
} 