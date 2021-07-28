package com.boralesgamuwa.florists.ordermanagementapp;


public class Test {

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
