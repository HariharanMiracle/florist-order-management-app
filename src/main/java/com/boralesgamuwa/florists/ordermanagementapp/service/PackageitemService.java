package com.boralesgamuwa.florists.ordermanagementapp.service;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;

import java.util.List;

public interface PackageitemService {
    List<Packageitem> listAllItems();
    boolean saveItem(Packageitem packageitem);
    Packageitem findByItemname(String itemname);
    List<Packageitem> findPackageItemListByPackageId(String packageId);
    List<Packageitem> findPackageItemListNotInPackage(String packageId);
    Packageitem findItemById(int id);
    List<Packageitem> findByItemnameContaining(String itemname);
    /** boolean editItem(Packageitem packageitem); */
}
