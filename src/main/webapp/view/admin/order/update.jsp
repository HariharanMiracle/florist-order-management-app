<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="org.springframework.web.servlet.support.ServletUriComponentsBuilder"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Package"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Order"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem"%>
<%@ page import="java.util.List"%>
<html>
<head>
    <title>Order Details</title>
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
        List<Orderitem> orderitemList = (List<Orderitem>) request.getAttribute("orderitemList");

        Order order = (Order) request.getAttribute("order");
        Package oldPackage = (Package) request.getAttribute("oldPackage");

        double advance = Double.parseDouble(request.getAttribute("advance") + "");
        double notAdvance = Double.parseDouble(request.getAttribute("notAdvance") + "");

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
            <h1>Place Order</h1>
            <hr/>
            <br/>

            <div class="p-3">
                <div class="row">
                    <div class="col-md-6">
                        <table class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <input type="hidden" class="form-control placeOrderFields" id="id" name="id" value="<%= order.getId() %>">
                                <input type="hidden" class="form-control placeOrderFields" id="orderDate" name="orderDate" value="<%= order.getOrderDate() %>">

                                <input type="hidden" class="form-control placeOrderFields" id="amount" name="amount" value="<%= order.getAmount() %>">
                                <input type="hidden" class="form-control placeOrderFields" id="billStatus" name="billStatus" value="<%= order.getBillStatus() %>">
                                <input type="hidden" class="form-control placeOrderFields" id="orderStatus" name="orderStatus" value="<%= order.getOrderStatus() %>">

                                <input type="hidden" class="form-control" id="advanceView" value="<%= advance %>">
                                <input type="hidden" class="form-control" id="notAdvanceView" value="<%= notAdvance %>">
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Auto-generated Number</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="orderNo" name="orderNo" value="<%= order.getOrderNo() %>" readOnly></td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Manual Order No</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="manualOrderNo" name="manualOrderNo" placeholder="Enter Manual Order No" value="<%= order.getManualOrderNo() %>" readOnly></td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Title</td>
                                    <td>
                                        <select id="title" name="title" class="form-control">
                                            <%
                                                if(order.getTitle().equals("MR"))
                                                    %><option value="MR" selected>MR</option><%
                                                else
                                                    %><option value="MR">MR</option><%

                                                if(order.getTitle().equals("MRS"))
                                                    %><option value="MRS" selected>MRS</option><%
                                                else
                                                    %><option value="MRS">MRS</option><%

                                                if(order.getTitle().equals("Master"))
                                                    %><option value="Master" selected>Master</option><%
                                                else
                                                    %><option value="Master">Master</option><%

                                                if(order.getTitle().equals("Miss"))
                                                    %><option value="Miss" selected>Miss</option><%
                                                else
                                                    %><option value="Miss">Miss</option><%

                                                if(order.getTitle().equals("Ven"))
                                                    %><option value="Ven" selected>Ven</option><%
                                                else
                                                    %><option value="Ven">Ven</option><%
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Name</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="name" name="name" value="<%= order.getName() %>" placeholder="Enter Name" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Address</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="address" name="address" value="<%= order.getAddress() %>" placeholder="Enter Address" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Religion</td>
                                    <td>
                                        <select id="religion" name="religion" class="form-control">
                                            <%
                                                if(order.getReligion().equals("Buddhist"))
                                                    %><option value="Buddhist" selected>Buddhist</option><%
                                                else
                                                    %><option value="Buddhist">Buddhist</option><%

                                                if(order.getReligion().equals("Hindu"))
                                                    %><option value="Hindu" selected>Hindu</option><%
                                                else
                                                    %><option value="Hindu">Hindu</option><%

                                                if(order.getReligion().equals("Roman Catholic"))
                                                    %><option value="Roman Catholic" selected>Roman Catholic</option><%
                                                else
                                                    %><option value="Roman Catholic">Roman Catholic</option><%

                                                if(order.getReligion().equals("Non Roman Catholic"))
                                                    %><option value="Non Roman Catholic" selected>Non Roman Catholic</option><%
                                                else
                                                    %><option value="Non Roman Catholic">Non Roman Catholic</option><%

                                                if(order.getReligion().equals("Other"))
                                                    %><option value="Other" selected>Other</option><%
                                                else
                                                    %><option value="Other">Other</option><%
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">7</th>
                                    <td>Nic No</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="nicNo" name="nicNo" minlength="10" maxlength="12" value="<%= order.getNicNo() %>" placeholder="Enter Nic No" required></td>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                    <div class="col-md-6">
                        <table class="table table-striped table-bordered" style="width:100%">
                            <thead>
                                <tr>
                                    <th scope="col">#</th>
                                    <th scope="col">Name</th>
                                    <th scope="col">Value</th>
                                </tr>
                            </thead>
                            <tbody>
                                <tr>
                                    <th scope="row">1</th>
                                    <td>Telephone No</td>
                                    <td><input type="tel" class="form-control placeOrderFields" id="telephoneNo" maxlength="10" minlength="10" name="telephoneNo" value="<%= order.getTelephoneNo() %>" placeholder="Enter Telephone No" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Dead Person Name</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="deadPersonName" name="deadPersonName" value="<%= order.getDeadPersonName() %>" placeholder="Enter Dead Person Name" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Funeral Date</td>
                                    <td><input type="date" class="form-control placeOrderFields" id="funeralDate" name="funeralDate" value="<%= order.getFuneralDate() %>" placeholder="Enter Funeral Date" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Cemetery</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="cemetry" name="cemetry" value="<%= order.getCemetry() %>" placeholder="Enter Cemetery" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Cremation / Burrial</td>
                                    <td>
                                        <select id="cremationBurrial" name="cremationBurrial" class="form-control">
                                            <%
                                                if(order.getReligion().equals("CREMATION"))
                                                    %><option value="CREMATION" selected>CREMATION</option><%
                                                else
                                                    %><option value="CREMATION">CREMATION</option><%

                                                if(order.getReligion().equals("BURRIAL"))
                                                    %><option value="BURRIAL" selected>BURIAL</option><%
                                                else
                                                    %><option value="BURRIAL">BURIAL</option><%
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Pay Mode</td>
                                    <td>
                                        <select id="payMode" name="payMode" class="form-control">
                                            <%
                                                if(order.getReligion().equals("CREDIT"))
                                                    %><option value="CREDIT" selected>CREDIT</option><%
                                                else
                                                    %><option value="CREDIT">CREDIT</option><%

                                                if(order.getReligion().equals("CARD"))
                                                    %><option value="CARD" selected>CARD</option><%
                                                else
                                                    %><option value="CARD">CARD</option><%
                                            %>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">7</th>
                                    <td>Past Date</td>
                                    <%
                                        if(order.getPastDate() == null){
                                            %><td><input type="date" class="form-control" id="pastDate" name="pastDate" placeholder="Enter Past Date"></td><%
                                        }
                                        else{
                                            %><td><input type="date" class="form-control" id="pastDate" name="pastDate" value="<%= order.getPastDate() %>" placeholder="Enter Past Date"></td><%
                                        }
                                    %>
                                </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>


            <div class="p-3">
                <h1>Package Name: <span><%=oldPackage.getName()%></span> | Old package list</h1>
                <hr/>
                <br/>

                <table class="table table-striped table-bordered" style="width:100%">
                    <thead>
                        <tr>
                            <th scope="col">#</th>
                            <th scope="col">Item Name</th>
                            <th scope="col">Actual Amount</th>
                            <th scope="col">Adjusted Amount</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            int cc = 1;
                            for(Orderitem orderItem: orderitemList){
                                %>
                                    <tr>
                                        <th scope="row"><%=cc %></th>
                                        <td><%=orderItem.getName()%></td>
                                        <td><%=orderItem.getActualAmount()%></td>
                                        <td><%=orderItem.getAdjustedAmount()%></td>
                                    </tr>
                                <%
                                cc++;
                            }
                        %>
                    <tbody>
                </table>
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
                        <button class="btn btn-info" onclick="CmdPlaceOrder()">Update Order</button>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <input type="hidden" id="url" value="<%=baseUrl %>/order/adminGetOrderItems/" />
    <input type="hidden" id="urlPost" value="<%=baseUrl %>/order/adminUpdateOrder" />
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

    function addAdvanceAndNotAdvance(){
        var adv = document.getElementById("advanceView").value;
        var notAdv = document.getElementById("notAdvanceView").value;

        document.getElementById("advance").value = adv;
        document.getElementById("notAdvance").value = notAdv;

        var advance = parseFloat(adv);
		var notAdvance = parseFloat(notAdv);
		var totalPrice = parseFloat(document.getElementById("totalPrice").innerHTML);
        if(advance == null || advance === undefined || Number.isNaN(advance)){
            document.getElementById("balance_display").innerHTML = totalPrice;
        }
        else{
            var bal = totalPrice - (advance + notAdvance);
            if(bal < 0){
                alert("Advance cannot be greater than balance");
                document.getElementById("balance_display").innerHTML = totalPrice;
                document.getElementById("advance").value = ""
                document.getElementById("notAdvance").value = ""
            }
            else{
                document.getElementById("balance_display").innerHTML = bal;
            }
        }
    }

    function CmdPlaceOrder()
    {
        console.log("CmdPlaceOrder");
        let id = $('#id').val();
        let orderNo = $('#orderNo').val();
        let orderDate = $('#orderDate').val();
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
        let payMode = $('#payMode').val();
        let advance = $('#advance').val();
        let notAdvance = $('#notAdvance').val();
        let packageId = $('#packageId').val();
        let pastDate = $('#pastDate').val();
        let amount = $('#amount').val();
        let billStatus = $('#billStatus').val();
        let orderStatus = $('#orderStatus').val();
        console.log("CmdPlaceOrder2");

        let DomElmItemId = document.querySelectorAll('.ItemId');
        let DomElmItemActAmount = document.querySelectorAll('.ItemActValue');
        let DomElmItemAdjAmount = document.querySelectorAll('.ItemAdjValue');
        let Item = [];
        console.log("CmdPlaceOrder3");

        for(let i = 0; i<DomElmItemId.length; i++)
        {
            let AdjValue = (DomElmItemAdjAmount[i].value<0 || DomElmItemAdjAmount[i].value==null || DomElmItemAdjAmount[i].value==="")?DomElmItemActAmount[i].value:DomElmItemAdjAmount[i].value;
            Item.push([DomElmItemId[i].value,AdjValue])
        }
        console.log("CmdPlaceOrder4");

        let Entity = new Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,payMode,advance,packageId,Item,pastDate,id,orderNo,orderDate,amount,billStatus,orderStatus,notAdvance);
        console.log("CmdPlaceOrder5");

        (IsFieldsEmpty(".placeOrderFields"))?PlaceOrder(Entity):alert("Mandatory Fields cannot Be Empty");
        console.log("CmdPlaceOrder6");
    }

    function Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,payMode,advance,packageId,Item,pastDate,id,orderNo,orderDate,amount,billStatus,orderStatus,notAdvance)
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
        this.payMode = payMode;
        this.advance = advance;
        this.notAdvance = notAdvance;
        this.packageId = packageId;
        this.Item = Item;
        this.pastDate = pastDate;
        this.id = id;
        this.orderNo = orderNo;
        this.orderDate = orderDate;
        this.amount = amount;
        this.billStatus = billStatus;
        this.orderStatus = orderStatus;
    }

    function PlaceOrder(Entity)
    {
        console.log("PlaceOrder");
        // console.log(Entity);
        var urlStr = $('#urlPost').val();
        console.log("PlaceOrder1");
        console.log("Entity: " + Entity)
        console.log("urlStr: " + urlStr)

        $.ajax({
            type: "POST",
            url: urlStr,
            contentType: "application/json",
            data: JSON.stringify(Entity),
            success: SuccessPlaceOrder
        });

        console.log("PlaceOrder2");
    }

    function SuccessPlaceOrder(Response)
    {
        console.log(Response)
        location.reload();
        window.location.href = document.getElementById("url1").value + "/order/adminDetails";
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

    function myFunction() {
        var tot = 0;
        var price1 = document.getElementsByName("itemActualAmount");
        var price2 = document.getElementsByName("itemAdjustedAmount");

        for(var i = 0; i < price1.length; i++){
            if(price2[i].value == "" || price2[i].value.length == 0){
                tot += parseFloat(price1[i].value);
            }
            else{
                tot += parseFloat(price2[i].value);
            }
        }

        document.getElementById("totalPrice").innerHTML = tot;
        document.getElementById("amount").value = tot;

        changeBalance();
    }

    function changeBalance(){
		var advance = parseFloat(document.getElementById("advance").value);
		var notAdvance = parseFloat(document.getElementById("notAdvance").value);
		var totalPrice = parseFloat(document.getElementById("totalPrice").innerHTML);
        if(advance == null || advance === undefined || Number.isNaN(advance)){
            document.getElementById("balance_display").innerHTML = totalPrice;
        }
        else{
            var bal = totalPrice - (advance + notAdvance);
            if(bal < 0){
                alert("Advance cannot be greater than balance");
                document.getElementById("balance_display").innerHTML = totalPrice;
                document.getElementById("advance").value = ""
                document.getElementById("notAdvance").value = ""
            }
            else{
                document.getElementById("balance_display").innerHTML = bal;
            }
        }
    }
</script>