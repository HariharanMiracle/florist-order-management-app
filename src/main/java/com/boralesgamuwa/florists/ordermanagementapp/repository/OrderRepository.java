package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OrderRepository extends CrudRepository<Order, Integer> {
}
