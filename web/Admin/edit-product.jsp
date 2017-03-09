<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Login | E-Shopper</title>
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
        <jsp:include page="header.jsp" />

        <section id="form" style="margin-top: 15px;"><!--form-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-1">
                        <div class="login-form"><!--login form-->
                            <h2>Edit Product</h2>
                            <form method="post" enctype="multipart/form-data"  name="productForm">
                                <input type="text" name="name" placeholder="Name" value="${product.name}" required/>
                                <input type="number" name="price" step="0.01" min="0" placeholder="price" value="${product.price}" required/>
                                <textarea placeholder="Description" name="desc" cols="50" rows="10" required >${product.description}</textarea>
                                <input type="number" name="stock"  min="0" placeholder="Stock Quantity" value="${product.stockQuantity}"  required/>
                                <select name="category">
                                    <c:forEach items="${categories}" var="cat">
                                        <c:if test="${cat == product.category}">
                                            <option selected="true" value="${cat}">${cat}</option>
                                        </c:if>
                                        <c:if test="${cat != product.category}">
                                            <option selected="true" value="${cat}">${cat}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>

                                <input type='file' name="image" accept="image/*" onchange="readURL(this);" style="background: none"/>
                                <input type="hidden" name="id" value="${product.id}"
                                <input type="hidden" name="img" value="${product.image}"/>
                                
                                <input type="submit"  class="btn btn-default" value="Save Product"/>
                                <!--                                <input type="text" placeholder="Name" />
                                                                <input type="email" placeholder="Email Address" />
                                                                <span>
                                                                    <input type="checkbox" class="checkbox"> 
                                                                    Keep me signed in
                                                                </span>
                                                                <button type="submit" class="btn btn-default">Login</button>-->
                            </form>
                        </div><!--/login form-->
                    </div>
                    <div class="col-sm-1">
                        <h2 class="or">and</h2>
                    </div>
                    <div class="col-sm-4">
                        <div class="signup-form"><!--sign up form-->
                            <h2>Product image</h2>

                            <img id="image-preview" src="../${product.image}" alt="your image" style="width: 50%;height: 20%" />



                        </div><!--/sign up form-->
                    </div>
                </div>
            </div>
        </section><!--/form-->


        <jsp:include page="footer.jsp" />


        <script src="../js/jquery.js"></script>
        <script src="../js/price-range.js"></script>
        <script src="../js/jquery.scrollUp.min.js"></script>
        <script src="../js/bootstrap.min.js"></script>
        <script src="../js/jquery.prettyPhoto.js"></script>
        <script src="../js/main.js"></script>
        
    </body>
</html>