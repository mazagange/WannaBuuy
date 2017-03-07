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

        <jsp:include page="header.jsp" />
        <!--end the header of the page-->

        <section id="form" style="margin-top: 15px;"><!--form-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 ">
                        <div class="signup-form" >

                            First Name: <label  name="firstName">
                                <c:out value="${sessionScope.user.firstName}"></c:out>
                                </label>
                                </br>
                                Last Name: <label  name="lastName"  >
                                <c:out value="${sessionScope.user.lastName}"></c:out>
                                </label>            
                                </br>
                                Email : <label  name="email"   >
                                <c:out value="${sessionScope.user.email}"></c:out>
                                </label> 
                                </br>
                                City:<lable name="city"   >
                                <c:out value="${sessionScope.user.city}"></c:out>
                                </lable>                              
                                </br>
                                Country:<label  name="country"   >
                                <c:out value="${sessionScope.user.country}"></c:out>
                                </label>
                                </br>
                                address:<label  name="adress"   >
                                <c:out value="${sessionScope.user.address}"></c:out>
                                </label> 
                                </br>
                                phone : <label  name="phone"   >
                                <c:out value="${sessionScope.user.phone}"></c:out>
                                </label>          
                                </br>
                                zip Code :<label name="zipCode" >
                                <c:out value="${sessionScope.user.zipCode}"></c:out>
                                </label>                     
                                </br>

                                credit: <label  name="credit" > 
                                <c:out value="${sessionScope.user.credit}"></c:out>
                                </label>   
                                </br>

                                <button type="submit" value="submit" onclick="document.location.href = 'edit-profile.jsp'" class="btn btn-default">Edit Profile</button>



                            </div>
                        </div>
                        <!--                    <div class="col-sm-1">
                                                <h2 class="or">OR</h2>
                                            </div>-->
                        <div class="col-sm-4">
                            <div class="signup-form">
                                <h2>Recharging Account</h2>
                                <form action="#">
                                    <input type="text" name="creditRecharge" placeholder="Enter credit number" required/>
                                    <button type="submit" class="btn btn-default">Recharge</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </section><!--/form-->

            <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->



        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/price-range.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
