package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.config.AES;
import com.boralesgamuwa.florists.ordermanagementapp.model.*;
import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
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

    @Autowired
    OrderService orderService;

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

    /**
     * This endpoint enables to find package by its id
     * tested
     * */
    @GetMapping("findItemById/{id}")
    public Packageitem findItemById(@PathVariable int id){
        try{
            return packageitemService.findItemById(id);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Packageitem();
        }
    }

    /**
     * This function enables to list all orders
     * tested
     * */
    @GetMapping("listAllOrders")
    public List<Order> listAllOrders(){
        try{
            return orderService.listAllOrders();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * This function enables to get order by order id
     * tested
     * */
    @GetMapping("getOrderById/{id}")
    public Order getOrderById(@PathVariable int id){
        try{
            return orderService.getOrderById(id);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    /**
     * This endpoint enables to get Orderitem list by order id
     * tested
     * */
    @GetMapping("listOrderItemByOrderId/{id}")
    public List<Orderitem> listOrderItemByOrderId(@PathVariable int id){
        try{
            return orderService.listOrderItemByOrderId(id);
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new ArrayList<>();
        }
    }

    /**
     * Access: All
     * This endpoint enables to get order by order id created from system
     * tested
     * */
    @GetMapping("getOrderByOrderId/{id}")
    public Order getOrderByOrderId(@PathVariable String id){
        try{
            Order order = orderService.getOrderByOrderId(id);
            if(order != null)
                return order;
            else
                return new Order();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }

    /**
     * Access: All
     * This endpoint enables to get order by order id created from system
     * tested
     * */
    @GetMapping("getOrderByManualOrderId/{id}")
    public Order getOrderByManualOrderId(@PathVariable String id){
        try{
            Order order = orderService.getOrderByManualOrderId(id);
            if(order != null)
                return order;
            else
                return new Order();
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
            return new Order();
        }
    }
}
