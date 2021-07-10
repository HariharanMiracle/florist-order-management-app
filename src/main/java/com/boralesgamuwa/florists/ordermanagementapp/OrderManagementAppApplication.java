package com.boralesgamuwa.florists.ordermanagementapp;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import springfox.documentation.swagger2.annotations.EnableSwagger2;


@SpringBootApplication
@EnableSwagger2
public class OrderManagementAppApplication {

	public static void main(String[] args) {
		ApplicationContext context = SpringApplication.run(OrderManagementAppApplication.class, args);
	}

}
