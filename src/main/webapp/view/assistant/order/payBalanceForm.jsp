<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Order"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Orderbill"%>
<html>
<head>
    <title>Pay Balance</title>
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
        double amountToBePaid = (double) request.getAttribute("amountToBePaid");
        double amountPaid = (double) request.getAttribute("amountPaid");
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
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/details"%>>Order Details</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/placeOrder"%>>Place Order</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/order/payBalance"%>>Pay Balance <span class="sr-only">(current)</span></a>
              </li>
            </ul>
          </div>
          <div class="text-right mr-5">
            <a class="btn btn-dark" href=<%=baseUrl + "/logout"%>>Logout</a>
          </div>
        </nav>

        <div class="p-5">
            <h1>Pay Balance</h1>
            <hr/>
            <br/>

            <div class="row">
                        <div class="col-md-3">
                            <h6 class="text-info">AUTO GENERATED ORDER NO</h6>
                            <h5> <%=order.getOrderNo() %> </h5>
                            <br/>

                            <h6 class="text-info">MANUAL ORDER NO</h6>
                            <h5> <%=order.getManualOrderNo() %> </h5>
                            <br/>

                            <h6 class="text-info">ORDER DATE</h6>
                            <h5> <%=order.getOrderDate() %> </h5>

                            <%
                                if(order.getPastDate() == null){
                                    %><h5> <%=order.getOrderDate() %> </h5><%
                                }
                                else{
                                    %><h5> <%=order.getPastDate() %> </h5><%
                                }
                            %>

                            <br/>

                            <h6 class="text-info">TITLE</h6>
                            <h5> <%=order.getTitle() %> </h5>
                        </div>
                        <div class="col-md-3">
                            <h6 class="text-info">NAME</h6>
                            <h5> <%=order.getName() %> </h5>
                            <br/>

                            <h6 class="text-info">ADDRESS</h6>
                            <h5> <%=order.getAddress() %> </h5>
                            <br/>

                            <h6 class="text-info">NIC NO</h6>
                            <h5> <%=order.getNicNo() %> </h5>
                            <br/>

                            <h6 class="text-info">TELEPHONE NO</h6>
                            <h5> <%=order.getTelephoneNo() %> </h5>
                        </div>
                        <div class="col-md-3">
                            <h6 class="text-info">DEAD PERSON NAME</h6>
                            <h5> <%=order.getDeadPersonName() %> </h5>
                            <br/>

                            <h6 class="text-info">FUNERAL DATE</h6>
                            <h5> <%=order.getFuneralDate() %> </h5>
                            <br/>

                            <h6 class="text-info">CEMETERY</h6>
                            <h5> <%=order.getCemetry() %> </h5>
                            <br/>

                            <h6 class="text-info">CREMATION OR BURRIAL</h6>
                            <h5> <%=order.getCremationBurrial() %> </h5>
                            <br/>
                        </div>
                        <div class="col-md-3">
                            <h6 class="text-info">PAY MODE</h6>
                            <h5> <%=order.getPayMode() %> </h5>
                            <br/>

                            <h6 class="text-info">ORDER STATUS</h6>
                            <h5> <%=order.getOrderStatus() %> </h5>
                            <br/>

                            <h6 class="text-info">BILL STATUS</h6>
                            <h5> <%=order.getBillStatus() %> </h5>
                            <br/>
                        </div>
                <div class="col-md-6 mt-5">
                    <h5>Previous Payments</h5>
                    <hr/>
                    <br/>

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
                                int i = 1;

                                for(Orderbill bill : orderbillList){
                                    %>
                                        <tr>
                                            <th scope="row"><%= i %></th>
                                            <td><%= bill.getPayment() %></td>
                                            <td><%= bill.getDate() %></td>
                                            <td><%= bill.getType() %></td>
                                        </tr>
                                    <%
                                    i++;
                                }
                            %>
                        </tbody>
                    </table>
                </div>
                <div class="col-md-6 mt-5">
                    <h5>Payment Form</h5>
                    <hr/>
                    <br/>

                    <input type="hidden" value="<%=amountPaid%>" id="paid"/>
                    <input type="hidden" value="<%=amountToBePaid%>" id="toPay"/>
                    <form method="post" action=<%=baseUrl + "/order/payBalance" %> onsubmit="return validateForm()">
                        <input type="hidden" value="<%=order.getId()%>" id="orderId" name="orderId"/>
                        <div class="form-group">
                            <h5>Amount to be paid: <%=amountToBePaid %></h5>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control" id="balance" name="balance" placeholder="Enter pay balance" required>
                        </div>
                        <button type="submit" class="btn btn-secondary">Pay</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</body>
</html>

<script>
function validateForm() {
  var balance = parseFloat(document.getElementById("balance").value);
  var toPay = parseFloat(document.getElementById("toPay").value);

  if(balance > toPay){
    alert("Balance to be paid should be less than: " + toPay);
    return false;
  }

  return true;
}
</script>