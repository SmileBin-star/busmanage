<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.BusRoute route = (org.example.busmanagement.model.entity.BusRoute) request.getAttribute("route");
%>
<!doctype html>
<html>
<head>
    <title>编辑线路</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">编辑线路</span>
    <a href="<%=ctx%>/route/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <input type="hidden" name="routeId" value="<%=route.getRouteId()%>">
            <div class="mb-3"><label>线路名称</label><input name="routeName" class="form-control" value="<%=route.getRouteName()%>" required></div>
            <div class="mb-3">
                <label>起点站</label>
                <select name="startStation" id="startStation" class="form-control" required>
                    <option value="">请选择起点站</option>
                </select>
            </div>
            <div class="mb-3">
                <label>终点站</label>
                <select name="endStation" id="endStation" class="form-control" required>
                    <option value="">请选择终点站</option>
                </select>
            </div>
            <div class="mb-3"><label>首班时间</label><input name="departureTime" type="time" class="form-control" value="<%=route.getDepartureTime()!=null?route.getDepartureTime():""%>" required></div>
            <div class="mb-3"><label>末班时间</label><input name="arrivalTime" type="time" class="form-control" value="<%=route.getArrivalTime()!=null?route.getArrivalTime():""%>" required></div>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" <%=route.getStatus()!=null&&route.getStatus()==1?"selected":""%>>运营</option>
                    <option value="0" <%=route.getStatus()!=null&&route.getStatus()==0?"selected":""%>>停运</option>
                </select>
            </div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    const currentStartStation = <%=route.getStartStation()%>;
    const currentEndStation = <%=route.getEndStation()%>;
    
    // 加载站点列表
    $.get(ctx+'/station/search', function(r){
        if(r.code===200 && r.data){
            let startHtml = '<option value="">请选择起点站</option>';
            let endHtml = '<option value="">请选择终点站</option>';
            r.data.forEach(function(s){
                const startSelected = s.stationId === currentStartStation ? ' selected' : '';
                const endSelected = s.stationId === currentEndStation ? ' selected' : '';
                startHtml += '<option value="'+s.stationId+'"'+startSelected+'>'+s.stationName+' (ID: '+s.stationId+')</option>';
                endHtml += '<option value="'+s.stationId+'"'+endSelected+'>'+s.stationName+' (ID: '+s.stationId+')</option>';
            });
            $('#startStation').html(startHtml);
            $('#endStation').html(endHtml);
        }
    });
    
    $('#form').submit(function(){
        $.post(ctx+'/route/edit', $(this).serialize(), r=>{
            if(r.code===200){
                location.href=ctx+'/route/manage';
            }else{
                alert(r.msg);
            }
        });
        return false;
    });
</script>
</body>
</html>

