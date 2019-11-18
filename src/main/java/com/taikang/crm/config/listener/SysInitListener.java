package com.taikang.crm.config.listener;

import com.taikang.crm.setting.model.DicValue;
import com.taikang.crm.setting.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.util.*;

@WebListener
public class SysInitListener implements ServletContextListener {

    @Autowired
    private DicService dicService;

    @Override
    public void contextInitialized(ServletContextEvent sce) {

        System.out.println("服务器缓存处理数据字典开始");

        ServletContext application = sce.getServletContext();

        Map<String, List<DicValue>> map = dicService.getAllDics();

        Set<String> keySet = map.keySet();
        for (String key : keySet) {
            application.setAttribute(key, map.get(key));
        }

        System.out.println("服务器缓存处理数据字典结束");


    }
}
