<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>公交站点列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <h2>公交站点查询</h2>

    <!-- 搜索框 -->
    <div class="search-box">
        <input type="text" id="stationName" placeholder="请输入站点名称">
        <button onclick="searchStations()">搜索</button>
    </div>

    <table border="1" class="station-table">
        <tr>
            <th>站点ID</th>
            <th>站点名称</th>
            <th>类型</th>
            <th>地址</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageResult.list}" var="station">
            <tr>
                <td>${station.stationId}</td>
                <td>${station.stationName}</td>
                <td>
                    <c:if test="${station.stationType == 1}">普通站</c:if>
                    <c:if test="${station.stationType == 2}">枢纽站</c:if>
                </td>
                <td>${station.address}</td>
                <td>
                    <c:if test="${station.status == 1}">
                        <span style="color: green;">启用</span>
                    </c:if>
                    <c:if test="${station.status == 0}">
                        <span style="color: red;">关闭</span>
                    </c:if>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/bus/station/detail/${station.stationId}">查看详情</a>
                    <c:if test="${sessionScope.user.roleType == 1}">
                        <a href="javascript:collectStation(${station.stationId})">收藏</a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>

    <!-- 分页控件 -->
    <div class="pagination">
        <a href="${pageContext.request.contextPath}/bus/station/list?pageNum=1">首页</a>
        <c:if test="${pageResult.pageNum > 1}">
            <a href="${pageContext.request.contextPath}/bus/station/list?pageNum=${pageResult.pageNum - 1}">上一页</a>
        </c:if>
        <c:if test="${pageResult.pageNum < pageResult.totalPages}">
            <a href="${pageContext.request.contextPath}/bus/station/list?pageNum=${pageResult.pageNum + 1}">下一页</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/bus/station/list?pageNum=${pageResult.totalPages}">尾页</a>
    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script>
    // 搜索站点
    function searchStations() {
        let name = $("#stationName").val();
        $.get("${pageContext.request.contextPath}/bus/station/search", {name: name}, function(res) {
            if (res.code === 200) {
                // 清空表格并重新渲染
                let html = "";
                res.data.forEach(station => {
                    html += `<tr>
                            <td>${station.stationId}</td>
                            <td>${station.stationName}</td>
                            <td>${station.stationType === 1 ? '普通站' : '枢纽站'}</td>
                            <td>${station.address}</td>
                            <td><span style="color: ${station.status === 1 ? 'green' : 'red'}">${station.status === 1 ? '启用' : '关闭'}</span></td>
                            <td>
                                <a href="${pageContext.request.contextPath}/bus/station/detail/${station.stationId}">查看详情</a>
                                <a href="javascript:collectStation(${station.stationId})">收藏</a>
                            </td>
                        </tr>`;
                });
                $(".station-table tr:gt(0)").remove(); // 保留表头
                $(".station-table").append(html);
            } else {
                alert(res.msg);
            }
        });
    }

    // 收藏站点（普通用户功能）
    function collectStation(stationId) {
        $.post("${pageContext.request.contextPath}/bus/collection/add", {
            targetId: stationId,
            collectionType: 2 // 2表示站点收藏
        }, function(res) {
            alert(res.msg);
        });
    }
</script>
</body>
</html>