package com.clinica.model;

import jakarta.persistence.*;
import java.time.LocalDate;
import java.util.HashSet;
import java.util.Set;

@Entity
@Table(name = "pacientes")
@DiscriminatorValue("PACIENTE")
public class Paciente extends Usuario {
    
    @Column(nullable = false)
    private String nombre;

    @Column(nullable = false)
    private String apellidos;

    @Column(nullable = false)
    private String dni;

    @Column(name = "fecha_nacimiento")
    private LocalDate fechaNacimiento;

    private String telefono;

    private String direccion;

    @Column(length = 500)
    private String observaciones;

    @OneToMany(mappedBy = "paciente")
    private Set<Visita> visitas = new HashSet<>();

    // Constructors
    public Paciente() {
        super();
        setRol(Rol.PACIENTE);
    }

    public Paciente(String username, String password, String nombre, String apellidos, String dni) {
        super(username, password, Rol.PACIENTE);
        this.nombre = nombre;
        this.apellidos = apellidos;
        this.dni = dni;
    }

    // Getters and Setters
    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getApellidos() {
        return apellidos;
    }

    public void setApellidos(String apellidos) {
        this.apellidos = apellidos;
    }

    public String getDni() {
        return dni;
    }

    public void setDni(String dni) {
        this.dni = dni;
    }

    public LocalDate getFechaNacimiento() {
        return fechaNacimiento;
    }

    public void setFechaNacimiento(LocalDate fechaNacimiento) {
        this.fechaNacimiento = fechaNacimiento;
    }

    public String getTelefono() {
        return telefono;
    }

    public void setTelefono(String telefono) {
        this.telefono = telefono;
    }

    public String getDireccion() {
        return direccion;
    }

    public void setDireccion(String direccion) {
        this.direccion = direccion;
    }

    public String getObservaciones() {
        return observaciones;
    }

    public void setObservaciones(String observaciones) {
        this.observaciones = observaciones;
    }

    public Set<Visita> getVisitas() {
        return visitas;
    }

    public void setVisitas(Set<Visita> visitas) {
        this.visitas = visitas;
    }

    // Helper methods
    public String getNombreCompleto() {
        return nombre + " " + apellidos;
    }
}