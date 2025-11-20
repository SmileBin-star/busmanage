<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();
%>
<!DOCTYPE html>
<html>
<head>
    <title>公交系统-首页</title>
    <meta charset="utf-8"/>
    <style>
        body{margin:0;font-family:Arial;background:#f5f5f5}
        .header{background:#007bff;color:#fff;padding:15px 30px;font-size:20px}
        .header a{float:right;color:#fff;font-size:14px;text-decoration:none}
        .container{padding:30px;display:flex;flex-wrap:wrap;gap:20px}
        .card{background:#fff;width:220px;padding:20px;border-radius:6px;box-shadow:0 0 6px #ccc;text-align:center}
        .card h4{margin:0 0 10px}
        .card a{display:inline-block;margin:5px 0;padding:6px 12px;background:#007bff;color:#fff;text-decoration:none;border-radius:4px;font-size:14px}
        .card a:hover{background:#0056b3}
    </style>
</head>
<body>
<div class="header">
    公交管理系统-首页
    <a href="<%=ctx%>/user/logout">退出登录</a>
    <div style="clear:both"></div>
</div>

<div class="container">
    <!-- 1 线路 -->
    <div class="card">
        <h4>线路管理</h4>
        <a href="<%=ctx%>/route/manage">线路列表</a>
        <a href="<%=ctx%>/route/add">新增线路</a>
    </div>

    <!-- 2 站点 -->
    <div class="card">
        <h4>站点管理</h4>
        <a href="<%=ctx%>/station/manage">站点列表</a>
        <a href="<%=ctx%>/station/add">新增站点</a>
    </div>

    <!-- 3 车辆 -->
    <div class="card">
        <h4>车辆管理</h4>
        <a href="<%=ctx%>/vehicle/manage">车辆列表</a>
        <a href="<%=ctx%>/vehicle/add">新增车辆</a>
    </div>

    <!-- 4 班次 -->
    <div class="card">
        <h4>班次调度</h4>
        <a href="<%=ctx%>/schedule/manage">班次列表</a>
        <a href="<%=ctx%>/schedule/add">新增班次</a>
    </div>

    <!-- 5 到站记录 -->
    <div class="card">
        <h4>到站记录</h4>
        <a href="<%=ctx%>/arrivalRecord/add">录入到站</a>
<<<<<<< HEAD
        <a href="<%=ctx%>/arrivalRecord/latest">最近到站</a>
=======
        <a href="<%=ctx%>/arrivalRecord/latest/1?limit=10">最近到站</a>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    </div>

    <!-- 6 通知公告 -->
    <div class="card">
        <h4>系统通知</h4>
        <a href="<%=ctx%>/systemNotice/page">通知列表</a>
        <a href="<%=ctx%>/systemNotice/add">发布通知</a>
    </div>

    <!-- 7 收藏 -->
    <div class="card">
        <h4>我的收藏</h4>
<<<<<<< HEAD
        <a href="<%=ctx%>/collection/list">收藏列表</a>
=======
        <a href="<%=ctx%>/collection/list?userId=${sessionScope.loginUser.userId}">收藏列表</a>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    </div>

    <!-- 8 日志 -->
    <div class="card">
        <h4>登录日志</h4>
        <a href="<%=ctx%>/user/loginLogs">我的日志</a>
        <a href="<%=ctx%>/user/admin/allLogs">所有日志</a>
    </div>
</div>
</body>
</html>