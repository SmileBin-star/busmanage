package org.example.busmanagement.model.entity;

import jakarta.persistence.Transient;
import lombok.Data;
import java.util.List;

@Data
public class BusRoute {
    private Integer routeId;         // 线路ID（PK）
    private String routeName;        // 线路名称
    private Integer startStation;    // 起点站ID（FK）
    private Integer endStation;      // 终点站ID（FK）
    private Integer totalStations;   // 总站点数
    private Double totalDistance;    // 总里程（公里）
    private String departureTime;    // 首班车时间
    private String arrivalTime;      // 末班车时间
    private Integer status;          // 状态：0-停运/1-运营

    @Transient
    private String startStationName; // 起点站名称（非数据库字段）
    @Transient
    private String endStationName;   // 终点站名称（非数据库字段）
    @Transient
    private List<BusStation> stations; // 线路包含的站点列表（非数据库字段）
}