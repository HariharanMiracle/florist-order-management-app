package com.boralesgamuwa.florists.ordermanagementapp.model;

import lombok.Data;

import javax.persistence.*;

// arun

@Data
@Entity
@Table(name = "orders")
public class Order {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private String orderNo; /** order id created by system */
    private String manualOrderNo;
    private String orderDate; /** yyyy-MM-dd */
    private String title;
    private String name;
    private String address;
    private String religion;
    private String nicNo;
    private String telephoneNo;
    private String deadPersonName;
    private String funeralDate; /** yyyy-MM-dd */
    private String cemetry;
    private String cremationBurrial; /** CREMATION, BURRIAL */
    private String billTo;
    private int packageId;
    private String payMode; /** CREDIT */
    private String orderStatus; /** PROCESSING, COMPLETED, CANCELLED */
    private String billStatus; /** PAID, UN_PAID */
    private double amount; /** Total amount to be paid */
}
