<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>站点管理</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">站点管理</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>站点列表</span>
            <a href="<%=ctx%>/station/add" class="btn btn-sm btn-success">新增站点</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr><th>ID</th><th>名称</th><th>地址</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $.get(ctx+'/station/list',r=>{
        let html='';
        r.data.list.forEach(s=>{
            html+='<tr>' +
                '<td>'+s.stationId+'</td>' +
                '<td>'+s.stationName+'</td>' +
                '<td>'+s.address+'</td>' +
                '<td>'+(s.status===1?'<span class="badge bg-success">启用</span>':'<span class="badge bg-secondary">关闭</span>')+'</td>' +
                '<td>' +
                    '<a href="'+ctx+'/station/edit/'+s.stationId+'" class="btn btn-sm btn-warning">编辑</a> ' +
                    '<button onclick="deleteStation('+s.stationId+')" class="btn btn-sm btn-danger">删除</button>' +
                '</td>' +
                '</tr>';
        });
        $('#tb').html(html);
    });
    
    // 删除站点
    function deleteStation(stationId){
        if(confirm('确定要删除这个站点吗？如果站点已关联线路，将无法删除。')){
            $.post(ctx+'/station/delete/'+stationId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    location.reload();
                }else{
                    alert(r.msg);
                }
            });
        }
    }
</script>
</body>
</html>