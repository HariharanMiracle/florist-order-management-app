package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface PackitmRepository extends CrudRepository<Packitm, Integer> {
    @Query(value = "SELECT * FROM `packitm` WHERE `packageid` = ? AND `packageitemid` = ?", nativeQuery = true)
    Packitm findPackItemByPackageIdAndItemId(String packageId, String packageItemId);
}
