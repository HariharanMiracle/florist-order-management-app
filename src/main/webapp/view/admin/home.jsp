<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.ResponseDto.AdminDashboardData"%>
<html>
<head>
    <title>Admin Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        AdminDashboardData data = (AdminDashboardData) request.getAttribute("data");
    %>
    <div>
        <nav class="navbar navbar-expand-lg navbar-light bg-light" style="padding: 0px !important; background-color: #ded5d5 !important;">
          <a class="navbar-brand" href="#"><img src=<%=baseUrl + "/landscape-logo.png"%> height="150px" /></a>
          <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
          </button>
          <div class="collapse navbar-collapse" id="navbarNavDropdown">
            <ul class="navbar-nav">
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/admin/home"%>>Home <span class="sr-only">(current)</span></a>
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
                <a class="nav-link" href=<%=baseUrl + "/order/adminDetails"%>>Order Details</a>
              </li>
            </ul>
          </div>
          <div class="text-right mr-5">
            <a class="btn btn-dark" href=<%=baseUrl + "/logout"%>>Logout</a>
          </div>
        </nav>

        <div class="p-5">
            <h1>Statistics</h1>
            <div class="row">
                <div class="col-md-3 p-3">
                    <div class="bg-info p-3" style="border-radius: 5px">
                        <h3 class="text-white">Profit</h3>
                        <hr/>
                        <h6 class="text-white">Current month profit: <%=data.getCurrentProfit() %></h6>
                        <h6 class="text-white">Total profit: <%=data.getAllProfit() %></h6>
                        <h6 class="text-white">Total Orders: <%=data.getAllOrdersCount() %></h6>
                    </div>
                </div>
                <div class="col-md-3 p-3">
                    <div class="bg-success p-3" style="border-radius: 5px">
                        <h3 class="text-white">Completed Orders</h3>
                        <hr/>
                        <h6 class="text-white">Current month profit: <%=data.getCompletedCurrentProfit() %></h6>
                        <h6 class="text-white">Total profit: <%=data.getCompletedAllProfit() %></h6>
                        <h6 class="text-white">Total Orders: <%=data.getCompletedAllOrdersCount() %></h6>
                    </div>
                </div>
                <div class="col-md-3 p-3">
                    <div class="bg-warning p-3" style="border-radius: 5px">
                        <h3 class="text-white">Cancelled Orders</h3>
                        <hr/>
                        <h6 class="text-white">Current month profit: <%=data.getCancelledCurrentProfit() %></h6>
                        <h6 class="text-white">Total profit: <%=data.getCancelledAllProfit() %></h6>
                        <h6 class="text-white">Total Orders: <%=data.getCancelledAllOrdersCount() %></h6>
                    </div>
                </div>
                <div class="col-md-3 p-3">
                    <div class="bg-danger p-3" style="border-radius: 5px">
                        <h3 class="text-white">Unpaid Orders</h3>
                        <hr/>
                        <h6 class="text-white">Current month profit: <%=data.getUnpaidCurrentProfit() %></h6>
                        <h6 class="text-white">Total profit: <%=data.getUnpaidAllProfit() %></h6>
                        <h6 class="text-white">Total Orders: <%=data.getUnpaidAllOrdersCount() %></h6>
                    </div>
                </div>

                <div class="col-md-6">
                    <div id="orderCount"></div>
                </div>
                <div class="col-md-6">
                    <div id="orderMonetary"></div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<script type="text/javascript">

      // Load Charts and the corechart package
      google.charts.load('current', {'packages':['corechart']});

      // Draw the pie chart for count
      google.charts.setOnLoadCallback(drawCountChart);

      // Draw the pie chart for monetary
      google.charts.setOnLoadCallback(drawMonetaryChart);

      // Callback that draws the pie chart for count
      function drawCountChart() {

        // Create the data table for count
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Order Name');
        data.addColumn('number', 'Count');
        data.addRows([
          ['Completed Order', <%=data.getCompletedAllOrdersCount() %>],
          ['Unpaid Order', <%=data.getUnpaidAllOrdersCount() %>],
        ]);

        // Set options for count pie chart
        var options = {title:'Graph on order count',
                       width:400,
                       height:300};

        // Instantiate and draw the chart for count
        var chart = new google.visualization.PieChart(document.getElementById('orderCount'));
        chart.draw(data, options);
      }

      // Callback that draws the pie chart for monetary
      function drawMonetaryChart() {

        // Create the data table for monetary
        var data = new google.visualization.DataTable();
        data.addColumn('string', 'Order Name');
        data.addColumn('number', 'Count');
        data.addRows([
          ['Completed Order', <%=data.getCompletedAllProfit() %>],
          ['Unpaid Order', <%=data.getUnpaidAllProfit() %>],
        ]);

        // Set options for monetary
        var options = {title:'Graph on monetary',
                       width:400,
                       height:300};

        // Instantiate and draw the chart for monetary
        var chart = new google.visualization.PieChart(document.getElementById('orderMonetary'));
        chart.draw(data, options);
      }
</script>