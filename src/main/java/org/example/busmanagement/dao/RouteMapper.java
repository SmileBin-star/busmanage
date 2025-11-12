package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.entity.BusStation;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface RouteMapper {
    List<BusRoute> selectAll(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);
    int countTotal();
    BusRoute selectById(Integer routeId);
    List<BusStation> selectStationsByRouteId(Integer routeId);
    int insert(BusRoute route);
    int update(BusRoute route);
    int updateStatus(@Param("routeId") Integer routeId, @Param("status") Integer status);
}