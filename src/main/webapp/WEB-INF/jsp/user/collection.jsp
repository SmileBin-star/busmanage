<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>我的收藏 - 公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<!-- 引入头部导航 -->
<div th:replace="common/header.jsp"></div>

<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <ul class="nav nav-tabs card-header-tabs">
                <li class="nav-item">
                    <a class="nav-link active" href="#" data-type="1">线路收藏</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="#" data-type="2">站点收藏</a>
                </li>
            </ul>
        </div>
        <div class="card-body">
            <!-- 线路收藏列表 -->
            <div id="route-collections">
                <div th:each="collection : ${routeCollections}">
                    <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                        <div>
                            <h6 th:text="${collection.routeName}">1路公交车</h6>
                            <small class="text-muted" th:text="${'起点：' + collection.startStationName + ' - 终点：' + collection.endStationName}">
                                起点：火车站 - 终点：汽车站
                            </small>
                        </div>
                        <div>
                            <a th:href="@{/user/route/search(keyword=${collection.routeName})}"
                               class="btn btn-sm btn-outline-secondary me-2">查看详情</a>
                            <button class="btn btn-sm btn-outline-danger cancel-collect"
                                    th:data-type="1"
                                    th:data-target-id="${collection.targetId}">
                                取消收藏
                            </button>
                        </div>
                    </div>
                </div>
                <div th:if="${routeCollections.isEmpty()}" class="text-center py-5">
                    <p class="text-muted">暂无线路收藏</p>
                </div>
            </div>

            <!-- 站点收藏列表（默认隐藏） -->
            <div id="station-collections" style="display: none;">
                <div th:each="collection : ${stationCollections}">
                    <div class="d-flex justify-content-between align-items-center p-3 border-bottom">
                        <div>
                            <h6 th:text="${collection.stationName}">火车站</h6>
                            <small class="text-muted" th:text="${collection.address}">XX路XX号</small>
                        </div>
                        <div>
                            <a th:href="@{/station/detail/{id}(id=${collection.targetId})}"
                               class="btn btn-sm btn-outline-secondary me-2">查看详情</a>
                            <button class="btn btn-sm btn-outline-danger cancel-collect"
                                    th:data-type="2"
                                    th:data-target-id="${collection.targetId}">
                                取消收藏
                            </button>
                        </div>
                    </div>
                </div>
                <div th:if="${stationCollections.isEmpty()}" class="text-center py-5">
                    <p class="text-muted">暂无站点收藏</p>
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
    // 切换收藏类型
    $(function() {
        $('.nav-link').click(function(e) {
            e.preventDefault();
            // 切换标签激活状态
            $('.nav-link').removeClass('active');
            $(this).addClass('active');

            // 显示对应收藏列表
            const type = $(this).data('type');
            if (type === 1) {
                $('#route-collections').show();
                $('#station-collections').hide();
            } else {
                $('#route-collections').hide();
                $('#station-collections').show();
            }
        });

        // 取消收藏
        $('.cancel-collect').click(function() {
            const type = $(this).data('type');
            const targetId = $(this).data('target-id');
            const row = $(this).closest('div.border-bottom');

            $.post('/collection/cancel', {
                userId: [[${session.loginUser.userId}]],
                type: type,
                targetId: targetId
            }, function(res) {
                if (res.success) {
                    row.remove();
                    // 检查是否为空
                    if ($('#route-collections > div').length === 0) {
                        $('#route-collections').html('<div class="text-center py-5"><p class="text-muted">暂无线路收藏</p></div>');
                    }
                    if ($('#station-collections > div').length === 0) {
                        $('#station-collections').html('<div class="text-center py-5"><p class="text-muted">暂无站点收藏</p></div>');
                    }
                } else {
                    alert(res.msg);
                }
            });
        });
    });
</script>
</body>
</html>