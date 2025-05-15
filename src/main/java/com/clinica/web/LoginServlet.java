package com.clinica.web;

import jakarta.persistence.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;
import com.clinica.model.Usuario;
import java.util.logging.Logger;
import java.util.logging.Level;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private static final Logger logger = Logger.getLogger(LoginServlet.class.getName());
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
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        String user = req.getParameter("user");
        String pass = req.getParameter("pass");
        
        logger.info("Login attempt - Username: " + user);
        
        EntityManager em = emf.createEntityManager();
        try {
            // First, let's check if the user exists
            TypedQuery<Usuario> query = em.createQuery(
                "SELECT u FROM Usuario u WHERE u.username = :u", Usuario.class);
            query.setParameter("u", user);
            
            try {
                Usuario u = query.getSingleResult();
                logger.info("User found in database: " + u.getUsername() + ", Role: " + u.getRol());
                
                // Now check the password
                if (pass.equals(u.getPassword())) {
                    logger.info("Password matches - Login successful");
            req.getSession().setAttribute("loggedIn", true);
            req.getSession().setAttribute("usuario", u);
                    resp.sendRedirect(req.getContextPath() + "/usuarios");
                } else {
                    logger.warning("Password mismatch for user: " + user);
                    resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp?error=1");
                }
        } catch (NoResultException e) {
                logger.warning("No user found with username: " + user);
                resp.sendRedirect(req.getContextPath() + "/jsp/login.jsp?error=1");
            }
        } catch (Exception e) {
            logger.log(Level.SEVERE, "Error during login process", e);
            throw new ServletException("Error during login", e);
        } finally {
            em.close();
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {
        req.getRequestDispatcher("/jsp/login.jsp").forward(req, resp);
    }
}
