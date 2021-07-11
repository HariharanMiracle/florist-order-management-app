package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem;

import java.util.List;

public interface OrderService {
    boolean placeOrder(Order order, Package aPackage, List<Orderitem> orderitemList, double advance, double balance);
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
}
