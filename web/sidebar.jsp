 <div class="left-sidebar">
                            <h2>Category</h2>
                            <div class="panel-group category-products" id="accordian"><!--category-productsr-->
                                <c:forEach items="${categories}" var="category">
                                    <div class="panel panel-default">
                                        <div class="panel-heading">
                                            <h4 class="panel-title"><a href="Products?category=${category}">${category}</a></h4>
                                        </div>
                                    </div>
                                </c:forEach>
                            </div>
                            <div class="price-range" style="margin-top: 60px;">
                                <h2>Search</h2>
                                <form action="Search" method="POST" style="margin-top: 15px;margin-bottom: 15px;">




                                    <input type="text" placeholder="search by name"  name="searchText" style=" margin: 10px;width: 80%"/>

                                    <select name="category" style=" margin: 10px;width: 80%">
                                        <option value="All">All</option>

                                        <c:forEach items="${categories}" var="cat">
                                            <option value="${cat}">${cat}</option>
                                        </c:forEach>
                                    </select>
                                    <input id="minPrice" type="hidden" name="minPrice" value="250"/>
                                    <input id="maxPrice" type="hidden" name="maxPrice" value="450"/>
                                    <div class="well text-center">
                                        <input type="range" name="price" class="span2" value="" data-slider-min="0" data-slider-max="1000" data-slider-step="5" data-slider-value="[250,450]" id="sl2" ><br />
                                        <b class="pull-left">0 EGP</b> <b class="pull-right">1500 EGP</b>
                                    </div>
                            </div>


                            <div style="text-align: center">
                                <button class="btn btn-warning" type="submit">Search</button>
                            </div>



                            </form>

                            

                        </div>