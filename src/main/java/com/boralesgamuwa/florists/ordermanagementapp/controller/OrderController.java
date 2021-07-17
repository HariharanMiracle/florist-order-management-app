package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import com.boralesgamuwa.florists.ordermanagementapp.model.Orderbill;
import com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem;
import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
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
    public ModelAndView payBalanceForm(){
        ModelAndView modelAndView = new ModelAndView();

        try{
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("payBalance")
    public ModelAndView payBalance(){
        ModelAndView modelAndView = new ModelAndView();

        try{
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

}
