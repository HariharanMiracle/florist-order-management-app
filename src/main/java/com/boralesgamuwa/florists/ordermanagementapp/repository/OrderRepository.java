package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;


@Repository
public interface OrderRepository extends CrudRepository<Order, Integer> {
    Order findByOrderNo(String orderNo);
    Order findByManualOrderNo(String manualOrderNo);

    @Query(value="SELECT * FROM `orders` WHERE bill_status = 'PAID'", nativeQuery = true)
    List<Order> listAllPaidOrders();

    @Query(value="SELECT * FROM `orders` WHERE bill_status = 'UN_PAID'", nativeQuery = true)
    List<Order> listAllUnPaidOrders();

    @Query(value="SELECT * FROM `orders` WHERE order_status = 'COMPLETED'", nativeQuery = true)
    List<Order> listAllCompletedOrders();

    @Query(value="SELECT * FROM `orders` WHERE order_status = 'PROCESSING'", nativeQuery = true)
    List<Order> listAllInCompletedOrders();

    @Query(value="SELECT * FROM `orders` WHERE order_status = 'CANCELLED'", nativeQuery = true)
    List<Order> listAllCancelledOrders();

    List<Order> findByOrderNoContainingAndManualOrderNoContainingAndNameContainingAndNicNoContainingOrderByManualOrderNoAsc(String orderNo, String manualOrderNo, String name, String nicNo);

    @Query(value = "SELECT * FROM orders ORDER BY id DESC LIMIT 1", nativeQuery = true)
    Order findLastOrder();

    @Query(value = "SELECT * FROM orders ORDER BY manual_order_no DESC LIMIT 1", nativeQuery = true)
    Order findLastOrderOrderByManualOrderNo();

    @Query(value = "SELECT * FROM orders WHERE order_date BETWEEN ? AND ?", nativeQuery = true)
    List<Order> listOrdersBetweenDate(String startDate, String endDate);

    @Query(value = "SELECT * FROM orders ORDER BY manual_order_no", nativeQuery = true)
    List<Order> listAllOrderAndOrderByManualOrderNo();

    @Query(value = "SELECT * FROM orders ORDER BY manual_order_no DESC", nativeQuery = true)
    List<Order> listAllOrderAndOrderByManualOrderNoDesc();
}
