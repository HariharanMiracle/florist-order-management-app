package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.model.Packageitem;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackItemManageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageitemService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("pacNitem")
public class PackageItemController {

    @Autowired
    private PackItemManageService packItemManageService;

    @Autowired
    private PackageitemService packageitemService;

    @Autowired
    private PackageService packageService;

    @GetMapping("list")
    public ModelAndView list() {
        ModelAndView modelAndView = new ModelAndView();

        try {

            modelAndView.setViewName("admin/packdetails/listview");

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
}
