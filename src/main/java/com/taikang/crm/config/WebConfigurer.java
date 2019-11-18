package com.taikang.crm.config;

import com.taikang.crm.config.intercepors.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class WebConfigurer implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        // 这个方法用来注册拦截器，我们自己写好的拦截器需要通过这里添加注册才能生效  
        registry.addInterceptor(new LoginInterceptor()).addPathPatterns("/**")
        .excludePathPatterns("/login.jsp","/settings/user/login.do",
                "/index.html","/", "/**/*.css",
                "/**/*.js", "/**/*.png", "/**/*.jpg","/**/*.JPG",
                "/**/*.jpeg", "/**/*.gif", "/**/fonts/*","/**/*.html");

    }

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        // 这个方法是用来配置静态资源的，比如html，js，css，等等
         registry.addResourceHandler("/crm/**")
         .addResourceLocations("classpath:/META-INF/resources/");
         }
}
