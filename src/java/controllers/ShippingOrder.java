/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import business.Business;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import javax.mail.Session;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.Order;
import model.OrderProduct;
import model.User;

/**
 *
 * @author Sama
 */
public class ShippingOrder extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession(true);
            
            String ShippingAdrress=request.getParameter("ShippingAdrress");
            String city=request.getParameter("city");
            String state=request.getParameter("state");
            String phone=request.getParameter("phone");
            String country=request.getParameter("country");
            int zip=Integer.parseInt(request.getParameter("zip"));
           
            double totalPrice=Double.parseDouble(request.getParameter("totalPrice"));
            User userObj= (User) session.getAttribute("user");
           /* decrement user amount ,decrement quentity instock, add order record , delete from cart */
         
            Business business=new Business();
            
            List<OrderProduct> orderProductList=business.retriveCart(userObj);
        
            if(!orderProductList.isEmpty()){
                /* decrement user amount */
                totalPrice=userObj.getCredit()-totalPrice;
                userObj.setCredit(totalPrice);
                session.setAttribute("user",userObj);
                business.updateUser(userObj);
               /*decrement quentity instock, delete from cart*/
                for (OrderProduct orderPro:orderProductList){
                        orderPro.getProduct().setStockQuantity(orderPro.getProduct().getStockQuantity()-orderPro.getQuantity());
                        business.updateProduct(orderPro.getProduct());
                        business.deleteFromCart(userObj,orderPro.getProduct());
                }
                /*add order record */
                Order orderObj=new Order(orderProductList, ShippingAdrress, city, state, country, phone,zip);
                System.out.println("dne ejejej");
                business.addOrder(userObj, orderObj);
              
                
            }
            
            System.out.println("toaot price "+totalPrice+"userid"+userObj.toString()+"data "+ShippingAdrress+" -- "+city+" -- "+state+"--"+
                                phone+" --- " +country+"--  "+zip);
           }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
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
        processRequest(request, response);
    }

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
        processRequest(request, response);
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
