package com.clinica.model;

import jakarta.persistence.*;
import java.time.LocalTime;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

@Entity
@Table(name = "odontologos")
@DiscriminatorValue("ODONTO")
public class Odontologo extends Usuario {
    
    @Column(nullable = false)
    private String numeroColegiado;

    @ManyToMany
    @JoinTable(
        name = "odontologo_especialidad",
        joinColumns = @JoinColumn(name = "odontologo_id"),
        inverseJoinColumns = @JoinColumn(name = "especialidad_id")
    )
    private Set<Especialidad> especialidades = new HashSet<>();

    @OneToMany(mappedBy = "odontologo")
    private Set<Visita> visitas = new HashSet<>();

    // Constructors
    public Odontologo() {
        super();
        setRol(Rol.ODONTO);
    }

    public Odontologo(String username, String password, String numeroColegiado) {
        super(username, password, Rol.ODONTO);
        this.numeroColegiado = numeroColegiado;
    }

    // Getters and Setters
    public String getNumeroColegiado() {
        return numeroColegiado;
    }

    public void setNumeroColegiado(String numeroColegiado) {
        this.numeroColegiado = numeroColegiado;
    }

    public Set<Especialidad> getEspecialidades() {
        return especialidades;
    }

    public void setEspecialidades(Set<Especialidad> especialidades) {
        this.especialidades = especialidades;
    }

    public Set<Visita> getVisitas() {
        return visitas;
    }

    public void setVisitas(Set<Visita> visitas) {
        this.visitas = visitas;
    }

    // Helper methods
    public void addEspecialidad(Especialidad especialidad) {
        especialidades.add(especialidad);
        especialidad.getOdontologos().add(this);
    }

    public void removeEspecialidad(Especialidad especialidad) {
        especialidades.remove(especialidad);
        especialidad.getOdontologos().remove(this);
    }
}