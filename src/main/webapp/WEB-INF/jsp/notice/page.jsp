<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
<<<<<<< HEAD
    org.example.busmanagement.model.entity.User loginUser = (org.example.busmanagement.model.entity.User) session.getAttribute("loginUser");
    boolean isAdmin = loginUser != null && loginUser.getRoleType() != null && loginUser.getRoleType() == 2;
=======
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
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
<<<<<<< HEAD
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>通知列表</span>
            <div class="d-flex align-items-center">
                <select id="statusFilter" class="form-select form-select-sm me-2" style="width: auto;">
                    <option value="">全部</option>
                    <option value="1">发布中</option>
                    <option value="0">已下架</option>
                </select>
                <% if (isAdmin) { %>
                <a href="<%=ctx%>/systemNotice/add" class="btn btn-sm btn-success me-2">发布通知</a>
                <% } %>
            </div>
=======
        <div class="card-header d-flex justify-content-between">
            <span>通知列表</span>
            <a href="<%=ctx%>/systemNotice/add" class="btn btn-sm btn-success">发布通知</a>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
<<<<<<< HEAD
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>发布者</th>
                    <th>发布时间</th>
                    <th>阅读数</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
=======
                <tr><th>标题</th><th>发布时间</th><th>阅读数</th><th>状态</th></tr>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
<<<<<<< HEAD
        <div class="card-footer">
            <nav>
                <ul class="pagination mb-0" id="pagination"></ul>
            </nav>
        </div>
    </div>
</div>

<!-- 详情模态框 -->
<div id="detailModal" style="display:none; position:fixed; top:0; left:0; width:100%; height:100%; background:rgba(0,0,0,0.5); z-index:1000; overflow:auto;">
    <div style="max-width:800px; margin:50px auto; background:#fff; border-radius:8px; padding:20px; position:relative;">
        <button onclick="closeDetail()" style="position:absolute; top:10px; right:10px; border:none; background:none; font-size:24px; cursor:pointer;">&times;</button>
        <h4 class="mb-3" id="detailTitle">通知详情</h4>
        <div class="mb-3">
            <strong>标题：</strong>
            <div id="detailTitleContent" class="mt-1"></div>
        </div>
        <div class="mb-3">
            <strong>内容：</strong>
            <div id="detailContent" class="mt-1 p-3 bg-light border rounded" style="white-space: pre-wrap; min-height:100px;"></div>
        </div>
        <div class="row">
            <div class="col-md-6">
                <strong>发布者：</strong>
                <span id="detailPublisher"></span>
            </div>
            <div class="col-md-6">
                <strong>发布时间：</strong>
                <span id="detailPublishTime"></span>
            </div>
        </div>
        <div class="row mt-2">
            <div class="col-md-6">
                <strong>阅读数：</strong>
                <span id="detailReadCount"></span>
            </div>
            <div class="col-md-6">
                <strong>状态：</strong>
                <span id="detailStatus"></span>
            </div>
        </div>
        <div class="mt-3 text-end">
            <button onclick="closeDetail()" class="btn btn-secondary">关闭</button>
        </div>
    </div>
</div>

<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    const isAdmin = <%=isAdmin%>;
    let currentPage = 1;
    const pageSize = 10;
    let currentStatus = '';

    function loadList(page, status) {
        currentPage = page || 1;
        currentStatus = status !== undefined ? status : currentStatus;
        
        $.get(ctx+'/systemNotice/api/list', {
            status: currentStatus || null,
            pageNum: currentPage,
            pageSize: pageSize
        }, function(r){
            if(r.code===200 && r.data){
                let html='';
                if(r.data.list && r.data.list.length > 0){
                    r.data.list.forEach(n=>{
                        const publisherName = n.publisherName || ('ID: ' + n.publisherId);
                        const publishTime = formatDateTime(n.publishTime);
                        html+='<tr>' +
                            '<td>'+n.noticeId+'</td>' +
                            '<td><a href="javascript:void(0)" onclick="viewDetail('+n.noticeId+')" class="text-decoration-none">'+n.title+'</a></td>' +
                            '<td>'+publisherName+'</td>' +
                            '<td>'+publishTime+'</td>' +
                            '<td>'+(n.readCount || 0)+'</td>' +
                            '<td>'+(n.status===1?'<span class="badge bg-success">发布中</span>':'<span class="badge bg-secondary">已下架</span>')+'</td>' +
                            '<td>' +
                                '<button onclick="viewDetail('+n.noticeId+')" class="btn btn-sm btn-info">查看</button> ';
                        if(isAdmin){
                            html += '<a href="'+ctx+'/systemNotice/edit/'+n.noticeId+'" class="btn btn-sm btn-warning">编辑</a> ' +
                                    '<button onclick="deleteNotice('+n.noticeId+')" class="btn btn-sm btn-danger">删除</button>';
                        }
                        html += '</td>' +
                            '</tr>';
                    });
                }else{
                    html='<tr><td colspan="7" class="text-center">暂无通知</td></tr>';
                }
                $('#tb').html(html);
                
                // 分页
                renderPagination(r.data.total, r.data.pageNum, r.data.pageSize);
            }else{
                $('#tb').html('<tr><td colspan="7" class="text-center">加载失败：' + (r.msg || '未知错误') + '</td></tr>');
            }
        });
    }

    function formatDateTime(dateTimeStr) {
        if (!dateTimeStr) return '';
        // 如果是 ISO 格式的日期时间字符串，转换为更友好的格式
        try {
            const date = new Date(dateTimeStr);
            const year = date.getFullYear();
            const month = String(date.getMonth() + 1).padStart(2, '0');
            const day = String(date.getDate()).padStart(2, '0');
            const hours = String(date.getHours()).padStart(2, '0');
            const minutes = String(date.getMinutes()).padStart(2, '0');
            return year + '-' + month + '-' + day + ' ' + hours + ':' + minutes;
        } catch (e) {
            return dateTimeStr;
        }
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

    // 查看详情
    function viewDetail(noticeId) {
        $.get(ctx + '/systemNotice/detail/' + noticeId, function(r) {
            if (r.code === 200 && r.data) {
                const notice = r.data;
                $('#detailTitle').text(notice.title);
                $('#detailTitleContent').text(notice.title);
                $('#detailContent').text(notice.content);
                $('#detailPublisher').text(notice.publisherName || ('ID: ' + notice.publisherId));
                $('#detailPublishTime').text(formatDateTime(notice.publishTime));
                $('#detailReadCount').text(notice.readCount || 0);
                $('#detailStatus').html(notice.status === 1 ? '<span class="badge bg-success">发布中</span>' : '<span class="badge bg-secondary">已下架</span>');
                
                // 显示模态框
                $('#detailModal').show();
            } else {
                alert('获取详情失败：' + (r.msg || '未知错误'));
            }
        });
    }

    // 关闭详情
    function closeDetail() {
        $('#detailModal').hide();
    }

    // 点击模态框背景关闭
    $('#detailModal').click(function(e) {
        if (e.target === this) {
            closeDetail();
        }
    });

    // 删除通知
    function deleteNotice(noticeId) {
        if(confirm('确定要删除这条通知吗？删除后无法恢复！')){
            $.post(ctx+'/systemNotice/delete/'+noticeId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    loadList(currentPage, currentStatus);
                }else{
                    alert('删除失败：' + (r.msg || '未知错误'));
                }
            });
        }
    }

    // 状态筛选
    $('#statusFilter').change(function(){
        loadList(1, $(this).val());
    });

    // 初始加载
    loadList(1);
=======
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
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
</script>
</body>
</html>