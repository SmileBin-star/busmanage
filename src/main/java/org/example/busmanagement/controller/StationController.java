package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusStation;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.RouteService;
import org.example.busmanagement.service.StationService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/station")
public class StationController {

    @Resource
    private StationService stationService;

    @Resource
    private RouteService routeService;

<<<<<<< HEAD
    // 管理员站点管理页面（带操作按钮）
    @GetMapping("/manage")
    public String manage() {
        // 页面通过 AJAX 加载数据，这里不需要设置 Model
        return "station/manage";
    }

    // 站点列表接口（AJAX）- 供 manage.jsp 使用
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<BusStation> pageResult = stationService.getStationPage(pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 站点列表页面（用户/管理员）- 保留原有功能
    @GetMapping("/listPage")
    public String listPage(
=======
    // 站点列表页面（用户/管理员）
    @GetMapping("/list")
    public String list(
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            Model model) {
        PageResult<BusStation> pageResult = stationService.getStationPage(pageNum, pageSize);
        model.addAttribute("pageResult", pageResult);
        return "user/station_list"; // 用户端页面
    }

<<<<<<< HEAD
=======
    // 管理员站点管理页面（带操作按钮）
    @GetMapping("/manage")
    public String manage(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize,
            Model model) {
        PageResult<BusStation> pageResult = stationService.getStationPage(pageNum, pageSize);
        model.addAttribute("pageResult", pageResult);
        return "admin/station_manage"; // 管理员页面
    }

>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    // 站点详情页面
    @GetMapping("/detail/{stationId}")
    public String detail(@PathVariable Integer stationId, Model model) {
        BusStation station = stationService.getStationById(stationId);
        if (station == null) {
            model.addAttribute("error", "站点不存在");
            return "common/error";
        }
        // 查询站点所属线路ID
        List<Integer> routeIds = stationService.getRouteIdsByStationId(stationId);
        model.addAttribute("station", station);
        model.addAttribute("routeIds", routeIds);
        return "user/station_detail";
    }

    // 添加站点页面（管理员）
    @GetMapping("/add")
    public String addPage() {
<<<<<<< HEAD
        return "station/add";
=======
        return "admin/station_add";
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }

    // 提交添加站点
    @PostMapping("/add")
    @ResponseBody
    public Result addStation(BusStation station) {
        try {
            boolean success = stationService.addStation(station);
            return success ? Result.success("站点添加成功") : Result.error("站点添加失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 编辑站点页面（管理员）
    @GetMapping("/edit/{stationId}")
    public String editPage(@PathVariable Integer stationId, Model model) {
        BusStation station = stationService.getStationById(stationId);
        if (station == null) {
            model.addAttribute("error", "站点不存在");
            return "common/error";
        }
        model.addAttribute("station", station);
<<<<<<< HEAD
        return "station/edit";
=======
        return "admin/station_edit";
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    }

    // 提交编辑站点
    @PostMapping("/edit")
    @ResponseBody
    public Result editStation(BusStation station) {
        try {
            boolean success = stationService.updateStation(station);
            return success ? Result.success("站点更新成功") : Result.error("站点更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 更改站点状态（启用/关闭）
    @PostMapping("/changeStatus")
    @ResponseBody
    public Result changeStatus(Integer stationId, Integer status) {
        try {
            boolean success = stationService.changeStatus(stationId, status);
            String msg = status == 1 ? "站点启用成功" : "站点关闭成功";
            return success ? Result.success(msg) : Result.error("状态更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 站点搜索接口（AJAX）
    @GetMapping("/search")
    @ResponseBody
    public Result searchStations(@RequestParam(required = false) String name) {
        List<BusStation> stations = stationService.searchStationsByName(name);
        return Result.success(stations);
    }
<<<<<<< HEAD

    // 删除站点
    @PostMapping("/delete/{stationId}")
    @ResponseBody
    public Result deleteStation(@PathVariable Integer stationId) {
        try {
            boolean success = stationService.deleteStation(stationId);
            return success ? Result.success("站点删除成功") : Result.error("站点删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}