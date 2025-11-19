<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>线路查询 - 公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        .station-item { padding: 8px 0; border-bottom: 1px dashed #eee; }
        .station-item:last-child { border-bottom: none; }
    </style>
</head>
<body>
<!-- 引入头部导航 -->
<div th:replace="common/header.jsp"></div>

<div class="container mt-4">
    <div class="card mb-4">
        <div class="card-header">
            <h5 class="mb-0">线路查询结果</h5>
        </div>
        <div class="card-body">
            <!-- 搜索条件回显 -->
            <div class="mb-3">
                <span class="text-muted">查询关键词：</span>
                <span th:text="${keyword}">1路</span>
            </div>

            <!-- 线路列表 -->
            <div th:each="route : ${routes}">
                <div class="border rounded p-3 mb-4">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h5 th:text="${route.routeName}">1路公交车</h5>
                        <button class="btn btn-sm btn-outline-primary collect-btn"
                                th:data-route-id="${route.routeId}"
                                th:text="${route.collected ? '已收藏' : '收藏'}">
                            收藏
                        </button>
                    </div>

                    <div class="mb-3">
                        <p class="mb-1">
                            <span class="fw-bold">起点：</span>
                            <span th:text="${route.startStationName}">火车站</span>
                        </p>
                        <p class="mb-1">
                            <span class="fw-bold">终点：</span>
                            <span th:text="${route.endStationName}">汽车站</span>
                        </p>
                        <p class="mb-1">
                            <span class="fw-bold">首末班时间：</span>
                            <span th:text="${route.departureTime + ' - ' + route.arrivalTime}">06:00 - 22:00</span>
                        </p>
                        <p class="mb-1">
                            <span class="fw-bold">总里程：</span>
                            <span th:text="${route.totalDistance + ' 公里'}">15.5 公里</span>
                        </p>
                        <p class="mb-1">
                            <span class="fw-bold">状态：</span>
                            <span class="badge bg-success" th:if="${route.status == 1}">运营中</span>
                            <span class="badge bg-secondary" th:if="${route.status == 0}">已停运</span>
                        </p>
                    </div>

                    <!-- 途经站点 -->
                    <div>
                        <h6>途经站点（<span th:text="${route.totalStations}">12</span>站）</h6>
                        <div class="ms-3 mt-2">
                            <div class="station-item" th:each="station, stat : ${route.stations}">
                                <span class="badge bg-primary me-2" th:text="${stat.index + 1}">1</span>
                                <span th:text="${station.stationName}">火车站</span>
                                <span class="text-muted small ms-2" th:if="${station.distanceFromPrev != null}">
                                        （距前站：<span th:text="${station.distanceFromPrev}">1.2</span>公里）
                                    </span>
                            </div>
                        </div>
                    </div>

                    <!-- 查看地图按钮 -->
                    <div class="mt-3">
                        <button class="btn btn-sm btn-outline-secondary"
                                th:data-route-id="${route.routeId}">
                            查看线路地图
                        </button>
                    </div>
                </div>
            </div>

            <!-- 无结果提示 -->
            <div th:if="${routes.isEmpty()}" class="text-center py-5">
                <p class="text-muted">未查询到相关线路，请更换关键词重试</p>
            </div>
        </div>
    </div>
</div>

<!-- 引入页脚 -->
<div th:replace="common/footer.jsp"></div>

<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/jquery.min.js"></script>
<script>
    // 收藏线路功能
    $(function() {
        $('.collect-btn').click(function() {
            const routeId = $(this).data('route-id');
            const btn = $(this);
            if (btn.text() === '已收藏') {
                // 取消收藏
                $.post('/collection/cancel', {
                    userId: [[${session.loginUser.userId}]],
                    type: 1,
                    targetId: routeId
                }, function(res) {
                    if (res.success) {
                        btn.text('收藏');
                        btn.removeClass('btn-primary').addClass('btn-outline-primary');
                    } else {
                        alert(res.msg);
                    }
                });
            } else {
                // 添加收藏
                $.post('/collection/add', {
                    userId: [[${session.loginUser.userId}]],
                    type: 1,
                    targetId: routeId
                }, function(res) {
                    if (res.success) {
                        btn.text('已收藏');
                        btn.removeClass('btn-outline-primary').addClass('btn-primary');
                    } else {
                        alert(res.msg);
                    }
                });
            }
        });
    });
</script>
</body>
</html>