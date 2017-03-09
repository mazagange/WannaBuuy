/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

/**
 *
 * @author ibrahiem
 */
public interface DB {

    public boolean addUser(User user, String token);

    public boolean checkAlreadyRegistered(String email);

    public User checkLogin(String email, String password);

    public boolean confirmEmail(String email, String token);

    public void addCategory(String name);

    public boolean categoryExsits(String name);

    public void deleteCategory(String name);

    public void addProduct(Product product);

    public void updateProduct(Product product);

    public void deleteProduct(int productId);

    public void updateUser(User user);

    public Product retriveProduct(int id);

    public List<Product> retriveProducts(String categoryName);

    public List<Product> retriveProducts();

    public List<String> retriveCategories();

    public boolean addOrder(User user, Order order);

    public boolean addToCart(User user, Product product, int quantity);

    public boolean deleteFromCart(User user, Product product);

    public boolean UpdateCart(User user, Product product, int quantity);

    public void addCard(CreditCard creditCard, int numberOfCards);

    public void addCredit(User user, int cardNumber);

    public List<OrderProduct> retriveCart(User user);

    public double checkCardExistance(long creditNumber);

    public void forgetPassword(String email, String token, Timestamp passwordTokenExpierDate);

    public Timestamp retriveExpirationDate(String passwordToken);

    public boolean updatePassword(String email, String newPassword);

    public User retriveUserObj(int userId);

    public List<Product> retriveProducts(String searchText, String categoryName);

}
