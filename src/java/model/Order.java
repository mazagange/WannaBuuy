/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package model;

import java.util.List;

/**
 *
 * @author ibrahiem
 */
public class Order {
    private List<OrderProduct> orderDetails;
    private int id;
    private String shippingAdress;
    private String city;
    private String state;
    private String country;
    private String phone;
    private int zipCode;

    public Order(List<OrderProduct> orderDetails, String shippingAdress, String city, String state, String country, String phone, int zipCode) {
        this.orderDetails = orderDetails;
        this.shippingAdress = shippingAdress;
        this.city = city;
        this.state = state;
        this.country = country;
        this.phone = phone;
        this.zipCode = zipCode;
    }

    public Order() {
    }

    public List<OrderProduct> getOrderDetails() {
        return orderDetails;
    }

    public void setOrderDetails(List<OrderProduct> orderDetails) {
        this.orderDetails = orderDetails;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getShippingAdress() {
        return shippingAdress;
    }

    public void setShippingAdress(String shippingAdress) {
        this.shippingAdress = shippingAdress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public int getZipCode() {
        return zipCode;
    }

    public void setZipCode(int zipCode) {
        this.zipCode = zipCode;
    }

    
}
