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

    @Override
    public List<Order> listAllOrders() {
        return null;
    }

    @Override
    public Order getOrderById(int orderId) {
        return null;
    }

    @Override
    public Order getOrderByOrderId(String orderId) {
        return null;
    }

    @Override
    public Order getOrderByManualOrderId(String orderId) {
        return null;
    }

    @Override
    public List<Order> listAllPaidOrders() {
        return null;
    }

    @Override
    public List<Order> listAllUnPaidOrders() {
        return null;
    }

    @Override
    public List<Order> listAllCompletedOrders() {
        return null;
    }

    @Override
    public List<Order> listAllInCompletedOrders() {
        return null;
    }

    @Override
    public List<Order> listAllCancelledOrders() {
        return null;
    }

    @Override
    public List<Packageitem> listOrderItemByOrderId(int orderId) {
        return null;
    }
}
