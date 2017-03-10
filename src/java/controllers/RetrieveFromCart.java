/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import business.Business;
import com.google.gson.Gson;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.Date;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import model.OrderProduct;
import model.Product;
import model.User;

/**
 *
 * @author Sama
 */
public class RetrieveFromCart extends HttpServlet {

        String buildGsonFromList(List<OrderProduct> orderProductList) {
        
        Gson orderProduct=new Gson();   
        System.out.println("get");
        System.out.println(orderProductList.size());
        System.out.println("jesion llsit "+orderProduct.toJson(orderProductList));
        return orderProduct.toJson(orderProductList);

        }
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            PrintWriter out = response.getWriter();
            int userId=Integer.parseInt(request.getParameter("userId"));
            int productId=Integer.parseInt(request.getParameter("productId"));
            Product productObj=new Product();
            productObj.setId(productId);
            User userObj= new User();
            userObj.setId(userId);
            Business business=new Business();
            boolean check=business.deleteFromCart(userObj,productObj);
            System.out.println("check "+ check);
            out.print("done ^_^");
        }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
            response.setContentType("application/json");
            PrintWriter out = response.getWriter();
            HttpSession session = request.getSession(true);
            
            int userId=Integer.parseInt(request.getParameter("userId"));
            User userObj= new User();
            userObj.setId(userId);
            Business business=new Business();
            List<OrderProduct> orderProductList=business.retriveCart(userObj);
        
           /* User user=new User(1,"asmaa@yaho.com","123", "asmaa","abdellatif", "city", "country","address", "011111656", true, 1212,new Date(12/12/1993),111111111);
            session.setAttribute("user",user);
            */
            out.print(buildGsonFromList(orderProductList));
}

    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
