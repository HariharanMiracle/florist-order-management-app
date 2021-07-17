package com.boralesgamuwa.florists.ordermanagementapp.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("login")
public class LoginController {

    @GetMapping("admin")
    public ModelAndView adminLoginForm(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("admin/login");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("admin")
    public ModelAndView adminLogin(@RequestParam("username") String username, @RequestParam("password") String password){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            log.info("username: {}", username);
            log.info("password: {}", password);

            /**
             * Validation
             * */
            return new ModelAndView("redirect:" + baseUrl + "/admin/home");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("assistant")
    public ModelAndView assistantLoginForm(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("assistant/login");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @PostMapping("assistant")
    public ModelAndView assistantLogin(@RequestParam("username") String username, @RequestParam("password") String password){
        ModelAndView modelAndView = new ModelAndView();

        try{
            final String baseUrl = ServletUriComponentsBuilder.fromCurrentContextPath().build().toUriString();

            log.info("username: {}", username);
            log.info("password: {}", password);

            /**
             * Validation
             * */
            return new ModelAndView("redirect:" + baseUrl + "/assistant/home");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

}
