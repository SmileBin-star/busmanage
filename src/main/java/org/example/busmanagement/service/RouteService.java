package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.vo.PageResult;

public interface RouteService {
    PageResult<BusRoute> getRoutePage(int pageNum, int pageSize);
    BusRoute getRouteDetail(Integer routeId);
    boolean addRoute(BusRoute route, Integer[] stationIds);
    boolean updateRoute(BusRoute route);
    boolean changeStatus(Integer routeId, Integer status);
<<<<<<< HEAD
    boolean deleteRoute(Integer routeId);
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}