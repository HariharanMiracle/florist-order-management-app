package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.config.AES;
import com.boralesgamuwa.florists.ordermanagementapp.model.User;
import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

@RestController
@RequestMapping("test")
public class TestController {

    @Autowired
    AES aes;

    @Autowired
    UserService userService;

//    @GetMapping("page")
//    public ModelAndView page(){
//        ModelAndView modelAndView = new ModelAndView();
//        modelAndView.setViewName("/test/page");
//        return modelAndView;
//    }

//    @GetMapping("sample")
//    public String sample(){
//        return "sample";
//    }

//    @GetMapping("createTestUser/{username}/{name}/{type}/{password}")
//    public boolean createTEstUser(@PathVariable String username, @PathVariable String name, @PathVariable String type, @PathVariable String password){
//        try{
//            User user = new User();
//            user.setUsername(username);
//            user.setPassword(aes.encrypt(password));
//            user.setType(type);
//            user.setName(name);
//            user.setActive(1);
//
//            userService.saveUser(user);
//
//            return true;
//        }
//        catch (Exception e){
//            System.out.println("Error: " + e.toString());
//            e.printStackTrace();
//            return false;
//        }
//    }
}
