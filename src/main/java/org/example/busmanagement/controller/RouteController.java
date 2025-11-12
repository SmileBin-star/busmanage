package org.example.busmanagement.controller;

import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.BusRoute;
import org.example.busmanagement.model.entity.BusRouteStation;
import org.example.busmanagement.model.entity.BusStation;
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
        return "admin/route_edit_stations";
    }

    // 新增：保存线路站点关联
    @PostMapping("/saveStations")
    @ResponseBody
    public Result saveStations(
            @RequestParam Integer routeId,
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
}