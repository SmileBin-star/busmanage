package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.ArrivalRecordMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusArrivalRecord;
import org.example.busmanagement.service.ArrivalRecordService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ArrivalRecordServiceImpl implements ArrivalRecordService {

    @Resource
    private ArrivalRecordMapper arrivalRecordMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addArrivalRecord(BusArrivalRecord record) {
        // 校验必填字段
        if (record.getVehicleId() == null || record.getStationId() == null
                || record.getScheduleId() == null || record.getActualArrivalTime() == null) {
            throw new BusinessException("车辆ID、站点ID、班次ID和到达时间不能为空");
        }
        return arrivalRecordMapper.insert(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean batchAddRecords(List<BusArrivalRecord> records) {
        if (records == null || records.isEmpty()) {
            throw new BusinessException("记录列表不能为空");
        }
        return arrivalRecordMapper.batchInsert(records) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateDepartureTime(Integer recordId, LocalDateTime departureTime) {
        if (recordId == null || departureTime == null) {
            throw new BusinessException("记录ID和出发时间不能为空");
        }
        BusArrivalRecord record = new BusArrivalRecord();
        record.setRecordId(recordId);
        record.setActualDepartureTime(departureTime);
        return arrivalRecordMapper.updateDepartureTime(record) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updatePassengerCount(Integer recordId, Integer in, Integer out) {
        if (recordId == null) {
            throw new BusinessException("记录ID不能为空");
        }
        // 上下车人数默认0（避免null）
        int passengerIn = in == null ? 0 : in;
        int passengerOut = out == null ? 0 : out;
        return arrivalRecordMapper.updatePassengerCount(recordId, passengerIn, passengerOut) > 0;
    }

    @Override
    public List<BusArrivalRecord> getByScheduleId(Integer scheduleId) {
        if (scheduleId == null) {
            throw new BusinessException("班次ID不能为空");
        }
        return arrivalRecordMapper.selectByScheduleId(scheduleId);
    }

    @Override
    public List<BusArrivalRecord> getLatestByStationId(Integer stationId, Integer limit) {
        if (stationId == null) {
            throw new BusinessException("站点ID不能为空");
        }
        // 默认查询最近5条
        int queryLimit = limit == null || limit <= 0 ? 5 : limit;
        return arrivalRecordMapper.selectLatestByStationId(stationId, queryLimit);
    }

    @Override
    public BusArrivalRecord getRecordById(Integer recordId) {
        if (recordId == null) {
            throw new BusinessException("记录ID不能为空");
        }
        return arrivalRecordMapper.selectById(recordId);
    }
}