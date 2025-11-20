<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    Integer loginUserId = (Integer) session.getAttribute("loginUser.userId");
    if (loginUserId == null) {
        loginUserId = 1; // 临时默认值，实际应从session获取
    }
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
                    <th>目标ID</th>
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
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    const userId=<%=loginUserId%>;
    let currentPage = 1;
    const pageSize = 10;
    let currentType = '';

    function loadList(page, type) {
        currentPage = page || 1;
        currentType = type || '';
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
                        html+='<tr>' +
                            '<td>'+typeBadge+'</td>' +
                            '<td>' +
                                '<a href="' + (c.collectionType===1 ? ctx+'/route/detail/'+c.targetId : ctx+'/station/detail/'+c.targetId) + '" target="_blank">' +
                                'ID: ' + c.targetId +
                                '</a>' +
                            '</td>' +
                            '<td>'+(c.collectionTime || '')+'</td>' +
                            '<td>' +
                                '<button onclick="deleteCollection('+c.collectionId+')" class="btn btn-sm btn-danger">删除</button> ' +
                                '<button onclick="cancelCollection('+c.collectionType+','+c.targetId+')" class="btn btn-sm btn-outline-secondary">取消收藏</button>' +
                            '</td>' +
                            '</tr>';
                    });
                }else{
                    html='<tr><td colspan="4" class="text-center">暂无收藏记录</td></tr>';
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

    // 删除收藏（按ID）
    function deleteCollection(collectionId){
        if(confirm('确定要删除这条收藏吗？')){
            $.post(ctx+'/collection/delete/'+collectionId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    loadList(currentPage, currentType);
                }else{
                    alert(r.msg);
                }
            });
        }
    }

    // 取消收藏（按类型和目标ID）
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
                    alert(r.msg);
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
</script>
</body>
</html>

