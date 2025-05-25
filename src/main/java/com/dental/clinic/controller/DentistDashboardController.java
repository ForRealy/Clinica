package com.dental.clinic.controller;

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

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/dentist")
@PreAuthorize("hasRole('DENTIST')")
public class DentistDashboardController {
    
    private final VisitService visitService;
    private final PatientService patientService;
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
        LocalDateTime nextWeek = now.plusDays(7).withHour(13).withMinute(0); // 1:00 PM next week
        LocalDateTime twoWeeksLater = now.plusDays(14).withHour(15).withMinute(30); // 3:30 PM two weeks later
        
        // Pending visit for tomorrow morning
        Visit visit1 = new Visit();
        visit1.setId("1");
        visit1.setPatientId("P001");
        visit1.setPatientName("John Smith");
        visit1.setDentistId(SARAH_ID);
        visit1.setDateTime(tomorrow);
        visit1.setReason("Regular checkup");
        visit1.setStatus(Visit.VisitStatus.PENDING);
        visit1.setPatientEmail("john.smith@email.com");
        
        // Pending visit for day after tomorrow afternoon
        Visit visit2 = new Visit();
        visit2.setId("2");
        visit2.setPatientId("P002");
        visit2.setPatientName("Emma Wilson");
        visit2.setDentistId(SARAH_ID);
        visit2.setDateTime(dayAfterTomorrow);
        visit2.setReason("Tooth pain");
        visit2.setStatus(Visit.VisitStatus.PENDING);
        visit2.setPatientEmail("emma.wilson@email.com");
        
        // Confirmed visit for three days later
        Visit visit3 = new Visit();
        visit3.setId("3");
        visit3.setPatientId("P001");
        visit3.setPatientName("John Smith");
        visit3.setDentistId(SARAH_ID);
        visit3.setDateTime(threeDaysLater);
        visit3.setReason("Cleaning");
        visit3.setStatus(Visit.VisitStatus.CONFIRMED);
        visit3.setPatientEmail("john.smith@email.com");
        
        // Completed visit from yesterday
        Visit visit4 = new Visit();
        visit4.setId("4");
        visit4.setPatientId("P002");
        visit4.setPatientName("Emma Wilson");
        visit4.setDentistId(SARAH_ID);
        visit4.setDateTime(yesterday);
        visit4.setReason("Cavity filling");
        visit4.setStatus(Visit.VisitStatus.COMPLETED);
        visit4.setNotes("Patient had a cavity in molar #3. Filling completed successfully.");
        visit4.setPatientEmail("emma.wilson@email.com");
        
        // Completed visit from five days ago
        Visit visit5 = new Visit();
        visit5.setId("5");
        visit5.setPatientId("P001");
        visit5.setPatientName("John Smith");
        visit5.setDentistId(SARAH_ID);
        visit5.setDateTime(fiveDaysAgo);
        visit5.setReason("Root canal");
        visit5.setStatus(Visit.VisitStatus.COMPLETED);
        visit5.setNotes("Root canal procedure completed. Patient scheduled for follow-up in 2 weeks.");
        visit5.setPatientEmail("john.smith@email.com");
        
        // New appointment for John Smith - Follow-up consultation
        Visit visit6 = new Visit();
        visit6.setId("6");
        visit6.setPatientId("P001");
        visit6.setPatientName("John Smith");
        visit6.setDentistId(SARAH_ID);
        visit6.setDateTime(nextWeek);
        visit6.setReason("Follow-up consultation after root canal");
        visit6.setStatus(Visit.VisitStatus.PENDING);
        visit6.setPatientEmail("john.smith@email.com");
        
        // New appointment for Emma Wilson - Regular cleaning
        Visit visit7 = new Visit();
        visit7.setId("7");
        visit7.setPatientId("P002");
        visit7.setPatientName("Emma Wilson");
        visit7.setDentistId(SARAH_ID);
        visit7.setDateTime(twoWeeksLater);
        visit7.setReason("Regular dental cleaning");
        visit7.setStatus(Visit.VisitStatus.PENDING);
        visit7.setPatientEmail("emma.wilson@email.com");
        
        SAMPLE_VISITS.add(visit1);
        SAMPLE_VISITS.add(visit2);
        SAMPLE_VISITS.add(visit3);
        SAMPLE_VISITS.add(visit4);
        SAMPLE_VISITS.add(visit5);
        SAMPLE_VISITS.add(visit6);
        SAMPLE_VISITS.add(visit7);
    }
    
    @Autowired
    public DentistDashboardController(VisitService visitService, PatientService patientService) {
        this.visitService = visitService;
        this.patientService = patientService;
        // Save all sample visits to the service
        for (Visit visit : SAMPLE_VISITS) {
            visitService.save(visit);
        }
    }
    
    @GetMapping("/appointments")
    @PreAuthorize("hasRole('DENTIST')")
    public String viewAppointments(Model model, Authentication authentication) {
        // For now, use Sarah's ID since our sample data is set up for her
        String dentistId = SARAH_ID;  // Use SARAH_ID instead of authentication.getName()
        List<Visit> allVisits = visitService.findByDentistId(dentistId);
        
        // Split visits into pending and confirmed
        List<Visit> pendingVisits = allVisits.stream()
                .filter(v -> v.getStatus() == Visit.VisitStatus.PENDING)
                .peek(visit -> {
                    if (visit.getPatientName() == null || visit.getPatientName().isEmpty()) {
                        if (visit.getPatientId() != null) {
                            patientService.findById(visit.getPatientId()).ifPresent(patient -> {
                                visit.setPatientName(patient.getFullName());
                            });
                        }
                    }
                })
                .toList();
                
        List<Visit> confirmedVisits = allVisits.stream()
                .filter(v -> v.getStatus() == Visit.VisitStatus.CONFIRMED)
                .peek(visit -> {
                    if (visit.getPatientName() == null || visit.getPatientName().isEmpty()) {
                        if (visit.getPatientId() != null) {
                            patientService.findById(visit.getPatientId()).ifPresent(patient -> {
                                visit.setPatientName(patient.getFullName());
                            });
                        }
                    }
                })
                .toList();
        
        model.addAttribute("pendingVisits", pendingVisits);
        model.addAttribute("confirmedVisits", confirmedVisits);
        return "dentist/appointments";
    }
    
    @GetMapping("/patients")
    @PreAuthorize("hasRole('DENTIST')")
    public String viewPatients(Model model, Authentication authentication) {
        // For now, use Sarah's ID since our sample data is set up for her
        String dentistId = SARAH_ID;  // Use SARAH_ID instead of authentication.getName()
        List<Visit> visits = visitService.findByDentistId(dentistId);
        
        // Add patient information to each visit
        visits.forEach(visit -> {
            if (visit.getPatientName() == null || visit.getPatientName().isEmpty()) {
                if (visit.getPatientId() != null) {  // Only try to find patient if ID is not null
                    patientService.findById(visit.getPatientId()).ifPresent(patient -> {
                        visit.setPatientName(patient.getFullName());
                    });
                }
            }
        });
        
        model.addAttribute("visits", visits);
        return "dentist/patients";
    }
} 