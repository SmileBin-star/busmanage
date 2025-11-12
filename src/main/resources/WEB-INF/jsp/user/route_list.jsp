<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>公交线路列表</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/style.css">
</head>
<body>
<div class="container">
    <h2>公交线路查询</h2>

    <table border="1" class="route-table">
        <tr>
            <th>线路ID</th>
            <th>线路名称</th>
            <th>起点站</th>
            <th>终点站</th>
            <th>总站点数</th>
            <th>首末班时间</th>
            <th>状态</th>
            <th>操作</th>
        </tr>
        <c:forEach items="${pageResult.list}" var="route">
            <tr>
                <td>${route.routeId}</td>
                <td>${route.routeName}</td>
                <td>${route.startStationName}</td>
                <td>${route.endStationName}</td>
                <td>${route.totalStations}</td>
                <td>${route.departureTime}-${route.arrivalTime}</td>
                <td>
                    <c:if test="${route.status == 1}">
                        <span style="color: green;">运营中</span>
                    </c:if>
                    <c:if test="${route.status == 0}">
                        <span style="color: red;">已停运</span>
                    </c:if>
                </td>
                <td>
                    <a href="${pageContext.request.contextPath}/bus/route/detail/${route.routeId}">查看详情</a>
                    <c:if test="${sessionScope.user.roleType == 2}">
                        <a href="${pageContext.request.contextPath}/bus/route/edit/${route.routeId}">编辑</a>
                        <a href="javascript:changeStatus(${route.routeId}, ${route.status == 1 ? 0 : 1})">
                                ${route.status == 1 ? '停运' : '启用'}
                        </a>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
    </table>

    <div class="pagination">
        <a href="${pageContext.request.contextPath}/bus/route/list?pageNum=1">首页</a>
        <c:if test="${pageResult.pageNum > 1}">
            <a href="${pageContext.request.contextPath}/bus/route/list?pageNum=${pageResult.pageNum - 1}">上一页</a>
        </c:if>
        <c:if test="${pageResult.pageNum < pageResult.totalPages}">
            <a href="${pageContext.request.contextPath}/bus/route/list?pageNum=${pageResult.pageNum + 1}">下一页</a>
        </c:if>
        <a href="${pageContext.request.contextPath}/bus/route/list?pageNum=${pageResult.totalPages}">尾页</a>
    </div>
</div>

<script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
<script>
    function changeStatus(routeId, status) {
        if (confirm(status === 0 ? "确定要停运该线路吗？" : "确定要启用该线路吗？")) {
            $.post("${pageContext.request.contextPath}/bus/route/changeStatus", {
                routeId: routeId,
                status: status
            }, function(res) {
                if (res.code === 200) {
                    alert(res.msg);
                    location.reload();
                } else {
                    alert(res.msg);
                }
            });
        }
    }
</script>
</body>
</html>