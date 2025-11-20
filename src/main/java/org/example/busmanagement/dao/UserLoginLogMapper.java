package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.UserLoginLog;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface UserLoginLogMapper {
    // 新增登录日志
    int insert(UserLoginLog loginLog);

    // 更新登出时间
    int updateLogoutTime(@Param("logId") Integer logId, @Param("logoutTime") LocalDateTime logoutTime);

    // 根据用户ID查询登录日志（分页）
    List<UserLoginLog> selectByUserId(@Param("userId") Integer userId, 
                                     @Param("pageNum") int pageNum, 
                                     @Param("pageSize") int pageSize);

    // 查询用户日志总数
    int countByUserId(Integer userId);

    // 查询所有日志（管理员用，分页）
    List<UserLoginLog> selectAll(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    // 查询所有日志总数
    int countTotal();
}