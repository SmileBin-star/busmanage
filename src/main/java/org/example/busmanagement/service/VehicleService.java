package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusVehicle;
import org.example.busmanagement.model.vo.PageResult;
import java.util.List;

public interface VehicleService {

    // 分页查询车辆列表
    PageResult<BusVehicle> getVehiclePage(int pageNum, int pageSize);

    // 根据ID查询车辆详情
    BusVehicle getVehicleById(Integer vehicleId);

    // 根据线路ID查询车辆
    List<BusVehicle> getVehiclesByRouteId(Integer routeId);

    // 添加新车辆
    boolean addVehicle(BusVehicle vehicle);

    // 更新车辆信息
    boolean updateVehicle(BusVehicle vehicle);

    // 更改车辆状态（运营/停用）
    boolean changeStatus(Integer vehicleId, Integer status);

    // 删除车辆
    boolean deleteVehicle(Integer vehicleId);
}