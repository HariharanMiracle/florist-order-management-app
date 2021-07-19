<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Package"%>
<%@ page import="java.util.List"%>
<html>
<head>
    <title>Place Order</title>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css" integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.2.1.slim.min.js" integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN" crossorigin="anonymous"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js" integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q" crossorigin="anonymous"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js" integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl" crossorigin="anonymous"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
</head>
<body class="bg-light">
    <%
        final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
        List<Package> packageList = (List<Package>) request.getAttribute("packageList");
    %>
    <input type="hidden" id="url1" value="<%= baseUrl %>"/>
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
              <li class="nav-item active">
                <a class="nav-link" href=<%=baseUrl + "/order/placeOrder"%>>Place Order <span class="sr-only">(current)</span></a>
              </li>
              <li class="nav-item">
                <a class="nav-link" href=<%=baseUrl + "/order/cancelOrder"%>>Cancel Order</a>
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
            <h1>Place Order</h1>
            <hr/>
            <br/>

            <div class="p-3">
                <div class="row">
                    <div class="col-md-3">
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="manualOrderNo" name="manualOrderNo" placeholder="Enter Manual Order No" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="title" name="title" placeholder="Enter Title" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="name" name="name" placeholder="Enter Name" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="address" name="address" placeholder="Enter Address" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="religion" name="religion" placeholder="Enter Religion" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="nicNo" name="nicNo" minlength="10" maxlength="12" placeholder="Enter Nic No" required>
                        </div>
                        <div class="form-group">
                            <input type="tel" class="form-control placeOrderFields" id="telephoneNo" maxlength="10" minlength="10" name="telephoneNo" placeholder="Enter Telephone No" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="deadPersonName" name="deadPersonName" placeholder="Enter Dead Person Name" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <input type="date" class="form-control placeOrderFields" id="funeralDate" name="funeralDate" placeholder="Enter Funeral Date" required>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="cemetry" name="cemetry" placeholder="Enter Cemetery" required>
                        </div>
                        <div class="form-group">
                            <select id="cremationBurrial" name="cremationBurrial" class="form-control">
                                <option value="CREMATION">CREMATION</option>
                                <option value="BURRIAL">BURRIAL</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="text" class="form-control placeOrderFields" id="billTo" name="billTo" placeholder="Enter Bill To" required>
                        </div>
                    </div>
                    <div class="col-md-3">
                        <div class="form-group">
                            <select id="payMode" name="payMode" class="form-control">
                                <option value="CREDIT">CREDIT</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control placeOrderFields" id="advance" name="advance" placeholder="Enter payment advance" required>
                        </div>
                        <div class="form-group">
                            <input type="number" class="form-control placeOrderFields" id="balance" name="balance" placeholder="Enter payment balance" required>
                        </div>
                    </div>
                </div>
            </div>
            <div class="p-3">
                <h1>Package Selection</h1>
                <hr/>
                <br/>

                <div class="row">
                    <div class="col-md-3">
                        <select id="packageId" name="packageId" class="form-control" onchange="getOrderItems(this.value)">
                            <option value="0">Choose...</option>
                            <%
                                for(Package pkg : packageList){
                                    %><option value="<%= pkg.getId() %>"><%= pkg.getName() %></option><%
                                }
                            %>
                        </select>
                    </div>
                    <div class="col-md-9">
                        <div id="items">

                        </div>
                        <br/>
                        <button class="btn btn-info" onclick="CmdPlaceOrder()">Place Order</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="url" value="<%=baseUrl %>/order/getOrderItems/" />
</body>
</html>

<script type="text/javascript">
    function getOrderItems(id){
        var url =  $('input#url').val() + id;
        const xhttp = new XMLHttpRequest();
        xhttp.onreadystatechange = function() {
            if (xhttp.readyState == XMLHttpRequest.DONE) {
                document.getElementById("items").innerHTML = xhttp.responseText;
            }
        }
        xhttp.open("GET", url);
        xhttp.send();
    }

    function CmdPlaceOrder()
    {
        let manualOrderNo = $('#manualOrderNo').val();
        let title = $('#title').val();
        let name = $('#name').val();
        let address = $('#address').val();
        let religion = $('#religion').val();
        let nicNo = $('#nicNo').val();
        let telephoneNo = $('#telephoneNo').val();
        let deadPersonName = $('#deadPersonName').val();
        let funeralDate = $('#funeralDate').val();
        let cemetry = $('#cemetry').val();
        let cremationBurrial = $('#cremationBurrial').val();
        let billTo = $('#billTo').val();
        let payMode = $('#payMode').val();
        let advance = $('#advance').val();
        let balance = $('#balance').val();
        let packageId = $('#packageId').val();

        let DomElmItemId = document.querySelectorAll('.ItemId');
        let DomElmItemActAmount = document.querySelectorAll('.ItemActValue');
        let DomElmItemAdjAmount = document.querySelectorAll('.ItemAdjValue');
        let Item = [];

        for(let i = 0; i<DomElmItemId.length; i++)
        {
            let AdjValue = (DomElmItemAdjAmount[i].value<0 || DomElmItemAdjAmount[i].value==null || DomElmItemAdjAmount[i].value==="")?DomElmItemActAmount[i].value:DomElmItemAdjAmount[i].value;
            Item.push([DomElmItemId[i].value,AdjValue])
        }

        let Entity = new Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,billTo,payMode,advance,balance,packageId,Item);

        (IsFieldsEmpty(".placeOrderFields"))?PlaceOrder(Entity):alert("Mandatory Fields cannot Be Empty");
    }

    function Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,billTo,payMode,advance,balance,packageId,Item)
    {
        this.manualOrderNo = manualOrderNo;
        this.title = title;
        this.name = name;
        this.address = address;
        this.religion = religion;
        this.nicNo = nicNo;
        this.telephoneNo = telephoneNo;
        this.deadPersonName = deadPersonName;
        this.funeralDate = funeralDate;
        this.cemetry = cemetry;
        this.cremationBurrial = cremationBurrial;
        this.billTo = billTo;
        this.payMode = payMode;
        this.advance = advance;
        this.balance = balance;
        this.packageId = packageId;
        this.Item = Item;
    }

    function PlaceOrder(Entity)
    {
        // console.log(Entity);
        $.ajax({
            type: "POST",
            url: "placeOrder",
            contentType: "application/json",
            data: JSON.stringify(Entity),
            success: SuccessPlaceOrder
        });
    }

    function SuccessPlaceOrder(Response)
    {
        console.log(Response)
        location.reload();
        alert(document.getElementById("url1").value + "/order/details");
        window.location.href = document.getElementById("url1").value + "/order/details";
    }

    function IsFieldsEmpty(ClassName)
    {
        let Fields = document.querySelectorAll(ClassName);
        for (let i=0; i<Fields.length; i++)
        {
            if(Fields[i].value==="" || Fields[i].value===null || Fields[i].value===" ")
                return false;
        }
        return true;
    }

</script>