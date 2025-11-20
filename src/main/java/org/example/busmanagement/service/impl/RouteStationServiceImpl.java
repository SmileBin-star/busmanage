package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.RouteStationMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusRouteStation;
import org.example.busmanagement.service.RouteStationService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class RouteStationServiceImpl implements RouteStationService {

    @Resource
    private RouteStationMapper routeStationMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean bindStations(Integer routeId, List<BusRouteStation> routeStations) {
        if (routeId == null || routeStations == null || routeStations.isEmpty()) {
            throw new BusinessException("线路ID和站点列表不能为空");
        }
        // 先删除原有关联（避免重复绑定）
        routeStationMapper.deleteByRouteId(routeId);
        // 批量插入新关联
        return routeStationMapper.batchInsert(routeStations) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateStations(List<BusRouteStation> routeStations) {
        if (routeStations == null || routeStations.isEmpty()) {
            throw new BusinessException("更新列表不能为空");
        }
        // 校验是否存在ID
        for (BusRouteStation rs : routeStations) {
            if (rs.getId() == null) {
                throw new BusinessException("关联ID不能为空");
            }
        }
        return routeStationMapper.batchUpdate(routeStations) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean unbindByRouteId(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return routeStationMapper.deleteByRouteId(routeId) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean unbindByStationId(Integer stationId) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        return routeStationMapper.deleteByStationId(stationId) > 0;
    }

    @Override
    public List<BusRouteStation> getByRouteId(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return routeStationMapper.selectByRouteId(routeId);
    }

    @Override
    public List<BusRouteStation> getWithStationInfo(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return routeStationMapper.selectWithStationInfo(routeId);
    }

    @Override
    public List<BusRouteStation> getByStationId(Integer stationId) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        return routeStationMapper.selectByStationId(stationId);
    }

    @Override
    public BusRouteStation getPrevStation(Integer routeId, Integer stationOrder) {
        if (routeId == null || stationOrder == null || stationOrder <= 1) {
            return null;  // 第一站没有前一站
        }
        return routeStationMapper.selectPrevStation(routeId, stationOrder);
    }

    @Override
    public Integer getMaxStationOrder(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return routeStationMapper.selectMaxOrderByRouteId(routeId);
    }
}