package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusRouteStation;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface RouteStationMapper {

    // 1. 基础CRUD
    BusRouteStation selectById(Integer id);

    List<BusRouteStation> selectByRouteId(Integer routeId);

    List<BusRouteStation> selectByStationId(Integer stationId);

    int insert(BusRouteStation routeStation);

    int update(BusRouteStation routeStation);

    int deleteById(Integer id);

    // 2. 批量操作
    int batchInsert(List<BusRouteStation> list);

    int batchUpdate(List<BusRouteStation> list);

    int deleteByRouteId(Integer routeId);

    int deleteByStationId(Integer stationId);

    // 3. 业务查询
    List<BusRouteStation> selectWithStationInfo(Integer routeId);  // 关联查询站点信息

    Integer selectMaxOrderByRouteId(Integer routeId);  // 查询线路最大站点顺序

    BusRouteStation selectPrevStation(@Param("routeId") Integer routeId, @Param("stationOrder") Integer stationOrder);  // 查询前一站
}