package org.example.busmanagement.model.entity;

import lombok.Data;
import jakarta.persistence.Transient;
import java.time.LocalDateTime;

@Data
public class BusArrivalRecord {
    private Integer recordId;             // 记录ID（PK）
    private Integer vehicleId;            // 车辆ID（FK）
    private Integer stationId;            // 站点ID（FK）
    private Integer scheduleId;           // 班次ID（FK）
    private LocalDateTime actualArrivalTime;   // 实际到达时间
    private LocalDateTime actualDepartureTime; // 实际出发时间（可为空）
    private Integer delayMinutes;         // 延误分钟数（默认0）
    private Integer passengerIn;          // 上车人数（默认0）
    private Integer passengerOut;         // 下车人数（默认0）

    // 关联字段（非数据库字段，用于关联查询）
    @Transient
    private String stationName;           // 站点名称
    @Transient
    private String licensePlate;          // 车牌号
}