<%-- 
    Document   : header
    Created on : Mar 3, 2017, 4:04:35 PM
    Author     : ibrahiem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Home | E-Shopper</title>
        <link href="../css/bootstrap.min.css" rel="stylesheet">
        <link href="../css/font-awesome.min.css" rel="stylesheet">
        <link href="../css/prettyPhoto.css" rel="stylesheet">
        <link href="../css/price-range.css" rel="stylesheet">
        <link href="../css/animate.css" rel="stylesheet">
        <link href="../css/main.css" rel="stylesheet">
        <link href="../css/responsive.css" rel="stylesheet">
        <!--[if lt IE 9]>
        <script src="js/html5shiv.js"></script>
        <script src="js/respond.min.js"></script>
        <![endif]-->       
        <link rel="shortcut icon" href="../images/ico/favicon.ico">
        <link rel="apple-touch-icon-precomposed" sizes="144x144" href="../images/ico/apple-touch-icon-144-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="114x114" href="../images/ico/apple-touch-icon-114-precomposed.png">
        <link rel="apple-touch-icon-precomposed" sizes="72x72" href="../images/ico/apple-touch-icon-72-precomposed.png">
        <link rel="apple-touch-icon-precomposed" href="../images/ico/apple-touch-icon-57-precomposed.png">
    </head><!--/head-->

    <body>

        <!--include the header of the page-->
        <!--todo check if the user is logged-in to retrive the logged in header--> 

        <header id="header"><!--header-->


            <div class="header-middle"><!--header-middle-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href=".."><img src="../images/home/logo.png" alt="" /></a>
                            </div>

                        </div>

                    </div>
                </div>
            </div><!--/header-middle-->

            
        </header><!--/header--> 
        <!--end the header of the page-->

        <section id="form" style="margin-top: 15px;"><!--form-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-1">
                        <div class="login-form"><!--login form-->
                            <h2>Login Admin page</h2>
                            <form action="j_security_check" method="post">

                                <input type="text" name="j_username" placeholder="user name" />
                                <input type="password" name="j_password" placeholder="Password" />

                            
                                <button type="submit" class="btn btn-default">Login</button>
                                
                            </form>
                        </div><!--/login form-->
                    </div>
                    
                    
                </div>
            </div>
        </section><!--/form-->


        <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->




        <script src="../js/jquery.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery.scrollUp.min.js"></script>
        <script src="../js/price-range.js"></script>
        <script src="../js/jquery.prettyPhoto.js"></script>
        <script src="../js/main.js"></script>
    </body>
</html>
