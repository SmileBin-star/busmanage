package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.RouteMapper;
import org.example.busmanagement.dao.RouteStationMapper;
<<<<<<< HEAD
import org.example.busmanagement.exception.BusinessException;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.entity.BusRouteStation;
import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.RouteService;
<<<<<<< HEAD
import org.example.busmanagement.service.StationService;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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

<<<<<<< HEAD
    @Resource
    private StationService stationService;

=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD
        // 验证线路名称不能为空
        if (route.getRouteName() == null || route.getRouteName().trim().isEmpty()) {
            throw new BusinessException("线路名称不能为空");
        }

        // 验证线路名称唯一性
        BusRoute existingRoute = routeMapper.selectByRouteName(route.getRouteName().trim());
        if (existingRoute != null) {
            throw new BusinessException("线路名称 \"" + route.getRouteName() + "\" 已存在，请使用其他名称");
        }

        // 验证起点站是否存在
        if (route.getStartStation() != null) {
            BusStation startStation = stationService.getStationById(route.getStartStation());
            if (startStation == null) {
                throw new BusinessException("起点站ID " + route.getStartStation() + " 不存在");
            }
        } else {
            throw new BusinessException("起点站ID不能为空");
        }

        // 验证终点站是否存在
        if (route.getEndStation() != null) {
            BusStation endStation = stationService.getStationById(route.getEndStation());
            if (endStation == null) {
                throw new BusinessException("终点站ID " + route.getEndStation() + " 不存在");
            }
        } else {
            throw new BusinessException("终点站ID不能为空");
        }

        // 验证起点站和终点站不能相同
        if (route.getStartStation().equals(route.getEndStation())) {
            throw new BusinessException("起点站和终点站不能相同");
        }

=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD
        if (route.getRouteId() == null) {
            throw new BusinessException("线路ID不能为空");
        }
        
        // 验证线路名称不能为空
        if (route.getRouteName() == null || route.getRouteName().trim().isEmpty()) {
            throw new BusinessException("线路名称不能为空");
        }

        // 验证线路名称唯一性（排除当前线路）
        BusRoute existingRoute = routeMapper.selectByRouteName(route.getRouteName().trim());
        if (existingRoute != null && !existingRoute.getRouteId().equals(route.getRouteId())) {
            throw new BusinessException("线路名称 \"" + route.getRouteName() + "\" 已被其他线路使用，请使用其他名称");
        }
        
        // 验证起点站是否存在
        if (route.getStartStation() != null) {
            BusStation startStation = stationService.getStationById(route.getStartStation());
            if (startStation == null) {
                throw new BusinessException("起点站ID " + route.getStartStation() + " 不存在");
            }
        }

        // 验证终点站是否存在
        if (route.getEndStation() != null) {
            BusStation endStation = stationService.getStationById(route.getEndStation());
            if (endStation == null) {
                throw new BusinessException("终点站ID " + route.getEndStation() + " 不存在");
            }
        }

        // 验证起点站和终点站不能相同
        if (route.getStartStation() != null && route.getEndStation() != null 
                && route.getStartStation().equals(route.getEndStation())) {
            throw new BusinessException("起点站和终点站不能相同");
        }

=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
        return routeMapper.update(route) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Integer routeId, Integer status) {
        return routeMapper.updateStatus(routeId, status) > 0;
    }
<<<<<<< HEAD

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteRoute(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        
        // 检查线路是否存在
        BusRoute route = routeMapper.selectById(routeId);
        if (route == null) {
            throw new BusinessException("线路不存在");
        }

        // 先删除线路站点关联（外键约束）
        routeStationMapper.deleteByRouteId(routeId);
        
        // 删除线路
        return routeMapper.deleteById(routeId) > 0;
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}