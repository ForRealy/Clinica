package com.clinica.web;

import com.clinica.model.Usuario;
import jakarta.persistence.*;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/usuario/form")
public class UsuarioFormServlet extends HttpServlet {
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
        String id = req.getParameter("id");
        if(id != null) {
            EntityManager em = emf.createEntityManager();
            try {
                Usuario u = em.find(Usuario.class, Long.valueOf(id));
            req.setAttribute("usuario", u);
            } finally {
                em.close();
            }
        }
        req.getRequestDispatcher("/jsp/usuarioForm.jsp").forward(req, resp);
    }
}

