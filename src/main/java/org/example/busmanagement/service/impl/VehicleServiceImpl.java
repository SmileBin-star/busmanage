package org.example.busmanagement.service.impl;

import org.example.busmanagement.dao.VehicleMapper;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusVehicle;
<<<<<<< HEAD
import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.VehicleService;
import org.example.busmanagement.service.RouteService;
=======
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.service.VehicleService;
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class VehicleServiceImpl implements VehicleService {

    @Resource
    private VehicleMapper vehicleMapper;

<<<<<<< HEAD
    @Resource
    private RouteService routeService;

=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD
        // 验证线路ID是否存在
        if (vehicle.getRouteId() == null) {
            throw new BusinessException("所属线路ID不能为空");
        }
        BusRoute route = routeService.getRouteDetail(vehicle.getRouteId());
        if (route == null) {
            throw new BusinessException("所属线路ID " + vehicle.getRouteId() + " 不存在，请选择有效的线路");
        }

        // 校验车牌号唯一性
        if (vehicle.getLicensePlate() == null || vehicle.getLicensePlate().trim().isEmpty()) {
            throw new BusinessException("车牌号不能为空");
        }
        if (vehicleMapper.countByLicensePlate(vehicle.getLicensePlate().trim()) > 0) {
            throw new BusinessException("车牌号 \"" + vehicle.getLicensePlate() + "\" 已存在");
        }
        
        // 设置车牌号去除空格
        vehicle.setLicensePlate(vehicle.getLicensePlate().trim());
        
=======
        // 校验车牌号唯一性
        if (vehicleMapper.countByLicensePlate(vehicle.getLicensePlate()) > 0) {
            throw new BusinessException("车牌号已存在");
        }
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
        return vehicleMapper.insert(vehicle) > 0;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateVehicle(BusVehicle vehicle) {
        if (vehicle.getVehicleId() == null) {
            throw new BusinessException("车辆ID不能为空");
        }
<<<<<<< HEAD
        
        // 验证车辆是否存在
        BusVehicle existing = vehicleMapper.selectById(vehicle.getVehicleId());
        if (existing == null) {
            throw new BusinessException("车辆不存在");
        }

        // 验证线路ID是否存在
        if (vehicle.getRouteId() != null) {
            BusRoute route = routeService.getRouteDetail(vehicle.getRouteId());
            if (route == null) {
                throw new BusinessException("所属线路ID " + vehicle.getRouteId() + " 不存在，请选择有效的线路");
            }
        }

        // 校验车牌号唯一性（排除当前车辆）
        if (vehicle.getLicensePlate() == null || vehicle.getLicensePlate().trim().isEmpty()) {
            throw new BusinessException("车牌号不能为空");
        }
        if (!existing.getLicensePlate().equals(vehicle.getLicensePlate().trim())
                && vehicleMapper.countByLicensePlate(vehicle.getLicensePlate().trim()) > 0) {
            throw new BusinessException("车牌号 \"" + vehicle.getLicensePlate() + "\" 已被其他车辆使用");
        }
        
        // 设置车牌号去除空格
        vehicle.setLicensePlate(vehicle.getLicensePlate().trim());
        
=======
        // 校验车牌号唯一性（排除当前车辆）
        BusVehicle existing = vehicleMapper.selectById(vehicle.getVehicleId());
        if (!existing.getLicensePlate().equals(vehicle.getLicensePlate())
                && vehicleMapper.countByLicensePlate(vehicle.getLicensePlate()) > 0) {
            throw new BusinessException("车牌号已存在");
        }
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteVehicle(Integer vehicleId) {
        if (vehicleId == null) {
            throw new BusinessException("车辆ID不能为空");
        }
        
        // 检查车辆是否存在
        BusVehicle vehicle = vehicleMapper.selectById(vehicleId);
        if (vehicle == null) {
            throw new BusinessException("车辆不存在");
        }

        // 注意：如果车辆有关联的班次调度，删除可能会失败（外键约束）
        // 这里先尝试删除，如果失败会抛出异常
        return vehicleMapper.deleteById(vehicleId) > 0;
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}