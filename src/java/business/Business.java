package business;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import model.CreditCard;
import model.Database;
import model.Order;
import model.OrderProduct;
import model.Product;
import model.User;

/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
/**
 *
 * @author ibrahiem
 */
public class Business implements business.BusinessLogic {

    /*Mohsen*/
    @Override
    public boolean addCategory(String name) {

        Database db = Database.getInstance();
        if (db.categoryExsits(name)) {
            return false;
        } else {
            db.addCategory(name);
            return true;
        }
    }

    @Override
    public void addProduct(Product product) {
        Database db = Database.getInstance();
        db.addProduct(product);
    }

    @Override
    public boolean categoryExsits(String name) {
        Database db = Database.getInstance();
        return db.categoryExsits(name);
    }

    @Override
    public List<String> getCategories() {
        Database db = Database.getInstance();
        return db.retriveCategories();
    }

    public boolean confirmEmail(String email, String token) {
        Database db = Database.getInstance();
        boolean confirmEmail = db.confirmEmail(email, token);
        if (confirmEmail) {
            new Thread(new Runnable() {
                @Override
                public void run() {
                    Mailer.send(email, "welcome to wannabuy", "welcome to wannabuy");
                }
            }).start();

        }
        return confirmEmail;
    }

    public Product retriveProduct(int id) {
        Database db = Database.getInstance();
        return db.retriveProduct(id);
    }
//    public List<Product> retriveAllProduct(String searchText ) {
//        Database db = Database.getInstance();
//        return db.searchAllProducts(searchText);
//    }

    public List<Product> retriveProducts(String categoryName) {
        Database db = Database.getInstance();
        return db.retriveProducts(categoryName);
    }

    public void updateProduct(Product product) {
        Database db = Database.getInstance();
        db.updateProduct(product);
    }

    public void deleteProduct(int id) {
        Database db = Database.getInstance();
        db.deleteProduct(id);
    }

    public void deleteCategory(String name) {
        Database db = Database.getInstance();
        db.deleteCategory(name);
    }

    public List<User> retriveUsers() {
        Database db = Database.getInstance();
        return db.retriveUsers();
    }

    public List<Order> retriveOrders(int userId) {
        Database db = Database.getInstance();
        return db.retriveOrders(userId);
    }

    public List<CreditCard> retriveCards() {
        Database db = Database.getInstance();
        return db.retriveCards();
    }

    public void printCard(long cardId) {
        Database db = Database.getInstance();
        db.printCard(cardId);
    }
    
    public List<Product> searchAllProducts(float parseFloat, float parseFloat0) {
        Database db = Database.getInstance();
        return db.searchAllProducts(parseFloat,parseFloat0);
    }

    public List<Product> retriveProducts(String category, float parseFloat, float parseFloat0) {
        Database db = Database.getInstance();
        return db.retriveProducts(category,parseFloat,parseFloat0);
    }


    /*End mohsen*/

 /*israa*/
    @Override
    public boolean addUser(User user, String appUrl) {
        Database db = Database.getInstance();
        if (db.checkAlreadyRegistered(user.getEmail())) {
            return false;
        }
        String token = UUID.randomUUID().toString();
        boolean addUser = db.addUser(user, token);
        String msg = "please click on this link to confirm your mail <br/> <a href='http://" + appUrl + "/Confirm?email=" + user.getEmail() + "&token=" + token + "'>click here to confirm</a><br/><br/>Wannabuy";
        new Thread(new Runnable() {
            @Override
            public void run() {
                Mailer.send(user.getEmail(), "confirmation mail Wanna buy", msg);
            }
        }).start();

        return addUser;
    }

    @Override
    public User checkLogin(String email, String password) {
        Database db = Database.getInstance();
        return db.checkLogin(email, password);
    }

