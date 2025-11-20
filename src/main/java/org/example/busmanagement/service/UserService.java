package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.User;
import org.example.busmanagement.model.vo.PageResult;

public interface UserService {
    // 根据用户名查询用户
    User getUserByUsername(String username);

    // 根据ID查询用户
    User getUserById(Integer userId);

    // 新增用户
    boolean addUser(User user);

    // 更新用户信息
    boolean updateUser(User user);

    // 修改密码
    boolean updatePassword(Integer userId, String newPassword);
}