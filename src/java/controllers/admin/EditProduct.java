/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package controllers.admin;

import business.Business;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import static java.lang.System.currentTimeMillis;
import java.util.List;
import javafx.scene.chart.BubbleChart;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Product;

/**
 *
 * @author ahmed mohsen
 */
public class EditProduct extends HttpServlet {

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
        String productId = request.getParameter("id");
        if (productId == null) {
            response.sendError(HttpServletResponse.SC_BAD_REQUEST, "no product to edit");
        } else {
            Business business = new Business();
            Product product = business.retriveProduct(Integer.parseInt(productId));
            List<String> categories = business.getCategories();
            request.setAttribute("categories", categories);
            request.setAttribute("product", product);
            request.getRequestDispatcher("edit-product.jsp").forward(request, response);
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
        String name = request.getParameter("name");
        String price = request.getParameter("price");
        String desc = request.getParameter("desc");
        String category = request.getParameter("category");
        String stock = request.getParameter("stock");
        System.out.println(desc);
        String imageUrl;
        if (request.getPart("image") != null) {
            String path = request.getServletContext().getRealPath("");
            path = path + "Products-images\\";
            final Part filePart = request.getPart("image");
            String fileName = getFileName(filePart);
            fileName = currentTimeMillis() + fileName;
            imageUrl = "Products-images\\" + fileName;
            OutputStream out = null;

            try {
                filePart.write(path + fileName);

            } catch (FileNotFoundException fne) {
                fne.printStackTrace();
            } finally {
                if (out != null) {
                    out.close();
                }

            }
        }else{
            imageUrl = request.getParameter("img");
        }
        Business business = new Business();
        business.updateProduct(new Product(name, Double.parseDouble(price), desc, imageUrl, Integer.parseInt(stock), category));
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

    private String getFileName(final Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
    }

}
