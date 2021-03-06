package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import com.boralesgamuwa.florists.ordermanagementapp.model.Orderbill;
import com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem;

import java.util.List;

public interface OrderService {
    boolean placeOrder(Order order, List<Orderitem> orderitemList, double advance, double balance);
    boolean cancelOrder(int orderId);
    boolean payBalance(int orderId, double amount);
    boolean completeOrder(int orderId);
    List<Order> listAllOrders();
    Order getOrderById(int orderId);
    Order getOrderByOrderId(String orderId);
    Order getOrderByManualOrderId(String orderId);
    List<Order> listAllPaidOrders();
    List<Order> listAllUnPaidOrders();
    List<Order> listAllCompletedOrders();
    List<Order> listAllInCompletedOrders();
    List<Order> listAllCancelledOrders();
    List<Orderitem> listOrderItemByOrderId(int orderId);
    List<Order> filterOrders(String orderNo, String manualOrderNo, String name, String nicNo);
    List<Orderbill> listAllOrderbillByOrderId(int id);
    Order findLastOrder();
    Order findLastOrderOrderByManualOrderNo();
    List<Order> listOrdersBetweenDate(String startDate, String endDate);
    boolean revertOrder(int orderId);
    List<Order> listAllOrderAndOrderByManualOrderNo();
    boolean updateOrder(Order order);
    boolean updateOrderAndChangePackage(Order order, List<Orderitem> orderitemList, double advance, double balance);
    List<Order> listAllOrderAndOrderByManualOrderNoDesc();
}
