package com.clinica.model;

import jakarta.persistence.*;

@Entity
public class Responsable {
    @Id @GeneratedValue
    private Long id;
    private String nombre;
    private String parentesco; // padre, madre, tutor…

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNombre() {
        return nombre;
    }

    public void setNombre(String nombre) {
        this.nombre = nombre;
    }

    public String getParentesco() {
        return parentesco;
    }

    public void setParentesco(String parentesco) {
        this.parentesco = parentesco;
    }
}