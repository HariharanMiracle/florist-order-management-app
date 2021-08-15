<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Order"%>
<html>
<head>
    <title>Order Details</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
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
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/cancelOrder"%>>Cancel Order</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/order/adminDetails"%>>Order Details <span class="sr-only">(current)</span></a>
              </li>
            </ul>
          </div>
          <div class="text-right mr-5">
            <a class="btn btn-dark" href=<%=baseUrl + "/logout"%>>Logout</a>
          </div>
        </nav>

        <div class="p-5">
            <h1>Order details</h1>
            <hr/>
            <br/>

            <div class="row">
                <div class="ml-5">
                    <form method="post" action=<%=baseUrl + "/order/adminListFilter" %>>
                        <div class="row">
                            <div><input type="text" class="form-control" id="orderNo" name="orderNo" placeholder="Order No"></div>
                            <div><input type="text" class="form-control" id="manualOrderNo" name="manualOrderNo" placeholder="Manual Order No"></div>
                            <div><input type="text" class="form-control" id="name" name="name" placeholder="Name"></div>
                            <div><input type="text" class="form-control" id="nicNo" name="nicNo" placeholder="Nic No"></div>

                            <div><input type="date" class="form-control" id="startDate" name="startDate" placeholder="Start Date"></div>
                            <div><input type="date" class="form-control" id="endDate" name="endDate" placeholder="End Date"></div>

                            <div><button type="submit" class="btn btn-info">Search</button></div>
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
                            double tot = 0;
                            for(Order order : orderList){
                                tot += order.getAmount();
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
                                            <a href=<%= baseUrl + "/order/adminDetail/" + order.getId() %> type="button" class="btn btn-warning">View Order Details</a>
                                            <a href=<%= baseUrl + "/order/printadmin/order/" + order.getId() %> type="button" class="btn btn-info">Print Order</a>
                                            <a href=<%= baseUrl + "/order/printadmin/invoice/" + order.getId() %> type="button" class="btn btn-info">Print Invoice</a>
                                        </td>
                                    </tr>
                                <%
                                i++;
                            }
                        %>
                    </tbody>
                </table>
                <br/>
                <h6>Total Order Amount: <%= tot %></h6>
            </div>
        </div>
    </div>
</body>
</html>