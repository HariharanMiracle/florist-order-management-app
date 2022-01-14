package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.*;
import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import com.google.gson.JsonArray;
import com.google.gson.JsonElement;
import com.google.gson.JsonObject;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;
import com.google.gson.Gson;


import javax.servlet.http.HttpServletRequest;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("order")
public class OrderController {

    @Autowired
    OrderService orderService;

    @Autowired
    PackageService packageService;

    @Autowired
    PackageitemService packageitemService;

    @GetMapping("details")
    public ModelAndView getOrderDetails(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.listAllOrderAndOrderByManualOrderNoDesc());
            modelAndView.setViewName("assistant/order/details");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("listFilter")
    public ModelAndView getOrderDetailsFiltered(@RequestParam("orderNo") String orderNo,
                                                @RequestParam("manualOrderNo") String manualOrderNo,
                                                @RequestParam("name") String name,
                                                @RequestParam("nicNo") String nicNo){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
            modelAndView.setViewName("assistant/order/details");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("detail/{id}")
    public ModelAndView getOrderDetailsById(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(id);
            Package pkg = packageService.getPackageById(order.getPackageId());
            List<Orderbill> orderbillList = orderService.listAllOrderbillByOrderId(order.getId());
            List<Orderitem> orderItemList = orderService.listOrderItemByOrderId(order.getId());

            modelAndView.addObject("order", order);
            modelAndView.addObject("orderbillList", orderbillList);
            modelAndView.addObject("orderItemList", orderItemList);
            modelAndView.addObject("package", pkg.getName());

            modelAndView.setViewName("assistant/order/detail");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("placeOrder")
    public ModelAndView placeOrderForm(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            String lastManualOrderNumber = "";
            Order order = orderService.findLastOrderOrderByManualOrderNo();
            if(order.getManualOrderNo() == null || order.getManualOrderNo().isEmpty())
                lastManualOrderNumber = "NONE";
            else
                lastManualOrderNumber = order.getManualOrderNo();

            List<Package> packageList = packageService.listAllPackages();
            modelAndView.addObject("packageList", packageList);
            modelAndView.addObject("lastManualOrderNumber", lastManualOrderNumber);
            modelAndView.setViewName("assistant/order/placeOrder");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("placeOrder")
    public ModelAndView placeOrder(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();
        try{
            JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);

            Order order = new Order();

            String manualOrderNo = data.get("manualOrderNo").getAsString();
            order.setManualOrderNo(manualOrderNo);

            //check manual order no
            List<Order> orderList = orderService.listAllOrders();
            if(!orderList.isEmpty()) {
                List<String> manualOrderNumberList = new ArrayList<>();
                orderList.stream().map(
                        orderObj -> {
                            manualOrderNumberList.add(orderObj.getManualOrderNo());
                            return orderObj;
                        }
                ).collect(Collectors.toList());

                if (manualOrderNumberList.contains(manualOrderNo)) {
                    throw new Exception("Manual Order Number Already Used");
                }
            }

            String title = data.get("title").getAsString();
            order.setTitle(title);

            String name = data.get("name").getAsString();
            order.setName(name);

            String address = data.get("address").getAsString();
            order.setAddress(address);

            String religion = data.get("religion").getAsString();
            order.setReligion(religion);

            String nicNo = data.get("nicNo").getAsString();
            order.setNicNo(nicNo);

            String telephoneNo = data.get("telephoneNo").getAsString();
            order.setTelephoneNo(telephoneNo);

            String deadPersonName = data.get("deadPersonName").getAsString();
            order.setDeadPersonName(deadPersonName);

            String funeralDate = data.get("funeralDate").getAsString();
            order.setFuneralDate(funeralDate);

            String pastDate = data.get("pastDate").getAsString();
            if(pastDate.isEmpty())
                order.setPastDate(null);
            else
                order.setPastDate(pastDate);

            String cemetry = data.get("cemetry").getAsString();
            order.setCemetry(cemetry);

            String cremationBurrial = data.get("cremationBurrial").getAsString();
            order.setCremationBurrial(cremationBurrial);

            String payMode = data.get("payMode").getAsString();
            order.setPayMode(payMode);

            int packageId = Integer.parseInt(data.get("packageId").getAsString());
            order.setPackageId(packageId);

            double advance = Double.parseDouble(data.get("advance").getAsString());

            double balance = 0;

            JsonArray items = data.get("Item").getAsJsonArray();

            List<Orderitem> orderitemList = new ArrayList<>();

            for(JsonElement obj : items){
                System.out.println(obj.toString());
                String val = obj.toString();
                String[] splitVal = val.split("\"");

                Orderitem orderitem = new Orderitem();
                orderitem.setAdjustedAmount(Double.parseDouble(splitVal[3]));
                orderitem.setItemId(Integer.parseInt(splitVal[1]));
                orderitemList.add(orderitem);
            }


            /**
             *  to send: Order order,
             *  Package aPackage,
             *  List<Orderitem> orderitemList,
             *  double advance,
             *  double balance
             *  */
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            orderService.placeOrder(order, orderitemList, advance, balance);
            return new ModelAndView("redirect:" + baseUrl + "/order/details");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("cancelOrder")
    public ModelAndView cancelOrder(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.listAllOrderAndOrderByManualOrderNo());
            modelAndView.setViewName("admin/order/cancelOrder");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("cancelOrder/{id}")
    public ModelAndView cancelOrderById(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            orderService.cancelOrder(id);
            return new ModelAndView("redirect:" + baseUrl + "/order/cancelOrder");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("revertOrder/{id}")
    public ModelAndView revertOrderById(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            orderService.revertOrder(id);
            return new ModelAndView("redirect:" + baseUrl + "/order/cancelOrder");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("listFilterCancelOrder")
    public ModelAndView getCancelOrderDetailsFiltered(@RequestParam("orderNo") String orderNo,
                                                @RequestParam("manualOrderNo") String manualOrderNo,
                                                @RequestParam("name") String name,
                                                @RequestParam("nicNo") String nicNo){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
            modelAndView.setViewName("admin/order/cancelOrder");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("payBalance")
    public ModelAndView payBalanceOrders(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.listAllOrderAndOrderByManualOrderNo());
            modelAndView.setViewName("assistant/order/payBalance");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("payBalance/{id}")
    public ModelAndView payBalanceByOrderId(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(id);
            List<Orderbill> orderbillList = orderService.listAllOrderbillByOrderId(order.getId());
            double amountToBePaid = 0;
            double amountPaid = 0;

            for(Orderbill orderbill : orderbillList){
                amountPaid += orderbill.getPayment();
            }

            amountToBePaid = order.getAmount() - amountPaid;

            modelAndView.addObject("order", order);
            modelAndView.addObject("orderbillList", orderbillList);
            modelAndView.addObject("amountToBePaid", amountToBePaid);
            modelAndView.addObject("amountPaid", amountPaid);

            modelAndView.setViewName("assistant/order/payBalanceForm");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("listFilterPayBalance")
    public ModelAndView getOrderDetailsFilteredPayBalance(@RequestParam("orderNo") String orderNo,
                                                @RequestParam("manualOrderNo") String manualOrderNo,
                                                @RequestParam("name") String name,
                                                @RequestParam("nicNo") String nicNo){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
            modelAndView.setViewName("assistant/order/payBalance");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("payBalance")
    public ModelAndView payBalanceForm(@RequestParam("balance") double balance, @RequestParam("orderId") int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            orderService.payBalance(orderId, balance);
            return new ModelAndView("redirect:" + baseUrl + "/order/payBalance");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("adminDetails")
    public ModelAndView getOrderDetailsAdmin(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.listAllOrderAndOrderByManualOrderNoDesc());
            modelAndView.setViewName("admin/order/details");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("adminListFilter")
    public ModelAndView getOrderDetailsFilteredAdmin(@RequestParam("orderNo") String orderNo,
                                                @RequestParam("manualOrderNo") String manualOrderNo,
                                                @RequestParam("name") String name,
                                                @RequestParam("nicNo") String nicNo,
                                                @RequestParam("startDate") String startDate,
                                                @RequestParam("endDate") String endDate){
        ModelAndView modelAndView = new ModelAndView();

        try{
            if((startDate == null || startDate.isEmpty()) && (endDate == null || endDate.isEmpty()))
                modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
            else
                modelAndView.addObject("orderList", orderService.listOrdersBetweenDate(startDate, endDate));

            modelAndView.setViewName("admin/order/details");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("adminDetail/{id}")
    public ModelAndView getOrderDetailsByIdAdmin(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(id);
            Package pkg = packageService.getPackageById(order.getPackageId());
            List<Orderbill> orderbillList = orderService.listAllOrderbillByOrderId(order.getId());
            List<Orderitem> orderItemList = orderService.listOrderItemByOrderId(order.getId());

            modelAndView.addObject("order", order);
            modelAndView.addObject("orderbillList", orderbillList);
            modelAndView.addObject("orderItemList", orderItemList);
            modelAndView.addObject("package", pkg.getName());

            modelAndView.setViewName("admin/order/detail");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("adminGetOrderItems/{id}")
    public ModelAndView adminGetOrderItems(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            List<Packageitem> packageitemList = packageitemService.findPackageItemListByPackageId(String.valueOf(id));
            modelAndView.setViewName("admin/order/placeOrderItems");
            modelAndView.addObject("packageitemList", packageitemList);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("getOrderItems/{id}")
    public ModelAndView getOrderItems(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            List<Packageitem> packageitemList = packageitemService.findPackageItemListByPackageId(String.valueOf(id));
            modelAndView.setViewName("assistant/order/placeOrderItems");
            modelAndView.addObject("packageitemList", packageitemList);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("print/order/{orderId}")
    public ModelAndView printOrder(@PathVariable int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(orderId);
            List<Orderitem> orderitemList = orderService.listOrderItemByOrderId(orderId);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            String currentDate = df.format(now);

            modelAndView.setViewName("assistant/order/print-order");
            modelAndView.addObject("order", order);
            modelAndView.addObject("orderitemList", orderitemList);
            modelAndView.addObject("currentDate", currentDate);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("print/invoice/{orderId}")
    public ModelAndView printInvoice(@PathVariable int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(orderId);
            List<Orderitem> orderitemList = orderService.listOrderItemByOrderId(orderId);
            List<Orderbill> paymentList = orderService.listAllOrderbillByOrderId(orderId);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            String currentDate = df.format(now);

            modelAndView.setViewName("assistant/order/print-invoice");
            modelAndView.addObject("order", order);
            modelAndView.addObject("orderitemList", orderitemList);
            modelAndView.addObject("paymentList", paymentList);
            modelAndView.addObject("currentDate", currentDate);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("printadmin/order/{orderId}")
    public ModelAndView printOrderAdmin(@PathVariable int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(orderId);
            List<Orderitem> orderitemList = orderService.listOrderItemByOrderId(orderId);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            String currentDate = df.format(now);

            modelAndView.setViewName("admin/order/print-order");
            modelAndView.addObject("order", order);
            modelAndView.addObject("orderitemList", orderitemList);
            modelAndView.addObject("currentDate", currentDate);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("printadmin/invoice/{orderId}")
    public ModelAndView printInvoiceAdmin(@PathVariable int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(orderId);
            List<Orderbill> paymentList = orderService.listAllOrderbillByOrderId(orderId);
            List<Orderitem> orderitemList = orderService.listOrderItemByOrderId(orderId);
            DateTimeFormatter df = DateTimeFormatter.ofPattern("yyyy/MM/dd");
            LocalDateTime now = LocalDateTime.now();
            String currentDate = df.format(now);

            modelAndView.setViewName("admin/order/print-invoice");
            modelAndView.addObject("order", order);
            modelAndView.addObject("orderitemList", orderitemList);
            modelAndView.addObject("paymentList", paymentList);
            modelAndView.addObject("currentDate", currentDate);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("adminUpdateOrder/{orderId}")
    public ModelAndView adminUpdateOrderView(@PathVariable int orderId){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Order order = orderService.getOrderById(orderId);
            List<Orderbill> paymentList = orderService.listAllOrderbillByOrderId(orderId);
            List<Orderitem> orderitemList = orderService.listOrderItemByOrderId(orderId);
            List<Package> packageList = packageService.listAllPackages();
            Package oldPackage = packageService.getPackageById(order.getPackageId());
            List<Orderbill> orderbillList = orderService.listAllOrderbillByOrderId(orderId);

            double advance = 0;
            double notAdvance = 0;

            for(Orderbill orderbill : orderbillList){
                if(orderbill.getType().equals("ADVANCE"))
                    advance += orderbill.getPayment();
                else
                    notAdvance += orderbill.getPayment();
            }

            modelAndView.addObject("packageList", packageList);
            modelAndView.setViewName("admin/order/update");
            modelAndView.addObject("order", order);
            modelAndView.addObject("orderitemList", orderitemList);
            modelAndView.addObject("paymentList", paymentList);
            modelAndView.addObject("oldPackage", oldPackage);
            modelAndView.addObject("advance", advance);
            modelAndView.addObject("notAdvance", notAdvance);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @PostMapping("adminUpdateOrder")
    public ModelAndView updateOrder(HttpServletRequest request){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            Order order = new Order();

            JsonObject data = new Gson().fromJson(request.getReader(), JsonObject.class);
            int id = Integer.parseInt(data.get("id").getAsString());
            order.setId(id);

            Order pastOrder = orderService.getOrderById(id);

            String orderNo = data.get("orderNo").getAsString();
            order.setOrderNo(orderNo);

            String manualOrderNo = data.get("manualOrderNo").getAsString();
            order.setManualOrderNo(manualOrderNo);

            order.setOrderDate(pastOrder.getOrderDate());

            String title = data.get("title").getAsString();
            order.setTitle(title);

            String name = data.get("name").getAsString();
            order.setName(name);

            String address = data.get("address").getAsString();
            order.setAddress(address);

            String religion = data.get("religion").getAsString();
            order.setReligion(religion);

            String nicNo = data.get("nicNo").getAsString();
            order.setNicNo(nicNo);

            String telephoneNo = data.get("telephoneNo").getAsString();
            order.setTelephoneNo(telephoneNo);

            String deadPersonName = data.get("deadPersonName").getAsString();
            order.setDeadPersonName(deadPersonName);

            String funeralDate = data.get("funeralDate").getAsString();
            order.setFuneralDate(funeralDate);

            String pastDate = data.get("pastDate").getAsString();
            if(pastDate.isEmpty())
                order.setPastDate(null);
            else
                order.setPastDate(pastDate);

            String cemetry = data.get("cemetry").getAsString();
            order.setCemetry(cemetry);

            String cremationBurrial = data.get("cremationBurrial").getAsString();
            order.setCremationBurrial(cremationBurrial);

            String payMode = data.get("payMode").getAsString();
            order.setPayMode(payMode);

            int packageId = Integer.parseInt(data.get("packageId").getAsString());

            double amount = Double.parseDouble(data.get("amount").getAsString());
            order.setAmount(amount);

            String billStatus = data.get("billStatus").getAsString();
            order.setBillStatus(billStatus);

            order.setOrderStatus(pastOrder.getOrderStatus());

            order.setBillStatus(pastOrder.getBillStatus());

            JsonArray items = data.get("Item").getAsJsonArray();

            List<Orderitem> orderitemList = new ArrayList<>();

            if(packageId == 0){
                /** Do not change past package details */
                order.setPackageId(pastOrder.getPackageId());
                order.setAmount(pastOrder.getAmount());

                /** Update basic order details */
                orderService.updateOrder(order);
            }
            else{
                /** Change past package details */
                order.setPackageId(packageId);

                for(JsonElement obj : items){
                    System.out.println(obj.toString());
                    String val = obj.toString();
                    String[] splitVal = val.split("\"");

                    Orderitem orderitem = new Orderitem();
                    orderitem.setAdjustedAmount(Double.parseDouble(splitVal[3]));
                    orderitem.setItemId(Integer.parseInt(splitVal[1]));
                    orderitemList.add(orderitem);
                }

                double advance = Double.parseDouble(data.get("advance").getAsString());
                double notAdvance = Double.parseDouble(data.get("notAdvance").getAsString());

                log.info("orderitemList: " + orderitemList.toString());
                log.info("advance: " + advance);
                log.info("notAdvance: " + notAdvance);

                /** Update basic order details and package details */
                orderService.updateOrderAndChangePackage(order, orderitemList, advance, notAdvance);
            }

            log.info("Order: " + order.toString());

            return new ModelAndView("redirect:" + baseUrl + "/order/adminDetails");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }

        return modelAndView;
    }

    @GetMapping("isValidManualOrderNumber/{orderNo}")
    public String isValidManualOrderNumber(@PathVariable String orderNo){

        try{
            Order order = orderService.getOrderByManualOrderId(orderNo);
            if(order == null)
                return "Manual order number is valid";
            else
                return "Manual order number is not valid";
        }
        catch (Exception e){
            e.printStackTrace();
            return "Something went wrong";
        }

    }
}
