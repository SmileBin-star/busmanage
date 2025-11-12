<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>编辑线路站点 - ${route.routeName}</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/admin.css">
</head>
<body>
<div class="container">
    <h2>${route.routeName} - 站点关联管理</h2>

    <div class="operation-bar">
        <a href="${pageContext.request.contextPath}/bus/route/manage" class="btn-back">返回线路管理</a>
    </div>

    <!-- 已关联站点列表 -->
    <div class="section">
        <h3>已关联站点（拖拽调整顺序）</h3>
        <div id="stationList" class="station-sort-list">
            <c:forEach items="${routeStations}" var="rs" varStatus="status">
                <div class="station-item" data-id="${rs.id}" data-station-id="${rs.stationId}">
                    <span class="order">${rs.stationOrder}</span>
                    <span class="name">${rs.stationName}</span>
                    <div class="actions">
                        <input type="number" class="distance" placeholder="距前一站(km)"
                               value="${rs.distanceFromPrev != null ? rs.distanceFromPrev : ''}">
                        <input type="number" class="time" placeholder="预计时间(分钟)"
                               value="${rs.estimatedTime != null ? rs.estimatedTime : ''}">
                        <button class="btn-remove" onclick="removeStation(this)">移除</button>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 可选站点列表 -->
    <div class="section">
        <h3>可选站点（点击添加）</h3>
        <div class="available-stations">
            <c:forEach items="${allStations}" var="station">
                <div class="available-item" onclick="addStation(${station.stationId}, '${station.stationName}')">
                        ${station.stationName}
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 保存按钮 -->
    <div class="submit-bar">
        <button id="saveBtn" class="btn-save" onclick="saveStations(${route.routeId})">保存关联</button>
    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script>
    // 添加站点到关联列表
    function addStation(stationId, stationName) {
        // 检查是否已添加
        if ($(`.station-item[data-station-id="${stationId}"]`).length > 0) {
            alert("该站点已关联");
            return;
        }
        // 获取当前最大顺序
        let maxOrder = 0;
        $('.station-item').each(function() {
            let order = parseInt($(this).find('.order').text());
            if (order > maxOrder) maxOrder = order;
        });
        // 添加新项
        let newItem = `
                <div class="station-item" data-station-id="${stationId}">
                    <span class="order">${maxOrder + 1}</span>
                    <span class="name">${stationName}</span>
                    <div class="actions">
                        <input type="number" class="distance" placeholder="距前一站(km)" step="0.1">
                        <input type="number" class="time" placeholder="预计时间(分钟)">
                        <button class="btn-remove" onclick="removeStation(this)">移除</button>
                    </div>
                </div>
            `;
        $('#stationList').append(newItem);
    }

    // 移除站点
    function removeStation(btn) {
        $(btn).closest('.station-item').remove();
        // 重新计算顺序
        resetOrder();
    }

    // 重置顺序号
    function resetOrder() {
        $('.station-item').each(function(index) {
            $(this).find('.order').text(index + 1);
        });
    }

    // 保存关联
    function saveStations(routeId) {
        let stations = [];
        $('.station-item').each(function(index) {
            let stationId = $(this).data('station-id');
            let distance = $(this).find('.distance').val() || 0;
            let time = $(this).find('.time').val() || 0;
            stations.push({
                stationId: stationId,
                stationOrder: index + 1,
                distanceFromPrev: parseFloat(distance),
                estimatedTime: parseInt(time)
            });
        });

        if (stations.length < 2) {
            alert("线路至少需要关联2个站点（起点和终点）");
            return;
        }

        // 提交保存
        $.ajax({
            url: "${pageContext.request.contextPath}/bus/route/saveStations?routeId=" + routeId,
            type: "POST",
            contentType: "application/json",
            data: JSON.stringify(stations),
            success: function(res) {
                if (res.code === 200) {
                    alert("保存成功");
                    location.reload();
                } else {
                    alert(res.msg);
                }
            }
        });
    }
</script>
</body>
</html>