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
import javax.servlet.http.HttpSession;
import model.User;

/**
 *
 * @author Sama
 */
public class AddToCart extends HttpServlet {

    

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        PrintWriter out = response.getWriter();
        try{
             HttpSession session = request.getSession(true);
             User userObj=(User) session.getAttribute("user");
            int productId=Integer.parseInt(request.getParameter("productId"));
            int quentity=Integer.parseInt(request.getParameter("quentity"));
            System.out.println("product s   p"+productId+"  q"+quentity+"  u"+userObj.toString());
            model.Product productObj=new model.Product();
            productObj.setId(productId);
            Business business=new Business();
            business.addToCart(userObj, productObj, quentity);
            }catch(Exception e){
              e.printStackTrace();
        }
    }
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
