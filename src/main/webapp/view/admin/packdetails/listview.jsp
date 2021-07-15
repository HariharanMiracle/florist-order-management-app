<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Package"%>
<%@ page import="java.util.List"%>
<html>
<head>
    <title>List Package</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        List<Package> packageList = (List<Package>) request.getAttribute("packageList");
    %>
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
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Statistics
                </a>
                <div class="dropdown-menu" aria-labelledby="navbarDropdownMenuLink">
                  <a class="dropdown-item" href=<%=baseUrl + "/statistics/all/orders"%>>All Orders</a>
                  <a class="dropdown-item" href=<%=baseUrl + "/statistics/paid/orders"%>>Paid Orders</a>
                  <a class="dropdown-item" href=<%=baseUrl + "/statistics/unpaid/orders"%>>Unpaid Orders</a>
                  <a class="dropdown-item" href=<%=baseUrl + "/statistics/cancelled/orders"%>Cancelled Orders</a>
                  <a class="dropdown-item" href=<%=baseUrl + "/report"%>>Report</a>
                </div>
              </li>
            </ul>
          </div>
    </nav>

        <div class="p-3">
            <h5>Package Details</h5>
            <hr/>
            <br/>

            <div class="row">
                <div class="ml-5">
                    <form method="post" action=<%=baseUrl + "/pacNitem/search" %>>
                        <div class="row">
                            <div><input type="text" class="form-control" id="name" name="name" placeholder="Search..."></div>
                            <div><button type="submit" class="btn btn-info">Search</button></div>
                        </div>
                    </form>
                </div>
            </div

            <%
                if(packageList.size() == 0){
                    %>
                    <div class="row p-5">
                        <div class="col-md-12 bg-warning text-center p-3" style="border-radius: 10px"> <h5 class="text-danger">No record exists</h5> </div>
                    </div>
                    <%
                }
                else{
                    %>
                    <div class="p-5">
                        <table class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Package Name</th>
                                    <th scope="col">Amount</th>
                                    <th scope="col">Operations</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                int i = 1;

                                for(Package pkg : packageList){
                                    %>
                                    <tr>
                                        <th scope="row"><%= i %></th>
                                        <td><%= pkg.getName() %></td>
                                        <td><%= pkg.getAmount() %></td>
                                        <td>
                                            <a href=<%= baseUrl + "/pacNitem/list/" + pkg.getId() %> type="button" class="btn btn-success">View & Add Items</a>
                                        </td>
                                    </tr>
                                    <%
                                    i++;
                                }
                                %>
                            </tbody>
                        </table>
                    </div>
                    <%
                }
            %>
        </div>
</body>
</html>