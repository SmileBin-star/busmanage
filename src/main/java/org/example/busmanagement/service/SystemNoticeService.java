package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.SystemNotice;
import org.example.busmanagement.model.vo.PageResult;
import java.util.List;

public interface SystemNoticeService {

    // 发布新通知
    boolean addNotice(SystemNotice notice);

    // 编辑通知
    boolean updateNotice(SystemNotice notice);

    // 更改通知状态
    boolean changeStatus(Integer noticeId, Integer status);

    // 增加阅读次数
    boolean incrementReadCount(Integer noticeId);

    // 根据ID查询详情
    SystemNotice getNoticeById(Integer noticeId);

    // 分页查询通知
    PageResult<SystemNotice> getNoticePage(Integer status, int pageNum, int pageSize);

    // 获取最新通知
    List<SystemNotice> getLatestNotices(Integer limit);

    // 删除通知
    boolean deleteNotice(Integer noticeId);
}