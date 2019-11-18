package com.taikang.crm.config.intercepors;

import com.taikang.crm.setting.model.User;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor implements HandlerInterceptor {

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        System.out.println("进入到登录拦截器");

        boolean flag =true;

        User user= (User) request.getSession().getAttribute("user");
        if (null == user) {
            //重定向到登录页
            /*
                在后台开发，对于响应跳转，使用转发或者重定向技术
                不论使用转发还是重定向，在程序开发中应当一律使用绝对路径
                传统的绝对路径的写法：/项目名/具体的资源路径

                转发：使用的是一种特殊的绝对路径，这种路径前面是不加/项目名 的，这种路径也是转发专用的路径表现形式，也称之为内部路径
                /login.jsp

                重定向：使用的就是传统的绝对路径
                /crm/login.jsp

                使用重定向既然使用到了项目名，就需要将项目名写活
                request.getContextPath()：动态的取得当前项目的  /项目名
             */
            response.sendRedirect("/crm/login.jsp");
            flag = false;
        }

        return flag;
    }
}
