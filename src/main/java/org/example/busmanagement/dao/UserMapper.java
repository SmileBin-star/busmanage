package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.User;
import org.apache.ibatis.annotations.Param;

public interface UserMapper {
    // 根据用户名查询用户
    User selectByUsername(String username);

    // 根据用户ID查询用户
    User selectById(Integer userId);

    // 新增用户
    int insert(User user);

    // 更新用户信息（不含密码）
    int update(User user);

    // 更新密码
    int updatePassword(@Param("userId") Integer userId, @Param("newPassword") String newPassword);
}