package org.example.busmanagement.dao;

import org.example.busmanagement.model.entity.BusArrivalRecord;
import org.apache.ibatis.annotations.Param;
import java.util.List;

public interface ArrivalRecordMapper {

    // 新增到站记录
    int insert(BusArrivalRecord record);

    // 批量新增到站记录
    int batchInsert(@Param("list") List<BusArrivalRecord> records);

    // 根据ID查询
    BusArrivalRecord selectById(Integer recordId);

    // 根据班次ID查询所有站点的到站记录
    List<BusArrivalRecord> selectByScheduleId(Integer scheduleId);

    // 根据车辆ID和站点ID查询
    BusArrivalRecord selectByVehicleAndStation(
            @Param("vehicleId") Integer vehicleId,
            @Param("stationId") Integer stationId);

    // 更新出发时间（车辆离开站点时更新）
    int updateDepartureTime(BusArrivalRecord record);

    // 更新乘客数量
    int updatePassengerCount(
            @Param("recordId") Integer recordId,
            @Param("passengerIn") Integer passengerIn,
            @Param("passengerOut") Integer passengerOut);

    // 查询某站点的最新到站记录
    List<BusArrivalRecord> selectLatestByStationId(
            @Param("stationId") Integer stationId,
            @Param("limit") Integer limit);

    // 分页查询到站记录
    List<BusArrivalRecord> selectPage(
            @Param("pageNum") int pageNum,
            @Param("pageSize") int pageSize,
            @Param("scheduleId") Integer scheduleId,
            @Param("stationId") Integer stationId);

    // 统计总数
    int countTotal(
            @Param("scheduleId") Integer scheduleId,
            @Param("stationId") Integer stationId);

    // 删除到站记录
    int deleteById(Integer recordId);
}