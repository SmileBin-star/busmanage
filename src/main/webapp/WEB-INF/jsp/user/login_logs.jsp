<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
<<<<<<< HEAD
    org.example.busmanagement.model.entity.User loginUser = (org.example.busmanagement.model.entity.User) session.getAttribute("loginUser");
    Integer userId = loginUser != null ? loginUser.getUserId() : null;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD
        <div class="card-header">登录记录</div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th>登录时间</th>
                    <th>登录IP</th>
                    <th>状态</th>
                    <th>登出时间</th>
                </tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
        <div class="card-footer">
            <nav>
                <ul class="pagination mb-0" id="pagination"></ul>
            </nav>
        </div>
=======
        <div class="card-header">最近 30 条记录</div>
        <table class="table table-hover mb-0">
            <thead class="table-light">
            <tr><th>登录时间</th><th>IP</th><th>状态</th><th>登出时间</th></tr>
            </thead>
            <tbody id="tb"></tbody>
        </table>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
<<<<<<< HEAD
    const userId = <%=userId != null ? userId : "null"%>;
    let currentPage = 1;
    const pageSize = 10;

    function loadList(page) {
        currentPage = page || 1;
        if (!userId) {
            $('#tb').html('<tr><td colspan="4" class="text-center">请先登录</td></tr>');
            return;
        }
        
        $.get(ctx+'/user/loginLogs/api', {
            pageNum: currentPage,
            pageSize: pageSize
        }, function(r){
            if(r.code===200 && r.data){
                let html='';
                if(r.data.list && r.data.list.length > 0){
                    r.data.list.forEach(l=>{
                        html+='<tr>' +
                            '<td>'+(l.loginTime || '')+'</td>' +
                            '<td>'+(l.loginIp || '')+'</td>' +
                            '<td>'+(l.loginStatus===1?'<span class="badge bg-success">成功</span>':'<span class="badge bg-danger">失败</span>')+'</td>' +
                            '<td>'+(l.logoutTime || '<span class="text-muted">未登出</span>')+'</td>' +
                            '</tr>';
                    });
                }else{
                    html='<tr><td colspan="4" class="text-center">暂无登录记录</td></tr>';
                }
                $('#tb').html(html);
                
                // 分页
                renderPagination(r.data.total, r.data.pageNum, r.data.pageSize);
            }else{
                $('#tb').html('<tr><td colspan="4" class="text-center">加载失败</td></tr>');
            }
        });
    }

    function renderPagination(total, pageNum, pageSize) {
        const totalPages = Math.ceil(total / pageSize);
        let html = '';
        
        if (totalPages <= 1) {
            $('#pagination').html('');
            return;
        }

        // 上一页
        html += '<li class="page-item' + (pageNum <= 1 ? ' disabled' : '') + '">' +
            '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + (pageNum - 1) + ')">上一页</a>' +
            '</li>';

        // 页码
        const startPage = Math.max(1, pageNum - 2);
        const endPage = Math.min(totalPages, pageNum + 2);
        
        if (startPage > 1) {
            html += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="loadList(1)">1</a></li>';
            if (startPage > 2) {
                html += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
        }

        for (let i = startPage; i <= endPage; i++) {
            html += '<li class="page-item' + (i === pageNum ? ' active' : '') + '">' +
                '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + i + ')">' + i + '</a>' +
                '</li>';
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                html += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
            html += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="loadList(' + totalPages + ')">' + totalPages + '</a></li>';
        }

        // 下一页
        html += '<li class="page-item' + (pageNum >= totalPages ? ' disabled' : '') + '">' +
            '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + (pageNum + 1) + ')">下一页</a>' +
            '</li>';

        $('#pagination').html(html);
    }

    // 初始加载
    loadList(1);
=======
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
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
</script>
</body>
</html>