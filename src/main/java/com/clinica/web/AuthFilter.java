package com.clinica.web;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class AuthFilter implements Filter {
    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // No initialization needed
    }

    @Override
    public void doFilter(ServletRequest req, ServletResponse res, FilterChain chain)
            throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        
        String requestPath = request.getRequestURI().substring(request.getContextPath().length());
        
        // Allow access to login-related resources and static content
        if (requestPath.equals("/login") || 
            requestPath.equals("/jsp/login.jsp") ||
            requestPath.startsWith("/css/") ||
            requestPath.startsWith("/js/") ||
            requestPath.startsWith("/images/")) {
            chain.doFilter(req, res);
            return;
        }
        
        // Check if user is logged in
        Boolean loggedIn = (Boolean) request.getSession().getAttribute("loggedIn");
        if (Boolean.TRUE.equals(loggedIn)) {
            chain.doFilter(req, res);
        } else {
            response.sendRedirect(request.getContextPath() + "/login");
        }
    }

    @Override
    public void destroy() {
        // No cleanup needed
    }
}
