<%-- 
    Document   : header
    Created on : Mar 3, 2017, 4:04:35 PM
    Author     : ibrahiem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Checkout | E-Shopper</title>
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <link href="css/font-awesome.min.css" rel="stylesheet">
        <link href="css/prettyPhoto.css" rel="stylesheet">
        <link href="css/price-range.css" rel="stylesheet">
        <link href="css/animate.css" rel="stylesheet">
        <link href="css/main.css" rel="stylesheet">
        <link href="css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="images/ico/apple-touch-icon-57-precomposed.png">

    </head><!--/head-->

    <body>
        <!--include the header of the page-->
        <!--todo check if the user is logged-in to retrive the logged in header--> 

        <jsp:include page="loggedin-header.jsp" />
        <!--end the header of the page-->

        <section id="cart_items">
            <div class="container">
                <!--            <div class="breadcrumbs">
                                <ol class="breadcrumb">
                                    <li><a href="#">Home</a></li>
                                    <li class="active">Check out</li>
                                </ol>
                            </div>/breadcrums-->




                <div class="shopper-informations">
                    <div class="row">
                        <!--                        <div class="col-sm-3">
                                                    <div class="shopper-info">
                                                        <p>Shopper Information</p>
                                                        <form>
                                                            <input type="text" placeholder="Display Name">
                                                            <input type="text" placeholder="User Name">
                                                            <input type="password" placeholder="Password">
                                                            <input type="password" placeholder="Confirm password">
                                                        </form>
                                                    </div>
                                                </div>-->

                        <div class="col-sm-4">
                            <!--                            <div class="order-message">
                                                            <p>Shipping Order</p>
                                                            <textarea name="message"  placeholder="Notes about your order, Special Notes for Delivery" rows="16"></textarea>
                                                            <label><input type="checkbox"> Shipping to bill address</label>
                                                        </div>	-->
                        </div>					
                    </div>
                </div>
                <div class="review-payment">
                    <h2>Review & Payment</h2>
                </div>

                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
                        <thead>
                            <tr class="cart_menu">
                                <td class="image">Item</td>
                                <td class="description"></td>
                                <td class="price">Price</td>
                                <td class="quantity">Quantity</td>
                                <td class="total">Total</td>
                                <td></td>
                            </tr>
                        </thead>
                        <tbody id="tbody">
                            <c:set var="totalPrice" value="${0}" />
                            <c:if test="${!empty orderProductList}">
                                <c:forEach items="${orderProductList}" var="orderProduct">
                                    <c:set var="totalPrice" value="${totalPrice +orderProduct.product.price*orderProduct.quantity}" />
                                    <tr> 
                                        <td class="cart_product">
                                            <a href=""><img width="30px" src="${orderProduct.product.image}" alt=""></a>
                                        </td>
                                        <td class="cart_description">
                                            <h4><a href="">${orderProduct.product.name}</a></h4><p>Product ID:<c:out value="${orderProduct.product.id}"/></p>
                                        </td>
                                        <td class="cart_price">
                                            <p>EGP <c:out value="${orderProduct.product.price}"/></p>
                                        </td>

                                        <td class="cart_quantity">
                                            <div class="cart_quantity_button">

                                                <input class="cart_quantity_input" type="text" readonly="true" name="quantity" value=${orderProduct.quantity} id="quentity${orderProduct.product.id}" autocomplete="off" size="2">

                                            </div>
                                        </td>
                                        <td class="cart_total">
                                            <p class="cart_total_price" id="p${orderProduct.product.id}">EGP <c:out value="${orderProduct.product.price*orderProduct.quantity}"/></p>
                                        </td>


                                    </tr>
                                </c:forEach>

                            </c:if>
                            <tr>
                                <td colspan="4"> </td>
                                <td colspan="2">
                                    <table class="table table-condensed total-result">
                                        <tr>
                                            <td>Total</td>
                                            <td><span id="spaneid">EGP ${totalPrice}</span></td>
                                        </tr>
                                    </table>
                                </td>
                            </tr>
                        </tbody>
                        <input id='total' type='hidden' value="${totalPrice}"/> 

                    </table>
                </div>
                <c:if test="${empty requestScope.orderProductList}">
                    <div class="alert alert-warning" id="error_msg" style="display: block;" >NO Product in cart</div>
                </c:if>       
                <div class="alert alert-warning" id="error_msg" style="display: none;" ></div>
                <div class="col-sm-5 clearfix">
                    <div class="bill-to">
                        <p>Bill To</p>
                        <div class="form-one">
                            <form id="orderForm" method="post" >
                                <input id='userCredit' type='hidden' value='${sessionScope.user.credit}'/>  
                                <input id='userId' type='hidden' value='${sessionScope.user.id}'/>  
                                <input type="text" placeholder="Shipping Adrress *" id="ShippingAdrress" required>
                                <input type="text" placeholder="city *" id="city" required>
                                <input type="hidden" placeholder="state" value="shipped" id="state" required>
                                <input type="text" placeholder="country *" id="country" required>
                                <input type="number" placeholder="Zip *" min="1" max="99999" id="zip" required>
                                <input type="tel" placeholder="phone *" id="phone" required>
                                <button type="submit" class="btn btn-default" class="btn btn-primary" id="shippingOrder" style="margin-bottom: 10px;text-align: right">Order</button>
                            </form>
                        </div>
                        <div class="form-two">



                        </div>
                    </div>
                </div>
            </div>
        </section> <!--/#cart_items-->


        <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->




        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script>
                                
                                var checkBalance = false;
                                var totalPrice = document.getElementById("total").value;
                                var userExist = false;
                                function checkBalancefunction() {
                                    var userCredit = document.getElementById("userCredit").value;
                                    var total = document.getElementById("total").value;
                                    if (parseInt(userCredit) >= parseInt(total)) {
                                        checkBalance = true;
                                    }
                                    return checkBalance;
                                }
                                function cartQuantityUp(id, inStock, price) {
                                    var quentity = id.value;
                                    quentity++;
                                    if (quentity <= inStock && inStock !== 0) {
                                        AddToCart(id.id.substring(8, 9), quentity, inStock);
                                        console.log("in up" + id.id.substring(8, 9));
                                        document.getElementById("p" + id.id.substring(8, 9)).innerHTML = "$" + eval(price * quentity);
                                        id.value = quentity;
                                        totalPrice = document.getElementById("total").value;
                                        totalPrice = parseInt(totalPrice) + price;
                                        document.getElementById("spaneid").innerHTML = "$" + totalPrice + ".0";
                                        document.getElementById("total").value = totalPrice;
                                    }
                                }
                                function cartQuatityDown(id, inStock, price) {
                                    var quentity = id.value;
                                    quentity--;
                                    if (quentity > 0 && inStock !== 0) {
                                        AddToCart(id.id.substring(8, 9), quentity, inStock);
                                        console.log("in down" + id.id.substring(8, 9));
                                        id.value = quentity;
                                        document.getElementById("p" + id.id.substring(8, 9)).innerHTML = "$" + eval(price * quentity);
                                        totalPrice = document.getElementById("total").value;
                                        totalPrice = parseInt(totalPrice) - price;
                                        document.getElementById("spaneid").innerHTML = "$" + totalPrice + ".0";
                                        document.getElementById("total").value = totalPrice;
                                    }
                                }
                                function deleteRow(id, row, product_id, price) {
                                    var i = row.parentNode.parentNode.rowIndex;
                                    console.log("row index " + i + "p " + product_id);
                                    console.log(" am here in add to cart  ");
                                    document.getElementById('tbody').deleteRow(i - 1);
                                    romveFromCart(product_id);
                                    var count = document.getElementById("tbody").children.length;
                                    count--;
                                    console.log(" count " + count);
                                    if (count === 0) {
                                        console.log("NO Product in cart");
                                        document.getElementById("error_msg").innerHTML = "NO Product in cart";
                                        document.getElementById("error_msg").style.display = 'block';
                                    }
                                    var quentity = id.value;
                                    totalPrice = document.getElementById("total").value;
                                    totalPrice = parseInt(totalPrice) - quentity * price;
                                    document.getElementById("spaneid").innerHTML = "$" + totalPrice + ".0";
                                    document.getElementById("total").value = totalPrice;
                                }

                                function romveFunCallBack(responseTxt, statusTxt, xhr) {
                                    if (statusTxt === "success") {
                                        console.log(" one product deleted from cart  ");
                                    }
                                }
                                function AddToCart(product_id, quentity, inStock) {
                                    if (inStock >= quentity && inStock !== 0) {
                                        $.get("AddToCart", {
                                            "productId": product_id,
                                            "quentity": quentity
                                        }, romveFunCallBack);
                                    }
                                }
                                function romveFromCart(product_id) {
                                    $.get("RemoveProductFromCart", {"productId": product_id}
                                    , romveFunCallBack);
                                }
                                $("#orderForm").submit( function(ev){
                                    var shipping = document.getElementById("ShippingAdrress").value;
                                    var city = document.getElementById("city").value;
                                    var state = document.getElementById("state").value;
                                    var phone = document.getElementById("phone").value;
                                    var country = document.getElementById("country").value;
                                    var zip = document.getElementById("zip").value;
                                    var count = document.getElementById("tbody").children.length;
                                    count--;
                                    console.log("count " + count);
                                    if (count !== 0) {
                                        if (checkBalancefunction()) {
                                            if (shipping !== "" && city !== "" && state !== "" && phone !== "" && country !== "" && zip !== "") {
                                                $.post("ShippingOrder", {"ShippingAdrress": $("#ShippingAdrress").val(),
                                                    "city": $("#city").val(),
                                                    "state": $("#state").val(),
                                                    "phone": $("#phone").val(),
                                                    "country": $("#country").val(),
                                                    "zip": $("#zip").val(),
                                                    "totalPrice": totalPrice
                                                }, shippingOrderCallBack);
                                                document.getElementById("ShippingAdrress").value = "";
                                                document.getElementById("city").value = "";
                                                document.getElementById("state").value = "";
                                                document.getElementById("phone").value = "";
                                                document.getElementById("country").value = "";
                                                document.getElementById("zip").value = "";
                                                console.log(" am here in add to cart  ");
                                                document.getElementById("total").value = null;
                                                document.getElementById("tbody").innerHTML = "";

                                            } else {
                                                console.log("credit erro");
                                                document.getElementById("error_msg").innerHTML = "fill all required data";
                                                document.getElementById("error_msg").style.display = 'block';
                                            }
                                        } else {
                                            console.log("credit erro");
                                            document.getElementById("error_msg").innerHTML = "NO amonut availble in your Credit";
                                            document.getElementById("error_msg").style.display = 'block';
                                        }
                                    } else {
                                        console.log("credit erro");
                                        document.getElementById("error_msg").innerHTML = "NO product in cart";
                                        document.getElementById("error_msg").style.display = 'block';
                                    }
                                    return false;
                                });

                                function shippingOrderCallBack(responseTxt, statusTxt, xhr) {
                                    if (statusTxt === "success") {
                                        document.getElementById("error_msg").innerHTML = responseTxt;
                                        document.getElementById("error_msg").style.display = 'block';
                                    }
                                }
        </script>
    </body>
</html>
