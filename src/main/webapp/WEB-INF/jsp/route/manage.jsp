<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>线路列表</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">线路管理</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>线路列表</span>
            <a href="<%=ctx%>/route/add" class="btn btn-sm btn-success">新增线路</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th>ID</th><th>名称</th><th>起点</th><th>终点</th><th>状态</th><th>操作</th>
                </tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    $.get(ctx+'/route/list', r=>{
        let html='';
        r.data.list.forEach(o=>{
<<<<<<< HEAD
            html+='<tr>' +
                '<td>'+o.routeId+'</td>' +
                '<td>'+o.routeName+'</td>' +
                '<td>'+o.startStationName+'</td>' +
                '<td>'+o.endStationName+'</td>' +
                '<td>'+(o.status===1?'<span class="badge bg-success">运营</span>':'<span class="badge bg-secondary">停运</span>')+'</td>' +
                '<td>' +
                    '<a href="'+ctx+'/route/edit/'+o.routeId+'" class="btn btn-sm btn-warning">编辑</a> ' +
                    '<a href="'+ctx+'/route/editStations/'+o.routeId+'" class="btn btn-sm btn-info">站点</a> ' +
                    '<button onclick="deleteRoute('+o.routeId+')" class="btn btn-sm btn-danger">删除</button>' +
                '</td></tr>';
        });
        $('#tb').html(html);
    });
    
    // 删除线路
    function deleteRoute(routeId){
        if(confirm('确定要删除这条线路吗？删除后将同时删除该线路的所有站点关联。')){
            $.post(ctx+'/route/delete/'+routeId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    location.reload();
                }else{
                    alert(r.msg);
                }
            });
        }
    }
=======
            html+=`<tr>
                <td>${o.routeId}</td><td>${o.routeName}</td><td>${o.startStationName}</td>
                <td>${o.endStationName}</td>
                <td>${o.status===1?'<span class="badge bg-success">运营</span>':'<span class="badge bg-secondary">停运</span>'}</td>
                <td>
                    <a href="${ctx}/route/edit/${o.routeId}" class="btn btn-sm btn-warning">编辑</a>
                    <a href="${ctx}/route/editStations/${o.routeId}" class="btn btn-sm btn-info">站点</a>
                </td></tr>`;
        });
        $('#tb').html(html);
    });
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
</script>
</body>
</html>