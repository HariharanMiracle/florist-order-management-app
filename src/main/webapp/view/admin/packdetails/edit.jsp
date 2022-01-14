<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Package"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem" %>
<%@ page import="java.util.Set" %>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Packitm" %>
<%@ page import="java.util.HashSet" %>
<html>
<head>
    <title>Package Item Modification</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        List<Packageitem> itemsInPack = (List<Packageitem>) request.getAttribute("itemsInPack");
        List<Packageitem> itemsNotInPack = (List<Packageitem>) request.getAttribute("itemsNotInPack");
        Package pack = (Package) request.getAttribute("pack");
        Set<Integer> newPackItems = new HashSet<>();
    %>
    <div>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding: 0px !important; background-color: #ded5d5 !important;">
          <a class="navbar-brand" href="#"><img src=<%=baseUrl + "/landscape-logo.png"%> height="150px" /></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/admin/home"%>>Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/package/list"%>>Packages</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/item/list"%>>Items</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/pacNitem/list"%>>Package & Items <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/cancelOrder"%>>Cancel Order</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/adminDetails"%>>Order Details</a>
              </li>
            </ul>
          </div>
          <div class="text-right mr-5">
            <a class="btn btn-dark" href=<%=baseUrl + "/logout"%>>Logout</a>
          </div>
        </nav>

        <div class="p-3">
            <h5>Manage Package Details - <b> <%=pack.getName()%> </h5>
            <hr/>
            <br/>

            <div class="row">

                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="border border-primary p-3" style="border-radius: 10px">
                        <div class="d-flex justify-content-center"><h4>Package Items - <%=pack.getName()%></h4></div>
                        </br>
                        <form method="post" action=<%=baseUrl + "/pacNitem/modifyRemove/"+pack.getId() %> >
                        <input type="hidden" id="url2" value="<%=baseUrl + "/pacNitem/modifyRemove/"+pack.getId() %> ">
                        <table class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Item Id</th>
                                    <th scope="col">Item Name</th>
                                    <th scope="col">Amount</th>
                                    <th scope="col">Remove</th>
                                </tr>
                            </thead>

                            <tbody>
                            <%
                                double total = 0;
                                if (!itemsInPack.isEmpty()){
                                    int i = 1;
                                    for (Packageitem inPack : itemsInPack) {

                            %>
                                        <tr>
                                            <th scope="row"><%= i %></th>
                                            <td><%= inPack.getId() %></td>
                                            <td><%= inPack.getItemname() %></td>
                                            <td><%= inPack.getAmount() %></td>
                                            <td><input type="checkbox" class="checkbox" name="removeItems" id="<%=inPack.getId()%>" value="<%=inPack.getId()%>"/></td>
                                        </tr>
                            <%
                                        total+= inPack.getAmount();
                                        i++;
                                    }
                                }else{
                            %>
                            <div class="alert alert-secondary d-flex justify-content-center" role="alert"> Select Items for the package</div>

                            <%
                                }
                            %>
                            </tbody>
                        </table>
                        </form>
                        <div class="alert alert-secondary d-flex justify-content-center" >
                            <h4> Total : <%=total%></h4>
                        </div>

                        <div class="d-flex justify-content-center" >
                            <button id="submit2" type="button" class="btn btn-primary">Remove Items</button>
                        </div>
                    </div>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-4">
                    <div class="border border-warning p-3" style="border-radius: 10px">
                        <div class="d-flex justify-content-center"><h4>Remaining Items</h4></div>
                        </br>
                        <form method="post" action=<%=baseUrl + "/pacNitem/modify/"+pack.getId() %> >
                            <input type="hidden" id="url" value="<%=baseUrl + "/pacNitem/modify/"+pack.getId() %> ">
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Item Id</th>
                                    <th scope="col">Item Name</th>
                                    <th scope="col">Item Amount</th>
                                    <th scope="col">Add</th>
                                </tr>
                                </thead>

                                <tbody>
                                <%
                                    if (itemsNotInPack.isEmpty()){

                                %>
                                <div class="alert alert-warning d-flex justify-content-center" role="alert"> All items included to the package</div>
                                <%  }else {
                                        int i = 1;
                                        for (Packageitem notInPack : itemsNotInPack) {

                                %>
                                    <tr>
                                        <th scope="row"><%= i %></th>
                                        <td><%= notInPack.getId() %></td>
                                        <td><%= notInPack.getItemname() %></td>
                                        <td><%= notInPack.getAmount() %></td>
                                        <td><input type="checkbox" class="checkbox" name="items" id="<%=notInPack.getId()%>" value="<%=notInPack.getId()%>"/></td>
                                    </tr>

                                <%
                                        i++;
                                    }

                                }
                                %>

                                </tbody>
                            </table>
                            <%
                                if (!itemsNotInPack.isEmpty()){

                            %>
                            <div class="d-flex justify-content-center" >
                                <button id="submit" type="button" class="btn btn-primary">Add Items</button>
                            </div>
                            <%
                                }
                            %>
                        </form>


                    </div>
                </div>

            </div>
        </div>
    </div>

</body>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

<script type="text/javascript">
    $('#submit').click(function() {
        var newItemList = [];

            $('input[name=items]').each(function () {
                if ($(this).prop('checked')) {
                    newItemList.push($(this).val())
                }
            });
        if (newItemList.length === 0) {
            alert("Please select at least one item to add!")
        } else {
            $.ajax({
                type: "POST",
                url: $('input#url').val(),
                contentType: 'application/json',
                data: JSON.stringify(newItemList),
                success: function (data) {
                    window.location.reload();
                }, error: function (data) {
                    window.location.reload();
                }
            });

        }
    });

    $('#submit2').click(function() {
            var newItemList = [];

                $('input[name=removeItems]').each(function () {
                    if ($(this).prop('checked')) {
                        newItemList.push($(this).val())
                    }
                });
            if (newItemList.length === 0) {
                alert("Please select at least one item to remove!")
            } else {
                $.ajax({
                    type: "POST",
                    url: $('input#url2').val(),
                    contentType: 'application/json',
                    data: JSON.stringify(newItemList),
                    success: function (data) {
                        window.location.reload();
                    }, error: function (data) {
                        window.location.reload();
                    }
                });

            }
        });
</script>
</html>
