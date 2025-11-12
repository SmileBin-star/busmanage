package org.example.busmanagement.model.entity;

import jakarta.persistence.Transient;
import lombok.Data;

@Data
public class BusStation {
    private Integer stationId;        // 站点ID（PK）
    private String stationName;       // 站点名称
    private Double latitude;          // 纬度
    private Double longitude;         // 经度
    private String address;           // 详细地址
    private Integer stationType;      // 站点类型：1-普通站/2-枢纽站
    private Integer status;           // 状态：0-关闭/1-启用

    // 关联字段（非数据库字段，用于线路-站点关联查询）
    @Transient
    private Integer stationOrder;     // 在线路中的顺序
    @Transient
    private Double distanceFromPrev;  // 距前一站距离（公里）
    @Transient
    private Integer estimatedTime;    // 预计通过时间（分钟）
}