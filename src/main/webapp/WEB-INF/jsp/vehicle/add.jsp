<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>新增车辆</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">新增车辆</span>
    <a href="<%=ctx%>/vehicle/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <div class="mb-3">
                <label>所属线路</label>
                <select name="routeId" id="routeId" class="form-control" required>
                    <option value="">请选择线路</option>
                </select>
            </div>
            <div class="mb-3"><label>车牌号</label><input name="licensePlate" class="form-control" required></div>
            <div class="mb-3">
                <label>车辆类型</label>
                <select name="vehicleType" class="form-control" required>
                    <option value="1">普通公交</option>
                    <option value="2">快速公交(BRT)</option>
                    <option value="3">双层公交</option>
                </select>
            </div>
            <div class="mb-3"><label>购买时间</label><input name="purchaseTime" type="date" class="form-control"></div>
            <div class="mb-3"><label>累计里程（公里）</label><input name="mileage" type="number" step="0.01" class="form-control" value="0"></div>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" selected>运营</option>
                    <option value="0">维修</option>
                    <option value="2">报废</option>
                </select>
            </div>
            <div class="mb-3"><label>司机ID（可选）</label><input name="driverId" type="number" class="form-control"></div>
            <button class="btn btn-primary">保存</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    
    // 加载线路列表
    $(document).ready(function() {
        $.get(ctx + '/route/list', {pageNum: 1, pageSize: 100}, function(res) {
            if (res.code === 200 && res.data && res.data.list) {
                let options = '<option value="">请选择线路</option>';
                res.data.list.forEach(function(route) {
                    options += '<option value="' + route.routeId + '">' + 
                        route.routeName + ' (ID:' + route.routeId + ')' +
                        '</option>';
                });
                $('#routeId').html(options);
            } else {
                alert('加载线路列表失败: ' + (res.msg || '未知错误'));
            }
        });
    });
    
    $('#form').submit(function(){
        // 获取表单数据，过滤掉空值
        const formData = {};
        $(this).serializeArray().forEach(function(item) {
            // 如果 purchaseTime 为空，不添加到 formData 中
            if (item.name === 'purchaseTime' && !item.value) {
                return; // 跳过空值
            }
            formData[item.name] = item.value;
        });
        
        $.post(ctx+'/vehicle/add', formData, r=>{
            if(r.code===200){location.href=ctx+'/vehicle/manage';}
            else{alert(r.msg);}
        });
        return false;
    });
</script>
</body>
</html>

