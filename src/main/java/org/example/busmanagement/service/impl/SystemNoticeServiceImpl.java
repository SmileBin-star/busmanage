package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.SystemNoticeMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.SystemNotice;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.SystemNoticeService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class SystemNoticeServiceImpl implements SystemNoticeService {

    @Resource
    private SystemNoticeMapper systemNoticeMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addNotice(SystemNotice notice) {
        // 校验必填字段
        if (notice.getTitle() == null || notice.getTitle().trim().isEmpty()
                || notice.getContent() == null || notice.getContent().trim().isEmpty()
                || notice.getPublisherId() == null) {
            throw new BusinessException("标题、内容和发布者ID不能为空");
        }
        // 设置默认值
        notice.setPublishTime(LocalDateTime.now());
        notice.setStatus(1); // 默认发布状态
        notice.setReadCount(0);
        return systemNoticeMapper.insert(notice) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateNotice(SystemNotice notice) {
        if (notice.getNoticeId() == null) {
            throw new BusinessException("通知ID不能为空");
        }
        // 校验通知是否存在
        SystemNotice exist = systemNoticeMapper.selectById(notice.getNoticeId());
        if (exist == null) {
            throw new BusinessException("通知不存在");
        }
        return systemNoticeMapper.update(notice) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Integer noticeId, Integer status) {
        if (noticeId == null || status == null) {
            throw new BusinessException("参数不能为空");
        }
        return systemNoticeMapper.updateStatus(noticeId, status) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean incrementReadCount(Integer noticeId) {
        if (noticeId == null) {
            throw new BusinessException("通知ID不能为空");
        }
        return systemNoticeMapper.incrementReadCount(noticeId) > 0;
    }

    @Override
    public SystemNotice getNoticeById(Integer noticeId) {
        if (noticeId == null) {
            throw new BusinessException("通知ID不能为空");
        }
        return systemNoticeMapper.selectById(noticeId);
    }

    @Override
    public PageResult<SystemNotice> getNoticePage(Integer status, int pageNum, int pageSize) {
        int total = systemNoticeMapper.countTotal(status);
        List<SystemNotice> notices = systemNoticeMapper.selectPage(
                status, (pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, notices);
    }

    @Override
    public List<SystemNotice> getLatestNotices(Integer limit) {
        // 默认查询最新5条
        int queryLimit = limit == null || limit <= 0 ? 5 : limit;
        return systemNoticeMapper.selectLatest(queryLimit);
    }
}