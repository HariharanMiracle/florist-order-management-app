package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("item")
public class ItemController {

    @Autowired
    PackageitemService packageitemService;

    @GetMapping("list")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            List<Packageitem> itemList = packageitemService.listAllItems();

            modelAndView.setViewName("admin/items/listview");
            modelAndView.addObject("itemList", itemList);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("search")
    public ModelAndView search(@RequestParam("name") String name){
        ModelAndView modelAndView = new ModelAndView();

        try{
            List<Packageitem> itemList = packageitemService.findByItemnameContaining(name);

            modelAndView.setViewName("admin/items/listview");
            modelAndView.addObject("itemList", itemList);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("add")
    public ModelAndView addForm(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("admin/items/add");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("add")
    public ModelAndView add(@RequestParam("name") String name, @RequestParam("amount") double amount){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            Packageitem item = new Packageitem();
            item.setId(0);
            item.setItemname(name);
            item.setAmount(amount);

            packageitemService.saveItem(item);

            return new ModelAndView("redirect:" + baseUrl + "/item/list");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

}
