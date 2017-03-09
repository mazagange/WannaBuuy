<%-- 
    Document   : header
    Created on : Mar 3, 2017, 4:04:35 PM
    Author     : ibrahiem
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>E-Shopper</title>
    </head>
    <body>
        <header id="header"><!--header-->


            <div class="header-middle"><!--header-middle-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="logo pull-left">
                                <a href="index.jsp"><img src="../images/home/logo.png" alt="" /></a>
                            </div>

                        </div>

                    </div>
                </div>
            </div><!--/header-middle-->

            <div class="header-bottom"><!--header-bottom-->
                <div class="container">
                    <div class="row">
                        <div class="col-sm-9">
                            <div class="navbar-header">
                                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target=".navbar-collapse">
                                    <span class="sr-only">Toggle navigation</span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                    <span class="icon-bar"></span>
                                </button>
                            </div>
                            <div class="mainmenu pull-left">
                                <ul class="nav navbar-nav collapse navbar-collapse">
                                    <li><a href="AdminHome.jsp" class="active">Home</a></li>
                                    <li><a href="add-cards.jsp" class="active">Cards</a></li> 
                                    <li><a href="add-category.jsp" class="active">Categories</a></li>
                                    <li><a href="add-product.jsp" class="active">Products</a></li>
                                    <li><a href="cards.jsp" class="active">Print Card</a></li>

                                </ul>
                            </div>
                        </div>
                    </div>
                    <!--                    <div class="row">
                                            <form action="Search" method="POST">
                    
                                                <div class="col-sm-3"></div>
                    
                                                <div class="col-sm-3">
                                                    <input type="text" placeholder="Search"  name="searchText" style="width: 100%"/>
                                                </div>
                                                <div class="col-sm-2">
                    
                                                    <select name="category">
                                                        <my:CategoriesTag/>
                                                    </select>
                                                </div>
                                                <div class="col-sm-3">
                                                                                        <div class="search_box pull-right">
                                                    <button class="btn btn-warning" type="submit">Search</button>
                                                                                        </div>
                                                </div>
                                            </form>
                                        </div>-->
                </div>

            </div><!--/header-bottom-->
        </header><!--/header-->    </body>
</html>
