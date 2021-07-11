package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PackageRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@Service
@Slf4j
public class PackageServiceImpl implements PackageService {
    @Autowired
    PackageRepository packageRepository;

    /**
     * Access: ADMIN
     * This function enables to create a package initially
     * initially package amount is 0
     * tested
     * */
    @Override
    public boolean savePackage(Package aPackage) {
        try{
            List<Package> searchPackageList = packageRepository.findByName(aPackage.getName());
            if(searchPackageList.size() == 0){
                aPackage.setAmount(0);
                packageRepository.save(aPackage);
            }
            else
                throw new Exception("Package's name already exist");
            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: SYSTEM, system use this to edit the amount of a package
     * This function enables to edit a package
     * This function will be used when adding items to the packages to change the total value of the package
     * */
    @Override
    public boolean editPackage(Package aPackage) {
        try {
            if(aPackage == null){
                throw new Exception("Package cannot be null");
            }
            if(aPackage.getId() <= 0){
                throw new Exception("Package entity's id is invalid");
            }
            packageRepository.save(aPackage);
            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: All
     * This function enables to view a package by its id
     * tested
     * */
    @Override
    public Package getPackageById(int id) {
        try {
            if(id <= 0){
                throw new Exception("Package entity's id is invalid");
            }
            Package aPackage = packageRepository.findById(id).get();
            return aPackage;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Package();
        }
    }

    /**
     * Access: All
     * This function enables to view all the packages
     * tested
     * */
    @Override
    public List<Package> listAllPackages() {
        try {
            List<Package> packageList = (List<Package>) packageRepository.findAll();
            if(packageList == null || packageList.size() == 0)
                throw new Exception("No packages exist");
            return packageList;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This function enables to view package by its name
     * tested
     * */
    @Override
    public Package getPackagesByName(String name) {
        try {
            List<Package> packageList = packageRepository.findByName(name);
            if(packageList.size() == 0)
                throw new Exception("Package's name doesn't exist");
            return packageList.get(0);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Package();
        }
    }

    /**
     * Access: All
     * This function enables to view packages by its name [USING SQL LIKE COMMAND]
     * tested
     * */
    @Override
    public List<Package> findByLikeName(String name) {
        try {
            List<Package> packageList = packageRepository.findByNameContaining(name);
            if(packageList == null || packageList.size() == 0)
                throw new Exception("No packages exist");
            return packageList;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }


}
