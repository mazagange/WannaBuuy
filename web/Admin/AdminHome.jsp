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

        <jsp:include page="header.jsp" />
        <!--end the header of the page-->

        <section id="form" style="margin-top: 15px;"><!--form-->
            <div class="container">
                <div class="row" style="text-align: center;margin-top: 10%">
                    <h1>Welcome To the Admin Panel </h1>
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
        <script>
            function showCategory(selectedCategory) {
                var selected = selectedCategory.value;
                if (selected != 0) {
                    var obj = {
                        category: selected
                    };
                    $.post("Products", obj, function (data, status, xhr) {
                        var products = document.getElementById("products");
                        var table = document.createElement("table");
                        table.innerHTML = "<tr><th>product name</th><th>price</th><th>quantity</th><th></th></tr>";
                        for (i = 0; i < data.length; i++) {
                            table.innerHTML += "<tr><td>" + data[i].name + "</td><td>" + data[i].price + "</td><td>" + data[i].stockQuantity + "</td><td><a href='EditProduct?id=" + data[i].id + "'>edit</a> <a href='DeleteProduct?id=" + data[i].id + "'>delete</a></td></tr>";
                        }
                    });
                }
            }
        </script>
    </body>
</html>