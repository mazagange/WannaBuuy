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

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String category = request.getParameter("category");
        String searchText = request.getParameter("searchText");
        String page = request.getParameter("page");
        if (category == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "category is required");
        } else {
            if (page == null) {
                page = "1";
            }
            int pageNo = Integer.parseInt(page);
            Business business = new Business();
            List<model.Product> products;
            if (category.equals("All")) {
                 products = business.retriveAllProduct(searchText);

            } else {
                 products = business.retriveProducts(searchText, category);
            }
            System.out.println(products.size());
            Stream<Product> stream = products.stream();
            if (pageNo == 1) {
                stream = stream.limit(12);
            } else {
                stream = stream.skip((pageNo - 1) * 12).limit(12);
            }
            List<Product> collect = stream.collect(Collectors.toList());
            System.out.println(collect.size());
            List<String> categories = business.getCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("products", collect);
            request.setAttribute("pageNo", pageNo);
            request.setAttribute("category", category);
            request.setAttribute("pagesNo", (int) Math.ceil(products.size() / (double) 12));
            System.out.println((int) Math.ceil(products.size() / (double) 12));
            request.getRequestDispatcher("shop.jsp").forward(request, response);
        }
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
        doGet(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
}
