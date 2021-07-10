package com.boralesgamuwa.florists.ordermanagementapp.model;

import lombok.Data;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;

@Data
@Entity
public class Orderbill {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private int id;
    private int orderNo;
    private double payment;
    private String date;
    private String type; /** ADVANCE, NOT_ADVANCE */
}
