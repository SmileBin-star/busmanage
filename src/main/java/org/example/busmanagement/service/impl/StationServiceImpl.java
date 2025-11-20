package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.StationMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.StationService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class StationServiceImpl implements StationService {

    @Resource
    private StationMapper stationMapper;

    @Override
    public PageResult<BusStation> getStationPage(int pageNum, int pageSize) {
        int total = stationMapper.countTotal();
        List<BusStation> stations = stationMapper.selectAll((pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, stations);
    }

    @Override
    public BusStation getStationById(Integer stationId) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        return stationMapper.selectById(stationId);
    }

    @Override
    public List<BusStation> getAllActiveStations() {
        return stationMapper.selectAllActive();
    }

    @Override
    public List<Integer> getRouteIdsByStationId(Integer stationId) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        return stationMapper.selectRouteIdsByStationId(stationId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addStation(BusStation station) {
        // 校验站点名称是否已存在
        List<BusStation> existing = stationMapper.selectByNameLike(station.getStationName());
        for (BusStation s : existing) {
            if (s.getStationName().equals(station.getStationName())) {
                throw new BusinessException("站点名称已存在");
            }
        }
        return stationMapper.insert(station) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateStation(BusStation station) {
        if (station.getStationId() == null) {
            throw new BusinessException("站点ID不能为空");
        }
        return stationMapper.update(station) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Integer stationId, Integer status) {
        if (stationId == null || status == null) {
            throw new BusinessException("参数不能为空");
        }
        // 检查站点是否关联线路（若关联则不允许关闭）
        List<Integer> routeIds = stationMapper.selectRouteIdsByStationId(stationId);
        if (status == 0 && !routeIds.isEmpty()) {
            throw new BusinessException("该站点已关联线路，无法关闭");
        }
        return stationMapper.updateStatus(stationId, status) > 0;
    }

    @Override
    public List<BusStation> searchStationsByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return getAllActiveStations(); // 若查询为空则返回所有启用站点
        }
        return stationMapper.selectByNameLike(name.trim());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteStation(Integer stationId) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        
        // 检查站点是否存在
        BusStation station = stationMapper.selectById(stationId);
        if (station == null) {
            throw new BusinessException("站点不存在");
        }

        // 检查站点是否关联线路（若关联则不允许删除）
        List<Integer> routeIds = stationMapper.selectRouteIdsByStationId(stationId);
        if (!routeIds.isEmpty()) {
            throw new BusinessException("该站点已关联线路，无法删除。请先解除线路关联后再删除");
        }

        return stationMapper.deleteById(stationId) > 0;
    }
}