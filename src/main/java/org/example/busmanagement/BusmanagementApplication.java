package org.example.busmanagement;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class BusmanagementApplication {
    public static void main(String[] args) {
        SpringApplication.run(BusmanagementApplication.class, args);
    }
}