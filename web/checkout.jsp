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
        <title>Checkout | E-Shopper</title>
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
           <script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script >
  
  var totalPrice=0;
  var checkBalance=false;
  var totalPrice=0;
  var userExist=false;
  $(document).ready(function(){
        console.log(" am here ");
        retrieveFromCart();
     });
  function checkUserExist(){
       var user = $('#userId').val();
       if(user !==""){
         userExist=true;
       }
   return userExist;
  }
    function submitedfun(responseTxt,statusTxt,xhr){
        if(statusTxt ==="success"){
            console.log(" scuccess transaction ");
            var tbody=document.getElementById("tbody");
            for(var i=0; i<responseTxt.length;i++){
                 console.log("product id: "+responseTxt[i].product.id+"  -->  "+
                         responseTxt[i].product.name+"  --> "+responseTxt[i].product.price+"  --> "
                         +responseTxt[i].product.description+"  --> "+responseTxt[i].product.image+" -->  "
                         +responseTxt[i].product.stockQuantity+"  --> "+responseTxt[i].product.category+" --> "
                         +responseTxt[i].quantity);

                totalPrice+=eval(responseTxt[i].product.price*responseTxt[i].quantity);
                 
                 var timage= document.createTextNode(responseTxt[i].product.image);
                 var tproduct_desc= document.createTextNode(responseTxt[i].product.description);
                 var tproduct_id= document.createTextNode("Web ID: "+responseTxt[i].product.id);
                 var tproduct_price= document.createTextNode("$"+responseTxt[i].product.price);
                 var torderProduct_quentity= document.createTextNode(responseTxt[i].quantity);
                 var ttotal_price= document.createTextNode("$"+eval(responseTxt[i].product.price*responseTxt[i].quantity));
                 var tproduct_plus= document.createTextNode("+");
                 var tproduct_minus= document.createTextNode("-");
                 
                var rproduct_record = document.createElement('tr');
            
                 var cproduct=document.createElement('td');
                 cproduct.setAttribute("class","cart_product");
                    var ahref_c1=document.createElement('a');
                    ahref_c1.setAttribute("href","");
                    var image_c1=document.createElement('img');
                    image_c1.setAttribute("src",responseTxt[i].product.image);
                    image_c1.setAttribute("alt","");
                    ahref_c1.appendChild(image_c1);
                 cproduct.appendChild(ahref_c1);    
                 
                 var cproduct_description=document.createElement('td');
                 cproduct_description.setAttribute("class","cart_description");   
                    var h4_c2=document.createElement('h4');
                        var ahref_c2=document.createElement('a');
                        ahref_c2.setAttribute("href","");
                        ahref_c2.appendChild(tproduct_desc);
                    h4_c2.appendChild(ahref_c2);    
                    var p_c2=document.createElement('p');
                    p_c2.appendChild(tproduct_id);
                 cproduct_description.appendChild(h4_c2);     
                 cproduct_description.appendChild(p_c2); 
                 
                 var cproduct_price=document.createElement('td');
                 cproduct_price.setAttribute("class","cart_price");   
                    var p_c3=document.createElement('p');
                    p_c3.appendChild(tproduct_price);
                 cproduct_price.appendChild(p_c3);     
                 
                 var corderProduct_quentity=document.createElement('td');
                 corderProduct_quentity.setAttribute("class","cart_quantity"); 
                    var div_c4=document.createElement("div");
                    div_c4.setAttribute("class","cart_quantity_button");
                       var ahref_c4=document.createElement('a');
                        ahref_c4.setAttribute("class","cart_quantity_up");
                        ahref_c4.setAttribute("onclick","cartQuantityUp(\"quentity"+responseTxt[i].product.id+"\","+responseTxt[i].product.stockQuantity+","+responseTxt[i].product.price+");");
                        ahref_c4.appendChild(tproduct_plus);
                        var input_c4=document.createElement('input');
                            input_c4.setAttribute("class","cart_quantity_input");
                            input_c4.setAttribute("type","text");
                            input_c4.setAttribute("readOnly",true);
                           
                            input_c4.setAttribute("name","quantity");
                            input_c4.setAttribute("value",responseTxt[i].quantity);
                            input_c4.setAttribute("id","quentity"+responseTxt[i].product.id);
                            input_c4.setAttribute("autocomplete","off");
                            input_c4.setAttribute("size","2");
                       var ahref_c41=document.createElement('a');
                       ahref_c41.setAttribute("class","cart_quantity_down");
                       ahref_c41.setAttribute("onclick","cartQuatityDown(\"quentity"+responseTxt[i].product.id+"\","+responseTxt[i].product.stockQuantity+","+responseTxt[i].product.price+");");
                       ahref_c41.appendChild(tproduct_minus);
                    div_c4.appendChild(ahref_c4);   
                    div_c4.appendChild(input_c4);
                    div_c4.appendChild(ahref_c41);
                    corderProduct_quentity.appendChild(div_c4);
                var ctotal_price=document.createElement('td');
                 ctotal_price.setAttribute("class","cart_total");   
                    var p_c5=document.createElement('p');
                    p_c5.setAttribute("class","cart_total_price"); 
                    p_c5.setAttribute("id","p"+responseTxt[i].product.id); 
                    p_c5.appendChild(ttotal_price);
                    ctotal_price.appendChild(p_c5);     

                var ccart_delete=document.createElement('td');
                ccart_delete.setAttribute("class","cart_delete");   
                    var ahref_c6=document.createElement('a');
                       ahref_c6.setAttribute("class","cart_quantity_delete");
                       ahref_c6.setAttribute("onclick","deleteRow(this,"+responseTxt[i].product.id+","+eval(responseTxt[i].product.price*responseTxt[i].quantity)+")");
                       
                   var i_c6=document.createElement('i');
                       i_c6.setAttribute("class","fa fa-times");
                    ahref_c6.appendChild(i_c6);        
                    ccart_delete.appendChild(ahref_c6);     
                rproduct_record.appendChild(cproduct);    
                rproduct_record.appendChild(cproduct_description);    
                rproduct_record.appendChild(cproduct_price);    
                rproduct_record.appendChild(corderProduct_quentity);    
                rproduct_record.appendChild(ctotal_price);    
                rproduct_record.appendChild(ccart_delete);    
                tbody.appendChild(rproduct_record);
            }
            var txt1=document.createTextNode(" ");
            var txt2=document.createTextNode("Total");
            var txt3=document.createTextNode("$"+totalPrice);
            
            var rtotalReuslt_record = document.createElement('tr');
                var td1=document.createElement('td');
                td1.setAttribute("colspan","4");
                td1.appendChild(txt1);
                var td11=document.createElement('td');
                td11.setAttribute("colspan","2");
                    
                var tabl1=document.createElement('table');
                tabl1.setAttribute("class","table table-condensed total-result");  
                    var tr1 = document.createElement('tr');
                        var td2=document.createElement('td');
                        td2.appendChild(txt2);
                        var td3=document.createElement('td');
                        var span1=document.createElement('span');
                        span1.setAttribute("id","spaneid");
                        span1.appendChild(txt3);    
                        td3.appendChild(span1);    
                    tr1.appendChild(td2);    
                    tr1.appendChild(td3);
               tabl1.appendChild(tr1);
               td11.appendChild(tabl1);
            rtotalReuslt_record.appendChild(td1);
            rtotalReuslt_record.appendChild(td11);
            tbody.appendChild(rtotalReuslt_record);
            var user = $('#user').val();
            console.log("user: " +user+"  "+parseFloat(user)+"  "+parseFloat(totalPrice));
            if(parseFloat(user)>=parseFloat(totalPrice)){
                 console.log("balance "+eval(parseFloat(user)-parseFloat(totalPrice)));
                 checkBalance=true;
            }
        }
  
    var count = document.getElementById("tbody").children.length;
      console.log(" count "+count);
      if(count===0){
         var tbody = document.getElementById("tbody");
         var p_c5=document.createElement('p');
                    p_c5.setAttribute("class","cart_price"); 
                    p_c5.setAttribute("style","padding-top: 10px; padding-right: 30px; padding-bottom: 10px; padding-left: 90px;");
                    p_c5.appendChild(document.createTextNode("NO Product in cart"));
        tbody.appendChild(p_c5);  
      }
    }
  function cartQuantityUp(id,inStock,price){
     var quentity=document.getElementById(id).value;
        quentity++;
        if(quentity<inStock &&inStock !==0){
         AddToCart(id.substring(8, 9),quentity,inStock);
         console.log("in up"+id.substring(8,9));
        document.getElementById("p"+id.substring(8,9)).innerHTML="$"+eval(price*quentity);
        document.getElementById(id).value=quentity;
       totalPrice=eval(totalPrice+price);
       document.getElementById("spaneid").innerHTML ="$"+totalPrice;
  
        }
    }
  function cartQuatityDown(id,inStock,price){
    var quentity=document.getElementById(id).value; 
        quentity--;
        if(quentity>0 &&inStock !==0){
             AddToCart(id.substring(8,9),quentity,inStock);
             console.log("in down"+id.substring(8, 9));
             document.getElementById(id).value=quentity;
             document.getElementById("p"+id.substring(8,9)).innerHTML="$"+eval(price*quentity);
             totalPrice=eval(totalPrice-price);
             document.getElementById("spaneid").innerHTML ="$"+totalPrice;
  
        }
  }
    function deleteRow(row,product_id,price){
      var i=row.parentNode.parentNode.rowIndex;
      console.log("row index "+i+"p "+product_id);
      console.log(" am here in add to cart  ");
      document.getElementById('tbody').deleteRow(i-1);
      romveFromCartFnuction(product_id);  
      var count = document.getElementById("tbody").children.length;
      console.log(" count "+count);
      if(count===0){
         var tbody = document.getElementById("tbody");
            var p_c5=document.createElement('p');
                     p_c5.setAttribute("class","cart_price"); 
                     p_c5.setAttribute("style","padding-top: 10px; padding-right: 30px; padding-bottom: 10px; padding-left: 90px;");
                    
            p_c5.appendChild(document.createTextNode("NO Product in cart"));
        tbody.appendChild(p_c5);  
      }
      totalPrice=eval(totalPrice-price);
     document.getElementById("spaneid").innerHTML ="$"+totalPrice;
  }
  function romveFunCallBack(responseTxt,statusTxt,xhr){
       if(statusTxt==="success"){
           console.log(" success  ");
       }
  }
  function AddToCart(product_id,quentity,inStock){
     if(inStock>= quentity &&inStock !==0 &&checkUserExist()){
        $.get("AddToCart",{"userId":$('#userId').val(),
                        "productId":product_id,        
                        "quentity":quentity    
                       },romveFunCallBack);
      
        }
  }
  function romveFromCartFnuction(product_id){
        $.get("RetrieveFromCart",{"userId":$('#userId').val(),
                               "productId":product_id        
                              },romveFunCallBack);
   }
  function retrieveFromCart(){
     if(checkUserExist()){
        $.post("RetrieveFromCart",{"userId":$('#userId').val()
                                  },submitedfun);
        console.log(" am here in add to cart  ");
    } 
  }
 function shippingOrder(){
  if(checkUserExist()){
        var shipping=document.getElementById("ShippingAdrress").value;
        var city=document.getElementById("city").value;
        var state=document.getElementById("state").value;
        var phone=document.getElementById("phone").value;
        var country=document.getElementById("country").value;
        var zip=document.getElementById("zip").value;    
        if(shipping!==""||city!==""||state!==""||phone!==""||country!==""||zip!=="" &&checkBalance ){
           console.log(" !@!2d to cart  ");
           $.post("ShippingOrder",{"ShippingAdrress":$("#ShippingAdrress").val(),
                                     "city":$("#city").val(),
                                      "state":$("#state").val(),
                                      "phone":$("#phone").val(),
                                      "country":$("#country").val(),
                                      "zip":$("#zip").val(),
                                      "totalPrice":totalPrice
                                   },submitedfun1);
      document.getElementById("ShippingAdrress").value="";
      document.getElementById("city").value="";
      document.getElementById("state").value="";
      document.getElementById("phone").value="";
      document.getElementById("country").value="";
      document.getElementById("zip").value="";    
      console.log(" am here in add to cart  ");
        }
        document.getElementById("tbody").innerHTML="";
        }
   }
  function submitedfun1(responseTxt,statusTxt,xhr){
      if(statusTxt ==="success"){
            console.log(" success ");
        }
  }
