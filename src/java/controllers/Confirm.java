/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import business.Business;
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ahmed mohsen
 */
public class Confirm extends HttpServlet {

    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String serverName = request.getServerName();
        int portNumber = request.getServerPort();
        String contextPath = request.getContextPath();
        String appUrl  = serverName + ":" +portNumber + contextPath;
        System.out.println(appUrl);
        String email = request.getParameter("email");
        String token = request.getParameter("token");
        if (email == null || token == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "important_parameter needed");
        } else {
            PrintWriter writer = response.getWriter();
            Business business = new Business();
            boolean confirmed = business.confirmEmail(email, token);
            if (confirmed) {
                response.sendRedirect("login.jsp");
            } else {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "important_parameter needed");
            }
        }

    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
