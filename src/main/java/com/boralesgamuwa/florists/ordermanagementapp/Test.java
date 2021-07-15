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
            Date date = new Date();
            LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
            int year = localDate.getYear();
            int month = localDate.getMonthValue();

            System.out.println(year);
            System.out.println(month);
        }
        catch (Exception e){
            System.out.println("Error: " + e);
        }

    }
}
