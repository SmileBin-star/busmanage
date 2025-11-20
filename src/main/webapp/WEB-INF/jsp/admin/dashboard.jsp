<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <title>管理后台 - 公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<!-- 引入头部导航 -->
<jsp:include page="/WEB-INF/jsp/common/header.jsp"/>

<div class="container mt-4">
    <div class="card">
        <div class="card-header">
            <h5 class="mb-0">管理后台首页</h5>
        </div>
        <div class="card-body">
            <p>欢迎管理员 <strong>${sessionScope.loginUser.username}</strong> 登录系统！</p>

            <div class="row mt-4">
                <div class="col-md-3">
                    <div class="card text-white bg-primary">
                        <div class="card-body">
                            <h6>线路管理</h6>
                            <a href="${pageContext.request.contextPath}/route/manage" class="btn btn-light btn-sm">进入</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-success">
                        <div class="card-body">
                            <h6>站点管理</h6>
                            <a href="${pageContext.request.contextPath}/station/manage" class="btn btn-light btn-sm">进入</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-warning">
                        <div class="card-body">
                            <h6>车辆管理</h6>
                            <a href="${pageContext.request.contextPath}/vehicle/manage" class="btn btn-light btn-sm">进入</a>
                        </div>
                    </div>
                </div>
                <div class="col-md-3">
                    <div class="card text-white bg-info">
                        <div class="card-body">
                            <h6>调度管理</h6>
                            <a href="${pageContext.request.contextPath}/schedule/manage" class="btn btn-light btn-sm">进入</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 引入页脚 -->
<jsp:include page="/WEB-INF/jsp/common/footer.jsp"/>

<script src="/js/bootstrap.bundle.min.js"></script>
</body>
</html>