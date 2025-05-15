package com.clinica.model;

import jakarta.persistence.*;

@Entity
@Table(name = "administradores")
@DiscriminatorValue("ADMIN")
public class Administrador extends Usuario {
    
    public Administrador() {
        super();
        setRol(Rol.ADMIN);
    }

    public Administrador(String username, String password) {
        super(username, password, Rol.ADMIN);
    }
} 