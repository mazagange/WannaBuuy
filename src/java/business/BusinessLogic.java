/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package business;

import java.util.ArrayList;
import java.util.List;
import model.CreditCard;
import model.OrderProduct;
import model.Product;
import model.User;

/**
 *
 * @author ibrahiem
 */
public interface BusinessLogic {

    public boolean addCategory(String name);

    public void addProduct(Product product);

    public boolean categoryExsits(String name);

    public List<String> getCategories();

    public boolean addUser(User user, String appUrl);

    public User checkLogin(String email, String password);

    public boolean cartExsits(User user, Product product);

    public boolean addToCart(User user, Product product, int quantity);

    public boolean deleteFromCart(User user, Product product);

    public boolean UpdateCart(User user, Product product, int quantity);

    public List<OrderProduct> retriveCart(User user);

    public boolean forgetPassword(String email, String appUrl);

    public boolean checkValidUrl(String token);

    public boolean resetPassword(String email, String token);

    public void addCreditCard(double amount, int numberOfCards);

    public User updateUserInfo(User user);
    // public List
}
