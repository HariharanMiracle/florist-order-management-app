package com.boralesgamuwa.florists.ordermanagementapp;

import com.boralesgamuwa.florists.ordermanagementapp.model.User;
import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.ApplicationContext;
import springfox.documentation.swagger2.annotations.EnableSwagger2;


@SpringBootApplication
@EnableSwagger2
public class OrderManagementAppApplication {

	public static void main(String[] args) {
		ApplicationContext context = SpringApplication.run(OrderManagementAppApplication.class, args);
//		UserService userService = context.getBean(UserService.class);
//
//		User user = new User();
//		user.setUsername("admin");
//		user.setPassword("admin@2021");
//		user.setType("ADMIN");
//		user.setName("Admin");
//		user.setActive(1);
//
//		userService.saveUser(user);
	}

}
