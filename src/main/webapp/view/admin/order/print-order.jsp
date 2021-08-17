<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.*"%>
<html>
<head>
    <title>Print Order</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        List<Orderitem> orderitemList = (List<Orderitem>) request.getAttribute("orderitemList");
        Order order = (Order) request.getAttribute("order");
        String currentDate = (String) request.getAttribute("currentDate");
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
            <div class="row" id="hide">
                <div class="col-md-12">
                    <div class="float-right">
                        <button class="btn btn-info" onclick="printDiv()">Print</button>
                    </div>
                </div>
            </div>

            <div id="print-view">
                <div class="row p-3">
                    <div class="col-md-1">
                        <div class="float-right">
                            <img src=<%=baseUrl + "/solid-logo.png"%> height="100px" />
                        </div>
                    </div>

                    <div class="col-md-5">
                        <div class="float-left mt-2">
                            <h4>BORALESGAMUWA FLORISTS</h4>
                            <p>52, Dehiwala road,<br/>Boralesgamuwa.</p>
                        </div>
                    </div>

                    <div class="col-md-6">
                        <div class="float-right">
                            <h4 style="color: #e8bb1a">Order</h4>
                            <p><%= order.getManualOrderNo() %></p>
                        </div>
                    </div>
                </div>

                <br/>

                <div class="p-3">
                    <h5 style="color: #e8bb1a"><b>Bill To:</b></h5>
                    <p><%= order.getBillTo() %></p>
                </div>

                <br/>

                <div class="row p-3">
                    <div class="col-md-2">
                        <h5 style="color: #e8bb1a">Invoice Date</h5>
                        <p><%= currentDate %></p>
                    </div>

                    <div class="col-md-3">
                        <h5 style="color: #e8bb1a">Customer Name</h5>
                        <p><%= order.getTitle() + " " + order.getName() %></p>
                    </div>

                    <div class="col-md-2">
                        <h5 style="color: #e8bb1a">Order No</h5>
                        <p><%= order.getOrderNo() %></p>
                    </div>

                    <div class="col-md-3">
                        <h5 style="color: #e8bb1a">Manual Order No</h5>
                        <p><%= order.getManualOrderNo() %></p>
                    </div>

                    <div class="col-md-2">
                        <h5 style="color: #e8bb1a">NIC No</h5>
                        <p><%= order.getNicNo() %></p>
                    </div>
                </div>

                <br/>

                <table class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th scope="col" style="color: #e8bb1a">No</th>
                            <th scope="col" style="color: #e8bb1a">Description</th>
                            <th scope="col" style="color: #e8bb1a">Amount</th>
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
                                    <td><%= item.getAdjustedAmount() %></td>
                                </tr>
                            <%
                                i++;
                            }
                        %>
                        <tr>
                            <td></td>
                            <td style="color: #e8bb1a"><b>Total</b></td>
                            <td style="color: #e8bb1a"><b><%= order.getAmount() %></b></td>
                        </tr>
                    </tbody>
                </table>

                <br/>

                <div class="row">
                    <div class="col-md-6 text-center">
                        <p>..................................................................</p>
                        <p>Authorized By</p>
                    </div>
                    <div class="col-md-6 text-center">
                        <p>..................................................................</p>
                        <p>Customer Signature</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script>
    function printDiv(){
        document.getElementById("hide").style.visibility = "hidden";
        window.print();
    }
</script>