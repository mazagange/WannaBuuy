<%-- 
    Document   : header
    Created on : Mar 3, 2017, 4:04:35 PM
    Author     : ibrahiem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Home | E-Shopper</title>
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

        <section id="slider"><!--slider-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-12">
                        <div id="slider-carousel" class="carousel slide" data-ride="carousel">
                            <ol class="carousel-indicators">
                                <li data-target="#slider-carousel" data-slide-to="0" class="active"></li>
                                <li data-target="#slider-carousel" data-slide-to="1"></li>
                                <li data-target="#slider-carousel" data-slide-to="2"></li>
                            </ol>

                            <div class="carousel-inner">
                                <div class="item active">
                                    <div class="col-sm-6">
                                        <h1><span>Wanna</span>Buy</h1>
                                        <h2>Online E-commerce</h2>
                                        <p>Buy what you need today and free shipping  </p>
                                        <!--<button type="button" class="btn btn-default get">Get it now</button>-->
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl1.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
                                    </div>
                                </div>
                                <div class="item">
                                    <div class="col-sm-6">
                                        <h1><span>Wanna</span>Buy</h1>
                                        <h2>Online E-commerce</h2>
                                        <p>Buy what you need today and free shipping  </p>
                                        <!--<button type="button" class="btn btn-default get">Get it now</button>-->
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl2.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png"  class="pricing" alt="" />
                                    </div>
                                </div>

                                <div class="item">
                                    <div class="col-sm-6">
                                        <h1><span>Wanna</span>Buy</h1>
                                        <h2>Online E-commerce</h2>
                                        <p>Buy what you need today and free shipping  </p>
                                        <!--<button type="button" class="btn btn-default get">Get it now</button>-->
                                    </div>
                                    <div class="col-sm-6">
                                        <img src="images/home/girl3.jpg" class="girl img-responsive" alt="" />
                                        <img src="images/home/pricing.png" class="pricing" alt="" />
                                    </div>
                                </div>

                            </div>

                            <a href="#slider-carousel" class="left control-carousel hidden-xs" data-slide="prev">
                                <i class="fa fa-angle-left"></i>
                            </a>
                            <a href="#slider-carousel" class="right control-carousel hidden-xs" data-slide="next">
                                <i class="fa fa-angle-right"></i>
                            </a>
                        </div>

                    </div>
                </div>
            </div>
        </section><!--/slider-->

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-sm-3">
                        <%@include file="sidebar.jsp" %> 
                    </div>

                    <div class="col-sm-9 padding-right">
                        <c:forEach items="${categories}" var="cat">
                            <div class="features_items" id="${cat}"><!--features_items-->
                                <h2 class="title text-center">${cat}</h2>

                                <c:set scope="page" var="pro" value="0"/>
                                <c:forEach items="${products}" var="product">
                                    
                                    <c:if test="${cat == product.category and pro<3}">
                                        <c:set scope="page" var="pro" value="${pro+1}"/>
                                        <div class="col-sm-4">
                                            <div class="product-image-wrapper">
                                                <div class="single-products">
                                                    <div class="productinfo text-center">
                                                        <img src="${product.image}" alt="" />
                                                        <h2>${product.price} EGP</h2>
                                                        <p>${product.name}</p>
                                                        <!--                                                        <a href="#" class="btn btn-default add-to-cart"><i class="fa fa-shopping-cart"></i>Add to cart</a>-->
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
                                    </c:if>

                                </c:forEach> 




                            </div><!--features_items-->
                        </c:forEach>

                    </div>
                </div>
            </div>
        </section>
        <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->



        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
        <script>
            var cats = document.getElementsByClassName("features_items");

            for (var i = 0; i < cats.length; i++) {
                if (cats[i].children.length < 2) {
                    cats[i].style.display = "none";

                }
            }
        </script>
    </body>
</html>