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
        <title>Cart | E-Shopper</title>
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

    <c:if test="${sessionScope.user !=null}">
        <jsp:include page="loggedin-header.jsp" />
    </c:if>
    <c:if test="${sessionScope.user ==null}">
        <jsp:include page="header.jsp" />
    </c:if>
    <!--end the header of the page-->

    <section id="cart_items">
        <div class="container">
            <div class="breadcrumbs">
                <ol class="breadcrumb">
                    <li><a href="#">Home</a></li>
                    <li class="active">Shopping Cart</li>
                </ol>
            </div>
            <div class="table-responsive cart_info">
                <table class="table table-condensed">
                    <input id='userId' type='hidden' value='${sessionScope.user.id}'/>  
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
                    <c:if test="${!empty requestScope.orderProductList}">
                          <c:set var="totalPrice" value="${0}" />
                         <c:forEach items="${requestScope.orderProductList}" var="orderProduct">
                           <c:set var="totalPrice" value="${totalPrice +orderProduct.product.price*orderProduct.quantity}" />
                           <tr> 
                           <td class="cart_product">
                               <a href=""><img width="30px" src="${orderProduct.product.image}" alt=""></a>
                           </td>
                           <td class="cart_description">
                               <h4><a href="">${orderProduct.product.name}</a></h4><p>product ID:<c:out value="${orderProduct.product.id}"/></p>
                           </td>
                           <td class="cart_price">
                               <p>EGP <c:out value="${orderProduct.product.price}"/></p>
                           </td>
                           <td class="cart_quantity">
                               <div class="cart_quantity_button">
                                   <a class="cart_quantity_up" onclick="cartQuantityUp(quentity${orderProduct.product.id},${orderProduct.product.stockQuantity},${orderProduct.product.price});">+</a>
                                   <input class="cart_quantity_input" type="text" readonly="true" name="quantity" value=${orderProduct.quantity} id="quentity${orderProduct.product.id}" autocomplete="off" size="2">
                                   <a class="cart_quantity_down" onclick="cartQuatityDown(quentity${orderProduct.product.id},${orderProduct.product.stockQuantity},${orderProduct.product.price});">-</a>
                               </div>
                           </td>
                           <td class="cart_total">
                               <p class="cart_total_price" id="p${orderProduct.product.id}">EGP <c:out value="${orderProduct.product.price*orderProduct.quantity}"/></p>
                           </td>
                           <td class="cart_delete">
                               <a class="cart_quantity_delete" onclick="deleteRow(this,${orderProduct.product.id})">
                                   <i class="fa fa-times"></i>
                               </a>
                           </td>
                          </tr>
                        </c:forEach>
                     </c:if>
                    </tbody>
                </table>
            </div>
               <c:if test="${empty requestScope.orderProductList}">
                      <div class="alert alert-warning" id="error_msg1" style="display: block;" >NO Product in cart</div>
                    </c:if>       
                 <div class="alert alert-warning" id="error_msg" style="display: none;" >NO Product in cart</div>
                   
    </div>
    </section> <!--/#cart_items-->

    <section id="do_action">
        <!--            <div class="container">
                        <div class="heading">
                            <h3>What would you like to do next?</h3>
                            <p>Choose if you have a discount code or reward points you want to use or would like to estimate your delivery cost.</p>
                        </div>
                        <div class="row">
                            <div class="col-sm-6">
                                <div class="chose_area">
                                    <ul class="user_option">
                                        <li>
                                            <input type="checkbox">
                                            <label>Use Coupon Code</label>
                                        </li>
                                        <li>
                                            <input type="checkbox">
                                            <label>Use Gift Voucher</label>
                                        </li>
                                        <li>
                                           <input type="checkbox">
                                            <label>Estimate Shipping & Taxes</label>
                                        </li>
                                    </ul>
                                    <ul class="user_info">
                                        <li class="single_field">
                                            <label>Country:</label>
                                            <select>
                                                <option>United States</option>
                                                <option>Bangladesh</option>
                                                <option>UK</option>
                                                <option>India</option>
                                                <option>Pakistan</option>
                                                <option>Ucrane</option>
                                                <option>Canada</option>
                                                <option>Dubai</option>
                                            </select>
        
                                        </li>
                                        <li class="single_field">
                                            <label>Region / State:</label>
                                            <select>
                                                <option>Select</option>
                                                <option>Dhaka</option>
                                                <option>London</option>
                                                <option>Dillih</option>
                                                <option>Lahore</option>
                                                <option>Alaska</option>
                                                <option>Canada</option>
                                                <option>Dubai</option>
                                            </select>
        
                                        </li>
                                        <li class="single_field zip-field">
                                            <label>Zip Code:</label>
                                            <input type="text">
                                        </li>
                                    </ul>
                                    <a class="btn btn-default update" href="">Get Quotes</a>
                                    <a class="btn btn-default check_out" href="">Continue</a>
                                </div>
                            </div>
                            <div class="col-sm-6">
                                <div class="total_area">
                                    <ul>
                                        <li>Cart Sub Total <span>$59</span></li>
                                        <li>Eco Tax <span>$2</span></li>
                                        <li>Shipping Cost <span>Free</span></li>
                                        <li>Total <span>$61</span></li>
                                    </ul>
                                    <a class="btn btn-default update" href="">Update</a>
                                    <a class="btn btn-default check_out" href="">Check Out</a>
                                </div>
                            </div>
                        </div>
                    </div>-->
    </section><!--/#do_action-->

    <!--include the footer of the page-->

    <jsp:include page="footer.jsp" />
    <!--end the footer of the page-->


    <script src="js/jquery.js"></script>
    <script src="js/bootstrap.min.js"></script>
    <script src="js/jquery.scrollUp.min.js"></script>
    <script src="js/jquery.prettyPhoto.js"></script>
    <script src="js/main.js"></script>
   <script>
     function cartQuantityUp(id, inStock, price) {
                var quentity = id.value;
                quentity++;
                if (quentity <= inStock && inStock !== 0) {
                    AddToCart(id.id.substring(8, 9), quentity, inStock);
                    console.log("in up" + id.id.substring(8, 9));
                    document.getElementById("p" + id.id.substring(8, 9)).innerHTML = "EGP" + eval(price * quentity);
                    id.value = quentity;
                }
            }
            function cartQuatityDown(id, inStock, price) {
                var quentity =  id.value;
                quentity--;
                if (quentity > 0 && inStock !== 0) {
                    AddToCart(id.id.substring(8, 9), quentity, inStock);
                    console.log("in down" + id.id.substring(8, 9));
                    document.getElementById("p" + id.id.substring(8, 9)).innerHTML = "EGP" + eval(price * quentity);
                    id.value = quentity;
                }
                
            }
            function deleteRow(row, product_id) {
                 console.log("am in delete row");
                var i = row.parentNode.parentNode.rowIndex;
                console.log("row index " + i + "p " + product_id);
                console.log(" am here in add to cart  ");
                document.getElementById('tbody').deleteRow(i - 1);
                romveFromCart(product_id);
                var count = document.getElementById("tbody").children.length;
                console.log(" count " + count);
                if (count === 0) {
                document.getElementById("error_msg").innerHTML="NO Product in cart";
                document.getElementById("error_msg").style.display='block';
                console.log("NO Product in cart");
                    }
        
    }
            function romveFunCallBack(responseTxt, statusTxt, xhr) {
                if (statusTxt === "success") {
                    console.log(" one product added to cart");
                }
            }
            function AddToCart(product_id, quentity, inStock) {
                if (inStock >= quentity && inStock !== 0) {
                    $.post("AddToCart", {
                                        "productId": product_id,
                                        "quentity": quentity
                    }, romveFunCallBack);

                }
            }
            function romveFromCart(product_id) {
                $.post("RemoveProductFromCart", {"productId": product_id}
                , romveFunCallBack);
            }
     </script>
</body>
</html>
