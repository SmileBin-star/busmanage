package org.example.busmanagement.service;

import org.example.busmanagement.model.entity.BusArrivalRecord;

import java.time.LocalDateTime;
import java.util.List;

public interface ArrivalRecordService {

    // 新增到站记录（车辆到达站点时）
    boolean addArrivalRecord(BusArrivalRecord record);

    // 批量新增到站记录
    boolean batchAddRecords(List<BusArrivalRecord> records);

    // 更新出发时间（车辆离开站点时）
    boolean updateDepartureTime(Integer recordId, LocalDateTime departureTime);

    // 更新上下车人数
    boolean updatePassengerCount(Integer recordId, Integer in, Integer out);

    // 根据班次ID查询所有站点的到站记录
    List<BusArrivalRecord> getByScheduleId(Integer scheduleId);

    // 查询某站点的最新到站记录（如最近5条）
    List<BusArrivalRecord> getLatestByStationId(Integer stationId, Integer limit);

    // 获取单条记录详情
    BusArrivalRecord getRecordById(Integer recordId);
}