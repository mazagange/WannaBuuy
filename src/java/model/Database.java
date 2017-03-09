/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import business.Mailer;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ibrahiem
 */
public class Database implements DB {

    private static Database instance = null;

    final static String URL = "jdbc:mysql://localhost/wannabuy";
    final static String USER = "root";
    final static String PASS = "root";
    private Connection con;

    private Database() {

        try {
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection(URL, USER, PASS);
        } catch (Exception e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public static Database getInstance() {
        if (instance == null) {
            instance = new Database();
        }
        return instance;
    }

    /* israa*/
    @Override
    public boolean addUser(User user, String token) {
        try {
            if (!checkAlreadyRegistered(user.getEmail())) {
                PreparedStatement pst = con.prepareStatement("insert into user(email,password,fname,lname"
                        + ",city,zip,phone,user_email_verified,country,address,registration_date,credite,confirmToken) values(?,?,?,?,?,?,?,?,?,?,?,?,?)");
                String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
                pst.setString(1, user.getEmail());
                pst.setString(2, hashedPassword);
                pst.setString(3, user.getFirstName());
                pst.setString(4, user.getLastName());
                pst.setString(5, user.getCity());
                pst.setInt(6, user.getZipCode());
                pst.setString(7, user.getPhone());
                pst.setBoolean(8, user.isEmailConfirmed());
                pst.setString(9, user.getCountry());
                pst.setString(10, user.getAddress());
                pst.setTimestamp(11, new Timestamp(user.getRegistrationDate().getTime()));
                pst.setDouble(12, user.getCredit());
                //generat string of 10 random character

                pst.setString(13, token);
                pst.executeUpdate();
                pst.close();
                return true;
            }

        } catch (SQLException ex) {
            System.out.println("User Already Exsists");
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public boolean checkAlreadyRegistered(String email) {
        try {
            PreparedStatement pst = con.prepareStatement("select * from user where email = ?");

            pst.setString(1, email);

            ResultSet resultset = pst.executeQuery();
            if (resultset.next()) {
                pst.close();
                return true;

            } else {
                pst.close();

                return false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return false;
    }

    @Override
    public User checkLogin(String email, String password) {
        try {
            PreparedStatement pst = con.prepareStatement("select * from user where email = ?");
            pst.setString(1, email);
            User user = null;

            ResultSet resultset = pst.executeQuery();
            if (resultset.next()) {
                String hashedPassword = resultset.getString("password");
                if (BCrypt.checkpw(password, hashedPassword)) {
                    user = new User(resultset.getInt("user_id"), resultset.getString("email"), "", resultset.getString("fname"), resultset.getString("lname"),
                            resultset.getString("city"), resultset.getString("country"), resultset.getString("address"),
                            resultset.getString("phone"), resultset.getBoolean("user_email_verified"),
                            resultset.getInt("zip"), resultset.getDate("registration_date"), resultset.getDouble("credite"));
                    return user;
                } else {
                    //System.out.println("not exsits");
                    return null;
                }

            }

            pst.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    @Override
    public void updateUser(User user) {
        try {
            PreparedStatement pst = con.prepareStatement("UPDATE user set fname=?,lname=?,city=?,zip=?,phone=?,country=?,address=? where user_id=?");
            pst.setString(1, user.getFirstName());
            pst.setString(2, user.getLastName());
            pst.setString(3, user.getCity());
            pst.setInt(4, user.getZipCode());
            pst.setString(5, user.getPhone());
            pst.setString(6, user.getCountry());
            pst.setString(7, user.getAddress());
            pst.setInt(8, user.getId());
            pst.executeUpdate();
            pst.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public void addCard(CreditCard creditCard, int numberOfCards) {
        try {
            PreparedStatement pst = con.prepareStatement("insert into creditcard(amonut,number) values(?,?)");
            for (int i = 0; i < numberOfCards; i++) {
                pst.setDouble(1, creditCard.getAmount());
                pst.setLong(2, creditCard.getNumber());
                pst.executeUpdate();
            }
            pst.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public double checkCardExistance(long creditNumber) {
        double amount = 0;
        try {
            PreparedStatement pst = con.prepareStatement("select amonut from creditcard where number = ?");
            pst.setLong(1, creditNumber);
            ResultSet resultset = pst.executeQuery();
            if (resultset.next()) {
                amount = resultset.getDouble("amonut");
                PreparedStatement deleteCard = con.prepareStatement("delete from creditcard where  number= ?");
                deleteCard.setLong(1, creditNumber);
                deleteCard.execute();
                pst.close();
                return amount;

            } else {
                pst.close();

                return amount;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return amount;
    }

    @Override
    public void addCredit(User user, long cardNumber) {

        try {
            double amountRetrieved = checkCardExistance(cardNumber);
            if (amountRetrieved != 0) {
                user.setCredit(user.getCredit() + amountRetrieved);
                PreparedStatement userCreditUpdate = con.prepareStatement("UPDATE user set credite=? where user_id=?");
                userCreditUpdate.setDouble(1, user.getCredit());
                userCreditUpdate.setInt(2, user.getId());
                userCreditUpdate.executeUpdate();

            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }

    }

    @Override
    public void forgetPassword(String email, String token, Timestamp passwordTokenExpierDate) {
        //insert into 2 new colums token and expiredate
        try {
            PreparedStatement pst = con.prepareStatement("UPDATE user set passwordResetToken=?,expirationDate=?  where email=?");
            pst.setString(1, token);
            pst.setTimestamp(2, passwordTokenExpierDate);
            pst.setString(3, email);
            pst.executeUpdate();
            pst.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }

    @Override
    public Timestamp retriveExpirationDate(String passwordToken) {
        Timestamp expirationDate = null;
        try {

            PreparedStatement pst = con.prepareStatement("SELECT expirationDate FROM user Where passwordResetToken =?");
            pst.setString(1, passwordToken);
            ResultSet rs = pst.executeQuery();
            while (rs.next()) {
                expirationDate = rs.getTimestamp("expirationDate");
            }
            rs.close();
            return expirationDate;
        } catch (SQLException e) {
            e.printStackTrace();
            return expirationDate;
        }

    }

    @Override
    public boolean updatePassword(String email, String newPassword) {

        try {
            PreparedStatement pst = con.prepareStatement("UPDATE user set password=?,passwordResetToken=?  where email=?");

            String hashedPassword = BCrypt.hashpw(newPassword, BCrypt.gensalt());
            pst.setString(1, hashedPassword);
            pst.setString(2, "");
            pst.setString(3, email);
            pst.executeUpdate();
            pst.close();
            return true;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    @Override
    public User retriveUserObj(int userId) {
        try {
            PreparedStatement pst = con.prepareStatement("select * from user where user_id = ?");
            pst.setInt(1, userId);
            User user = null;

            ResultSet resultset = pst.executeQuery();
            if (resultset.next()) {
                user = new User(resultset.getInt("user_id"), resultset.getString("email"), "", resultset.getString("fname"), resultset.getString("lname"),
                        resultset.getString("city"), resultset.getString("country"), resultset.getString("address"),
                        resultset.getString("phone"), resultset.getBoolean("user_email_verified"),
                        resultset.getInt("zip"), resultset.getDate("registration_date"), resultset.getDouble("credite"));
                return user;

            }

            pst.close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;

    }

    /*end israa*/

 /* Mohsen*/
    @Override
    public boolean confirmEmail(String email, String token) {
        boolean confirmed = false;
        try {
            PreparedStatement select = con.prepareStatement("select confirmToken FROM user WHERE email = ?");
            select.setString(1, email);
            ResultSet rs = select.executeQuery();
            rs.next();
            String confirmToken = rs.getString(1);
            if (token.equals(confirmToken)) {
                PreparedStatement update = con.prepareStatement("update user set user_email_verified= ? WHERE email = ?");
                update.setInt(1, 1);
                update.setString(2, email);
                update.executeUpdate();

                confirmed = true;
            } else {
                confirmed = false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return confirmed;
    }

    @Override
    public void addCategory(String name) {
        try {
            PreparedStatement insert = con.prepareStatement("insert into productcategory(category_name) values(?)");
            insert.setString(1, name);
            insert.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public boolean categoryExsits(String name) {
        boolean exist = true;
        try {
            PreparedStatement select = con.prepareStatement("select COUNT(*) from productcategory where category_name = ?");
            select.setString(1, name);
            ResultSet rs = select.executeQuery();
            rs.next();
            if (rs.getInt(1) < 1) {
                exist = false;
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return exist;
    }

    @Override
    public void deleteCategory(String name) {
        try {
            PreparedStatement delete = con.prepareStatement("delete from productcategory where category_name = ?");
            delete.setString(1, name);
            delete.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public void addProduct(Product product) {
        try {
            PreparedStatement insert = con.prepareStatement("insert into product(product_name,price,description,image,quantityInStock,product_category) values(?,?,?,?,?,?)");
            PreparedStatement select = con.prepareStatement("select category_id FROM productcategory WHERE category_name = ?");
            select.setString(1, product.getCategory());
            ResultSet rs = select.executeQuery();
            rs.next();
            int categoryId = rs.getInt(1);
            insert.setString(1, product.getName());
            insert.setDouble(2, product.getPrice());
            insert.setString(3, product.getDescription());
            insert.setString(4, product.getImage());
            insert.setInt(5, product.getStockQuantity());
            insert.setInt(6, categoryId);
            insert.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public void updateProduct(Product product) {
        try {
            PreparedStatement update = con.prepareStatement("update product set product_name= ?,price = ?,description = ?,image = ?,quantityInStock = ? where product_id = ?");
            update.setString(1, product.getName());
            update.setDouble(2, product.getPrice());
            update.setString(3, product.getDescription());
            update.setString(4, product.getImage());
            update.setInt(5, product.getStockQuantity());
            update.setInt(6, product.getId());
            update.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public void deleteProduct(int productId) {
        try {
            PreparedStatement delete = con.prepareStatement("delete from product where product_id = ?");
            delete.setInt(1, productId);
            delete.execute();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    @Override
    public Product retriveProduct(int id) {
        Product product = new Product();
        try {

            PreparedStatement select = con.prepareStatement("SELECT product.product_id, product.product_name,product.price, product.description,product.image, product.quantityInStock,productcategory.category_name as cat_name FROM product LEFT JOIN productcategory ON product.product_category=productcategory.category_id Where product_id = ?");
            select.setInt(1, id);
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                product.setId(rs.getInt(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getDouble(3));
                product.setDescription(rs.getString(4));
                product.setImage(rs.getString(5));
                product.setStockQuantity(rs.getInt(6));
                product.setCategory(rs.getString(7));
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return product;
    }

    @Override
    public List<Product> retriveProducts(String categoryName) {
        List<Product> products = new ArrayList<>();
        try {

            PreparedStatement select = con.prepareStatement("SELECT product.product_id, product.product_name,product.price, product.description,product.image, product.quantityInStock,productcategory.category_name as cat_name FROM product LEFT JOIN productcategory ON product.product_category=productcategory.category_id Where category_name = ?");
            select.setString(1, categoryName);
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getDouble(3));
                product.setDescription(rs.getString(4));
                product.setImage(rs.getString(5));
                product.setStockQuantity(rs.getInt(6));
                product.setCategory(rs.getString(7));
                products.add(product);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public List<Product> retriveProducts() {
        List<Product> products = new ArrayList<>();
        try {
            PreparedStatement select = con.prepareStatement("SELECT product.product_id, product.product_name,product.price, product.description,product.image, product.quantityInStock,productcategory.category_name as cat_name FROM product LEFT JOIN productcategory ON product.product_category=productcategory.category_id");
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getDouble(3));
                product.setDescription(rs.getString(4));
                product.setImage(rs.getString(5));
                product.setStockQuantity(rs.getInt(6));
                product.setCategory(rs.getString(7));
                products.add(product);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return products;
    }

    @Override
    public List<String> retriveCategories() {
        List<String> categories = new ArrayList<>();
        try {

            PreparedStatement select = con.prepareStatement("select * FROM productcategory");
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                categories.add(rs.getString("category_name"));
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return categories;
    }

    @Override
    public boolean addOrder(User user, Order order) {
        try {
            // insert into order
            PreparedStatement insert = con.prepareStatement("insert into productorder(user_id,shipAddress,city,state,country,phone,zip) values(?,?,?,?,?,?,?)", Statement.RETURN_GENERATED_KEYS);
            insert.setInt(1, user.getId());
            insert.setString(2, order.getShippingAdress());
            insert.setString(3, order.getCity());
            insert.setString(4, order.getState());
            insert.setString(5, order.getCountry());
            insert.setString(6, order.getPhone());
            insert.setString(7, String.valueOf(order.getZipCode()));
            insert.executeUpdate();

            // get order id 
            ResultSet generatedKeys = insert.getGeneratedKeys();
            int orderId = 0;
            if (generatedKeys.next()) {
                orderId = generatedKeys.getInt(1);
            }

            // insert order details
            for (OrderProduct p : order.getOrderDetails()) {
                PreparedStatement insertOrderProduct = con.prepareStatement("insert into orderdetails(order_id,product_id,quantityOrdered) values(?,?,?)");
                insertOrderProduct.setInt(1, orderId);
                insertOrderProduct.setInt(2, p.getProduct().getId());
                insertOrderProduct.setInt(3, p.getQuantity());
                insertOrderProduct.executeUpdate();
            }

        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return true;
    }

    public List<Order> retriveOrders(int userId) {
        List<Order> orders = new ArrayList<>();
        try {

            PreparedStatement select = con.prepareStatement("SELECT order_id,shipAddress,city,state,country,phone,zip  FROM productorder Where user_id = ?");
            select.setInt(1, userId);
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                Order order = new Order();
                order.setId(rs.getInt(1));
                order.setShippingAdress(rs.getString(2));
                order.setCity(rs.getString(3));
                order.setState(rs.getString(4));
                order.setCountry(rs.getString(5));
                order.setPhone(rs.getString(6));
                order.setZipCode(Integer.parseInt(rs.getString(7)));
                List<OrderProduct> orderProducts = new ArrayList<>();
                PreparedStatement select2 = con.prepareStatement("SELECT product.product_id, product.product_name,product.price, product.description,product.image, product.quantityInStock,orderdetails.quantityOrdered FROM orderdetails LEFT JOIN product ON product.product_id=orderdetails.product_id where order_id = ?");
                select2.setInt(1, order.getId());
                ResultSet rs2 = select2.executeQuery();
                while (rs2.next()) {

                    orderProducts.add(new OrderProduct(new Product(rs.getString(2), rs.getDouble(3), rs.getString(4), rs.getString(5), rs.getInt(6), ""), rs.getInt(7)));
                }
                rs2.close();
                order.setOrderDetails(orderProducts);
                orders.add(order);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return orders;
    }

    public List<User> retriveUsers() {
        List<User> users = new ArrayList<>();
        try {
            PreparedStatement select = con.prepareStatement("SELECT user_id, email,fname, lname,city, zip,phone,country,registration_date,address,credite  FROM product LEFT JOIN productcategory ON product.product_category=productcategory.category_id");
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                User user = new User();
                user.setId(rs.getInt(1));
                user.setEmail(rs.getString(2));
                user.setFirstName(rs.getString(3));
                user.setLastName(rs.getString(4));
                user.setCity(rs.getString(5));
                user.setZipCode(rs.getInt(6));
                user.setPhone(rs.getString(7));
                user.setCountry(rs.getString(8));
                user.setRegistrationDate(rs.getDate(9));
                user.setAddress(rs.getString(10));
                user.setCredit(rs.getDouble(11));
                users.add(user);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return users;
    }

    public void printCard(int cardId) {
        try {
            PreparedStatement update = con.prepareStatement("update creditcard set printed= '1' where creditCard_id = ?");
            update.setInt(1, cardId);
            update.executeUpdate();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
    }

    public List<CreditCard> retriveCards() {
        List<CreditCard> creditCards = new ArrayList<>();
        try {

            PreparedStatement select = con.prepareStatement("SELECT amonut, number,printed FROM creditcard");
            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                CreditCard creditCard = new CreditCard();
                creditCard.setAmount(rs.getDouble(1));
                creditCard.setNumber(rs.getLong(2));
                creditCard.setPrinted(rs.getBoolean(3));
                creditCards.add(creditCard);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return creditCards;
    }


    /*End mohsen*/
 /*Asmaa*/
    @Override
    public boolean addToCart(User user, Product product, int quantity) {

        try {
            /*check if record exist befor or not */
           /*  PreparedStatement selectStmt = con.prepareStatement("SELECT * from cart where user_id=? and product_id=?");
            selectStmt.setInt(1, user.getId());
            selectStmt.setInt(2, product.getId());
            ResultSet result1= selectStmt.executeQuery();
            if(result1.next()){
                UpdateCart(user, product, quantity);
            }else{*/
            // insert into cart
            PreparedStatement insert = con.prepareStatement("insert into cart(user_id,product_id,quantity) values(?,?,?)");
            insert.setInt(1, user.getId());
            insert.setInt(2, product.getId());
            insert.setInt(3, quantity);
            int result = insert.executeUpdate();
            if (result != 0) {
                System.out.println("inserted ");
                return true;
            }
            //}
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean cartExsits(User user, Product product) {
        try {
            PreparedStatement selectStmt = con.prepareStatement("SELECT * from cart where user_id=? and product_id=?");
            selectStmt.setInt(1, user.getId());
            selectStmt.setInt(2, product.getId());
            ResultSet result1 = selectStmt.executeQuery();
            if (result1.next()) {

                return true;
            }
        } catch (SQLException ex) {
            Logger.getLogger(Database.class.getName()).log(Level.SEVERE, null, ex);
        }
        return false;

    }

    @Override
    public boolean deleteFromCart(User user, Product product) {

        try {
            // delete into cart
            PreparedStatement deleteStmt = con.prepareStatement("delete from cart where user_id=? and product_id=?");
            deleteStmt.setInt(1, user.getId());
            deleteStmt.setInt(2, product.getId());
            int result = deleteStmt.executeUpdate();
            if (result != 0) {
                System.out.println("deleted");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    @Override
    public boolean UpdateCart(User user, Product product, int quantity) {

        try {
            // update cart
            PreparedStatement updateStmt = con.prepareStatement("update cart set quantity= ? where user_id=? and product_id =?");
            updateStmt.setInt(1, quantity);
            updateStmt.setInt(2, user.getId());
            updateStmt.setInt(3, product.getId());
            int result = updateStmt.executeUpdate();
            if (result != 0) {
                System.out.println("updated");
                return true;
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;

    }

    @Override
    public List<OrderProduct> retriveCart(User user) {
        List<OrderProduct> orderProductList = new ArrayList<>();
        OrderProduct orderProduct = null;
        int product_id = 0, category_id;
        try {
            // select cart
            PreparedStatement selectStmt = con.prepareStatement("SELECT * from cart where user_id=?");
            selectStmt.setInt(1, user.getId());
            ResultSet result = selectStmt.executeQuery();
            while (result.next()) {
                orderProduct = new OrderProduct();
                /*get all product_id, retrive all product record , fill product obj, fill quentity,add in listrs */
                orderProduct.setQuantity(result.getInt("quantity"));
                product_id = result.getInt("product_id");
                PreparedStatement select = con.prepareStatement("SELECT * FROM product Where product_id= ?");
                select.setInt(1, product_id);
                ResultSet rs = select.executeQuery();
                while (rs.next()) {
                    Product product = new Product();
                    product.setId(rs.getInt(1));
                    product.setName(rs.getString(2));
                    product.setPrice(rs.getDouble(3));
                    product.setDescription(rs.getString(4));
                    product.setImage(rs.getString(5));
                    product.setStockQuantity(rs.getInt(6));
                    category_id = rs.getInt(7);
                    PreparedStatement selectCat = con.prepareStatement("SELECT category_name FROM  productcategory Where category_id= ?");
                    selectCat.setInt(1, category_id);
                    ResultSet rs1 = selectCat.executeQuery();
                    while (rs1.next()) {
                        product.setCategory(rs1.getString(1));
                    }
                    rs1.close();
                    orderProduct.setProduct(product);
                }
                orderProductList.add(orderProduct);
                rs.close();
            }
            result.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        System.out.println("list size " + orderProductList.size());
        return orderProductList;
    }

    /*End asmaa*/
 /*Start ibrahiem*/
    @Override
    public List<Product> retriveProducts(String searchText, String categoryName) {
        List<Product> products = new ArrayList<>();
        try {

            PreparedStatement select = con.prepareStatement("SELECT product.product_id, product.product_name,product.price,"
                    + " product.description,product.image,"
                    + " product.quantityInStock,productcategory.category_name as cat_name FROM"
                    + " product LEFT JOIN productcategory ON product.product_category=productcategory.category_id"
                    + " Where category_name = ? and product_name like ?");
            select.setString(1, categoryName);
            select.setString(2, "%" + searchText + "%");

            ResultSet rs = select.executeQuery();
            while (rs.next()) {
                Product product = new Product();
                product.setId(rs.getInt(1));
                product.setName(rs.getString(2));
                product.setPrice(rs.getDouble(3));
                product.setDescription(rs.getString(4));
                product.setImage(rs.getString(5));
                product.setStockQuantity(rs.getInt(6));
                product.setCategory(rs.getString(7));
                products.add(product);
            }
            rs.close();
        } catch (SQLException e) {
            // TODO Auto-generated catch block
            e.printStackTrace();
        }
        return products;
    }
    /*end ibrahiem*/
}
