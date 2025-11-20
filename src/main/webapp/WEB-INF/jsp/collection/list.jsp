<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
<<<<<<< HEAD
    org.example.busmanagement.model.entity.User loginUser = (org.example.busmanagement.model.entity.User) session.getAttribute("loginUser");
    Integer loginUserId = loginUser != null ? loginUser.getUserId() : null;
    if (loginUserId == null) {
        response.sendRedirect(ctx + "/user/login");
        return;
    }
=======
    Integer loginUserId = (Integer) session.getAttribute("loginUser.userId");
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
%>
<!doctype html>
<html>
<head>
    <title>我的收藏</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">我的收藏</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
<<<<<<< HEAD
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>收藏列表</span>
            <div>
                <select id="typeFilter" class="form-select form-select-sm d-inline-block" style="width: auto;">
                    <option value="">全部</option>
                    <option value="1">线路</option>
                    <option value="2">站点</option>
                </select>
            </div>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th>类型</th>
                    <th>名称</th>
                    <th>ID</th>
                    <th>收藏时间</th>
                    <th>操作</th>
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
        <div class="card-header">收藏列表</div>
        <ul class="list-group list-group-flush" id="list"></ul>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
<<<<<<< HEAD
    const userId=<%=loginUserId%>;
    let currentPage = 1;
    const pageSize = 10;
    let currentType = '';

    function loadList(page, type) {
        currentPage = page || 1;
        currentType = type !== undefined ? type : currentType;
        
        $.get(ctx+'/collection/api/list', {
            userId: userId,
            type: currentType || null,
            pageNum: currentPage,
            pageSize: pageSize
        }, function(r){
            if(r.code===200 && r.data){
                let html='';
                if(r.data.list && r.data.list.length > 0){
                    r.data.list.forEach(c=>{
                        const typeName = c.collectionType===1?'线路':'站点';
                        const typeBadge = c.collectionType===1?'<span class="badge bg-primary">线路</span>':'<span class="badge bg-info">站点</span>';
                        const targetName = c.targetName || ('ID: ' + c.targetId);
                        const detailUrl = c.collectionType===1 ? ctx+'/route/manage' : ctx+'/station/manage';
                        html+='<tr>' +
                            '<td>'+typeBadge+'</td>' +
                            '<td>' +
                                '<a href="' + detailUrl + '" target="_blank">' + targetName + '</a>' +
                            '</td>' +
                            '<td>'+c.targetId+'</td>' +
                            '<td>'+(c.collectionTime || '')+'</td>' +
                            '<td>' +
                                '<button onclick="cancelCollection('+c.collectionType+','+c.targetId+')" class="btn btn-sm btn-danger">取消收藏</button>' +
                            '</td>' +
                            '</tr>';
                    });
                }else{
                    html='<tr><td colspan="5" class="text-center">暂无收藏记录</td></tr>';
                }
                $('#tb').html(html);
                
                // 分页
                renderPagination(r.data.total, r.data.pageNum, r.data.pageSize);
            }else{
                $('#tb').html('<tr><td colspan="5" class="text-center">加载失败：' + (r.msg || '未知错误') + '</td></tr>');
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

    // 取消收藏
    function cancelCollection(type, targetId){
        if(confirm('确定要取消收藏吗？')){
            $.post(ctx+'/collection/cancel', {
                userId: userId,
                type: type,
                targetId: targetId
            }, function(r){
                if(r.code===200){
                    alert('取消收藏成功');
                    loadList(currentPage, currentType);
                }else{
                    alert('取消收藏失败：' + (r.msg || '未知错误'));
                }
            });
        }
    }

    // 类型筛选
    $('#typeFilter').change(function(){
        const type = $(this).val();
        loadList(1, type);
    });

    // 初始加载
    loadList(1);
=======
    const userId='<%=loginUserId%>';
    $.get(ctx+'/collection/list',{userId:userId},r=>{
        let html='';
        r.data.forEach(c=>{
            const name=c.collectionType===1?'线路':'站点';
            html+=`<li class="list-group-item d-flex justify-content-between">
                ${name} ID：${c.targetId}
                <button class="btn btn-sm btn-outline-danger" onclick="cancel(${c.collectionType},${c.targetId})">取消</button>
            </li>`;
        });
        $('#list').html(html);
    });
    function cancel(type,id){
        $.post(ctx+'/collection/cancel',{userId:userId,collectionType:type,targetId:id},r=>{
            if(r.code===200)location.reload();
        });
    }
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
</script>
</body>
</html>