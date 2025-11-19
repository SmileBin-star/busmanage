<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>用户首页 - 公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
    <style>
        .carousel-item { height: 300px; }
        .notice-card { max-height: 300px; overflow-y: auto; }
    </style>
</head>
<body>
<!-- 引入头部导航 -->
<div th:replace="common/header.jsp"></div>

<div class="container mt-4">
    <!-- 搜索框 -->
    <div class="card mb-4">
        <div class="card-body">
            <form th:action="@{/user/route/search}" method="get" class="row g-3">
                <div class="col-md-8">
                    <input type="text" name="keyword" class="form-control"
                           placeholder="请输入线路名称或站点名称查询" required>
                </div>
                <div class="col-md-4">
                    <button type="submit" class="btn btn-primary w-100">搜索</button>
                </div>
            </form>
        </div>
    </div>

    <!-- 轮播图 -->
    <div id="carouselExampleIndicators" class="carousel slide mb-4" data-bs-ride="true">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1"></button>
            <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="/images/bus1.jpg" class="d-block w-100 h-100 object-cover" alt="公交动态1">
            </div>
            <div class="carousel-item">
                <img src="/images/bus2.jpg" class="d-block w-100 h-100 object-cover" alt="公交动态2">
            </div>
            <div class="carousel-item">
                <img src="/images/bus3.jpg" class="d-block w-100 h-100 object-cover" alt="公交动态3">
            </div>
        </div>
        <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
        </button>
        <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
        </button>
    </div>

    <div class="row">
        <!-- 热门线路列表 -->
        <div class="col-md-8">
            <div class="card mb-4">
                <div class="card-header">
                    <h5 class="mb-0">热门线路</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group">
                        <li class="list-group-item d-flex justify-content-between align-items-center" th:each="route : ${hotRoutes}">
                            <div>
                                <h6 th:text="${route.routeName}">1路公交车</h6>
                                <small class="text-muted" th:text="${'起点：' + route.startStationName + ' - 终点：' + route.endStationName}">
                                    起点：火车站 - 终点：汽车站
                                </small>
                                <br>
                                <small class="text-muted" th:text="${'首末班：' + route.departureTime + ' - ' + route.arrivalTime}">
                                    首末班：06:00 - 22:00
                                </small>
                            </div>
                            <button class="btn btn-sm btn-outline-primary collect-btn"
                                    th:data-route-id="${route.routeId}"
                                    th:text="${route.collected ? '已收藏' : '收藏'}">
                                收藏
                            </button>
                        </li>
                    </ul>
                </div>
            </div>
        </div>

        <!-- 最新通知 -->
        <div class="col-md-4">
            <div class="card notice-card">
                <div class="card-header">
                    <h5 class="mb-0">最新通知</h5>
                </div>
                <div class="card-body">
                    <ul class="list-group list-group-flush">
                        <li class="list-group-item" th:each="notice : ${latestNotices}">
                            <a th:href="@{/systemNotice/detail/{id}(id=${notice.noticeId})}"
                               th:text="${notice.title}" class="text-decoration-none">
                                线路调整通知
                            </a>
                            <p class="mb-0 text-muted small" th:text="${notice.createTime}">2023-10-01</p>
                        </li>
                    </ul>
                </div>
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
            $.post('/collection/add', {
                userId: [[${session.loginUser.userId}]],
                type: 1,  // 1-线路收藏
                targetId: routeId
            }, function(res) {
                if (res.success) {
                    btn.text('已收藏');
                    btn.removeClass('btn-outline-primary').addClass('btn-primary');
                } else {
                    alert(res.msg);
                }
            });
        });
    });
</script>
</body>
</html>