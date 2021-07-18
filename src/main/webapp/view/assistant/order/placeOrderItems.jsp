<%@ page contentType="text/html;charset=UTF-8"%>
<%@ page import="com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem"%>
<%@ page import="java.util.List"%>
<div>
    <%
        List<Packageitem> packList = (List<Packageitem>) request.getAttribute("packageitemList");
        for(Packageitem itm : packList){
            %>
                <div class="row">
                    <input type="hidden" class="ItemId form-control" name="itemId" value="<%= itm.getId() %>" required>
                    <div class="col-md-4 p-2"><h6 class="mt-2"><%= itm.getItemname() %></h6></div>
                    <div class="col-md-4 p-2"><input type="number" class="ItemActValue form-control" name="itemActualAmount" value="<%= itm.getAmount() %>" readonly></div>
                    <div class="col-md-4 p-2"><input type="number" class="ItemAdjValue form-control" name="itemAdjustedAmount" placeholder="Enter adjusted amount" required></div>
                </div>
            <%
        }

        if(packList.size() == 0){
            %><h5 class="text-danger">There are no items in this package, Please choose another package !!!</h5>
            <input type="hidden" id="packageStatus" value="false" /><%
        }
        else{
            %><input type="hidden" id="packageStatus" value="true" /><%
        }
    %>
</div>