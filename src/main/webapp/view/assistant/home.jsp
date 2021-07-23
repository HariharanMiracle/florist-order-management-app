<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.ResponseDto.AdminDashboardData"%>
<html>
<head>
    <title>Assistant Home</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
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
                <a class="nav-link" href=<%=baseUrl + "/assistant/home"%>>Home <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/details"%>>Order Details</a>
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

        <div class="p-5 text-center">
            <img src=<%=baseUrl + "/solid-logo.png"%> height="300px" />
            <h1>WELCOME TO</h1>
            <h1 class="text-info">BORALESGAMUWA</h1>
            <h1>FLORISTS</h1>
        </div>
    </div>
</body>
</html>