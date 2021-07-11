package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Orderitem;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderitemRepository extends CrudRepository<Orderitem, Integer> {
    List<Orderitem> findByOrderId(int orderId);
}
