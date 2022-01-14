<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem"%>
<%@ page import="java.util.List"%>
<div>
    <%
        List<Packageitem> packList = (List<Packageitem>) request.getAttribute("packageitemList");
        double tot = 0;
        for(Packageitem itm : packList){
            %>
                <div class="row">
                    <input type="hidden" class="ItemId form-control" name="itemId" value="<%= itm.getId() %>" required>
                    <div class="col-md-4 p-2"><h6 class="mt-2"><%= itm.getItemname() %></h6></div>
                    <div class="col-md-4 p-2"><input type="number" class="ItemActValue form-control" name="itemActualAmount" value="<%= itm.getAmount() %>" readonly></div>
                    <div class="col-md-4 p-2"><input type="number" class="ItemAdjValue form-control" name="itemAdjustedAmount" placeholder="Enter adjusted amount" onkeyup="myFunction()" required></div>
                </div>
            <%
            tot += itm.getAmount();
        }

        if(packList.size() == 0){
            %><h5 class="text-danger">There are no items in this package, Please choose another package !!!</h5>
            <input type="hidden" id="packageStatus" value="false" /><%
        }
        else{
            %><input type="hidden" id="packageStatus" value="true" /><%
        }
    %>

    <div class="row mt-2 ml-2">
        <div class="col-md-2 mt-2">
            <h6>Total: <span id="totalPrice"><%= tot %></span></h6>
        </div>
        <div class="col-md-2">
            <input type="number" class="form-control placeOrderFields" id="advance" name="advance" placeholder="Enter Advance" onkeyup="changeBalance()" required>
            <span class="text-danger">If no advance is paid, please insert '0'</span>
        </div>
        <div class="col-md-2">
            <input type="number" class="form-control placeOrderFields" id="notAdvance" name="notAdvance" placeholder="Enter Not Advance" onkeyup="changeBalance()" required>
            <span class="text-danger">If no not-advance is paid, please insert '0'</span>
        </div>
        <div class="col-md-2 mt-2">
            <h6>Balance: <span id="balance_display"><%= tot %></span></h6>
        </div>
        <div class="col-md-2">
            <button class="btn btn-info" onclick="addAdvanceAndNotAdvance()">Load Bill Details</button>
            <span class="text-danger">Clicking this button loads the previous advance and not advance</span>
        </div>
    </div>
</div>