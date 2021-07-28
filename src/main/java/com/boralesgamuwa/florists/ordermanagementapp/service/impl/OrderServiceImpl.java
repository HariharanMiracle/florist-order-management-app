package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.*;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderbillRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderitemRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PrintjobRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@Service
@Slf4j
public class OrderServiceImpl implements OrderService {

    @Autowired
    OrderRepository orderRepository;

    @Autowired
    OrderbillRepository orderbillRepository;

    @Autowired
    PrintjobRepository printjobRepository;

    @Autowired
    OrderitemRepository orderitemRepository;

    @Autowired
    PackageitemService packageitemService;

    /**
     * Access: Assistant
     * This function enables to place an order
     * */
    @Override
    public boolean placeOrder(Order order, List<Orderitem> orderitemList, double advance, double balance) {
        try{
            /**
             * Save order
             * */
            double sum = 0;
            double total = advance + balance;

            for(Orderitem orderitem : orderitemList){
                sum += orderitem.getAdjustedAmount();
            }
            order.setAmount(sum);

            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String orderDate = formatter.format(date);

            order.setOrderDate(orderDate);

            if(order.getAmount() == total){
                order.setBillStatus("PAID");
                order.setOrderStatus("COMPLETED");
            }
            else{
                order.setBillStatus("UN_PAID");
                order.setOrderStatus("PROCESSING");
            }

            Order savedOrder = orderRepository.save(order);
            String savedOrderId = "ORD" +  String.format("%09d", savedOrder.getId());
            order.setOrderNo(savedOrderId);
            orderRepository.save(order);

            /**
             * Save advance orderbill if there is any
             * */
            if(advance > 0){
                Orderbill advanceOrderbill = new Orderbill();
                advanceOrderbill.setOrderNo(savedOrder.getId());
                advanceOrderbill.setPayment(advance);
                advanceOrderbill.setDate(orderDate);
                advanceOrderbill.setType("ADVANCE");

                orderbillRepository.save(advanceOrderbill);
            }

            /**
             * Save not advance orderbill if there is any
             * */
            if(balance > 0){
                Orderbill balanceOrderbill = new Orderbill();
                balanceOrderbill.setOrderNo(savedOrder.getId());
                balanceOrderbill.setPayment(advance);
                balanceOrderbill.setDate(orderDate);
                balanceOrderbill.setType("NOT_ADVANCE");

                orderbillRepository.save(balanceOrderbill);
            }

            /**
             * Save all items
             * */
            for(Orderitem orderitem : orderitemList){
                Packageitem item = packageitemService.findItemById(orderitem.getItemId());
                orderitem.setName(item.getItemname());
                orderitem.setActualAmount(item.getAmount());
                orderitem.setOrderId(savedOrder.getId());
            }
            orderitemRepository.saveAll(orderitemList);

            /**
             * Save print job
             * */
            Printjob printjob = new Printjob();
            printjob.setOrderId(savedOrder.getId());
            printjob.setStatus("PROCESSING");

            printjobRepository.save(printjob);

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: Assistant
     * This function enables to cancel an order
     * */
    @Override
    public boolean cancelOrder(int orderId) {
        try{
            Order order = orderRepository.findById(orderId).get();
            if(order.getOrderStatus().equals("PROCESSING"))
                order.setOrderStatus("CANCELLED");
            orderRepository.save(order);

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: Assistant
     * This function enables to pay the balance amount
     * */
    @Override
    public boolean payBalance(int orderId, double amount) {
        try{
            double total = amount;

            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String orderDate = formatter.format(date);

            Order order = orderRepository.findById(orderId).get();

            List<Orderbill> orderbillList = orderbillRepository.findByOrderNo(orderId);

            for(Orderbill orderbill : orderbillList){
                total += orderbill.getPayment();
            }

            Orderbill saveOrderBill = new Orderbill();
            saveOrderBill.setOrderNo(order.getId());
            saveOrderBill.setType("NOT_ADVANCE");
            saveOrderBill.setPayment(amount);
            saveOrderBill.setDate(orderDate);

            if(total > order.getAmount()){
                throw new Exception("Amount violation! You have to pay: " + (order.getAmount() - (total - amount)));
            }
            else{
                if(total == order.getAmount()){
                    order.setBillStatus("PAID");
                    order.setOrderStatus("COMPLETED");
                    orderRepository.save(order);
                }

                orderbillRepository.save(saveOrderBill);
            }

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: Assistant
     * This function enables to mark the order as completed
     * */
    @Override
    public boolean completeOrder(int orderId) {
        try{
            Order order = orderRepository.findById(orderId).get();

            List<Orderbill> orderbillList = orderbillRepository.findByOrderNo(orderId);

            double total = 0;
            for(Orderbill orderbill : orderbillList){
                total = orderbill.getPayment();
            }

            if(total == order.getAmount()){
                order.setOrderStatus("COMPLETED");
                orderRepository.save(order);
            }
            else{
                throw new Exception("There is a balance amount to be paid");
            }

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: All
     * This function enables to list all orders
     * tested
     * */
    @Override
    public List<Order> listAllOrders() {
        try{
            return (List<Order>) orderRepository.findAll();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get order by order id
     * tested
     * */
    @Override
    public Order getOrderById(int orderId) {
        try{
            return orderRepository.findById(orderId).get();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    /**
     * Access: All
     * This function enables to get order by order id created from system
     * tested
     * */
    @Override
    public Order getOrderByOrderId(String orderId) {
        try{
            return orderRepository.findByOrderNo(orderId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    /**
     * Access: All
     * This function enables to get order by manual order id
     * tested
     * */
    @Override
    public Order getOrderByManualOrderId(String orderId) {
        try{
            return orderRepository.findByManualOrderNo(orderId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    /**
     * Access: All
     * This function enables to get fully paid orders
     * */
    @Override
    public List<Order> listAllPaidOrders() {
        try{
            return orderRepository.listAllPaidOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get un paid orders
     * */
    @Override
    public List<Order> listAllUnPaidOrders() {
        try{
            return orderRepository.listAllUnPaidOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get completed orders
     * */
    @Override
    public List<Order> listAllCompletedOrders() {
        try{
            return orderRepository.listAllCompletedOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get in-completed orders
     * */
    @Override
    public List<Order> listAllInCompletedOrders() {
        try{
            return orderRepository.listAllInCompletedOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get cancelled orders
     * */
    @Override
    public List<Order> listAllCancelledOrders() {
        try{
            return orderRepository.listAllCancelledOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to get Orderitem list by order id
     * tested
     * */
    @Override
    public List<Orderitem> listOrderItemByOrderId(int orderId) {
        try{
            return orderitemRepository.findByOrderId(orderId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    @Override
    public List<Order> filterOrders(String orderNo, String manualOrderNo, String name, String nicNo) {
        try{
            if(orderNo == null){
                orderNo = "";
            }

            if(manualOrderNo == null){
                manualOrderNo = "";
            }

            if(name == null){
                name = "";
            }

            if(nicNo == null){
                nicNo = "";
            }

            return orderRepository.findByOrderNoContainingAndManualOrderNoContainingAndNameContainingAndNicNoContaining(orderNo, manualOrderNo, name, nicNo);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    @Override
    public List<Orderbill> listAllOrderbillByOrderId(int id) {
        try{
            return orderbillRepository.findByOrderNo(id);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    @Override
    public Order findLastOrder() {
        try{
            return orderRepository.findLastOrder();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    @Override
    public List<Order> listOrdersBetweenDate(String startDate, String endDate) {
        try{
            return orderRepository.listOrdersBetweenDate(startDate, endDate);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: Assistant
     * This function enables to revert an order
     * */
    @Override
    public boolean revertOrder(int orderId) {
        try{
            Order order = orderRepository.findById(orderId).get();
            if(order.getOrderStatus().equals("CANCELLED"))
                order.setOrderStatus("PROCESSING");
            orderRepository.save(order);

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }
}