</script>
</head><!--/head-->

    <body>
        <!--include the header of the page-->
        <!--todo check if the user is logged-in to retrive the logged in header--> 

        <jsp:include page="header.jsp" />
        <!--end the header of the page-->

        <section id="cart_items">
            <div class="container">
                <div class="breadcrumbs">
                    <ol class="breadcrumb">
                        <li><a href="#">Home</a></li>
                        <li class="active">Check out</li>
                    </ol>
                </div><!--/breadcrums-->

                <div class="step-one">
                    <h2 class="heading">Step1</h2>
                </div>
                <div class="checkout-options">
                    <h3>New User</h3>
                    <p>Checkout options</p>
                    <ul class="nav">
                        <li>
                            <label><input type="checkbox"> Register Account</label>
                        </li>
                        <li>
                            <label><input type="checkbox"> Guest Checkout</label>
                        </li>
                        <li>
                            <a href=""><i class="fa fa-times"></i>Cancel</a>
                        </li>
                    </ul>
                </div><!--/checkout-options-->

                <div class="register-req">
                    <p>Please use Register And Checkout to easily get access to your order history, or use Checkout as Guest</p>
                </div><!--/register-req-->

                <div class="shopper-informations">
                    <div class="row">
                        <div class="col-sm-3">
                            <div class="shopper-info">
                                <p>Shopper Information</p>
                                <form>
                                    <input type="text" placeholder="Display Name">
                                    <input type="text" placeholder="User Name">
                                    <input type="password" placeholder="Password">
                                    <input type="password" placeholder="Confirm password">
                                </form>
                                <a class="btn btn-primary" href="">Get Quotes</a>
                                <a class="btn btn-primary" onclick="shippingOrder();" id="shippingOrder">Continue</a>
                            </div>
                        </div>
                        <div class="col-sm-5 clearfix">
                            <div class="bill-to">
                                <p>Bill To</p>
                                <div class="form-one">
                                    <form>
                                        <input id='user' type='hidden' value='${sessionScope.user.credit}'/>  
                                         <input id='userId' type='hidden' value='${sessionScope.user.id}'/>  
                                        <input type="text" placeholder="Company Name">
                                        <input type="text" placeholder="Email*">
                                        <input type="text" placeholder="Title">
                                        <input type="text" placeholder="First Name *">
                                        <input type="text" placeholder="Middle Name">
                                        <input type="text" placeholder="Last Name *">
                                        <input type="text" placeholder="Address 1 *">
                                        <input type="text" placeholder="Address 2">
                                    </form>
                                </div>
                                <div class="form-two">
                                    <form>
                                        <input type="text" placeholder="Shipping Adrress *" id="ShippingAdrress" required>
                                        <input type="text" placeholder="city *" id="city" required>
                                        <input type="text" placeholder="state" id="state" required>
                                        <input type="text" placeholder="phone *" id="phone" required>
                                        <input type="text" placeholder="country *" id="country" required>
                                        <input type="number" placeholder="Zip *" id="zip" required>
                                    </form>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="order-message">
                                <p>Shipping Order</p>
                                <textarea name="message"  placeholder="Notes about your order, Special Notes for Delivery" rows="16"></textarea>
                                <label><input type="checkbox"> Shipping to bill address</label>
                            </div>	
                        </div>					
                    </div>
                </div>
                <div class="review-payment">
                    <h2>Review & Payment</h2>
                </div>

                <div class="table-responsive cart_info">
                    <table class="table table-condensed">
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
                        </tbody>
                    </table>
                </div>
                <div class="payment-options">
                    <span>
                        <label><input type="checkbox"> Direct Bank Transfer</label>
                    </span>
                    <span>
                        <label><input type="checkbox"> Check Payment</label>
                    </span>
                    <span>
                        <label><input type="checkbox"> Paypal</label>
                    </span>
                </div>
            </div>
        </section> <!--/#cart_items-->


        <!--include the footer of the page-->

        <jsp:include page="footer.jsp" />
        <!--end the footer of the page-->




        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.scrollUp.min.js"></script>
        <script src="js/jquery.prettyPhoto.js"></script>
        <script src="js/main.js"></script>
    </body>
</html>
