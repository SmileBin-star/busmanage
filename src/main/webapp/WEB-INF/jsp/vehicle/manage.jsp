<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>车辆管理</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">车辆管理</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>车辆列表</span>
            <a href="<%=ctx%>/vehicle/add" class="btn btn-sm btn-success">新增车辆</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr><th>ID</th><th>车牌</th><th>类型</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $.get(ctx+'/vehicle/list',r=>{
        let html='';
        r.data.list.forEach(v=>{
            html+=`<tr><td>${v.vehicleId}</td><td>${v.licensePlate}</td>
                <td>${v.vehicleType===1?'普通公交':'快速公交'}</td>
                <td>${v.status===1?'<span class="badge bg-success">运营</span>':'<span class="badge bg-secondary">停用</span>'}</td>
                <td><a href="${ctx}/vehicle/edit/${v.vehicleId}" class="btn btn-sm btn-warning">编辑</a></td></tr>`;
        });
        $('#tb').html(html);
    });
</script>
</body>
</html>