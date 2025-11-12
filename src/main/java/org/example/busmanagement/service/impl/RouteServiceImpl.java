package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.RouteMapper;
import org.example.busmanagement.dao.RouteStationMapper;
import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.entity.BusRouteStation;
import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.RouteService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class RouteServiceImpl implements RouteService {

    @Resource
    private RouteMapper routeMapper;

    @Resource
    private RouteStationMapper routeStationMapper;

    @Override
    public PageResult<BusRoute> getRoutePage(int pageNum, int pageSize) {
        int total = routeMapper.countTotal();
        List<BusRoute> routes = routeMapper.selectAll((pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, routes);
    }

    @Override
    public BusRoute getRouteDetail(Integer routeId) {
        BusRoute route = routeMapper.selectById(routeId);
        if (route != null) {
            List<BusStation> stations = routeMapper.selectStationsByRouteId(routeId);
            route.setStations(stations);
        }
        return route;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addRoute(BusRoute route, Integer[] stationIds) {
        int rows = routeMapper.insert(route);
        if (rows <= 0) {
            return false;
        }
        for (int i = 0; i < stationIds.length; i++) {
            BusRouteStation rs = new BusRouteStation();
            rs.setRouteId(route.getRouteId());
            rs.setStationId(stationIds[i]);
            rs.setStationOrder(i + 1);
            routeStationMapper.insert(rs);
        }
        return true;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateRoute(BusRoute route) {
        return routeMapper.update(route) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Integer routeId, Integer status) {
        return routeMapper.updateStatus(routeId, status) > 0;
    }
}