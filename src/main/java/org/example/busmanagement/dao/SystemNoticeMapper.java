package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.SystemNotice;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface SystemNoticeMapper {

    // 新增通知
    int insert(SystemNotice notice);

    // 更新通知
    int update(SystemNotice notice);

    // 更新状态（发布/下架）
    int updateStatus(@Param("noticeId") Integer noticeId, @Param("status") Integer status);

    // 更新阅读次数
    int incrementReadCount(Integer noticeId);

    // 根据ID查询
    SystemNotice selectById(Integer noticeId);

    // 分页查询通知（支持状态筛选）
    List<SystemNotice> selectPage(
            @Param("status") Integer status,
            @Param("pageNum") int pageNum,
            @Param("pageSize") int pageSize);

    // 统计总数（支持状态筛选）
    int countTotal(@Param("status") Integer status);

    // 查询最新通知（限制条数）
    List<SystemNotice> selectLatest(@Param("limit") Integer limit);
}