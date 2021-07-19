package com.boralesgamuwa.florists.ordermanagementapp;

import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;

public class Test {

    @Autowired
    private  static UserService userService;

    public static void main(String[] args) {
        try{
            System.out.println("test method2");
            String a = "[\"2\",\"800\"]";
            String[] b = a.split("\"");
            System.out.println(b);
            // 1, 3

            String savedOrderId = "ORD" +  String.format("%07d", 5);
            System.out.println(savedOrderId);
        }
        catch (Exception e){
            System.out.println("Error: " + e);
        }

    }
}
