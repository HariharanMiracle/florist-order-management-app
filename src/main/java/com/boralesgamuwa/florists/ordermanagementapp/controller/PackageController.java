package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.model.Package;
import com.boralesgamuwa.florists.ordermanagementapp.service.PackageService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("package")
public class PackageController {

    @Autowired
    PackageService packageService;

    @GetMapping("list")
    public ModelAndView list(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            List<Package> packageList = packageService.listAllPackages();

            modelAndView.setViewName("admin/packages/listview");
            modelAndView.addObject("packageList", packageList);
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
            List<Package> packageList = packageService.findByLikeName(name);

            modelAndView.setViewName("admin/packages/listview");
            modelAndView.addObject("packageList", packageList);
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
            modelAndView.setViewName("admin/packages/add");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("add")
    public ModelAndView add(@RequestParam("name") String name){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            Package pkg = new Package();
            pkg.setName(name);
            pkg.setId(0);

            packageService.savePackage(pkg);

            return new ModelAndView("redirect:" + baseUrl + "/package/list");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("edit/{id}")
    public ModelAndView editForm(@PathVariable int id){
        ModelAndView modelAndView = new ModelAndView();

        try{
            Package pkg = packageService.getPackageById(id);
            modelAndView.setViewName("admin/packages/edit");
            modelAndView.addObject("pkg", pkg);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("edit")
    public ModelAndView edit(@RequestParam("id") int id, @RequestParam("name") String name, @RequestParam("amount") double amount){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            Package pkg = new Package();
            pkg.setId(id);
            pkg.setName(name);
            pkg.setAmount(amount);

            packageService.editPackage(pkg);

            return new ModelAndView("redirect:" + baseUrl + "/package/list");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

}
