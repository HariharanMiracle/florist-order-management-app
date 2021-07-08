package com.boralesgamuwa.florists.ordermanagementapp.service.impl;

import com.boralesgamuwa.florists.ordermanagementapp.model.User;
import com.boralesgamuwa.florists.ordermanagementapp.repository.UserRepository;
import com.boralesgamuwa.florists.ordermanagementapp.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import static com.boralesgamuwa.florists.ordermanagementapp.util.Constant.*;

@Service
@Slf4j
public class UserServiceImpl implements UserService {

    @Autowired
    UserRepository userRepository;

    @Autowired
    PasswordEncoder passwordEncoder;

    @Override
    public boolean saveUser(User user) {
        try{
            userRepository.save(user);
            return true;
        }
        catch (Exception e){
            log.error(ERROR_LOG, e);
        }
        return false;
    }
}
