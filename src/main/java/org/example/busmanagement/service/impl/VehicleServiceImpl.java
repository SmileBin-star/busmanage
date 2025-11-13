package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.VehicleMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusVehicle;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.VehicleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class VehicleServiceImpl implements VehicleService {

    @Resource
    private VehicleMapper vehicleMapper;

    @Override
    public PageResult<BusVehicle> getVehiclePage(int pageNum, int pageSize) {
        int total = vehicleMapper.countTotal();
        List<BusVehicle> vehicles = vehicleMapper.selectAll((pageNum - 1) * pageSize, pageSize);
        return new PageResult<>(total, vehicles);
    }

    @Override
    public BusVehicle getVehicleById(Integer vehicleId) {
        if (vehicleId == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        return vehicleMapper.selectById(vehicleId);
    }

    @Override
    public List<BusVehicle> getVehiclesByRouteId(Integer routeId) {
        if (routeId == null) {
            throw new BusinessException("线路ID不能为空");
        }
        return vehicleMapper.selectByRouteId(routeId);
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean addVehicle(BusVehicle vehicle) {
        // 校验车牌号唯一性
        if (vehicleMapper.countByLicensePlate(vehicle.getLicensePlate()) > 0) {
            throw new BusinessException("车牌号已存在");
        }
        return vehicleMapper.insert(vehicle) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateVehicle(BusVehicle vehicle) {
        if (vehicle.getVehicleId() == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        // 校验车牌号唯一性（排除当前车辆）
        BusVehicle existing = vehicleMapper.selectById(vehicle.getVehicleId());
        if (!existing.getLicensePlate().equals(vehicle.getLicensePlate())
                && vehicleMapper.countByLicensePlate(vehicle.getLicensePlate()) > 0) {
            throw new BusinessException("车牌号已存在");
        }
        return vehicleMapper.update(vehicle) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean changeStatus(Integer vehicleId, Integer status) {
        if (vehicleId == null || status == null) {
            throw new BusinessException("参数不能为空");
        }
        return vehicleMapper.updateStatus(vehicleId, status) > 0;
    }
}