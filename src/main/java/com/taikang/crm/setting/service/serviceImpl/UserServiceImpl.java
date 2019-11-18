package com.taikang.crm.setting.service.serviceImpl;

import com.taikang.crm.common.exception.LoginException;
import com.taikang.crm.common.utils.DateTimeUtil;
import com.taikang.crm.setting.mapper.UserMapper;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.setting.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;

    @Override
    public User login(String loginAct, String loginPwd, String ip) throws LoginException {

        /*
            登录的过程：

                验证账号密码是否正确（创建dao层，执行dao层的login方法去验证），返回User对象

                如果登录失败，我们选择使用自定义异常的方式为控制器（controller）提供相应的异常信息

                判断User对象是否为null，如果为null，说明 登录失败，失败原因：账号密码不正确，为控制器throw一个异常，异常信息为账号密码不正确
                    select * from tbl_user where loginAct=? and loginPwd=?

                    如果User对象不为null，说明账号密码正确
                    从User对象中取出expireTime，lockState，allowIps
                    验证expireTime，如果验证失败，说明 登录失败，失败原因：账号已失效，为控制器throw一个异常，异常信息为账号已失效
                    验证lockState，如果验证失败，说明 登录失败，失败原因：账号已锁定，为控制器throw一个异常，异常信息为账号已锁定
                    验证allowIps，如果验证失败，说明 登录失败，失败原因：ip地址受限，为控制器throw一个异常，异常信息为ip地址受限
         */

        //验证账号密码是否正确，返回user对象
        Map<String,Object> paraMap = new HashMap<>();
        paraMap.put("loginAct",loginAct);
        paraMap.put("loginPwd",loginPwd);

        User user = userMapper.login(paraMap);
        //user为null，说明账号密码不正确
        if (null == user) {
            throw new LoginException("账号或密码错误,请重新输入");
        }

        //如果程序能够顺利的走到这一行，说明账号密码正确
        //验证以下3项信息

        //验证失效时间
        String expireTime = user.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();
        if (expireTime.compareTo(currentTime) < 0) {
            throw new LoginException("账号已失效");
        }

        //验证锁定状态
        String lockState = user.getLockState();
        if ("0".equals(lockState)) {
            throw new LoginException("账号已锁定");
        }

        //验证ip地址
        String allowIps = user.getAllowIps();
        if (!allowIps.contains(ip)) {
            throw new LoginException("ip地址受限");
        }

        return user;
    }

    @Override
    public List<User> getUserList() {

        List<User> userList = userMapper.getUserList();

        return userList;
    }
}
