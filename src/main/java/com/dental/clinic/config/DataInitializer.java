package com.dental.clinic.config;

import com.dental.clinic.model.Dentist;
import com.dental.clinic.model.Patient;
import com.dental.clinic.model.User;
import com.dental.clinic.service.DentistService;
import com.dental.clinic.service.PatientService;
import com.dental.clinic.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Component;

import java.time.LocalDate;
import java.time.LocalTime;

@Component
public class DataInitializer implements CommandLineRunner {

    private final DentistService dentistService;
    private final PatientService patientService;
    private final UserService userService;
    private final PasswordEncoder passwordEncoder;

    @Autowired
    public DataInitializer(DentistService dentistService, PatientService patientService, UserService userService, PasswordEncoder passwordEncoder) {
        this.dentistService = dentistService;
        this.patientService = patientService;
        this.userService = userService;
        this.passwordEncoder = passwordEncoder;
    }

    @Override
    public void run(String... args) {
        // Create admin user
        User adminUser = new User("admin", passwordEncoder.encode("admin"), User.UserRole.ADMIN);
        userService.save(adminUser);

        // Create first dentist
        Dentist dentist1 = new Dentist("Dr. Sarah Johnson", "ORTHODONTIST");
        dentist1.setStartTime(LocalTime.of(8, 0));
        dentist1.setEndTime(LocalTime.of(15, 0));
        dentist1.setEmail("sarah.johnson@dentalclinic.com");
        dentist1.setPhone("123456789");
        dentistService.save(dentist1);

        // Create second dentist
        Dentist dentist2 = new Dentist("Dr. Michael Chen", "ENDODONTIST");
        dentist2.setStartTime(LocalTime.of(8, 0));
        dentist2.setEndTime(LocalTime.of(15, 0));
        dentist2.setEmail("michael.chen@dentalclinic.com");
        dentist2.setPhone("987654321");
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
        User patientUser = new User("john.smith@email.com", passwordEncoder.encode("password123"), User.UserRole.PATIENT);
        patientUser.setAssociatedPatientId(patient.getId());
        userService.save(patientUser);

        // Create user accounts for dentists
        User dentist1User = new User("sarah.johnson@dentalclinic.com", passwordEncoder.encode("123456789"), User.UserRole.DENTIST);
        dentist1User.setAssociatedDentistId(dentist1.getId());
        userService.save(dentist1User);

        User dentist2User = new User("michael.chen@dentalclinic.com", passwordEncoder.encode("987654321"), User.UserRole.DENTIST);
        dentist2User.setAssociatedDentistId(dentist2.getId());
        userService.save(dentist2User);

        // Create second patient
        Patient patient2 = new Patient(
            "Emma Wilson",
            LocalDate.of(1990, 10, 20),
            "+1-555-0124",
            "emma.wilson@email.com",
            Patient.PaymentMethod.MUTUAL,
            "Regular check-up"
        );
        patientService.save(patient2);

        // Create second patient user
        User patient2User = new User("emma.wilson@email.com", passwordEncoder.encode("emma2024"), User.UserRole.PATIENT);
        patient2User.setAssociatedPatientId(patient2.getId());
        userService.save(patient2User);
    }
} 