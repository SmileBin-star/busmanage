package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.entity.BusRouteStation;
import org.example.busmanagement.model.entity.BusStation;
<<<<<<< HEAD
import org.example.busmanagement.model.vo.PageResult;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.RouteService;
import org.example.busmanagement.service.RouteStationService;
import org.example.busmanagement.service.StationService;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/route")
public class RouteController {

    // 已有的注入
    @Resource private RouteService routeService;
    @Resource private StationService stationService;
    // 新增注入
    @Resource private RouteStationService routeStationService;

<<<<<<< HEAD
    // 线路管理页面
    @GetMapping("/manage")
    public String manage(Model model) {
        // 页面通过 AJAX 加载数据，这里不需要设置 Model
        return "route/manage";
    }

    // 线路列表接口（AJAX）
    @GetMapping("/list")
    @ResponseBody
    public Result list(
            @RequestParam(defaultValue = "1") int pageNum,
            @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<BusRoute> pageResult = routeService.getRoutePage(pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 添加线路页面
    @GetMapping("/add")
    public String addPage() {
        return "route/add";
    }

    // 提交添加线路
    @PostMapping("/add")
    @ResponseBody
    public Result addRoute(BusRoute route) {
        try {
            // 设置默认值
            if (route.getStatus() == null) {
                route.setStatus(1); // 默认运营状态
            }
            if (route.getTotalStations() == null) {
                route.setTotalStations(0); // 初始站点数为0，后续通过编辑站点功能添加
            }
            if (route.getTotalDistance() == null) {
                route.setTotalDistance(0.0);
            }
            // 添加线路（不包含站点，站点通过编辑站点功能添加）
            boolean success = routeService.addRoute(route, new Integer[0]);
            return success ? Result.success("线路添加成功") : Result.error("线路添加失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    // 新增：编辑线路站点关联页面
    @GetMapping("/editStations/{routeId}")
    public String editStationsPage(@PathVariable Integer routeId, Model model) {
        BusRoute route = routeService.getRouteDetail(routeId);
        if (route == null) {
            model.addAttribute("error", "线路不存在");
            return "common/error";
        }
        // 获取线路已关联的站点
        List<BusRouteStation> routeStations = routeStationService.getWithStationInfo(routeId);
        // 获取所有可用站点（供选择）
        List<BusStation> allStations = stationService.getAllActiveStations();

        model.addAttribute("route", route);
        model.addAttribute("routeStations", routeStations);
        model.addAttribute("allStations", allStations);
<<<<<<< HEAD
        return "route/editStations";
    }

    // 新增：保存线路站点关联
    @PostMapping("/saveStations/{routeId}")
    @ResponseBody
    public Result saveStations(
            @PathVariable Integer routeId,
=======
        return "admin/route_edit_stations";
    }

    // 新增：保存线路站点关联
    @PostMapping("/saveStations")
    @ResponseBody
    public Result saveStations(
            @RequestParam Integer routeId,
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
            @RequestBody List<BusRouteStation> routeStations) {
        try {
            // 补充线路ID到关联对象中
            for (BusRouteStation rs : routeStations) {
                rs.setRouteId(routeId);
            }
            boolean success = routeStationService.bindStations(routeId, routeStations);
            return success ? Result.success("线路站点关联成功") : Result.error("关联失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 新增：查询线路站点关联（供前端AJAX调用）
    @GetMapping("/getStations/{routeId}")
    @ResponseBody
    public Result getRouteStations(@PathVariable Integer routeId) {
        try {
            List<BusRouteStation> stations = routeStationService.getWithStationInfo(routeId);
            return Result.success(stations);
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }
<<<<<<< HEAD

    // 编辑线路页面
    @GetMapping("/edit/{routeId}")
    public String editPage(@PathVariable Integer routeId, Model model) {
        BusRoute route = routeService.getRouteDetail(routeId);
        if (route == null) {
            model.addAttribute("error", "线路不存在");
            return "common/error";
        }
        model.addAttribute("route", route);
        return "route/edit";
    }

    // 提交更新线路
    @PostMapping("/edit")
    @ResponseBody
    public Result editRoute(BusRoute route) {
        try {
            // 设置默认值
            if (route.getStatus() == null) {
                route.setStatus(1);
            }
            if (route.getTotalStations() == null) {
                route.setTotalStations(0);
            }
            if (route.getTotalDistance() == null) {
                route.setTotalDistance(0.0);
            }
            boolean success = routeService.updateRoute(route);
            return success ? Result.success("线路更新成功") : Result.error("线路更新失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 删除线路
    @PostMapping("/delete/{routeId}")
    @ResponseBody
    public Result deleteRoute(@PathVariable Integer routeId) {
        try {
            boolean success = routeService.deleteRoute(routeId);
            return success ? Result.success("线路删除成功") : Result.error("线路删除失败");
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
}