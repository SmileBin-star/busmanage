<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.BusStation station = (org.example.busmanagement.model.entity.BusStation) request.getAttribute("station");
%>
<!doctype html>
<html>
<head>
    <title>编辑站点</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">编辑站点</span>
    <a href="<%=ctx%>/station/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <input type="hidden" name="stationId" value="<%=station.getStationId()%>">
            <div class="mb-3"><label>站点名称</label><input name="stationName" class="form-control" value="<%=station.getStationName()!=null?station.getStationName():""%>" required></div>
            <div class="mb-3"><label>纬度</label><input name="latitude" type="number" step="0.000001" class="form-control" value="<%=station.getLatitude()!=null?station.getLatitude():""%>"></div>
            <div class="mb-3"><label>经度</label><input name="longitude" type="number" step="0.000001" class="form-control" value="<%=station.getLongitude()!=null?station.getLongitude():""%>"></div>
            <div class="mb-3"><label>详细地址</label><input name="address" class="form-control" value="<%=station.getAddress()!=null?station.getAddress():""%>"></div>
            <div class="mb-3">
                <label>站点类型</label>
                <select name="stationType" class="form-control" required>
                    <option value="1" <%=station.getStationType()!=null&&station.getStationType()==1?"selected":""%>>普通站</option>
                    <option value="2" <%=station.getStationType()!=null&&station.getStationType()==2?"selected":""%>>枢纽站</option>
                </select>
            </div>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" <%=station.getStatus()!=null&&station.getStatus()==1?"selected":""%>>启用</option>
                    <option value="0" <%=station.getStatus()!=null&&station.getStatus()==0?"selected":""%>>关闭</option>
                </select>
            </div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    $('#form').submit(function(){
        $.post(ctx+'/station/edit', $(this).serialize(), r=>{
            if(r.code===200){
                location.href=ctx+'/station/manage';
            }else{
                alert(r.msg);
            }
        });
        return false;
    });
</script>
</body>
</html>

