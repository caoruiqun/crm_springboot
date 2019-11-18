package com.taikang.crm.setting.controller;

import com.taikang.crm.common.exception.LoginException;
import com.taikang.crm.common.utils.MD5Util;
import com.taikang.crm.setting.model.User;
import com.taikang.crm.setting.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserController {
    @Autowired
    private UserService userService;

    @RequestMapping("/settings/user/login.do")
    @ResponseBody
    public Object login(HttpServletRequest request,
                      @RequestParam (value = "loginAct",required = true) String loginAct,
                        @RequestParam (value = "loginPwd",required = true) String loginPwd) {

        System.out.println("进入到验证登录的操作");
        //密码加密
        loginPwd = MD5Util.getMD5(loginPwd);

        //接收ip地址
        String ip = request.getRemoteAddr();
        System.out.println("ip:"+ip);

        /*

                为前端同时响应多个信息，我们要考虑使用

                map
                    可以

                vo
                    可以

                如果该需求的复用率比较高，创建一个vo类，使用非常方便
                如果该需求仅仅只是在当前出现，创建vo类对于系统的开销太大了，临时使用map就可以了

                观察我们现在的需求，需要为前端提供success表示登陆失败，提供msg错误消息，这种需求就在当前登录下有用，
                                                                                    所以我们选择使用map就可以了

             */
        Map<String,Object> retMap = new HashMap<>();

        try {
             /*

                登录成功后，为前端响应的信息为：
                    {"success":true}

             */
            User user = userService.login(loginAct,loginPwd,ip);
            request.getSession().setAttribute("user", user);
//            HttpSession session = request.getSession();
//            session.setAttribute("user", user);

            retMap.put("success", true);
            return retMap;
        } catch (LoginException e) {
            //一旦进入到catch块，证明业务层执行登录业务的过程中，一定出现了异常
            //登录失败

            /*

                登录失败后，为前端响应的信息为：
                    {"success":false,"msg":错误信息}

             */
            retMap.put("success", false);
            retMap.put("msg", e.getMessage());
        }

        return retMap;
    }
}
