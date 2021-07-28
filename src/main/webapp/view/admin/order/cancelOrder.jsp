<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Order"%>
<html>
<head>
    <title>Cancel Order</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        List<Order> orderList = (List<Order>) request.getAttribute("orderList");
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
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/pacNitem/list"%>>Package & Items</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/order/cancelOrder"%>>Cancel Order <span class="sr-only">(current)</span></a>
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

        <div class="p-5">
            <input type="hidden" id="url1" value="<%=baseUrl + "/order/cancelOrder" %>">
            <input type="hidden" id="url2" value="<%=baseUrl + "/order/revertOrder" %>">

            <h1>Cancel Order</h1>
            <hr/>
            <br/>

            <div class="row">
                <div class="ml-5">
                    <form method="post" action=<%=baseUrl + "/order/listFilterCancelOrder" %>>
                        <div class="row">
                            <div><input type="text" class="form-control" id="orderNo" name="orderNo" placeholder="Order No"></div>
                            <div><input type="text" class="form-control" id="manualOrderNo" name="manualOrderNo" placeholder="Manual Order No"></div>
                            <div><input type="text" class="form-control" id="name" name="name" placeholder="Name"></div>
                            <div><input type="text" class="form-control" id="nicNo" name="nicNo" placeholder="Nic No"></div>
                            <div>&nbsp;&nbsp;&nbsp;<button type="submit" class="btn btn-info">Search</button></div>
                            <div>&nbsp;&nbsp;&nbsp;<button class="btn btn-info" onclick="location.reload()">Reload</button></div>
                        </div>
                    </form>
                </div>
            </div

            <div class="row">
                <table class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Auto-Generated Id</th>
                            <th scope="col">Manual Order Id</th>
                            <th scope="col">Order Date</th>
                            <th scope="col">Order Person Name</th>
                            <th scope="col">NIC No</th>
                            <th scope="col">Telephone No</th>
                            <th scope="col">Order Status</th>
                            <th scope="col">Bill Status</th>
                            <th scope="col">Total Amount</th>
                            <th scope="col">Operations</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int i = 1;

                            for(Order order : orderList){
                                %>
                                    <tr>
                                        <th scope="row"><%= i %></th>
                                        <td><%= order.getOrderNo() %></td>
                                        <td><%= order.getManualOrderNo() %></td>
                                        <td><%= order.getOrderDate() %></td>
                                        <td><%= order.getName() %></td>
                                        <td><%= order.getNicNo() %></td>
                                        <td><%= order.getTelephoneNo() %></td>
                                        <%
                                            if(order.getOrderStatus().equals("PROCESSING")){
                                                %><td class="bg-danger text-white">PROCESSING</td><%
                                            }
                                            else if(order.getOrderStatus().equals("COMPLETED")){
                                                %><td class="bg-light">COMPLETED</td><%
                                            }
                                            else{
                                                %><td class="bg-success text-white">CANCELLED</td><%
                                            }
                                        %>
                                        <%
                                            if(order.getBillStatus().equals("PAID")){
                                                %><td class="bg-light">PAID</td><%
                                            }
                                            else{
                                                %><td class="bg-danger text-white">UN PAID</td><%
                                            }
                                        %>
                                        <td><%= order.getAmount() %></td>
                                        <td>
                                            <%
                                                if(order.getOrderStatus().equals("PROCESSING")){
                                                    %>
                                                        <button class="btn btn-warning" onclick="cancelOrder(<%= order.getId() %>)">Cancel Order</button>
                                                    <%
                                                }
                                                else if(order.getOrderStatus().equals("CANCELLED")){
                                                    %>
                                                        <button class="btn btn-warning" onclick="revertOrder(<%= order.getId() %>)">Revert Order</button>
                                                    <%
                                                }
                                                else{
                                                    %>
                                                        <p class="text-danger">You can only cancel processing order</p>
                                                    <%
                                                }
                                            %>

                                        </td>
                                    </tr>
                                <%
                                i++;
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
<script>
    function cancelOrder(id) {
      var r = confirm("Do you want to cancel this order?");
      if (r == true) {
        var url = $('input#url1').val() + "/" + id;
        const xhttp = new XMLHttpRequest();
        xhttp.open("GET", url);
        xhttp.send();
      } else {
        alert("Order not cancelled !!!");
      }
    }

    function revertOrder(id) {
      var r = confirm("Do you want to revert this order?");
      if (r == true) {
        var url = $('input#url2').val() + "/" + id;
        const xhttp = new XMLHttpRequest();
        xhttp.open("GET", url);
        xhttp.send();
      } else {
        alert("Order not reverted !!!");
      }
    }
</script>