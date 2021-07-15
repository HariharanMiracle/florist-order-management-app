package com.boralesgamuwa.florists.ordermanagementapp.repository;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface PackageitemRepository extends CrudRepository<Packageitem, Integer> {
    List<Packageitem> findByItemname(String itemname);

    @Query(value = "SELECT i.* FROM packageitem i, packitm pit WHERE i.id = pit.packageitemid AND pit.packageid = ?", nativeQuery = true)
    List<Packageitem> findPackageItemListByPackageId(String packageId);

    List<Packageitem> findByItemnameContaining(String itemname);

}
