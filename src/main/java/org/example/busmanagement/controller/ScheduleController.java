package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusSchedule;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.ScheduleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/schedule")
public class ScheduleController {

    @Resource
    private ScheduleService scheduleService;

    // 调度列表页面
    @GetMapping("/manage")
    public String manage() {
        // 页面通过 AJAX 加载数据，这里不需要设置 Model
        return "schedule/manage";
    }

    // 调度列表接口（AJAX）- 供 manage.jsp 使用
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) Integer routeId,
            @RequestParam(required = false) Integer status) {
        try {
            PageResult<BusSchedule> pageResult = scheduleService.getSchedulePage(pageNum, pageSize, routeId, status);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 添加调度页面
    @GetMapping("/add")
    public String addPage() {
        return "schedule/add";
    }

    // 提交添加调度
    @PostMapping("/add")
    @ResponseBody
    public Result addSchedule(BusSchedule schedule) {
        try {
            boolean success = scheduleService.addSchedule(schedule);
            return success ? Result.success("调度添加成功") : Result.error("调度添加失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 编辑调度页面
    @GetMapping("/edit/{scheduleId}")
    public String editPage(@PathVariable Integer scheduleId, Model model) {
        BusSchedule schedule = scheduleService.getScheduleById(scheduleId);
        if (schedule == null) {
            model.addAttribute("error", "调度记录不存在");
            return "common/error";
        }
        model.addAttribute("schedule", schedule);
        return "schedule/edit";
    }

    // 提交编辑调度
    @PostMapping("/edit")
    @ResponseBody
    public Result editSchedule(BusSchedule schedule) {
        try {
            boolean success = scheduleService.updateSchedule(schedule);
            return success ? Result.success("调度更新成功") : Result.error("调度更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 取消调度
    @PostMapping("/cancel")
    @ResponseBody
    public Result cancelSchedule(Integer scheduleId) {
        try {
            boolean success = scheduleService.updateScheduleStatus(scheduleId, 0);
            return success ? Result.success("调度已取消") : Result.error("操作失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 批量取消调度
    @PostMapping("/batchCancel")
    @ResponseBody
    public Result batchCancel(@RequestBody List<Integer> scheduleIds) {
        try {
            boolean success = scheduleService.batchCancel(scheduleIds);
            return success ? Result.success("批量取消成功") : Result.error("操作失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 按线路ID查询调度（AJAX）
    @GetMapping("/getByRoute/{routeId}")
    @ResponseBody
    public Result getByRoute(@PathVariable Integer routeId) {
        try {
            List<BusSchedule> schedules = scheduleService.getByRouteId(routeId);
            return Result.success(schedules);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 删除调度
    @PostMapping("/delete/{scheduleId}")
    @ResponseBody
    public Result deleteSchedule(@PathVariable Integer scheduleId) {
        try {
            boolean success = scheduleService.deleteSchedule(scheduleId);
            return success ? Result.success("调度删除成功") : Result.error("调度删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
}