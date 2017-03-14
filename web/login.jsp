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
        <title>Login | E-Shopper</title>
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
                    <div class="col-sm-4 col-sm-offset-1">
                        <div class="login-form"><!--login form-->
                            <c:if test="${requestScope.error == 'login'}">
                                <div class="alert alert-warning">
                                    <strong>!</strong> error in Email or password 
                                </div>
                            </c:if>
                            <c:if test="${requestScope.error == 'confirm'}">
                                <div class="alert alert-warning">
                                    <strong>!</strong> please confirm your email first
                                </div>
                            </c:if>
                            <h2>Login to your account</h2>
                            <form action="Login" method="post">

                                <input type="email" name="email" placeholder="Email Address" required/>
                                <input type="password" name="pass" placeholder="Password" required/>

                                
                                <button type="submit" class="btn btn-default">Login</button>
                                <a href="forget-pasword.jsp">Forgotten account?</a>
                            </form>
                        </div><!--/login form-->
                    </div>
                    <div class="col-sm-1">
                        <h2 class="or">OR</h2>
                    </div>
                    <div class="col-sm-4">
                        <div class="signup-form"><!--sign up form-->
                            <c:if test="${requestScope.signedup == 'true'}">
                                <div class="alert alert-success">
                                    <strong>successful please confirm your email </strong> 
                                </div>
                            </c:if>
                            <c:if test="${requestScope.error == 'signup'}">
                                <div class="alert alert-warning">
                                    <strong>!</strong> this email is registered before
                                </div>
                            </c:if>
                            <h2>New User Signup!</h2>
                            <form action="Signup" method="post">
                                <input type="text" name="fName" placeholder="first Name" required/>
                                <input type="text" name="lName" placeholder="last Name" required/>


                                <input type="email" name="email" placeholder="Email Address" required />
                                <input type="password" name="pass" placeholder="Password" required/>
                                <input type="text" name="city" placeholder="City" required/>
                                <input type="text" name="country" placeholder=" Country" required/>
                                <input type="text" name="address" placeholder="Address" required/>
                                <input type="tel" name="phone" placeholder="Phone" required/>
                                <input type="number" name="zip" placeholder="Postal code" required />
                                <button type="submit" class="btn btn-default">Signup</button>
                            </form>
                        </div><!--/sign up form-->
                    </div>
                </div>
            </div>
        </section><!--/form-->


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
