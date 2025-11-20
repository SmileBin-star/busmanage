package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusArrivalRecord;
import org.example.busmanagement.model.vo.Result;
<<<<<<< HEAD
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.ArrivalRecordService;
import jakarta.annotation.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;
import org.springframework.beans.propertyeditors.StringTrimmerEditor;
import java.time.LocalDateTime;
import java.util.List;

@Controller
=======
import org.example.busmanagement.service.ArrivalRecordService;
import jakarta.annotation.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;

@RestController
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
@RequestMapping("/arrivalRecord")
public class ArrivalRecordController {

    @Resource
    private ArrivalRecordService arrivalRecordService;

<<<<<<< HEAD
    // 初始化数据绑定，处理日期时间格式
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        // 处理字符串去除空格
        binder.registerCustomEditor(String.class, new StringTrimmerEditor(true));
    }

    // 到站记录管理页面
    @GetMapping("/manage")
    public String manage() {
        return "arrival/manage";
    }

    // 添加到站记录页面
    @GetMapping("/add")
    public String addPage() {
        return "arrival/add";
    }

    // 到站记录列表接口（AJAX）
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            @RequestParam(required = false) Integer scheduleId,
            @RequestParam(required = false) Integer stationId) {
        try {
            PageResult<BusArrivalRecord> pageResult = arrivalRecordService.getRecordPage(pageNum, pageSize, scheduleId, stationId);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 新增到站记录（车辆到达时调用）
    @PostMapping("/add")
    @ResponseBody
=======
    // 新增到站记录（车辆到达时调用）
    @PostMapping("/add")
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    public Result addRecord(@RequestBody BusArrivalRecord record) {
        try {
            boolean success = arrivalRecordService.addArrivalRecord(record);
            return success ? Result.success("到站记录添加成功") : Result.error("添加失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

<<<<<<< HEAD
    // 删除到站记录
    @PostMapping("/delete/{recordId}")
    @ResponseBody
    public Result deleteRecord(@PathVariable Integer recordId) {
        try {
            boolean success = arrivalRecordService.deleteRecord(recordId);
            return success ? Result.success("到站记录删除成功") : Result.error("删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 更新出发时间（车辆离开时调用）
    @PostMapping("/updateDeparture")
    @ResponseBody
=======
    // 更新出发时间（车辆离开时调用）
    @PostMapping("/updateDeparture")
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    public Result updateDeparture(
            @RequestParam Integer recordId,
            @RequestParam @DateTimeFormat(iso = DateTimeFormat.ISO.DATE_TIME) LocalDateTime departureTime) {
        try {
            boolean success = arrivalRecordService.updateDepartureTime(recordId, departureTime);
            return success ? Result.success("出发时间更新成功") : Result.error("更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 更新上下车人数
    @PostMapping("/updatePassengers")
<<<<<<< HEAD
    @ResponseBody
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    public Result updatePassengers(
            @RequestParam Integer recordId,
            @RequestParam(required = false) Integer passengerIn,
            @RequestParam(required = false) Integer passengerOut) {
        try {
            boolean success = arrivalRecordService.updatePassengerCount(recordId, passengerIn, passengerOut);
            return success ? Result.success("乘客数量更新成功") : Result.error("更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 根据班次ID查询记录
    @GetMapping("/bySchedule/{scheduleId}")
<<<<<<< HEAD
    @ResponseBody
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    public Result getBySchedule(@PathVariable Integer scheduleId) {
        try {
            List<BusArrivalRecord> records = arrivalRecordService.getByScheduleId(scheduleId);
            return Result.success(records);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

<<<<<<< HEAD
    // 最近到站页面
    @GetMapping("/latest")
    public String latestPage() {
        return "arrival/latest";
    }

    // 查询站点最新到站记录（API）
    @GetMapping("/latest/{stationId}")
    @ResponseBody
=======
    // 查询站点最新到站记录
    @GetMapping("/latest/{stationId}")
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    public Result getLatest(
            @PathVariable Integer stationId,
            @RequestParam(required = false) Integer limit) {
        try {
            List<BusArrivalRecord> records = arrivalRecordService.getLatestByStationId(stationId, limit);
            return Result.success(records);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }
<<<<<<< HEAD

    // 查询所有最新到站记录（API，用于最近到站页面）
    @GetMapping("/latest/all")
    @ResponseBody
    public Result getAllLatest(
            @RequestParam(required = false) Integer stationId,
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "20") int pageSize) {
        try {
            PageResult<BusArrivalRecord> pageResult = arrivalRecordService.getRecordPage(pageNum, pageSize, null, stationId);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}