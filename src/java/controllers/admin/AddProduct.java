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
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;
import model.Product;

/**
 *
 * @author ahmed mohsen
 */
@MultipartConfig
public class AddProduct extends HttpServlet {

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
        String path = request.getServletContext().getRealPath("");
        path = path + "Products-images\\";
        final Part filePart = request.getPart("image");
        String fileName = getFileName(filePart);
        fileName = currentTimeMillis() + fileName;
        final String imageUrl = "Products-images\\" + fileName;
        OutputStream out = null;
        final PrintWriter writer = response.getWriter();
        try {
            filePart.write(path + fileName);
            writer.print("New file " + fileName + " created at " + path);
        } catch (FileNotFoundException fne) {
            writer.print("Error While Uploading Your File");
        } finally {
            if (out != null) {
                out.close();
            }

            if (writer != null) {
                writer.close();
            }
        }

        Business business = new Business();
        business.addProduct(new Product(name, Double.parseDouble(price), desc, imageUrl, Integer.parseInt(stock), category));
    }

    private String getFileName(final Part part) {
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;
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
