/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import business.Business;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

/**
 *
 * @author ahmed mohsen
 */
public class Signup extends HttpServlet {

 



    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String fName = request.getParameter("fName");
        String lName = request.getParameter("lName");
        String email = request.getParameter("email");
        String pass = request.getParameter("pass");
        String city = request.getParameter("city");
        String country = request.getParameter("country");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");
        String zip = request.getParameter("zip");
        
        Business business = new Business();
        
        String serverName = request.getServerName();
        int portNumber = request.getServerPort();
        String contextPath = request.getContextPath();
        String appUrl  = serverName + ":" +portNumber + contextPath;
        System.out.println(appUrl);
        boolean addUser = business.addUser(new User(0, email, pass, fName, lName, city, country, address, phone, false, Integer.parseInt(zip),new Date() , 0),appUrl);
        if(addUser){
            request.setAttribute("signedup", "true");
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }else{
            request.setAttribute("error", "signup");
            request.getRequestDispatcher("login.jsp").forward(request, response);
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
