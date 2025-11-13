package org.example.busmanagement.model.entity;

import lombok.Data;

import java.math.BigDecimal;
import java.util.Date;

@Data
public class BusVehicle {
    private Integer vehicleId;         // 车辆ID（PK）
    private Integer routeId;           // 所属线路ID（FK）
    private String licensePlate;       // 车牌号（唯一）
    private Integer vehicleType;       // 车辆类型（1-普通公交/2-快速公交等）
    private Date purchaseTime;         // 购置时间
    private BigDecimal mileage;        // 总里程（公里）
    private Integer status;            // 状态：0-停用/1-运营
    private Integer driverId;          // 司机ID（FK，可为空）
}