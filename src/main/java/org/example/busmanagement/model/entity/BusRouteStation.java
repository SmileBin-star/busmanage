package org.example.busmanagement.model.entity;

import lombok.Data;

@Data
public class BusRouteStation {
    private Integer id;                 // 关联ID（PK）
    private Integer routeId;            // 线路ID（FK）
    private Integer stationId;          // 站点ID（FK）
    private Integer stationOrder;       // 站点顺序（1开始）
    private Double distanceFromPrev;    // 距前一站距离（公里）
    private Integer estimatedTime;      // 预计通过时间（分钟，从前一站到本站）
}