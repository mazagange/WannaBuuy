package tags;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import business.Business;
import java.io.IOException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.JspFragment;
import javax.servlet.jsp.tagext.SimpleTagSupport;

/**
 *
 * @author ahmed mohsen
 */
public class CategoriesTag extends SimpleTagSupport {

    /**
     * Called by the container to invoke this tag. The implementation of this
     * method is provided by the tag library developer, and handles all tag
     * processing, body iteration, etc.
     */
    @Override
    public void doTag() throws JspException {
        JspWriter out = getJspContext().getOut();
        
        Business business = new Business();
        List<String> categories = business.getCategories();
        for(String cat : categories){
            try {
                out.println("<option value=\""+cat+"\">"+cat+"</option>");
            } catch (IOException ex) {
                Logger.getLogger(CategoriesTag.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
    }
    
}
