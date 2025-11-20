<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>我的登录日志</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">我的登录日志</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header">最近 30 条记录</div>
        <table class="table table-hover mb-0">
            <thead class="table-light">
            <tr><th>登录时间</th><th>IP</th><th>状态</th><th>登出时间</th></tr>
            </thead>
            <tbody id="tb"></tbody>
        </table>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $.get(ctx+'/user/loginLogs',r=>{
        let html='';
        r.data.list.forEach(l=>{
            html+=`<tr>
                <td>${l.loginTime}</td><td>${l.loginIp}</td>
                <td>${l.loginStatus===1?'<span class="badge bg-success">成功</span>':'<span class="badge bg-danger">失败</span>'}</td>
                <td>${l.logoutTime||'未登出'}</td>
            </tr>`;
        });
        $('#tb').html(html);
    });
</script>
</body>
</html>