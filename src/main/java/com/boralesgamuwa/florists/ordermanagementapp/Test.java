package com.boralesgamuwa.florists.ordermanagementapp;

import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

public class Test {

    @Autowired
    private  static UserService userService;

    public static void main(String[] args) {
        try{
            System.out.println("test method2");
        }
        catch (Exception e){
            System.out.println("Error: " + e);
        }

    }
}
