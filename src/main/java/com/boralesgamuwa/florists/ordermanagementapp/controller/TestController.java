package com.boralesgamuwa.florists.ordermanagementapp.controller;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("test")
public class TestController {

    @GetMapping("page")
    public ModelAndView page(){
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.setViewName("/test/page");
        return modelAndView;
    }

    @GetMapping("sample")
    public String sample(){
        return "sample";
    }
}
