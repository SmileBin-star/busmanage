package org.example.busmanagement.controller;

import jakarta.servlet.http.HttpSession;
import org.example.busmanagement.exception.BusinessException;
import org.example.busmanagement.model.entity.User;
import org.example.busmanagement.model.entity.UserLoginLog;
import org.example.busmanagement.model.vo.PageResult;
import org.example.busmanagement.model.vo.Result;
import org.example.busmanagement.service.UserService;
import org.example.busmanagement.service.UserLoginLogService;
import jakarta.annotation.Resource;
import jakarta.servlet.http.HttpServletRequest;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import java.time.LocalDateTime;

@Controller
@RequestMapping("/user")
public class UserController {

    @Resource
    private UserService userService;

    @Resource
    private UserLoginLogService loginLogService;

    // 登录页面
    @GetMapping("/login")  // 方法级别路径，完整路径为 /user/login
    public String loginPage() {
        return "user/login";
    }
    // 执行登录
    @PostMapping("/login")
    @ResponseBody
    public Result login(@RequestParam String username,
                       @RequestParam String password,
                       HttpServletRequest request) {

        try {
            // 1. 查询用户
            User user = userService.getUserByUsername(username);
            if (user == null) {
                return Result.error("用户名不存在");
            }

            // 2. 此处省略密码校验逻辑（实际应使用BCrypt比对）
            boolean passwordMatch = true; // 替换为真实校验逻辑

            // 3. 记录登录日志
            UserLoginLog loginLog = new UserLoginLog();
            loginLog.setUserId(user.getUserId());
            loginLog.setLoginTime(LocalDateTime.now());
            loginLog.setLoginIp(request.getRemoteAddr());
            loginLog.setLoginStatus(passwordMatch ? 1 : 0);

            Integer logId = loginLogService.recordLoginLog(loginLog);

            if (passwordMatch) {
                // 登录成功，存储用户信息到Session
                request.getSession().setAttribute("loginUser", user);
                request.getSession().setAttribute("currentLogId", logId);

                System.out.println("===返回给前端的data=" + "/user/index");
                // 使用 (Object) 强制调用 success(Object data) 方法，确保 data 字段被设置
                return Result.success((Object) "/user/index");   // 返回相对路径，前端会自动加上context-path
            } else {
                return Result.error("密码错误");
            }
        } catch (BusinessException e) {
            return Result.error(e.getMessage());
        }
    }

    @GetMapping("/index")          // 地址 /user/index
    public String home(HttpSession session) {
        // 如果担心用户直接敲地址，可以在这里再校验一次 session
        if (session.getAttribute("loginUser") == null) {
            return "redirect:/user/login";
        }
        return "user/index";        // 这里写你真正的首页 html（不带 .jsp）
    }

    // 登出
    @GetMapping("/logout")
    public String logout(HttpServletRequest request) {
        // 更新登出时间
        Integer logId = (Integer) request.getSession().getAttribute("currentLogId");
        if (logId != null) {
            loginLogService.updateLogoutTime(logId);
        }
        // 清除Session
        request.getSession().invalidate();
        return "redirect:/user/login";
    }

    // 查看个人登录日志页面
    @GetMapping("/loginLogs")
    public String loginLogsPage(HttpServletRequest request) {
        User loginUser = (User) request.getSession().getAttribute("loginUser");
        if (loginUser == null) {
            return "redirect:/user/login";
        }
        return "user/login_logs";
    }

    // 查看个人登录日志接口（AJAX）
    @GetMapping("/loginLogs/api")
    @ResponseBody
    public Result loginLogs(@RequestParam(defaultValue = "1") int pageNum,
                           @RequestParam(defaultValue = "10") int pageSize,
                           HttpServletRequest request) {
        try {
            User loginUser = (User) request.getSession().getAttribute("loginUser");
            if (loginUser == null) {
                return Result.error("请先登录");
            }
            PageResult<UserLoginLog> pageResult = loginLogService.getUserLoginLogs(loginUser.getUserId(), pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }

    // 管理员查看所有登录日志页面
    @GetMapping("/admin/allLogs")
    public String allLoginLogsPage() {
        return "admin/all_login_logs";
    }

    // 管理员查看所有登录日志接口（AJAX）
    @GetMapping("/admin/allLogs/api")
    @ResponseBody
    public Result allLoginLogs(@RequestParam(defaultValue = "1") int pageNum,
                              @RequestParam(defaultValue = "10") int pageSize) {
        try {
            PageResult<UserLoginLog> pageResult = loginLogService.getAllLoginLogs(pageNum, pageSize);
            return Result.success(pageResult);
        } catch (Exception e) {
            return Result.error("系统异常：" + e.getMessage());
        }
    }
}