<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>班次调度</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">班次调度</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>班次列表</span>
            <a href="<%=ctx%>/schedule/add" class="btn btn-sm btn-success">新增班次</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr><th>ID</th><th>线路ID</th><th>发车</th><th>到达</th><th>状态</th><th>操作</th></tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $.get(ctx+'/schedule/list',r=>{
        let html='';
        r.data.list.forEach(s=>{
            let statusHtml = s.status===1?'<span class="badge bg-success">正常</span>':s.status===0?'<span class="badge bg-danger">取消</span>':'<span class="badge bg-secondary">完成</span>';
            html+='<tr>' +
                '<td>'+s.scheduleId+'</td>' +
                '<td>'+s.routeId+'</td>' +
                '<td>'+s.departureTime+'</td>' +
                '<td>'+s.arrivalTime+'</td>' +
                '<td>'+statusHtml+'</td>' +
                '<td>' +
                    '<a href="'+ctx+'/schedule/edit/'+s.scheduleId+'" class="btn btn-sm btn-warning">编辑</a> ' +
                    '<button onclick="deleteSchedule('+s.scheduleId+')" class="btn btn-sm btn-danger">删除</button>' +
                '</td>' +
                '</tr>';
        });
        $('#tb').html(html);
    });
    
    // 删除调度
    function deleteSchedule(scheduleId){
        if(confirm('确定要删除这个班次调度吗？')){
            $.post(ctx+'/schedule/delete/'+scheduleId, function(r){
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