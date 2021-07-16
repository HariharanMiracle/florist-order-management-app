package com.boralesgamuwa.florists.ordermanagementapp.ResponseDto;

import lombok.Data;

@Data
public class AdminDashboardData {
    private double allProfit;
    private double currentProfit;
    private int allOrdersCount;

    private double completedAllProfit;
    private double completedCurrentProfit;
    private int completedAllOrdersCount;

    private double cancelledAllProfit;
    private double cancelledCurrentProfit;
    private int cancelledAllOrdersCount;

    private double unpaidAllProfit;
    private double unpaidCurrentProfit;
    private int unpaidAllOrdersCount;
}
