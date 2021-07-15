package com.boralesgamuwa.florists.ordermanagementapp.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("admin")
public class AdminController {
    @GetMapping("home")
    public ModelAndView adminHome(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("admin/home");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }
}
