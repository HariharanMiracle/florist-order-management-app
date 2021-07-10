package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;

import java.util.List;

public interface PackageitemService {
    boolean saveItem(Packageitem packageitem);
    Packageitem findByItemname(String itemname);
    List<Packageitem> findPackageItemListByPackageId(String packageId);
    List<Packageitem> findPackageItemListNotInPackage(String packageId);
    Packageitem findItemById(int id);
    /** boolean editItem(Packageitem packageitem); */
}
