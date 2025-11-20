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
<<<<<<< HEAD
            <div class="mb-3">
                <label>班次</label>
                <select name="scheduleId" id="scheduleId" class="form-control" required>
                    <option value="">请选择班次</option>
                </select>
            </div>
            <div class="mb-3">
                <label>站点</label>
                <select name="stationId" id="stationId" class="form-control" required>
                    <option value="">请选择站点</option>
                </select>
            </div>
            <div class="mb-3">
                <label>车辆ID（自动填充）</label>
                <input name="vehicleId" id="vehicleId" type="number" class="form-control" readonly required>
                <small class="text-muted">选择班次后自动填充</small>
            </div>
            <div class="mb-3"><label>到达时间</label><input name="actualArrivalTime" type="datetime-local" class="form-control" required></div>
            <div class="mb-3"><label>延误分钟数（可选）</label><input name="delayMinutes" type="number" class="form-control" value="0"></div>
            <div class="mb-3"><label>上车人数（可选）</label><input name="passengerIn" type="number" class="form-control" value="0"></div>
            <div class="mb-3"><label>下车人数（可选）</label><input name="passengerOut" type="number" class="form-control" value="0"></div>
=======
            <div class="mb-3"><label>车辆ID</label><input name="vehicleId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>站点ID</label><input name="stationId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>班次ID</label><input name="scheduleId" type="number" class="form-control" required></div>
            <div class="mb-3"><label>到达时间</label><input name="actualArrivalTime" type="datetime-local" class="form-control" required></div>
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
<<<<<<< HEAD
    
    // 存储班次列表数据
    let scheduleList = [];
    
    // 加载班次列表
    $(document).ready(function() {
        $.get(ctx + '/schedule/list', {pageNum: 1, pageSize: 100}, function(res) {
            if (res.code === 200 && res.data && res.data.list) {
                scheduleList = res.data.list; // 保存数据供后续使用
                let options = '<option value="">请选择班次</option>';
                res.data.list.forEach(function(schedule) {
                    const statusText = schedule.status === 1 ? '正常' : schedule.status === 0 ? '取消' : '已完成';
                    options += '<option value="' + schedule.scheduleId + '">' + 
                        '班次ID:' + schedule.scheduleId + ' (线路:' + schedule.routeId + ', ' + schedule.departureTime + '-' + schedule.arrivalTime + ', ' + statusText + ')' +
                        '</option>';
                });
                $('#scheduleId').html(options);
            } else {
                alert('加载班次列表失败: ' + (res.msg || '未知错误'));
            }
        });
        
        // 加载站点列表
        $.get(ctx + '/station/search', function(res) {
            if (res.code === 200 && res.data) {
                let options = '<option value="">请选择站点</option>';
                res.data.forEach(function(station) {
                    options += '<option value="' + station.stationId + '">' + 
                        station.stationName + ' (ID:' + station.stationId + ')' +
                        '</option>';
                });
                $('#stationId').html(options);
            } else {
                alert('加载站点列表失败: ' + (res.msg || '未知错误'));
            }
        });
    });
    
    // 当班次改变时，自动填充车辆ID
    $('#scheduleId').change(function() {
        const scheduleId = $(this).val();
        if (scheduleId) {
            // 从已加载的班次列表中查找
            const schedule = scheduleList.find(s => s.scheduleId == scheduleId);
            if (schedule && schedule.vehicleId) {
                // 设置车辆ID
                $('#vehicleId').val(schedule.vehicleId);
            } else {
                $('#vehicleId').val('');
            }
        } else {
            $('#vehicleId').val('');
        }
    });
    
    $('#form').submit(function(){
        // 构建JSON对象
        let actualArrivalTimeStr = $('input[name="actualArrivalTime"]').val();
        // datetime-local格式转换为ISO格式 (2024-01-01T12:00 -> 2024-01-01T12:00:00)
        if (actualArrivalTimeStr && actualArrivalTimeStr.length === 16) {
            actualArrivalTimeStr = actualArrivalTimeStr + ':00';
        }
        
        const formData = {
            scheduleId: parseInt($('#scheduleId').val()),
            stationId: parseInt($('#stationId').val()),
            vehicleId: parseInt($('#vehicleId').val()),
            actualArrivalTime: actualArrivalTimeStr,
            delayMinutes: parseInt($('input[name="delayMinutes"]').val()) || 0,
            passengerIn: parseInt($('input[name="passengerIn"]').val()) || 0,
            passengerOut: parseInt($('input[name="passengerOut"]').val()) || 0
        };
        
        $.ajax({
            url: ctx + '/arrivalRecord/add',
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(formData),
            dataType: 'json',
            success: function(r) {
                if(r.code === 200) {
                    alert('添加成功');
                    location.href = ctx + '/arrivalRecord/manage';
                } else {
                    alert(r.msg);
                }
            },
            error: function(xhr) {
                alert('添加失败: ' + (xhr.responseJSON ? xhr.responseJSON.msg : '请检查网络连接'));
            }
        });
=======
    $('#form').submit(function(){
        $.post(ctx+'/arrivalRecord/add', JSON.stringify(Object.fromEntries($(this).serializeArray().map(x=>[x.name,x.value]))), r=>{
            if(r.code===200){location.href=ctx+'/user/index';}
            else{alert(r.msg);}
        },'json');
>>>>>>> 51be8eca486a0b89e7c55378a404bddf93d74dc1
        return false;
    });
</script>
</body>
</html>