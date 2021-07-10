package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Printjob;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PrintjobRepository extends CrudRepository<Printjob, Integer> {
}