    @Override
    public boolean forgetPassword(String email, String appUrl) {
        //check if user already exsists
        //create new 2 fileds in user db one for password-reset-token and other for expiration date of token
        // send mail with servlet name /resetpassword + user email + usertoken 
        Database db = Database.getInstance();
        if (db.checkAlreadyRegistered(email)) {
            String passwordToken = UUID.randomUUID().toString();
            Date date = new Date(System.currentTimeMillis() + 15 * 60 * 1000);
            Timestamp expiratinDate = new Timestamp(date.getTime());
            db.forgetPassword(email, passwordToken, expiratinDate);
            String msg = "please click on this link to reset your password  <br/> <a href='http://" + appUrl + "/ResetPassword?email=" + email + "&passwordToken=" + passwordToken + "'>click here to reset your password</a><br/><br/>Wannabuy";
            new Thread(new Runnable() {
                @Override
                public void run() {
                    Mailer.send(email, "Reset Password mail Wanna buy", msg);
                }
            }).start();

            return true;
        } else {
            return false;
        }

    }

    @Override
    public boolean checkValidUrl(String token) {

        Database db = Database.getInstance();
        Timestamp expirationDateInDB = db.retriveExpirationDate(token);
        if (null == expirationDateInDB || token == null) {
            return false;
        }
        Date date = new Date();
        Timestamp now = new Timestamp(date.getTime());
        if (now.before(expirationDateInDB)) {
            return true;

        } else {
            return false;
        }

    }

    public boolean resetPassword(String email, String newPassword) {
        Database db = Database.getInstance();
        if (db.updatePassword(email, newPassword)) {
            return true;
        } else {
            return false;
        }

    }

    public User updateUserInfo(User user) {
        Database db = Database.getInstance();
        db.updateUser(user);
        return db.retriveUserObj(user.getId());
    }

    @Override
    public void rechargeAccount(User user, long cardNumber) {
        Database db = Database.getInstance();
        db.addCredit(user, cardNumber);

    }

    /*End israa*/
 /* Start Asmaa*/
    @Override
    public boolean addToCart(User user, Product product, int quantity) {
        Database db = Database.getInstance();
        if (db.cartExsits(user, product)) {
            return db.UpdateCart(user, product, quantity);
        } else {
            return db.addToCart(user, product, quantity);
        }
    }

    @Override
    public boolean deleteFromCart(User user, Product product) {
        Database db = Database.getInstance();
        return db.deleteFromCart(user, product);

    }

    @Override
    public boolean UpdateCart(User user, Product product, int quantity) {
        Database db = Database.getInstance();
        if (db.cartExsits(user, product)) {
            return db.UpdateCart(user, product, quantity);
        } else {
            return db.addToCart(user, product, quantity);
        }
    }

    @Override
    public List<OrderProduct> retriveCart(User user) {
        Database db = Database.getInstance();
        return db.retriveCart(user);
    }

    @Override
    public boolean cartExsits(User user, Product product) {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    @Override
    public boolean addOrder(User user, Order order) {
        Database db = Database.getInstance();
        db.addOrder(user, order);

        return true;
    }

    @Override
    public void updateUser(User user) {
        Database db = Database.getInstance();
        db.updateUser(user);
    }

    /*end asmaa*/
 /*Start ibrahiem*/
    @Override
    public void addCreditCard(double amount, int numberOfCards) {
        Database db = Database.getInstance();
        db.addCard(new CreditCard(0, amount), numberOfCards);
    }


    public List<Product> retriveProducts(String searchText, String categoryName ,float lowPrice,float highPrice) {
        Database db = Database.getInstance();
        return db.searchProducts(searchText,categoryName,lowPrice,highPrice);
    }
    public List<Product> searchAllProducts(String searchText, float lowPrice,float highPrice) {
        Database db = Database.getInstance();
        return db.searchAllProducts(searchText,lowPrice,highPrice);
    }
    public List<Product> retriveProducts() {
        Database db = Database.getInstance();
        return db.retriveProducts();
    }
    /*end ibrahiem*/

    
}
