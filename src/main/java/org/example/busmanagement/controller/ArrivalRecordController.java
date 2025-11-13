package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusArrivalRecord;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.ArrivalRecordService;
import jakarta.annotation.Resource;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;
import java.util.List;

@RestController
@RequestMapping("/arrivalRecord")
public class ArrivalRecordController {

    @Resource
    private ArrivalRecordService arrivalRecordService;

    // 新增到站记录（车辆到达时调用）
    @PostMapping("/add")
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

    // 更新出发时间（车辆离开时调用）
    @PostMapping("/updateDeparture")
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
    public Result getBySchedule(@PathVariable Integer scheduleId) {
        try {
            List<BusArrivalRecord> records = arrivalRecordService.getByScheduleId(scheduleId);
            return Result.success(records);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    // 查询站点最新到站记录
    @GetMapping("/latest/{stationId}")
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
}