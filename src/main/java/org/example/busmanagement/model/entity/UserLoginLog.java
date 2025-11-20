package org.example.busmanagement.model.entity;

import lombok.Data;
import java.time.LocalDateTime;

@Data
public class UserLoginLog {
    private Integer logId;           // 日志ID（PK）
    private Integer userId;          // 用户ID（FK）
    private LocalDateTime loginTime; // 登录时间
    private String loginIp;          // 登录IP
    private Integer loginStatus;     // 登录状态：0-失败/1-成功
    private LocalDateTime logoutTime;// 登出时间

    // 非数据库字段，用于关联查询用户名
    private String username;
}