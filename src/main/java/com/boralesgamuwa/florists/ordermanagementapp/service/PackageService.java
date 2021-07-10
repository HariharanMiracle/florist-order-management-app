package com.boralesgamuwa.florists.ordermanagementapp.service;


import com.boralesgamuwa.florists.ordermanagementapp.model.Package;

import java.util.List;

public interface PackageService {
    boolean savePackage(Package aPackage);
    boolean editPackage(Package aPackage);
    Package getPackageById(int id);
    List<Package> listAllPackages();
    Package getPackagesByName(String name);
    List<Package> findByLikeName(String name);
}
