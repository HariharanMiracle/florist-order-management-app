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
            modelAndView.setViewName("assistant/home");
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
