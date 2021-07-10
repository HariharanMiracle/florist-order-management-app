package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PackageRepository extends CrudRepository<Package, Integer> {
    List<Package> findByName(String name);

    @Query(value="SELECT * FROM `package` WHERE `name` LIKE '%?%'", nativeQuery = true)
    List<Package> findByLikeName(String name);
}
