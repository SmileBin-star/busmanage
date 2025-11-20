<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>通知公告</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">通知公告</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>通知列表</span>
            <a href="<%=ctx%>/systemNotice/add" class="btn btn-sm btn-success">发布通知</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr><th>标题</th><th>发布时间</th><th>阅读数</th><th>状态</th></tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $.get(ctx+'/systemNotice/page',r=>{
        let html='';
        r.data.list.forEach(n=>{
            html+=`<tr>
                <td><a href="${ctx}/systemNotice/detail/${n.noticeId}" target="_blank">${n.title}</a></td>
                <td>${n.publishTime}</td><td>${n.readCount}</td>
                <td>${n.status===1?'<span class="badge bg-success">发布中</span>':'<span class="badge bg-secondary">已下架</span>'}</td>
            </tr>`;
        });
        $('#tb').html(html);
    });
</script>
</body>
</html>