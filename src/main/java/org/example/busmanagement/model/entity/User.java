package org.example.busmanagement.model.entity;

import jakarta.persistence.Transient;
import lombok.Data;
import java.time.LocalDateTime;

@Data
public class User {
    private Integer userId;          // 用户ID（PK）
    private String username;         // 用户名
    private String password;         // 密码（BCrypt加密）
    private Integer roleType;        // 角色类型：1-普通用户/2-管理员/3-司机/4-调度员
    private String phone;            // 手机号
    private LocalDateTime createTime; // 创建时间

    @Transient
    private String roleName;         // 角色名称（非数据库字段）
}