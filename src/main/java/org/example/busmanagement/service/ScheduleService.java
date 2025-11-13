package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusSchedule;
import org.example.busmanagement.model.vo.PageResult;
import java.util.List;

public interface ScheduleService {

    // 调度管理
    boolean addSchedule(BusSchedule schedule);

    boolean updateSchedule(BusSchedule schedule);

    boolean deleteSchedule(Integer scheduleId);

    boolean batchCancel(List<Integer> scheduleIds);

    // 查询功能
    BusSchedule getScheduleById(Integer scheduleId);

    List<BusSchedule> getByRouteId(Integer routeId);

    List<BusSchedule> getByVehicleId(Integer vehicleId);

    PageResult<BusSchedule> getSchedulePage(
            int pageNum,
            int pageSize,
            Integer routeId,
            Integer status
    );

    boolean updateScheduleStatus(Integer scheduleId, Integer status);
}