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
        String lastManualOrderNumber = (String) request.getAttribute("lastManualOrderNumber");
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
                                    <td>Last entered manual order number</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="lastManualOrderNo" name="lastManualOrderNo" placeholder="manual order number" value="<%= lastManualOrderNumber %>" readonly></td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Manual Order No</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="manualOrderNo" name="manualOrderNo" placeholder="Enter Manual Order No" required onkeyup="isValidManualOrderNumber()"></td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Title</td>
                                    <td>
                                        <select id="title" name="title" class="form-control">
                                            <option value="MR">MR</option>
                                            <option value="MRS">MRS</option>
                                            <option value="Master">Master</option>
                                            <option value="Miss">Miss</option>
                                            <option value="Ven">Ven</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Name</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="name" name="name" placeholder="Enter Name" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Address</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="address" name="address" placeholder="Enter Address" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Religion</td>
                                    <td>
                                        <select id="religion" name="religion" class="form-control">
                                            <option value="Buddhist">Buddhist</option>
                                            <option value="Hindu">Hindu</option>
                                            <option value="Roman Catholic">Roman Catholic</option>
                                            <option value="Non Roman Catholic">Non Roman Catholic</option>
                                            <option value="Other">Other</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">7</th>
                                    <td>Nic No</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="nicNo" name="nicNo" minlength="10" maxlength="12" placeholder="Enter Nic No" required></td>
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
                                    <td>Past Date</td>
                                    <td><input type="date" class="form-control" id="pastDate" name="pastDate" placeholder="Enter Past Date"></td>
                                </tr>
                                <tr>
                                    <th scope="row">2</th>
                                    <td>Dead Person Name</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="deadPersonName" name="deadPersonName" placeholder="Enter Dead Person Name" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">3</th>
                                    <td>Funeral Date</td>
                                    <td><input type="date" class="form-control placeOrderFields" id="funeralDate" name="funeralDate" placeholder="Enter Funeral Date" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">4</th>
                                    <td>Cemetery</td>
                                    <td><input type="text" class="form-control placeOrderFields" id="cemetry" name="cemetry" placeholder="Enter Cemetery" required></td>
                                </tr>
                                <tr>
                                    <th scope="row">5</th>
                                    <td>Cremation / Burrial</td>
                                    <td>
                                        <select id="cremationBurrial" name="cremationBurrial" class="form-control">
                                            <option value="CREMATION">CREMATION</option>
                                            <option value="BURRIAL">BURIAL</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">6</th>
                                    <td>Pay Mode</td>
                                    <td>
                                        <select id="payMode" name="payMode" class="form-control">
                                            <option value="CREDIT">CREDIT</option>
                                            <option value="CARD">CARD</option>
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th scope="row">7</th>
                                    <td>Telephone No</td>
                                    <td><input type="tel" class="form-control placeOrderFields" id="telephoneNo" maxlength="10" minlength="10" name="telephoneNo" placeholder="Enter Telephone No" required></td>
                                </tr>
                            </tbody>
                        </table>
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
        let payMode = $('#payMode').val();
        let advance = $('#advance').val();
        let packageId = $('#packageId').val();
        let pastDate = $('#pastDate').val();

        let DomElmItemId = document.querySelectorAll('.ItemId');
        let DomElmItemActAmount = document.querySelectorAll('.ItemActValue');
        let DomElmItemAdjAmount = document.querySelectorAll('.ItemAdjValue');
        let Item = [];

        for(let i = 0; i<DomElmItemId.length; i++)
        {
            let AdjValue = (DomElmItemAdjAmount[i].value<0 || DomElmItemAdjAmount[i].value==null || DomElmItemAdjAmount[i].value==="")?DomElmItemActAmount[i].value:DomElmItemAdjAmount[i].value;
            Item.push([DomElmItemId[i].value,AdjValue])
        }

        let Entity = new Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,payMode,advance,packageId,Item,pastDate);

        (IsFieldsEmpty(".placeOrderFields"))?PlaceOrder(Entity):alert("Mandatory Fields cannot Be Empty");
    }

    function Order(manualOrderNo,title,name,address,religion,nicNo,telephoneNo,deadPersonName,funeralDate,cemetry,cremationBurrial,payMode,advance,packageId,Item,pastDate)
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
        this.packageId = packageId;
        this.Item = Item;
        this.pastDate = pastDate;
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

        changeBalance();
    }

    function changeBalance(){
		var advance = parseFloat(document.getElementById("advance").value);
		var totalPrice = parseFloat(document.getElementById("totalPrice").innerHTML);
        if(advance == null || advance === undefined || Number.isNaN(advance)){
            document.getElementById("balance_display").innerHTML = totalPrice;
        }
        else{
            var bal = totalPrice - advance;
            if(bal < 0){
                alert("Advance cannot be greater than balance");
                document.getElementById("balance_display").innerHTML = totalPrice;
                document.getElementById("advance").value = ""
            }
            else{
                document.getElementById("balance_display").innerHTML = bal;
            }
        }
    }

    function isValidManualOrderNumber() {
        console.log("Hi")
        var orderId = document.getElementById("manualOrderNo").value;

        var urlStr = document.getElementById("url1").value + "/order/isValidManualOrderNumber/" + orderId;


        $.ajax({
            type: "GET",
            url: urlStr,
            success: isValidManualOrderNumberSucc
        });
    }

    function isValidManualOrderNumberSucc(rsp){

        if(rsp == "Manual order number is not valid" || rsp == "Something went wrong"){
            alert(rsp);
            document.getElementById("manualOrderNo").value = "";
        }

    }
</script>