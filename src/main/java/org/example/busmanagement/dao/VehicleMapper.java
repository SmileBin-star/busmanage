package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusVehicle;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface VehicleMapper {

    // 分页查询所有车辆
    List<BusVehicle> selectAll(@Param("pageNum") int pageNum, @Param("pageSize") int pageSize);

    // 查询总记录数
    int countTotal();

    // 根据ID查询车辆
    BusVehicle selectById(Integer vehicleId);

    // 根据线路ID查询车辆
    List<BusVehicle> selectByRouteId(Integer routeId);

    // 新增车辆
    int insert(BusVehicle vehicle);

    // 更新车辆信息
    int update(BusVehicle vehicle);

    // 更新车辆状态（运营/停用）
    int updateStatus(@Param("vehicleId") Integer vehicleId, @Param("status") Integer status);

    // 检查车牌号是否已存在
    int countByLicensePlate(String licensePlate);
}