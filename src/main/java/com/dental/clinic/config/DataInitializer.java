package com.dental.clinic.config;

import com.dental.clinic.model.Dentist;
import com.dental.clinic.model.Patient;
import com.dental.clinic.model.User;
import com.dental.clinic.service.DentistService;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;

@Component
public class DataInitializer implements CommandLineRunner {

    private final DentistService dentistService;
    private final PatientService patientService;
    private final UserService userService;

    @Autowired
    public DataInitializer(DentistService dentistService, PatientService patientService, UserService userService) {
        this.dentistService = dentistService;
        this.patientService = patientService;
        this.userService = userService;
    }

    @Override
    public void run(String... args) {
        // Create admin user
        User adminUser = new User("admin", "admin", User.UserRole.ADMIN);
        userService.save(adminUser);

        // Create first dentist
        Dentist dentist1 = new Dentist("Dr. Sarah Johnson", "Orthodontics");
        dentist1.setStartTime(LocalTime.of(8, 0));
        dentist1.setEndTime(LocalTime.of(15, 0));
        dentistService.save(dentist1);

        // Create second dentist
        Dentist dentist2 = new Dentist("Dr. Michael Chen", "Endodontics");
        dentist2.setStartTime(LocalTime.of(8, 0));
        dentist2.setEndTime(LocalTime.of(15, 0));
        dentistService.save(dentist2);

        // Create patient
        Patient patient = new Patient(
            "John Smith",
            LocalDate.of(1988, 5, 15),
            "+1-555-0123",
            "john.smith@email.com",
            Patient.PaymentMethod.PRIVATE,
            "Root canal treatment"
        );
        patientService.save(patient);

        // Create patient user
        User patientUser = new User("john.smith", "password123", User.UserRole.PATIENT);
        patientUser.setAssociatedPatientId(patient.getId());
        userService.save(patientUser);

        // Create user accounts for dentists
        User dentist1User = new User("sarah.johnson", "password123", User.UserRole.DENTIST);
        dentist1User.setAssociatedDentistId(dentist1.getId());
        userService.save(dentist1User);

        User dentist2User = new User("michael.chen", "password123", User.UserRole.DENTIST);
        dentist2User.setAssociatedDentistId(dentist2.getId());
        userService.save(dentist2User);
    }
} 