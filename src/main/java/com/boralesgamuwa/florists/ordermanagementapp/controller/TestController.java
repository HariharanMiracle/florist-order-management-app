package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.config.AES;
import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.model.User;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

/**
 * This is a test controller
 * */
@RestController
@RequestMapping("test")
@Slf4j
public class TestController {

    @Autowired
    AES aes;

    @Autowired
    UserService userService;

    @Autowired
    PackageitemService packageitemService;

    @Autowired
    PackageService packageService;

    /**
     * This is a sample endpoint
     * */
    @GetMapping("sample")
    public String sample(){
        return "sample";
    }

    /**
     * This endpoint takes to a jsp page
     * */
    @GetMapping("page")
    public ModelAndView page(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/test/page");
        return modelAndView;
    }

    /**
     * This endpoint enables to create a user
     * */
    @GetMapping("createTestUser/{username}/{name}/{type}/{password}")
    public boolean createTEstUser(@PathVariable String username, @PathVariable String name, @PathVariable String type, @PathVariable String password){
        try{
            User user = new User();
            user.setUsername(username);
            user.setPassword(aes.encrypt(password));
            user.setType(type);
            user.setName(name);
            user.setActive(1);

            userService.saveUser(user);

            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * This endpoint enables to create a package item (item)
     * tested
     * */
    @PostMapping("createPackageItem")
    public boolean createPackageItem(@RequestBody Packageitem packageitem){
        try{
            return packageitemService.saveItem(packageitem);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * This endpoint enables to create a package
     * tested
     * */
    @PostMapping("createPackage")
    public boolean createPackage(@RequestBody Package aPackage){
        try{
            return packageService.savePackage(aPackage);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return false;
        }
    }

    /**
     * This endpoint enables to view a package by its id
     * tested
     * */
    @GetMapping("getPackage/{packageId}")
    public Package getPackage(@PathVariable int packageId){
        try{
            return packageService.getPackageById(packageId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Package();
        }
    }

    /**
     * This endpoint enables to view all the packages
     * tested
     * */
    @GetMapping("getAllPackages")
    public List<Package> getAllPackages(){
        try{
            return packageService.listAllPackages();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * This endpoint enables to view package by its name
     * tested
     * */
    @GetMapping("getPackagesByName/{name}")
    public Package getPackagesByName(@PathVariable String name){
        try{
            return packageService.getPackagesByName(name);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Package();
        }
    }

    /**
     * This endpoint enables to view packages by its name [USING SQL LIKE COMMAND]
     * tested
     * */
    @GetMapping("packageFindByLikeName/{name}")
    public List<Package> packageFindByLikeName(@PathVariable String name){
        try{
            return packageService.findByLikeName(name);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * This endpoint enables to find a package item by its name
     * tested
     * */
    @GetMapping("packageItemfindByItemname/{name}")
    public Packageitem packageItemfindByItemname(@PathVariable String name){
        try{
            return packageitemService.findByItemname(name);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Packageitem();
        }
    }

    /**
     * This endpoint enables to find a package item by its name
     * tested
     * */
    @GetMapping("findPackageItemListByPackageId/{packageId}")
    public List<Packageitem> findPackageItemListByPackageId(@PathVariable String packageId){
        try{
            return packageitemService.findPackageItemListByPackageId(packageId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * This endpoint enables to find packages not in the passed package
     * tested
     * */
    @GetMapping("findPackageItemListNotInPackage/{packageId}")
    public List<Packageitem> findPackageItemListNotInPackage(@PathVariable String packageId){
        try{
            return packageitemService.findPackageItemListNotInPackage(packageId);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }
}
