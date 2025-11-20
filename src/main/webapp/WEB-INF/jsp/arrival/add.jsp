<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>录入到站</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">录入到站</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <div class="mb-3"><label>车辆ID</label><input name="vehicleId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>站点ID</label><input name="stationId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>班次ID</label><input name="scheduleId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>到达时间</label><input name="actualArrivalTime" type="datetime-local" class="form-control" required></div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    $('#form').submit(function(){
        $.post(ctx+'/arrivalRecord/add', JSON.stringify(Object.fromEntries($(this).serializeArray().map(x=>[x.name,x.value]))), r=>{
            if(r.code===200){location.href=ctx+'/user/index';}
            else{alert(r.msg);}
        },'json');
        return false;
    });
</script>
</body>
</html>