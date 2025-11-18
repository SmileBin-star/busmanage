package org.example.busmanagement.interceptor;

import org.example.busmanagement.model.entity.User;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.springframework.web.servlet.HandlerInterceptor;

// 登录拦截器：验证用户是否登录
public class LoginInterceptor implements HandlerInterceptor {

    // 请求处理前拦截
    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        // 获取Session中的登录用户
        HttpSession session = request.getSession();
        User loginUser = (User) session.getAttribute("loginUser");

        // 未登录：重定向到登录页
        if (loginUser == null) {
            response.sendRedirect(request.getContextPath() + "/user/login");
            return false; // 终止请求
        }

        // 已登录：继续执行
        return true;
    }
}