package org.example.busmanagement.config;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.context.annotation.Configuration;

@Configuration
@MapperScan("org.example.busmanagement.dao")
public class MyBatisConfig {
    // 可在此添加MyBatis自定义配置（如分页插件等）
}