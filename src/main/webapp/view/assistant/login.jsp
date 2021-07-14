<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<html>
<head>
    <title>Assistant Login</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
</head>
<body>
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
    %>
    <div class="row">
        <div class="col-md-8 p-3 text-center" style="background-color:#ded5d5">
            <img src=<%=baseUrl + "/hollow-logo.png"%> height="" width="90%"/>
        </div>
        <div class="col-md-4 bg-info p-5">
            <div class="mt-5">
                <h1 class="text-white">WELCOME TO</h1>
                <h3><b>BORALESGAMUWA</b></h3>
                <h3><b>FLORISTS</b></h3>
            </div>
            <div class="p-5 text-center">


                <h5 class="text-white">Assistant Login</h5>
                <form method="post" action=<%=baseUrl + "/login/assistant" %>>
                  <div class="form-group">
                    <label for="inputUsername">Username</label>
                    <input type="text" class="form-control" id="username" name="username" placeholder="Enter username" required>
                  </div>
                  <div class="form-group">
                    <label for="inputPassword">Password</label>
                    <input type="password" class="form-control" id="password" name="password" placeholder="Password" required>
                  </div>
                  <button type="submit" class="btn btn-secondary">Login</button>
                </form>
            </div>
            <div class="row p-5">
                <div class="col-12 text-center"><a href=<%= baseUrl + "/" %> type="button" class="btn btn-secondary">Home</a></div>
            </div>


        </div>
    </div>
</body>
</html>