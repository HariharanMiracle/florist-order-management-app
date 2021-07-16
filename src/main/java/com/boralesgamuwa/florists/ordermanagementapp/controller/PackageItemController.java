package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packitm;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackItemManageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackitmService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import java.util.ArrayList;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("pacNitem")
public class PackageItemController {

    @Autowired
    private PackitmService packitmService;

    @Autowired
    private PackageitemService packageitemService;

    @Autowired
    private PackageService packageService;

    @GetMapping("list")
    public ModelAndView list() {
        ModelAndView modelAndView = new ModelAndView();

        try {
            List<Package> packageList = packageService.listAllPackages();

            modelAndView.setViewName("admin/packdetails/listview");
            modelAndView.addObject("packageList", packageList);
        } catch (Exception e) {
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("list/{packId}")
    public ModelAndView listPackageDetails(@PathVariable String packId) {
        ModelAndView modelAndView = new ModelAndView();

        try {
            List<Packageitem> itemsInPack = packageitemService.findPackageItemListByPackageId(packId);
            List<Packageitem> itemsNotInPack = packageitemService.findPackageItemListNotInPackage(packId);
            Package pack = packageService.getPackageById(Integer.parseInt(packId));

            modelAndView.setViewName("admin/packdetails/edit");
            modelAndView.addObject("itemsInPack", itemsInPack);
            modelAndView.addObject("itemsNotInPack", itemsNotInPack);
            modelAndView.addObject("pack", pack);
        } catch (Exception e) {
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }


    @PostMapping("modify/{packId}")
    public ModelAndView modifyPackDetails(@PathVariable String packId, @RequestBody String[] newItemList) {
        ModelAndView modelAndView = new ModelAndView();

        try {
            packitmService.savePackItems(newItemList,packId);

            List<Packageitem> itemsInPack = packageitemService.findPackageItemListByPackageId(packId);
            List<Packageitem> itemsNotInPack = packageitemService.findPackageItemListNotInPackage(packId);
            Package pack = packageService.getPackageById(Integer.parseInt(packId));

            modelAndView.setViewName("admin/packdetails/edit");
            modelAndView.addObject("itemsInPack", itemsInPack);
            modelAndView.addObject("itemsNotInPack", itemsNotInPack);
            modelAndView.addObject("pack", pack);

        } catch (Exception e) {
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
            List<Package> packageList = packageService.findByLikeName(name);

            modelAndView.setViewName("admin/packdetails/listview");
            modelAndView.addObject("packageList", packageList);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }
}
