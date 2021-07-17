package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.*;
import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

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
            modelAndView.addObject("orderList", orderService.listAllOrders());
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
            List<Package> packageList = packageService.listAllPackages();
            modelAndView.addObject("packageList", packageList);
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
    public ModelAndView placeOrder(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            /**
             *  to send: Order order,
             *  Package aPackage,
             *  List<Orderitem> orderitemList,
             *  double advance,
             *  double balance
             *  */
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();
            orderService.placeOrder(null, null, null, 0, 0);
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
            modelAndView.addObject("orderList", orderService.listAllOrders());
            modelAndView.setViewName("assistant/order/cancelOrder");
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

    @PostMapping("listFilterCancelOrder")
    public ModelAndView getCancelOrderDetailsFiltered(@RequestParam("orderNo") String orderNo,
                                                @RequestParam("manualOrderNo") String manualOrderNo,
                                                @RequestParam("name") String name,
                                                @RequestParam("nicNo") String nicNo){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
            modelAndView.setViewName("assistant/order/cancelOrder");
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
            modelAndView.addObject("orderList", orderService.listAllOrders());
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
            modelAndView.addObject("orderList", orderService.listAllOrders());
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
                                                @RequestParam("nicNo") String nicNo){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.addObject("orderList", orderService.filterOrders(orderNo, manualOrderNo, name, nicNo));
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
}
