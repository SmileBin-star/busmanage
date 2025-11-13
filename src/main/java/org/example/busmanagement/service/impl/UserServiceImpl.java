package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.UserMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.User;
import org.example.busmanagement.service.UserService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class UserServiceImpl implements UserService {

    @Resource
    private UserMapper userMapper;

    @Override
    public User getUserByUsername(String username) {
        if (username == null || username.trim().isEmpty()) {
            throw new BusinessException("用户名不能为空");
        }
        return userMapper.selectByUsername(username.trim());
    }

    @Override
    public User getUserById(Integer userId) {
        if (userId == null) {
            throw new BusinessException("用户ID不能为空");
        }
        return userMapper.selectById(userId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addUser(User user) {
        if (user == null || user.getUsername() == null) {
            throw new BusinessException("用户信息不完整");
        }
        // 校验用户名是否已存在
        User exist = userMapper.selectByUsername(user.getUsername());
        if (exist != null) {
            throw new BusinessException("用户名已存在");
        }
        return userMapper.insert(user) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateUser(User user) {
        if (user == null || user.getUserId() == null) {
            throw new BusinessException("用户ID不能为空");
        }
        return userMapper.update(user) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updatePassword(Integer userId, String newPassword) {
        if (userId == null || newPassword == null) {
            throw new BusinessException("参数不能为空");
        }
        return userMapper.updatePassword(userId, newPassword) > 0;
    }
}