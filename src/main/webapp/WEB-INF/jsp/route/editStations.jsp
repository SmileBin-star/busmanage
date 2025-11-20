<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.BusRoute route = (org.example.busmanagement.model.entity.BusRoute) request.getAttribute("route");
    java.util.List<org.example.busmanagement.model.entity.BusRouteStation> routeStations = (java.util.List<org.example.busmanagement.model.entity.BusRouteStation>) request.getAttribute("routeStations");
    java.util.List<org.example.busmanagement.model.entity.BusStation> allStations = (java.util.List<org.example.busmanagement.model.entity.BusStation>) request.getAttribute("allStations");
    if (routeStations == null) routeStations = new java.util.ArrayList<>();
    if (allStations == null) allStations = new java.util.ArrayList<>();
%>
<!doctype html>
<html>
<head>
    <title>编辑线路站点</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
    <style>
        .station-item {
            border: 1px solid #ddd;
            border-radius: 4px;
            padding: 10px;
            margin-bottom: 10px;
            background: #f9f9f9;
        }
        .station-item:hover {
            background: #f0f0f0;
        }
        .order-badge {
            display: inline-block;
            width: 30px;
            height: 30px;
            line-height: 30px;
            text-align: center;
            background: #007bff;
            color: white;
            border-radius: 50%;
            margin-right: 10px;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">编辑线路站点 - <%=route.getRouteName()%></span>
    <a href="<%=ctx%>/route/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>线路站点列表</span>
            <button class="btn btn-sm btn-success" onclick="addStation()">添加站点</button>
        </div>
        <div class="card-body">
            <div id="stationList">
                <% if (routeStations.isEmpty()) { %>
                    <div class="text-center text-muted py-4">暂无站点，请添加站点</div>
                <% } else { %>
                    <% for (int i = 0; i < routeStations.size(); i++) { 
                        org.example.busmanagement.model.entity.BusRouteStation rs = routeStations.get(i);
                        String stationName = "站点ID: " + rs.getStationId();
                        // 从allStations中查找站点名称
                        for (org.example.busmanagement.model.entity.BusStation s : allStations) {
                            if (s.getStationId() != null && s.getStationId().equals(rs.getStationId())) {
                                stationName = s.getStationName() != null ? s.getStationName() : stationName;
                                break;
                            }
                        }
                    %>
                        <div class="station-item" data-station-id="<%=rs.getStationId()%>">
                            <div class="d-flex justify-content-between align-items-center">
                                <div class="d-flex align-items-center">
                                    <span class="order-badge"><%=rs.getStationOrder() != null ? rs.getStationOrder() : (i + 1)%></span>
                                    <div>
                                        <strong><%=stationName%></strong> (ID: <%=rs.getStationId()%>)
                                        <div class="small text-muted mt-1">
                                            距离前一站: <%=rs.getDistanceFromPrev() != null ? rs.getDistanceFromPrev() + "公里" : "未设置"%> | 
                                            预计时间: <%=rs.getEstimatedTime() != null ? rs.getEstimatedTime() + "分钟" : "未设置"%>
                                        </div>
                                    </div>
                                </div>
                                <div>
                                    <button class="btn btn-sm btn-warning" onclick="moveUp(<%=i%>)">上移</button>
                                    <button class="btn btn-sm btn-warning" onclick="moveDown(<%=i%>)">下移</button>
                                    <button class="btn btn-sm btn-danger" onclick="removeStation(<%=i%>)">删除</button>
                                </div>
                            </div>
                        </div>
                    <% } %>
                <% } %>
            </div>
            
            <!-- 添加站点表单 -->
            <div class="card mt-3" id="addStationForm" style="display:none;">
                <div class="card-header">添加站点</div>
                <div class="card-body">
                    <div class="mb-3">
                        <label>选择站点</label>
                        <select id="newStationId" class="form-control">
                            <option value="">请选择站点</option>
                            <% for (org.example.busmanagement.model.entity.BusStation s : allStations) { %>
                                <option value="<%=s.getStationId()%>"><%=s.getStationName()%> (ID: <%=s.getStationId()%>)</option>
                            <% } %>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label>距离前一站（公里）</label>
                        <input type="number" id="newDistance" class="form-control" step="0.01" placeholder="可选">
                    </div>
                    <div class="mb-3">
                        <label>预计时间（分钟）</label>
                        <input type="number" id="newTime" class="form-control" placeholder="可选">
                    </div>
                    <div>
                        <button class="btn btn-primary" onclick="confirmAddStation()">确认添加</button>
                        <button class="btn btn-secondary" onclick="cancelAddStation()">取消</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="card-footer">
            <button class="btn btn-primary" onclick="saveStations()">保存站点顺序</button>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    const routeId = <%=route.getRouteId()%>;
    let stations = [];
    
    // 初始化站点列表
    <% for (org.example.busmanagement.model.entity.BusRouteStation rs : routeStations) { %>
    stations.push({
        stationId: <%=rs.getStationId()%>,
        stationOrder: <%=rs.getStationOrder() != null ? rs.getStationOrder() : 0%>,
        distanceFromPrev: <%=rs.getDistanceFromPrev() != null ? rs.getDistanceFromPrev() : "null"%>,
        estimatedTime: <%=rs.getEstimatedTime() != null ? rs.getEstimatedTime() : "null"%>
    });
    <% } %>
    
    // 显示添加站点表单
    function addStation() {
        $('#addStationForm').show();
    }
    
    // 取消添加
    function cancelAddStation() {
        $('#addStationForm').hide();
        $('#newStationId').val('');
        $('#newDistance').val('');
        $('#newTime').val('');
    }
    
    // 确认添加站点
    function confirmAddStation() {
        const stationId = $('#newStationId').val();
        if (!stationId) {
            alert('请选择站点');
            return;
        }
        
        // 检查是否已添加
        if (stations.find(s => s.stationId == stationId)) {
            alert('该站点已添加');
            return;
        }
        
        const newStation = {
            stationId: parseInt(stationId),
            stationOrder: stations.length + 1,
            distanceFromPrev: $('#newDistance').val() ? parseFloat($('#newDistance').val()) : null,
            estimatedTime: $('#newTime').val() ? parseInt($('#newTime').val()) : null
        };
        
        stations.push(newStation);
        renderStationList();
        cancelAddStation();
    }
    
    // 删除站点
    function removeStation(index) {
        if (confirm('确定要删除这个站点吗？')) {
            stations.splice(index, 1);
            updateOrder();
            renderStationList();
        }
    }
    
    // 上移
    function moveUp(index) {
        if (index > 0) {
            const temp = stations[index];
            stations[index] = stations[index - 1];
            stations[index - 1] = temp;
            updateOrder();
            renderStationList();
        }
    }
    
    // 下移
    function moveDown(index) {
        if (index < stations.length - 1) {
            const temp = stations[index];
            stations[index] = stations[index + 1];
            stations[index + 1] = temp;
            updateOrder();
            renderStationList();
        }
    }
    
    // 更新顺序
    function updateOrder() {
        stations.forEach((s, index) => {
            s.stationOrder = index + 1;
        });
    }
    
    // 渲染站点列表
    function renderStationList() {
        if (stations.length === 0) {
            $('#stationList').html('<div class="text-center text-muted py-4">暂无站点，请添加站点</div>');
            return;
        }
        
        let html = '';
        stations.forEach((s, index) => {
            const stationName = $('#newStationId option[value="' + s.stationId + '"]').text() || '站点ID: ' + s.stationId;
            html += '<div class="station-item" data-station-id="' + s.stationId + '">' +
                '<div class="d-flex justify-content-between align-items-center">' +
                '<div class="d-flex align-items-center">' +
                '<span class="order-badge">' + s.stationOrder + '</span>' +
                '<div>' +
                '<strong>' + stationName + '</strong>' +
                '<div class="small text-muted mt-1">' +
                '距离前一站: ' + (s.distanceFromPrev !== null ? s.distanceFromPrev + '公里' : '未设置') + ' | ' +
                '预计时间: ' + (s.estimatedTime !== null ? s.estimatedTime + '分钟' : '未设置') +
                '</div>' +
                '</div>' +
                '</div>' +
                '<div>' +
                '<button class="btn btn-sm btn-warning" onclick="moveUp(' + index + ')">上移</button> ' +
                '<button class="btn btn-sm btn-warning" onclick="moveDown(' + index + ')">下移</button> ' +
                '<button class="btn btn-sm btn-danger" onclick="removeStation(' + index + ')">删除</button>' +
                '</div>' +
                '</div>' +
                '</div>';
        });
        $('#stationList').html(html);
    }
    
    // 保存站点顺序
    function saveStations() {
        if (stations.length === 0) {
            alert('请至少添加一个站点');
            return;
        }
        
        // 准备数据
        const routeStations = stations.map((s, index) => ({
            stationId: s.stationId,
            stationOrder: index + 1,
            distanceFromPrev: s.distanceFromPrev,
            estimatedTime: s.estimatedTime
        }));
        
        $.ajax({
            url: ctx + '/route/saveStations/' + routeId,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(routeStations),
            dataType: 'json',
            success: function(r) {
                if (r.code === 200) {
                    alert('保存成功');
                    location.reload();
                } else {
                    alert(r.msg || '保存失败');
                }
            },
            error: function(xhr) {
                alert('保存失败：' + (xhr.responseJSON ? xhr.responseJSON.msg : '请检查网络连接'));
            }
        });
    }
</script>
</body>
</html>

