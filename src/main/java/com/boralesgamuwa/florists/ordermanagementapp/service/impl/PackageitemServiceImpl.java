package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.repository.PackageitemRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@Service
@Slf4j
public class PackageitemServiceImpl implements PackageitemService {

    @Autowired
    PackageitemRepository packageitemRepository;

    /**
     * Access: ADMIN
     * This function enables to list all package items
     * tested
     * */
    @Override
    public List<Packageitem> listAllItems() {
        try {
            List<Packageitem> itemList = (List<Packageitem>) packageitemRepository.findAll();
            if(itemList == null || itemList.size() == 0)
                throw new Exception("No items exist");
            return itemList;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: ADMIN
     * This function enables to create a package item
     * tested
     * */
    @Override
    public boolean saveItem(Packageitem packageitem) {
        try{
            List<Packageitem> searchPackageitemList = packageitemRepository.findByItemname(packageitem.getItemname());
            if(searchPackageitemList.size() == 0)
                packageitemRepository.save(packageitem);
            else
                throw new Exception("Packageitem's name already exist");
            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * Access: ADMIN
     * This function enables to edit a package item
     * @Override
     *     public boolean editItem(Packageitem packageitem) {
     *         try{
     *             if(packageitem == null){
     *                 throw new Exception("Packageitem cannot be null");
     *             }
     *             if(packageitem.getId() <= 0){
     *                 throw new Exception("Packageitem entity's id is invalid");
     *             }
     *
     *             packageitemRepository.save(packageitem);
     *             return true;
     *         }
     *         catch (Exception e){
     *             log.error(ERROR_LOG, e);
     *             return false;
     *         }
     *     }
     * */

    /**
     * Access: ALL
     * This function enables to find a package item by its name
     * tested
     * */
    @Override
    public Packageitem findByItemname(String itemname) {
        try{
            List<Packageitem> packageitemList = packageitemRepository.findByItemname(itemname);
            if(packageitemList.size() == 0)
                throw new Exception("Packageitem's name doesn't exist");
            return packageitemList.get(0);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Packageitem();
        }
    }

    /**
     * Access: ALL
     * This function enables to find package items by package id
     * tested
     * */
    @Override
    public List<Packageitem> findPackageItemListByPackageId(String packageId) {
        try{
            return packageitemRepository.findPackageItemListByPackageId(packageId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: ALL
     * This function enables to find package items not in the passed package
     * tested
     * */
    @Override
    public List<Packageitem> findPackageItemListNotInPackage(String packageId) {
        try{
            List<Packageitem> packageitemList = packageitemRepository.findPackageItemListByPackageId(packageId);
            List<Packageitem> allItems = (List<Packageitem>) packageitemRepository.findAll();
            List<Packageitem> list = new ArrayList<>();

            if(packageitemList == null || packageitemList.size() == 0)
                return allItems;

            for(Packageitem obj : allItems){
                boolean status = false;
                for(Packageitem obj2 : packageitemList){
                    if(obj.getId() == obj2.getId())
                        status = true;
                }

                if(status == false)
                    list.add(obj);
            }

            return list;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: ALL
     * This function enables to find package items by its id
     * tested
     * */
    @Override
    public Packageitem findItemById(int id) {
        try{
            if(id <= 0){
                throw new Exception("Packageitem entity's id is invalid");
            }
            Packageitem packageitem = packageitemRepository.findById(id).get();
            return packageitem;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Packageitem();
        }
    }

    /**
     * Access: ALL
     * This function enables to find package items by its id
     * tested
     * */
    @Override
    public List<Packageitem> findByItemnameContaining(String itemname) {
        try {
            List<Packageitem> itemList = packageitemRepository.findByItemnameContaining(itemname);
            if(itemList == null || itemList.size() == 0)
                throw new Exception("No package item exist");
            return itemList;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }
}
