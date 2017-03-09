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
        <script>
            function addCategory() {
                var catName = document.getElementById("catName").value;
                var obj = {
                    catName: catName
                };
                $.post("AddCategory", obj,function(data, status, xhr){
                    console.log(data);
                    if(data == "Added"){
                        document.getElementById("catName").value = "";
                    }else{
                        
                    }
                });
                return false;
            }
            
            
        </script>
    </head><!--/head-->

    <body>
        <jsp:include page="header.jsp" />

        <section id="form" style="margin-top: 15px"><!--form-->
            <div class="container">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-1">
                        <div class="login-form"><!--Category form-->
                            <h2>Adding New Category</h2>
                            <form >
                                <input id="catName" type="text" placeholder="Category Name" required />

                                <button type="submit" onclick="return addCategory()" class="btn btn-default">Add</button>
                            </form>
                        </div><!--/login form-->
                    </div>
                    <!--				<div class="col-sm-1">
                                                            <h2 class="or">OR</h2>
                                                    </div>-->
                    <div class="col-sm-4">
                        <!--					<div class="signup-form">sign up form
                                                                        <h2>New User Signup!</h2>
                                                                        <form action="#">
                                                                                <input type="text" placeholder="Name"/>
                                                                                <input type="email" placeholder="Email Address"/>
                                                                                <input type="password" placeholder="Password"/>
                                                                                <button type="submit" class="btn btn-default">Signup</button>
                                                                        </form>
                                                                </div>/sign up form-->
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