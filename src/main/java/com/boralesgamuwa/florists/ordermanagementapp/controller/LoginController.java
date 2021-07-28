package com.boralesgamuwa.florists.ordermanagementapp.controller;

import lombok.extern.slf4j.Slf4j;
import org.springframework.security.web.WebAttributes;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.support.ServletUriComponentsBuilder;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
public class LoginController {

    @GetMapping("login")
    public ModelAndView login(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("login");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("login-success")
    public ModelAndView loginSuccess(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("login-succ");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    @GetMapping("login-error")
    public ModelAndView login(HttpServletRequest request, ModelAndView model) {
        try{
            HttpSession session = request.getSession(false);
            String errorMessage = null;
            if (session != null) {
                String ex = session.getAttribute(WebAttributes.AUTHENTICATION_EXCEPTION).toString();
                if(ex != null && !ex.isEmpty()){
                    String splitEx[] = ex.split(":");
                    errorMessage = splitEx[1];
                }
                else{
                    errorMessage = "Something went wrong!!!";
                }
            }
            model.setViewName("login");
            model.addObject("error", errorMessage);
            return model;
        }
        catch (Exception e){
            System.out.println("msg: " + e.getMessage());
            return model;
        }
    }

    @GetMapping("accessDenied")
    public ModelAndView accessDenied(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            modelAndView.setViewName("accessDenied");
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }
}
