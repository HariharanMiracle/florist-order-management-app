package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.*;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderbillRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.OrderitemRepository;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PrintjobRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.lang.Package;
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

    /**
     * Access: Assistant
     * This function enables to place an order
     * */
    @Override
    public boolean placeOrder(Order order, Package aPackage, List<Orderitem> orderitemList, double advance, double balance) {
        try{
            /**
             * Save order
             * */
            double total = advance + balance;

            Date date = new Date();
            SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
            String orderDate = formatter.format(date);

            order.setOrderDate(orderDate);
            order.setOrderStatus("PROCESSING");

            if(order.getAmount() == total)
                order.setBillStatus("PAID");
            else
                order.setBillStatus("UN_PAID");

            Order savedOrder = orderRepository.save(order);
            String savedOrderId = "ORD" +  String.format("%7d", savedOrder.getId());
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
            saveOrderBill.setType("ADVANCE");
            saveOrderBill.setPayment(amount);
            saveOrderBill.setDate(orderDate);

            if(total > order.getAmount()){
                throw new Exception("Amount violation! You have to pay: " + (order.getAmount() - (total - amount)));
            }
            else{
                if(total == order.getAmount()){
                    order.setBillStatus("PAID");
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
}
