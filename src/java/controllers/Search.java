/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers;

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import business.Business;
import java.util.List;
import java.util.stream.Collectors;
import java.util.stream.Stream;
import model.Product;

/**
 *
 * @author ibrahiem
 */
public class Search extends HttpServlet {

    

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
        String category = request.getParameter("category");
        String searchText = request.getParameter("searchText");
        String minPrice = request.getParameter("minPrice");
        String maxPrice = request.getParameter("maxPrice");
        System.out.println(minPrice +  "-"  + maxPrice);
            Business business = new Business();
            List<model.Product> products;
            if (category.equals("All")) {
                if(searchText.equals("")){
                    products = business.searchAllProducts(Float.parseFloat(minPrice),Float.parseFloat(maxPrice));
                }else{
                 products = business.searchAllProducts(searchText,Float.parseFloat(minPrice),Float.parseFloat(maxPrice));
                }
            } else {
                if(searchText.equals("")){
                    products = business.retriveProducts(category,Float.parseFloat(minPrice),Float.parseFloat(maxPrice));
                }else{
                 products = business.retriveProducts(searchText, category,Float.parseFloat(minPrice),Float.parseFloat(maxPrice));
                }
            }
            
            List<String> categories = business.getCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("products", products);
            request.setAttribute("category", category);
            
            request.getRequestDispatcher("search.jsp").forward(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
