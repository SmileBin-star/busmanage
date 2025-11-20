<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.BusSchedule schedule = (org.example.busmanagement.model.entity.BusSchedule) request.getAttribute("schedule");
%>
<!doctype html>
<html>
<head>
    <title>编辑班次</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">编辑班次</span>
    <a href="<%=ctx%>/schedule/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <input type="hidden" name="scheduleId" value="<%=schedule.getScheduleId()%>">
            <div class="mb-3">
                <label>线路</label>
                <select name="routeId" id="routeId" class="form-control" required>
                    <option value="">请选择线路</option>
                </select>
            </div>
            <div class="mb-3"><label>发车时间</label><input name="departureTime" type="time" class="form-control" value="<%=schedule.getDepartureTime()!=null?schedule.getDepartureTime():""%>" required></div>
            <div class="mb-3"><label>到达时间</label><input name="arrivalTime" type="time" class="form-control" value="<%=schedule.getArrivalTime()!=null?schedule.getArrivalTime():""%>" required></div>
            <div class="mb-3">
                <label>车辆</label>
                <select name="vehicleId" id="vehicleId" class="form-control" required>
                    <option value="">请先选择线路</option>
                </select>
            </div>
            <div class="mb-3"><label>司机ID（可选）</label><input name="driverId" type="number" class="form-control" value="<%=schedule.getDriverId()!=null?schedule.getDriverId():""%>"></div>
            <div class="mb-3"><label>核定载客量</label><input name="capacity" type="number" class="form-control" value="<%=schedule.getCapacity()!=null?schedule.getCapacity():""%>" required></div>
            <div class="mb-3"><label>实际载客数</label><input name="actualPassengers" type="number" class="form-control" value="<%=schedule.getActualPassengers()!=null?schedule.getActualPassengers():0%>"></div>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" <%=schedule.getStatus()!=null&&schedule.getStatus()==1?"selected":""%>>正常</option>
                    <option value="0" <%=schedule.getStatus()!=null&&schedule.getStatus()==0?"selected":""%>>取消</option>
                    <option value="2" <%=schedule.getStatus()!=null&&schedule.getStatus()==2?"selected":""%>>已完成</option>
                </select>
            </div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    const currentRouteId = <%=schedule.getRouteId() != null ? schedule.getRouteId() : "null"%>;
    const currentVehicleId = <%=schedule.getVehicleId() != null ? schedule.getVehicleId() : "null"%>;
    
    // 加载线路列表
    $(document).ready(function() {
        $.get(ctx + '/route/list', {pageNum: 1, pageSize: 100}, function(res) {
            if (res.code === 200 && res.data && res.data.list) {
                let options = '<option value="">请选择线路</option>';
                res.data.list.forEach(function(route) {
                    const selected = currentRouteId !== null && route.routeId === currentRouteId ? ' selected' : '';
                    options += '<option value="' + route.routeId + '"' + selected + '>' + 
                        route.routeName + ' (ID:' + route.routeId + ')' +
                        '</option>';
                });
                $('#routeId').html(options);
                
                // 如果已有线路ID，加载车辆列表
                if (currentRouteId) {
                    loadVehicles(currentRouteId);
                }
            } else {
                alert('加载线路列表失败: ' + (res.msg || '未知错误'));
            }
        });
    });
    
    // 加载车辆列表
    function loadVehicles(routeId) {
        $.get(ctx + '/vehicle/getByRoute/' + routeId, function(res) {
            if (res.code === 200 && res.data) {
                let options = '<option value="">请选择车辆</option>';
                res.data.forEach(function(vehicle) {
                    const statusText = vehicle.status === 1 ? '运营' : vehicle.status === 0 ? '维修' : '报废';
                    const selected = currentVehicleId !== null && vehicle.vehicleId === currentVehicleId ? ' selected' : '';
                    options += '<option value="' + vehicle.vehicleId + '"' + selected + '>' + 
                        vehicle.licensePlate + ' (' + statusText + ')' +
                        '</option>';
                });
                $('#vehicleId').html(options);
            } else {
                $('#vehicleId').html('<option value="">该线路暂无车辆</option>');
            }
        });
    }
    
    // 当线路改变时，加载该线路的车辆列表
    $('#routeId').change(function() {
        const routeId = $(this).val();
        if (routeId) {
            loadVehicles(routeId);
        } else {
            $('#vehicleId').html('<option value="">请先选择线路</option>');
        }
    });
    
    $('#form').submit(function(){
        $.post(ctx+'/schedule/edit', $(this).serialize(), r=>{
            if(r.code===200){
                location.href=ctx+'/schedule/manage';
            }else{
                alert(r.msg);
            }
        });
        return false;
    });
</script>
</body>
</html>

