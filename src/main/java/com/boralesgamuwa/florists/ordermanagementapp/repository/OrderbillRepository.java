package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Orderbill;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface OrderbillRepository extends CrudRepository<Orderbill, Integer> {
    List<Orderbill> findByOrderNo(int orderNo);
}
