<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>系统通知管理</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">系统通知管理</span>
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
                <tr>
                    <th>ID</th>
                    <th>标题</th>
                    <th>发布者ID</th>
                    <th>发布时间</th>
                    <th>阅读数</th>
                    <th>状态</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    function loadList(){
        $.get(ctx+'/systemNotice/list', function(r){
            if(r.code===200 && r.data){
                let html='';
                r.data.list.forEach(n=>{
                    html+='<tr>' +
                        '<td>'+n.noticeId+'</td>' +
                        '<td>'+n.title+'</td>' +
                        '<td>'+n.publisherId+'</td>' +
                        '<td>'+(n.publishTime || '')+'</td>' +
                        '<td>'+(n.readCount || 0)+'</td>' +
                        '<td>'+(n.status===1?'<span class="badge bg-success">发布中</span>':'<span class="badge bg-secondary">已下架</span>')+'</td>' +
                        '<td>' +
                            '<a href="'+ctx+'/systemNotice/edit/'+n.noticeId+'" class="btn btn-sm btn-warning">编辑</a> ' +
                            '<button onclick="deleteNotice('+n.noticeId+')" class="btn btn-sm btn-danger">删除</button>' +
                        '</td>' +
                        '</tr>';
                });
                $('#tb').html(html);
            }else{
                $('#tb').html('<tr><td colspan="7" class="text-center">暂无数据</td></tr>');
            }
        });
    }
    
    loadList();
    
    // 删除通知
    function deleteNotice(noticeId){
        if(confirm('确定要删除这条通知吗？')){
            $.post(ctx+'/systemNotice/delete/'+noticeId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    loadList();
                }else{
                    alert(r.msg);
                }
            });
        }
    }
</script>
</body>
</html>

