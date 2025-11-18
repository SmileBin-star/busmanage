package org.example.busmanagement.config;

import org.example.busmanagement.interceptor.LoginInterceptor;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.InterceptorRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurer;

@Configuration
public class InterceptorConfig implements WebMvcConfigurer {

    @Override
    public void addInterceptors(InterceptorRegistry registry) {
        registry.addInterceptor(new LoginInterceptor())
                .addPathPatterns("/**") // 拦截所有请求
                .excludePathPatterns(
                        // 排除登录相关路径（必须包含上下文路径吗？不，这里用相对路径）
                        "/user/login",       // 登录页面
                        "/user/loginSubmit", // 登录提交接口（如果有的话）
                        "/static/**",        // 静态资源
                        "/error"             // 错误页面
                );
    }
}