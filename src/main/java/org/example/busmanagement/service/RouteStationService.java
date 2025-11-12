package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusRouteStation;
import java.util.List;

public interface RouteStationService {

    // 1. 线路-站点关联管理
    boolean bindStations(Integer routeId, List<BusRouteStation> routeStations);  // 绑定线路与站点（批量）

    boolean updateStations(List<BusRouteStation> routeStations);  // 更新线路-站点关联

    boolean unbindByRouteId(Integer routeId);  // 解除线路与所有站点的关联

    boolean unbindByStationId(Integer stationId);  // 解除站点与所有线路的关联

    // 2. 查询功能
    List<BusRouteStation> getByRouteId(Integer routeId);  // 按线路ID查询关联

    List<BusRouteStation> getWithStationInfo(Integer routeId);  // 按线路ID查询关联（含站点信息）

    List<BusRouteStation> getByStationId(Integer stationId);  // 按站点ID查询关联线路

    BusRouteStation getPrevStation(Integer routeId, Integer stationOrder);  // 获取前一站关联信息

    // 3. 辅助功能
    Integer getMaxStationOrder(Integer routeId);  // 获取线路最大站点顺序
}