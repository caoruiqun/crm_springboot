package com.taikang.crm.setting.service;

import com.taikang.crm.common.exception.LoginException;
import com.taikang.crm.setting.model.User;

import java.util.List;

public interface UserService {
    User login(String loginAct, String loginPwd, String ip) throws LoginException;

    List<User> getUserList();
}
