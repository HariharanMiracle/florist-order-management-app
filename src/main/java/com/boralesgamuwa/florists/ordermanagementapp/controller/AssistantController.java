package com.boralesgamuwa.florists.ordermanagementapp.controller;

import com.boralesgamuwa.florists.ordermanagementapp.ResponseDto.AdminDashboardData;
import com.boralesgamuwa.florists.ordermanagementapp.model.Order;
import com.boralesgamuwa.florists.ordermanagementapp.service.OrderService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.servlet.ModelAndView;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.ERROR_LOG;

@RestController
@Slf4j
@RequestMapping("assistant")
public class AssistantController {

    @Autowired
    OrderService orderService;

    /**
     * Home - same as admin dash board
     * Display order - payment details
     * Place order
     * Cancel order
     * Pay balance
     * */
    @GetMapping("home")
    public ModelAndView adminHome(){
        ModelAndView modelAndView = new ModelAndView();

        try{
            AdminDashboardData data = new AdminDashboardData();

            data.setAllProfit(0);
            data.setCurrentProfit(0);

            data.setCompletedAllProfit(0);
            data.setCompletedCurrentProfit(0);

            data.setCancelledAllProfit(0);
            data.setCancelledCurrentProfit(0);

            data.setUnpaidAllProfit(0);
            data.setUnpaidCurrentProfit(0);

            List<Order> allOrders = orderService.listAllOrders();
            List<Order> cancelledOrderList = orderService.listAllCancelledOrders();
            List<Order> completedOrders = orderService.listAllCompletedOrders();
            List<Order> unpaidOrders = orderService.listAllUnPaidOrders();

            data.setAllOrdersCount(allOrders.size());
            data.setCompletedAllOrdersCount(completedOrders.size());
            data.setCancelledAllOrdersCount(cancelledOrderList.size());
            data.setUnpaidAllOrdersCount(unpaidOrders.size());

            for(Order order : completedOrders){
                data.setAllProfit(data.getAllProfit() + order.getAmount());
                data.setCompletedAllProfit(data.getCompletedAllProfit() + order.getAmount());

                if(isInCurrentMonth(order.getOrderDate())){
                    data.setCurrentProfit(data.getCurrentProfit() + order.getAmount());
                    data.setCompletedCurrentProfit(data.getCompletedCurrentProfit() + order.getAmount());
                }
            }

            for(Order order : cancelledOrderList){
                data.setCancelledAllProfit(data.getCancelledAllProfit() + order.getAmount());

                if(isInCurrentMonth(order.getOrderDate())){
                    data.setCancelledCurrentProfit(data.getCancelledCurrentProfit() + order.getAmount());
                }
            }

            for(Order order : unpaidOrders){
                data.setUnpaidAllProfit(data.getUnpaidAllProfit() + order.getAmount());

                if(isInCurrentMonth(order.getOrderDate())){
                    data.setUnpaidCurrentProfit(data.getUnpaidCurrentProfit() + order.getAmount());
                }
            }

            modelAndView.setViewName("assistant/home");
            modelAndView.addObject("data", data);
        }
        catch (Exception e){
            modelAndView.setViewName("error/page");
            modelAndView.addObject("error", e.getMessage());
            log.error(ERROR_LOG, e);
        }
        return modelAndView;
    }

    private boolean isInCurrentMonth(String dbDate){
        Date date = new Date();
        LocalDate localDate = date.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();

        String[] dbDateList = dbDate.split("-");
        int dbYear = Integer.parseInt(dbDateList[0]);
        int dbMonth = Integer.parseInt(dbDateList[1]);

        int year = localDate.getYear();
        int month = localDate.getMonthValue();

        if((dbYear == year) && (dbMonth == month))
            return true;
        else
            return false;
    }

}
