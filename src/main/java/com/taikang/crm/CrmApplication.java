package com.taikang.crm;

import com.taikang.crm.config.PropertiesListener;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;

@SpringBootApplication
@ServletComponentScan
public class CrmApplication {

    public static void main(String[] args) {
//        SpringApplication.run(CrmApplication.class, args);
        SpringApplication application = new SpringApplication(CrmApplication.class);
        // 第四种方式：注册监听器
        application.addListeners(new PropertiesListener("Stage2Possibility.properties"));
        application.run(args);
    }

}
