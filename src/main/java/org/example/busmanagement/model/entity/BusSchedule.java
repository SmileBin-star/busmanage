package org.example.busmanagement.model.entity;

import lombok.Data;

@Data
public class BusSchedule {
    private Integer scheduleId;        // 调度ID（PK）
    private Integer routeId;           // 线路ID（FK）
    private String departureTime;      // 发车时间
    private String arrivalTime;        // 到达时间
    private Integer vehicleId;         // 车辆ID（FK）
    private Integer driverId;          // 司机ID（FK）
    private Integer capacity;          // 核定载客量
    private Integer actualPassengers;  // 实际载客量
    private Integer status;            // 状态：0-取消/1-正常/2-已完成
}