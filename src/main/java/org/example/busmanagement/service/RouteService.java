package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.vo.PageResult;

public interface RouteService {
    PageResult<BusRoute> getRoutePage(int pageNum, int pageSize);
    BusRoute getRouteDetail(Integer routeId);
    boolean addRoute(BusRoute route, Integer[] stationIds);
    boolean updateRoute(BusRoute route);
    boolean changeStatus(Integer routeId, Integer status);
}