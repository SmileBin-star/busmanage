<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>新增线路</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">新增线路</span>
    <a href="<%=ctx%>/route/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <div class="mb-3"><label>线路名称</label><input name="routeName" class="form-control" required></div>
            <div class="mb-3"><label>起点站ID</label><input name="startStation" type="number" class="form-control" required></div>
            <div class="mb-3"><label>终点站ID</label><input name="endStation" type="number" class="form-control" required></div>
            <div class="mb-3"><label>首班时间</label><input name="departureTime" type="time" class="form-control" required></div>
            <div class="mb-3"><label>末班时间</label><input name="arrivalTime" type="time" class="form-control" required></div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    $('#form').submit(function(){
        $.post(ctx+'/route/add', $(this).serialize(), r=>{
            if(r.code===200){location.href=ctx+'/route/manage';}
            else{alert(r.msg);}
        });
        return false;
    });
</script>
</body>
</html>