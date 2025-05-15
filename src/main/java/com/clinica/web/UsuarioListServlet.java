package com.clinica.web;

import com.clinica.model.Usuario;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/usuarios")
public class UsuarioListServlet extends HttpServlet {
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
        EntityManager em = emf.createEntityManager();
        try {
            List<Usuario> lista = em.createQuery("FROM Usuario", Usuario.class).getResultList();
        req.setAttribute("usuarios", lista);
            req.getRequestDispatcher("/jsp/usuarios.jsp").forward(req, resp);
        } finally {
        em.close();
        }
    }
}

