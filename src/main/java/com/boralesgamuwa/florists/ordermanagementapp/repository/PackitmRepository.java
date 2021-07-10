package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PackitmRepository extends CrudRepository<Packitm, Integer> {
}
