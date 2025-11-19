<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
    <div class="container">
        <!-- 系统名称 -->
        <a class="navbar-brand" th:href="@{/user/index}">城市公交管理系统</a>

        <!-- 导航菜单 -->
        <div class="collapse navbar-collapse">
            <ul class="navbar-nav me-auto">
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/user/index}">首页</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/user/route/search}">线路查询</a>
                </li>
                </li>
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/station/list}">站点查询</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/user/collection}">我的收藏</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" th:href="@{/systemNotice/page(status=1)}">系统通知</a>
                </li>
            </ul>

            <!-- 用户信息 -->
            <div class="navbar-nav">
                <li class="nav-item dropdown">
                    <a class="nav-link dropdown-toggle" href="#" id="userDropdown" role="button" data-bs-toggle="dropdown">
                        <span th:text="${session.loginUser.username}">用户名</span>
                    </a>
                    <ul class="dropdown-menu dropdown-menu-end">
                        <li><a class="dropdown-item" th:href="@{/user/profile}">个人中心</a></li>
                        <li><a class="dropdown-item" th:href="@{/user/loginLogs}">登录日志</a></li>
                        <li><hr class="dropdown-divider"></li>
                        <li><a class="dropdown-item" th:href="@{/user/logout}">退出登录</a></li>
                    </ul>
                </li>
            </div>
        </div>
    </div>
</nav>
</body>
</html>