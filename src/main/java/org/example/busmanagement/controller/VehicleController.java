package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusVehicle;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.VehicleService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
<<<<<<< HEAD
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.*;

import java.text.SimpleDateFormat;
import java.util.Date;
=======
import org.springframework.web.bind.annotation.*;

>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import java.util.List;

@Controller
@RequestMapping("/vehicle")
public class VehicleController {

    @Resource
    private VehicleService vehicleService;

<<<<<<< HEAD
    // 初始化数据绑定，处理日期格式和空值
    @InitBinder
    public void initBinder(WebDataBinder binder) {
        binder.registerCustomEditor(Date.class, new org.springframework.beans.propertyeditors.CustomDateEditor(
                new SimpleDateFormat("yyyy-MM-dd"), true));
    }

    // 车辆管理页面（管理员）
    @GetMapping("/manage")
    public String manage() {
        // 页面通过 AJAX 加载数据，这里不需要设置 Model
        return "vehicle/manage";
    }

    // 车辆列表接口（AJAX）- 供 manage.jsp 使用
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<BusVehicle> pageResult = vehicleService.getVehiclePage(pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
=======
    // 车辆管理页面（管理员）
    @GetMapping("/manage")
    public String manage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            Model model) {
        PageResult<BusVehicle> pageResult = vehicleService.getVehiclePage(pageNum, pageSize);
        model.addAttribute("pageResult", pageResult);
        return "admin/vehicle_manage"; // 需创建对应的JSP页面
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }

    // 车辆详情页面
    @GetMapping("/detail/{vehicleId}")
    public String detail(@PathVariable Integer vehicleId, Model model) {
        BusVehicle vehicle = vehicleService.getVehicleById(vehicleId);
        if (vehicle == null) {
            model.addAttribute("error", "车辆不存在");
            return "common/error";
        }
        model.addAttribute("vehicle", vehicle);
        return "admin/vehicle_detail"; // 需创建对应的JSP页面
    }

    // 添加车辆页面
    @GetMapping("/add")
    public String addPage() {
<<<<<<< HEAD
        return "vehicle/add";
=======
        return "admin/vehicle_add"; // 需创建对应的JSP页面
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }

    // 提交添加车辆
    @PostMapping("/add")
    @ResponseBody
    public Result addVehicle(BusVehicle vehicle) {
        try {
<<<<<<< HEAD
            // 处理空值：如果 purchaseTime 为空字符串，设置为 null
            // Spring 会自动处理，但如果前端提交空字符串，需要手动处理
            // 这里通过 @InitBinder 或直接处理都可以，但更简单的是在前端不提交空字段
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
            boolean success = vehicleService.addVehicle(vehicle);
            return success ? Result.success("车辆添加成功") : Result.error("车辆添加失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 编辑车辆页面
    @GetMapping("/edit/{vehicleId}")
    public String editPage(@PathVariable Integer vehicleId, Model model) {
        BusVehicle vehicle = vehicleService.getVehicleById(vehicleId);
        if (vehicle == null) {
            model.addAttribute("error", "车辆不存在");
            return "common/error";
        }
        model.addAttribute("vehicle", vehicle);
<<<<<<< HEAD
        return "vehicle/edit";
=======
        return "admin/vehicle_edit"; // 需创建对应的JSP页面
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }

    // 提交编辑车辆
    @PostMapping("/edit")
    @ResponseBody
    public Result editVehicle(BusVehicle vehicle) {
        try {
            boolean success = vehicleService.updateVehicle(vehicle);
            return success ? Result.success("车辆更新成功") : Result.error("车辆更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 更改车辆状态（运营/停用）
    @PostMapping("/changeStatus")
    @ResponseBody
    public Result changeStatus(Integer vehicleId, Integer status) {
        try {
            boolean success = vehicleService.changeStatus(vehicleId, status);
            String msg = status == 1 ? "车辆启用成功" : "车辆停用成功";
            return success ? Result.success(msg) : Result.error("状态更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 根据线路ID查询车辆（AJAX接口）
    @GetMapping("/getByRoute/{routeId}")
    @ResponseBody
    public Result getVehiclesByRoute(@PathVariable Integer routeId) {
        try {
            List<BusVehicle> vehicles = vehicleService.getVehiclesByRouteId(routeId);
            return Result.success(vehicles);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }
<<<<<<< HEAD

    // 删除车辆
    @PostMapping("/delete/{vehicleId}")
    @ResponseBody
    public Result deleteVehicle(@PathVariable Integer vehicleId) {
        try {
            boolean success = vehicleService.deleteVehicle(vehicleId);
            return success ? Result.success("车辆删除成功") : Result.error("车辆删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}