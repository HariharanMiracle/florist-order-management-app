<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Order"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Orderbill"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem"%>
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

        Order order = (Order) request.getAttribute("order");
        List<Orderbill> orderbillList = (List<Orderbill>) request.getAttribute("orderbillList");
        List<Orderitem> orderitemList = (List<Orderitem>) request.getAttribute("orderItemList");
        String aPackage = (String) request.getAttribute("package");
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
                <a class="nav-link" href=<%=baseUrl + "/assistant/home"%>>Home</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/order/details"%>>Order Details <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/placeOrder"%>>Place Order</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/payBalance"%>>Pay Balance</a>
              </li>
            </ul>
          </div>
          <div class="text-right mr-5">
            <a class="btn btn-dark" href=<%=baseUrl + "/logout"%>>Logout</a>
          </div>
        </nav>

        <div class="p-5">
            <h1>Details</h1>
            <hr/>
            <br/>

            <div class="row">
                <div class="col-md-12 p-3">
                    <h3>Order Detail</h3>
                    <hr/>
                    <br/>

                    <div class="row">
                        <div class="col-md-6 p-2">
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">1</th>
                                        <td>AUTO GENERATED ORDER NO</td>
                                        <td><%=order.getOrderNo() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">2</th>
                                        <td>MANUAL ORDER NO</td>
                                        <td><%=order.getManualOrderNo() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">3</th>
                                        <td>ORDER DATE</td>
                                        <td><%=order.getOrderDate() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">4</th>
                                        <td>NAME</td>
                                        <td><%=order.getTitle() + ' ' + order.getName() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">5</th>
                                        <td>ADDRESS</td>
                                        <td><%=order.getAddress() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">6</th>
                                        <td>RELIGION</td>
                                        <td><%=order.getReligion() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">7</th>
                                        <td>NIC NO</td>
                                        <td><%=order.getNicNo() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">8</th>
                                        <td>TELEPHONE NO</td>
                                        <td><%=order.getTelephoneNo() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">9</th>
                                        <td>DEAD PERSON NAME</td>
                                        <td><%=order.getDeadPersonName() %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-md-6 p-2">
                            <table class="table table-striped table-bordered" style="width:100%">
                                <thead>
                                    <tr>
                                        <th scope="col">#</th>
                                        <th scope="col">Name</th>
                                        <th scope="col">Value</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <tr>
                                        <th scope="row">10</th>
                                        <td>FUNERAL DATE</td>
                                        <td><%=order.getFuneralDate() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">11</th>
                                        <td>CEMETERY</td>
                                        <td><%=order.getCemetry() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">12</th>
                                        <td>CREMATION OR BURRIAL</td>
                                        <td><%=order.getCremationBurrial() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">13</th>
                                        <td>BILL TO</td>
                                        <td><%=order.getBillTo() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">14</th>
                                        <td>PACKAGE</td>
                                        <td><%=aPackage %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">15</th>
                                        <td>PAY MODE</td>
                                        <td><%=order.getPayMode() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">16</th>
                                        <td>ORDER STATUS</td>
                                        <td><%=order.getOrderStatus() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">17</th>
                                        <td>BILL STATUS</td>
                                        <td><%=order.getBillStatus() %></td>
                                    </tr>
                                    <tr>
                                        <th scope="row">18</th>
                                        <td>AMOUNT</td>
                                        <td><%=order.getAmount() %></td>
                                    </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>
                <div class="col-md-6 p-3">
                    <h3>Order Item details</h3>
                    <hr/>
                    <br/>

                    <table class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Item Name</th>
                                <th scope="col">Actual Amount</th>
                                <th scope="col">Adjusted Amount</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                int i = 1;

                                for(Orderitem item : orderitemList){
                                    %>
                                        <tr>
                                            <th scope="row"><%= i %></th>
                                            <td><%= item.getName() %></td>
                                            <td><%= item.getActualAmount() %></td>
                                            <td><%= item.getAdjustedAmount() %></td>
                                        </tr>
                                    <%
                                    i++;
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6 p-3">
                    <h3>Order Bill Details</h3>
                    <hr/>
                    <br/>

                    <% double amnt = 0; %>
                    <table class="table table-striped table-bordered" style="width:100%">
                        <thead>
                            <tr>
                                <th scope="col">#</th>
                                <th scope="col">Amount Paid</th>
                                <th scope="col">Paid Date</th>
                                <th scope="col">Payment Type</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                i = 1;

                                for(Orderbill bill : orderbillList){
                                    %>
                                        <tr>
                                            <th scope="row"><%= i %></th>
                                            <td><%= bill.getPayment() %></td>
                                            <td><%= bill.getDate() %></td>
                                            <td><%= bill.getType() %></td>
                                        </tr>
                                    <%
                                    amnt += bill.getPayment();
                                    i++;
                                }
                            %>
                        </tbody>
                    </table>
                    <div class="row">
                        <div class="col-md-6">
                            <h6 class="text-info">BALANCE AMOUNT</h6>
                            <h5><%= order.getAmount() - amnt %></h5>
                        </div>
                        <div class="col-md-6">
                            <h6 class="text-info">PAID AMOUNT</h6>
                            <h5><%= amnt %></h5>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>