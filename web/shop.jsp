<%-- 
    Document   : header
    Created on : Mar 3, 2017, 4:04:35 PM
    Author     : ibrahiem
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Shop | E-Shopper</title>
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

        <jsp:include page="header.jsp" />
        <!--end the header of the page-->

       
        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <%@include file="sidebar.jsp" %> 
                    </div>

                    <div class="col-sm-9 padding-right">
                        <div class="features_items"><!--features_items-->
                            <h2 class="title text-center">Features Items</h2>

                            <c:if test="${empty products}">
                            <h2>no products </h2>
                            </c:if>
                            <!--div ely hytkkr kaza mara momken ytkrr 12 bs w b3d kda a5leh yro7 nfs page tanya w ygeb 12--> 
                            <c:forEach items="${products}" var="product">
                            <div class="col-sm-4">
                                <div class="product-image-wrapper">
                                    <div class="single-products">
                                        <div class="productinfo text-center">
                                            <img src="${product.image}" alt="" />
                                            <h2>${product.price} EGP</h2>
                                            <p>${product.name}</p>
<!--                                            <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>-->
                                        </div>
                                        <div class="product-overlay">

                                            <div class="overlay-content">
                                                <h2>${product.price} EGP</h2>
                                                <!--todo forward to product details with product id--> 
                                                <a href="${baseURL}Product?id=${product.id}"><p>${product.name}</p></a>
                                                <!--<a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>-->

                                            </div>
                                        </div>
                                    </div>
                                    
                                </div>
                            </div>
                            </c:forEach>



                            
                        </div><!--features_items-->
                        <ul class="pagination">
                                <c:forEach begin="1" end="${pagesNo}" var="no"> 
                                <li <c:if test="${no == pageNo}">class="active"</c:if>><a href="${baseURL}Products?category=${category}&page=${no}">${no}</a></li>
                                </c:forEach>
                                <li><a href="${baseURL}Products?category=${category}&page=${pageNo+1}">&raquo;</a></li>
                        </ul>
                    </div>
                </div>
            </div>
        </section>

        <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->




        <script src="js/jquery.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>