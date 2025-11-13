package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusSchedule;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ScheduleMapper {

    // 基础CRUD
    BusSchedule selectById(Integer scheduleId);

    List<BusSchedule> selectByRouteId(Integer routeId);

    List<BusSchedule> selectByVehicleId(Integer vehicleId);

    List<BusSchedule> selectByDriverId(Integer driverId);

    List<BusSchedule> selectByStatus(Integer status);

    int insert(BusSchedule schedule);

    int update(BusSchedule schedule);

    int deleteById(Integer scheduleId);

    // 批量操作
    int batchInsert(List<BusSchedule> list);

    int batchUpdateStatus(@Param("ids") List<Integer> ids, @Param("status") Integer status);

    // 分页查询
    List<BusSchedule> selectPage(
            @Param("pageNum") int pageNum,
            @Param("pageSize") int pageSize,
            @Param("routeId") Integer routeId,
            @Param("status") Integer status
    );

    int countTotal(
            @Param("routeId") Integer routeId,
            @Param("status") Integer status
    );
    int updateStatus(@Param("scheduleId") Integer scheduleId, @Param("status") Integer status);
}