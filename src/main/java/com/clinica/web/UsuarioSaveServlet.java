package com.clinica.web;

import com.clinica.model.Usuario;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/usuario/save")
public class UsuarioSaveServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(UsuarioSaveServlet.class.getName());
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        try {
            emf = Persistence.createEntityManagerFactory("ClinicaPU");
            logger.info("EntityManagerFactory initialized successfully");
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error initializing EntityManagerFactory", e);
            throw new ServletException("Error initializing database connection", e);
        }
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
            logger.info("EntityManagerFactory closed");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        String rolStr = request.getParameter("rol");
        String id = request.getParameter("id");

        logger.info("Saving user - Username: " + username + ", Role: " + rolStr);

        EntityManager em = emf.createEntityManager();
        try {
            em.getTransaction().begin();
            
            Usuario usuario;
            if (id != null && !id.isEmpty()) {
                usuario = em.find(Usuario.class, Long.valueOf(id));
                if (usuario == null) {
                    throw new ServletException("Usuario no encontrado");
                }
            } else {
                usuario = new Usuario();
            }
            
            usuario.setUsername(username);
            usuario.setPassword(password); // En producción, esto debería estar hasheado
            usuario.setRol(Usuario.Rol.valueOf(rolStr));
            
            if (id == null || id.isEmpty()) {
                em.persist(usuario);
            }
            
            em.getTransaction().commit();
            
            HttpSession session = request.getSession();
            session.setAttribute("mensaje", "Usuario " + (id != null ? "actualizado" : "creado") + " exitosamente");
            
            response.sendRedirect(request.getContextPath() + "/usuarios");
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            logger.log(Level.SEVERE, "Error saving user", e);
            throw new ServletException("Error al guardar usuario", e);
        } finally {
            em.close();
        }
    }
}
