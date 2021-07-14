<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<html>
<head>
    <title>Start</title>
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
                <h5 class="text-white">We provide the best</h5>
                <h5 class="text-white">service in Sri Lanka.</h5>
                <h5 class="text-white">We serve the nation</h5>
                <h5 class="text-white">and our customers</h5>
                <h5 class="text-white">very pleasantly to</h5>
                <h5 class="text-white">keep them better</h5>
                <h5 class="text-white">at any cost !!!</h5>
                <h6 class="text-white"><i>~ beyond the respect</i></h6>
            </div>
            <div class="row p-5">
                <div class="col-6 text-center"><a href=<%= baseUrl + "/login/admin" %> type="button" class="btn btn-secondary">Admin</a></div>
                <div class="col-6 text-center"><a href=<%= baseUrl + "/login/assistant" %> type="button" class="btn btn-secondary">Assistant</a></div>
            </div>
        </div>
    </div>
</body>
</html>