# Dental Clinic Management System

A comprehensive web application for managing a dental clinic, built with Spring Boot and JSP.

## Features

### User Management
- Multi-role system (Admin, Dentist, Patient)
- Secure authentication and authorization
- Role-based access control
- User profile management

### Admin Features
- Dashboard with overview of clinic operations
- Manage dentists (add, edit, delete)
- Manage patients (add, edit, delete)
- View all appointments and visits
- User management (create accounts, assign roles)

### Dentist Features
- Dashboard with appointment overview
- View and manage appointments
- Handle appointment requests
- Confirm or cancel appointments
- Complete visits with notes
- View patient history
- Manage their schedule

### Patient Features
- Dashboard with appointment overview
- Request new appointments
- View appointment history
- View completed visit notes
- Manage profile information
- View upcoming appointments

### Appointment Management
- Real-time appointment scheduling
- Appointment status tracking (Pending, Confirmed, Completed, Cancelled)
- Working hours enforcement (Monday-Friday, 9 AM - 5 PM)
- Weekend appointment prevention
- 30-minute appointment slots
- Automatic patient name association
- Visit notes and completion tracking

### Security Features
- Spring Security integration
- Password encryption
- Session management
- CSRF protection
- URL security
- Role-based access control

## Technical Stack

### Backend
- Java 17
- Spring Boot 2.7.0
- Spring Security
- Spring MVC
- JSP/JSTL

### Frontend
- Bootstrap 5
- JavaScript
- JSP/JSTL
- CSS

### Database
- In-memory data storage (ConcurrentHashMap)
- UUID-based entity identification

## Getting Started

### Prerequisites
- Java 17 or higher
- Maven 3.6 or higher
- Modern web browser

### Installation
1. Clone the repository
```bash
git clone [repository-url]
```

2. Navigate to the project directory
```bash
cd dental-clinic
```

3. Build the project
```bash
mvn clean install
```

4. Run the application
```bash
mvn spring-boot:run
```

5. Access the application at `http://localhost:8080/dental-clinic`

### Default Users
- Admin: username: `admin`, password: `admin`
- Dentist: username: `sarah`, password: `password`
- Patient: Create a new account through the registration process

## Usage

### Admin Access
1. Log in as admin
2. Access the dashboard at `/admin/dashboard`
3. Manage users, dentists, and patients
4. Monitor all appointments

### Dentist Access
1. Log in as dentist
2. Access the dashboard at `/dentist/dashboard`
3. View and manage appointments
4. Complete visits with notes

### Patient Access
1. Log in as patient
2. Access the dashboard at `/patient/dashboard`
3. Request new appointments
4. View appointment history

## Appointment Scheduling Rules
- Appointments are available Monday to Friday
- Working hours: 9:00 AM to 5:00 PM
- 30-minute appointment slots
- No weekend appointments
- Patients can only have one pending appointment at a time
- Appointments must be confirmed by a dentist
- Completed appointments include visit notes

## Security Notes
- All passwords are encrypted
- URLs are protected against malicious patterns
- Session management is enforced
- CSRF protection is enabled
- Role-based access control is implemented

## Contributing
1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request

## License
This project is licensed under the MIT License - see the LICENSE file for details. 