package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.SystemNotice;
import org.example.busmanagement.model.entity.User;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.SystemNoticeService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/systemNotice")
public class SystemNoticeController {

    @Resource
    private SystemNoticeService systemNoticeService;

    // 通知管理页面
    @GetMapping("/manage")
    public String manage() {
        return "notice/manage";
    }

    // 通知列表接口（AJAX）
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(required = false) Integer status,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<SystemNotice> pageResult = systemNoticeService.getNoticePage(status, pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 添加通知页面
    @GetMapping("/add")
    public String addPage() {
        return "notice/add";
    }

    // 发布通知（管理员）
    @PostMapping("/add")
    @ResponseBody
    public Result addNotice(SystemNotice notice, HttpServletRequest request) {
        try {
            // 如果发布者ID为空，从session获取当前登录用户
            if (notice.getPublisherId() == null) {
                User loginUser = (User) request.getSession().getAttribute("loginUser");
                if (loginUser != null) {
                    notice.setPublisherId(loginUser.getUserId());
                } else {
                    return Result.error("请先登录");
                }
            }
            boolean success = systemNoticeService.addNotice(notice);
            return success ? Result.success("通知发布成功") : Result.error("发布失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 编辑通知页面
    @GetMapping("/edit/{noticeId}")
    public String editPage(@PathVariable Integer noticeId, Model model) {
        SystemNotice notice = systemNoticeService.getNoticeById(noticeId);
        if (notice == null) {
            model.addAttribute("error", "通知不存在");
            return "common/error";
        }
        model.addAttribute("notice", notice);
        return "notice/edit";
    }

    // 编辑通知（管理员）
    @PostMapping("/update")
    @ResponseBody
    public Result updateNotice(SystemNotice notice) {
        try {
            boolean success = systemNoticeService.updateNotice(notice);
            return success ? Result.success("通知更新成功") : Result.error("更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 删除通知
    @PostMapping("/delete/{noticeId}")
    @ResponseBody
    public Result deleteNotice(@PathVariable Integer noticeId) {
        try {
            boolean success = systemNoticeService.deleteNotice(noticeId);
            return success ? Result.success("通知删除成功") : Result.error("删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 更改通知状态（管理员）
    @PostMapping("/changeStatus")
    @ResponseBody
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
    @ResponseBody
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

    // 通知列表页面
    @GetMapping("/page")
    public String page() {
        return "notice/page";
    }

    // 分页查询通知列表（API接口）
    @GetMapping("/api/list")
    @ResponseBody
    public Result getNoticePageApi(
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
    @ResponseBody
    public Result getLatestNotices(@RequestParam(required = false) Integer limit) {
        try {
            List<SystemNotice> notices = systemNoticeService.getLatestNotices(limit);
            return Result.success(notices);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }
}