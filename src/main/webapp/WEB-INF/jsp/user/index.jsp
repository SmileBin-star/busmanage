<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>公交管理系统 - 首页</title>
    <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100">
<div class="container mx-auto p-6">
    <h1 class="text-3xl font-bold mb-6 text-center">欢迎使用公交管理系统</h1>

    <div class="grid grid-cols-2 md:grid-cols-3 gap-6">
        <!-- 站点管理 -->
        <a href="<c:url value='/station/list'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-blue-600">站点管理</h2>
            <p class="text-gray-600 mt-2">查看、搜索、管理所有公交站点</p>
        </a>

        <!-- 线路管理 -->
        <a href="<c:url value='/route/manage'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-green-600">线路管理</h2>
            <p class="text-gray-600 mt-2">管理公交线路及站点关联</p>
        </a>

        <!-- 车辆管理 -->
        <a href="<c:url value='/vehicle/manage'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-purple-600">车辆管理</h2>
            <p class="text-gray-600 mt-2">车辆信息及状态管理</p>
        </a>

        <!-- 调度管理 -->
        <a href="<c:url value='/schedule/manage'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-orange-600">调度管理</h2>
            <p class="text-gray-600 mt-2">班次调度与状态管理</p>
        </a>

        <!-- 到站记录 -->
        <a href="<c:url value='/arrivalRecord/latest/0?limit=10'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-red-600">到站记录</h2>
            <p class="text-gray-600 mt-2">查看最近车辆到站信息</p>
        </a>

        <!-- 系统公告 -->
        <a href="<c:url value='/systemNotice/page'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-indigo-600">系统公告</h2>
            <p class="text-gray-600 mt-2">查看平台最新通知</p>
        </a>

        <!-- 我的收藏 -->
        <a href="<c:url value='/collection/list?userId=${sessionScope.loginUser.userId}'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-pink-600">我的收藏</h2>
            <p class="text-gray-600 mt-2">收藏的线路与站点</p>
        </a>

        <!-- 登录日志 -->
        <a href="<c:url value='/user/loginLogs'/>" class="block p-6 bg-white rounded-lg shadow hover:shadow-lg">
            <h2 class="text-xl font-semibold text-gray-600">登录日志</h2>
            <p class="text-gray-600 mt-2">查看个人登录记录</p>
        </a>
    </div>

    <div class="text-center mt-10">
        <a href="<c:url value='/user/logout'/>" class="text-red-500 hover:underline">退出登录</a>
    </div>
</div>
</body>
</html>