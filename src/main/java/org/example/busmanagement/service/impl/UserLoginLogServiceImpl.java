package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.UserLoginLogMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.UserLoginLog;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.UserLoginLogService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class UserLoginLogServiceImpl implements UserLoginLogService {

    @Resource
    private UserLoginLogMapper loginLogMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Integer recordLoginLog(UserLoginLog loginLog) {
        if (loginLog == null || loginLog.getUserId() == null || loginLog.getLoginTime() == null) {
            throw new BusinessException("日志信息不完整");
        }
        loginLogMapper.insert(loginLog);
        return loginLog.getLogId(); // 返回自增的日志ID
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateLogoutTime(Integer logId) {
        if (logId == null) {
            throw new BusinessException("日志ID不能为空");
        }
        return loginLogMapper.updateLogoutTime(logId, LocalDateTime.now()) > 0;
    }

    @Override
    public PageResult<UserLoginLog> getUserLoginLogs(Integer userId, int pageNum, int pageSize) {
        if (userId == null) {
            throw new BusinessException("用户ID不能为空");
        }
        int total = loginLogMapper.countByUserId(userId);
        List<UserLoginLog> logs = loginLogMapper.selectByUserId(userId, (pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, logs);
    }

    @Override
    public PageResult<UserLoginLog> getAllLoginLogs(int pageNum, int pageSize) {
        int total = loginLogMapper.countTotal();
        List<UserLoginLog> logs = loginLogMapper.selectAll((pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, logs);
    }
}