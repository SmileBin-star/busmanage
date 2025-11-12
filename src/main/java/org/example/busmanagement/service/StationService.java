package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.vo.PageResult;
import java.util.List;

public interface StationService {

    // 分页查询站点
    PageResult<BusStation> getStationPage(int pageNum, int pageSize);

    // 根据ID查询站点详情
    BusStation getStationById(Integer stationId);

    // 查询所有启用的站点
    List<BusStation> getAllActiveStations();

    // 查询站点所属的线路ID列表
    List<Integer> getRouteIdsByStationId(Integer stationId);

    // 添加新站点
    boolean addStation(BusStation station);

    // 更新站点信息
    boolean updateStation(BusStation station);

    // 更改站点状态（启用/关闭）
    boolean changeStatus(Integer stationId, Integer status);

    // 根据名称模糊查询站点
    List<BusStation> searchStationsByName(String name);
}