<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="java.util.List"%>
<html>
<head>
    <title>Add Item</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
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
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/admin/home"%>>Home</a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/package/list"%>>Packages</a>
              </li>
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/item/list"%>>Items <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/pacNitem/list"%>>Package & Items</a>
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
            <h5>Add Item</h5>
            <hr/>
            <br/>
            <form method="post" action=<%=baseUrl + "/item/add" %>>
                <div class="form-group">
                    <label for="inputName">Item Name</label>
                    <input type="text" class="form-control" id="name" name="name" placeholder="Enter item name" required>
                </div>
                <div class="form-group">
                    <label for="inputAmount">Amount</label>
                    <input type="text" class="form-control" id="amount" name="amount" placeholder="Enter amount" required>
                </div>
                <button type="submit" class="btn btn-secondary">Save</button>
            </form>
        </div>
    </div>
</body>
</html>