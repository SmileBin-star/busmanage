package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.UserLoginLog;
import org.example.busmanagement.model.vo.PageResult;

public interface UserLoginLogService {
    // 记录登录日志
    Integer recordLoginLog(UserLoginLog loginLog);

    // 更新登出时间
    boolean updateLogoutTime(Integer logId);

    // 查询用户的登录日志（分页）
    PageResult<UserLoginLog> getUserLoginLogs(Integer userId, int pageNum, int pageSize);

    // 查询所有登录日志（管理员用，分页）
    PageResult<UserLoginLog> getAllLoginLogs(int pageNum, int pageSize);
}