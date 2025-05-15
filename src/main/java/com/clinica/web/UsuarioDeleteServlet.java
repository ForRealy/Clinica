package com.clinica.web;

import com.clinica.model.Usuario;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/usuario/delete")
public class UsuarioDeleteServlet extends HttpServlet {
    private EntityManagerFactory emf;

    @Override
    public void init() throws ServletException {
        emf = Persistence.createEntityManagerFactory("ClinicaPU");
    }

    @Override
    public void destroy() {
        if (emf != null && emf.isOpen()) {
            emf.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Long id = Long.valueOf(req.getParameter("id"));
        EntityManager em = emf.createEntityManager();
        try {
        em.getTransaction().begin();
        Usuario u = em.find(Usuario.class, id);
            if(u != null) em.remove(u);
        em.getTransaction().commit();
            resp.sendRedirect(req.getContextPath() + "/usuarios");
        } catch (Exception e) {
            if (em.getTransaction().isActive()) {
                em.getTransaction().rollback();
            }
            throw new ServletException("Error al eliminar usuario", e);
        } finally {
        em.close();
        }
    }
}
