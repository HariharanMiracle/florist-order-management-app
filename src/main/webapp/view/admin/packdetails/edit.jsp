<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Package"%>
<%@ page import="java.util.List"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem" %>
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
        List<Packageitem> itemsInPack = (List<Packageitem>) request.getAttribute("itemsInPack");
        List<Packageitem> itemsNotInPack = (List<Packageitem>) request.getAttribute("itemsNotInPack");
        Package pack = (Package) request.getAttribute("pack");
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
              <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle" href="#" id="navbarDropdownMenuLink" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                  Statistics
                </a>
              </li>
            </ul>
          </div>
        </nav>

        <div class="p-3">
            <h5>Manage Package Details - <b> <%=pack.getName()%> </h5>
            <hr/>
            <br/>

            <div class="row">

                <div class="col-md-1"></div>
                <div class="col-md-4">
                    <div class="border border-primary">
                        <div class="d-flex justify-content-center"><h4>Items in the Package</h4></div>
                        </br>
                        <%
                            for (Packageitem inPack : itemsInPack) {
                        %>
                        <div class="">
                            <input type="checkbox" class="checkbox" id="<%=inPack.getId()%>"
                                   name="<%=inPack.getId()%>">
                            <label class=""><%=inPack.getItemname()%></label>
                        </div>
                        <%
                            }
                        %>
                    </div>
                </div>
                <div class="col-md-2"></div>
                <div class="col-md-4">
                    <div class="border border-warning">
                        <div class="d-flex justify-content-center"><h4>Items not in the Package</h4></div>
                        </br>
                        <%
                            for (Packageitem notInPack : itemsNotInPack) {

                        %>
                        <input type="checkbox" class="checkbox" id="<%=notInPack.getId()%>"
                            name="<%=notInPack.getId()%>">
                        <label class=""><%=notInPack.getItemname()%></label>
                        <br>
                        <%
                            }
                        %>


                    </div>
                </div>

            </div>
        </div>
    </div>
</body>
</html>
