package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.ScheduleMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusSchedule;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.ScheduleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class ScheduleServiceImpl implements ScheduleService {

    @Resource
    private ScheduleMapper scheduleMapper;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addSchedule(BusSchedule schedule) {
        validateSchedule(schedule);
        return scheduleMapper.insert(schedule) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateScheduleStatus(Integer scheduleId, Integer status) {
        if (scheduleId == null || status == null) {
            throw new BusinessException("参数不能为空");
        }
        // 调用mapper层更新状态（假设有对应的mapper方法）
        return scheduleMapper.updateStatus(scheduleId, status) > 0;
    }
    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateSchedule(BusSchedule schedule) {
        if (schedule.getScheduleId() == null) {
            throw new BusinessException("调度ID不能为空");
        }
        validateSchedule(schedule);
        return scheduleMapper.update(schedule) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteSchedule(Integer scheduleId) {
        if (scheduleId == null) {
            throw new BusinessException("调度ID不能为空");
        }
        return scheduleMapper.deleteById(scheduleId) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean batchCancel(List<Integer> scheduleIds) {
        if (scheduleIds == null || scheduleIds.isEmpty()) {
            throw new BusinessException("调度ID列表不能为空");
        }
        return scheduleMapper.batchUpdateStatus(scheduleIds, 0) > 0;
    }

    @Override
    public BusSchedule getScheduleById(Integer scheduleId) {
        if (scheduleId == null) {
            throw new BusinessException("调度ID不能为空");
        }
        return scheduleMapper.selectById(scheduleId);
    }

    @Override
    public List<BusSchedule> getByRouteId(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return scheduleMapper.selectByRouteId(routeId);
    }

    @Override
    public List<BusSchedule> getByVehicleId(Integer vehicleId) {
        if (vehicleId == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        return scheduleMapper.selectByVehicleId(vehicleId);
    }

    @Override
    public PageResult<BusSchedule> getSchedulePage(
            int pageNum,
            int pageSize,
            Integer routeId,
            Integer status) {
        int total = scheduleMapper.countTotal(routeId, status);
        List<BusSchedule> schedules = scheduleMapper.selectPage(
                (pageNum - 1) * pageSize,
                pageSize,
                routeId,
                status
        );
        return new PageResult<>(total, schedules);
    }

    // 校验调度信息
    private void validateSchedule(BusSchedule schedule) {
        if (schedule.getRouteId() == null) {
            throw new BusinessException("线路ID不能为空");
        }
        if (schedule.getVehicleId() == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        if (schedule.getDepartureTime() == null || schedule.getDepartureTime().isEmpty()) {
            throw new BusinessException("发车时间不能为空");
        }
        if (schedule.getArrivalTime() == null || schedule.getArrivalTime().isEmpty()) {
            throw new BusinessException("到达时间不能为空");
        }
        if (schedule.getCapacity() == null || schedule.getCapacity() <= 0) {
            throw new BusinessException("核定载客量必须大于0");
        }
    }
}