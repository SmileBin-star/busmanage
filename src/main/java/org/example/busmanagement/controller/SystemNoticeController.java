package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.SystemNotice;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.SystemNoticeService;
import jakarta.annotation.Resource;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/systemNotice")
public class SystemNoticeController {

    @Resource
    private SystemNoticeService systemNoticeService;

    // 发布通知（管理员）
    @PostMapping("/add")
    public Result addNotice(@RequestBody SystemNotice notice) {
        try {
            boolean success = systemNoticeService.addNotice(notice);
            return success ? Result.success("通知发布成功") : Result.error("发布失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 编辑通知（管理员）
    @PostMapping("/update")
    public Result updateNotice(@RequestBody SystemNotice notice) {
        try {
            boolean success = systemNoticeService.updateNotice(notice);
            return success ? Result.success("通知更新成功") : Result.error("更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 更改通知状态（管理员）
    @PostMapping("/changeStatus")
    public Result changeStatus(
            @RequestParam Integer noticeId,
            @RequestParam Integer status) {
        try {
            boolean success = systemNoticeService.changeStatus(noticeId, status);
            String msg = status == 1 ? "通知发布成功" : "通知下架成功";
            return success ? Result.success(msg) : Result.error("操作失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 获取通知详情（带阅读量递增）
    @GetMapping("/detail/{noticeId}")
    public Result getNoticeDetail(@PathVariable Integer noticeId) {
        try {
            // 阅读量+1
            systemNoticeService.incrementReadCount(noticeId);
            SystemNotice notice = systemNoticeService.getNoticeById(noticeId);
            return Result.success(notice);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 分页查询通知列表
    @GetMapping("/page")
    public Result getNoticePage(
            @RequestParam(required = false) Integer status,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<SystemNotice> pageResult = systemNoticeService.getNoticePage(status, pageNum, pageSize);
            return Result.success(pageResult);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 获取最新通知
    @GetMapping("/latest")
    public Result getLatestNotices(@RequestParam(required = false) Integer limit) {
        try {
            List<SystemNotice> notices = systemNoticeService.getLatestNotices(limit);
            return Result.success(notices);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }
}