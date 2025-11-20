package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.ArrivalRecordMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusArrivalRecord;
import org.example.busmanagement.model.entity.BusVehicle;
import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.entity.BusSchedule;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.ArrivalRecordService;
import org.example.busmanagement.service.VehicleService;
import org.example.busmanagement.service.StationService;
import org.example.busmanagement.service.ScheduleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.time.LocalDateTime;
import java.util.List;

@Service
public class ArrivalRecordServiceImpl implements ArrivalRecordService {

    @Resource
    private ArrivalRecordMapper arrivalRecordMapper;

    @Resource
    private VehicleService vehicleService;

    @Resource
    private StationService stationService;

    @Resource
    private ScheduleService scheduleService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addArrivalRecord(BusArrivalRecord record) {
        // 校验必填字段
        if (record.getVehicleId() == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        if (record.getStationId() == null) {
            throw new BusinessException("站点ID不能为空");
        }
        if (record.getScheduleId() == null) {
            throw new BusinessException("班次ID不能为空");
        }
        if (record.getActualArrivalTime() == null) {
            throw new BusinessException("到达时间不能为空");
        }

        // 验证车辆是否存在
        BusVehicle vehicle = vehicleService.getVehicleById(record.getVehicleId());
        if (vehicle == null) {
            throw new BusinessException("车辆ID " + record.getVehicleId() + " 不存在");
        }

        // 验证站点是否存在
        BusStation station = stationService.getStationById(record.getStationId());
        if (station == null) {
            throw new BusinessException("站点ID " + record.getStationId() + " 不存在");
        }

        // 验证班次是否存在
        BusSchedule schedule = scheduleService.getScheduleById(record.getScheduleId());
        if (schedule == null) {
            throw new BusinessException("班次ID " + record.getScheduleId() + " 不存在");
        }

        // 验证车辆是否属于该班次
        if (!schedule.getVehicleId().equals(record.getVehicleId())) {
            throw new BusinessException("车辆ID " + record.getVehicleId() + " 不属于班次 " + record.getScheduleId());
        }

        // 设置默认值
        if (record.getDelayMinutes() == null) {
            record.setDelayMinutes(0);
        }
        if (record.getPassengerIn() == null) {
            record.setPassengerIn(0);
        }
        if (record.getPassengerOut() == null) {
            record.setPassengerOut(0);
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

    @Override
    public PageResult<BusArrivalRecord> getRecordPage(int pageNum, int pageSize, Integer scheduleId, Integer stationId) {
        int total = arrivalRecordMapper.countTotal(scheduleId, stationId);
        List<BusArrivalRecord> records = arrivalRecordMapper.selectPage((pageNum - 1) * pageSize, pageSize, scheduleId, stationId);
        return new PageResult<>(total, records);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteRecord(Integer recordId) {
        if (recordId == null) {
            throw new BusinessException("记录ID不能为空");
        }
        
        // 检查记录是否存在
        BusArrivalRecord record = arrivalRecordMapper.selectById(recordId);
        if (record == null) {
            throw new BusinessException("到站记录不存在");
        }

        return arrivalRecordMapper.deleteById(recordId) > 0;
    }
}