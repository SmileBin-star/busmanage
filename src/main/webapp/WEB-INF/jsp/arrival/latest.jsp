<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>最近到站</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
    <style>
        .arrival-card {
            border: 1px solid #ddd;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            background: #fff;
            box-shadow: 0 2px 4px rgba(0,0,0,0.1);
            transition: box-shadow 0.3s;
        }
        .arrival-card:hover {
            box-shadow: 0 4px 8px rgba(0,0,0,0.15);
        }
        .station-name {
            font-size: 18px;
            font-weight: bold;
            color: #007bff;
            margin-bottom: 10px;
        }
        .arrival-time {
            font-size: 16px;
            color: #28a745;
            font-weight: 500;
        }
        .delay-badge {
            display: inline-block;
            padding: 2px 8px;
            border-radius: 12px;
            font-size: 12px;
            margin-left: 10px;
        }
        .delay-on-time {
            background: #d4edda;
            color: #155724;
        }
        .delay-late {
            background: #f8d7da;
            color: #721c24;
        }
    </style>
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">最近到站</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between align-items-center">
            <span>最近到站记录</span>
            <div class="d-flex align-items-center">
                <select id="stationFilter" class="form-select form-select-sm me-2" style="width: auto;">
                    <option value="">全部站点</option>
                </select>
                <select id="limitFilter" class="form-select form-select-sm" style="width: auto;">
                    <option value="20" selected>显示20条</option>
                    <option value="50">显示50条</option>
                    <option value="100">显示100条</option>
                </select>
            </div>
        </div>
        <div class="card-body" id="arrivalList">
            <div class="text-center text-muted py-4">加载中...</div>
        </div>
        <div class="card-footer">
            <nav>
                <ul class="pagination mb-0" id="pagination"></ul>
            </nav>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    let currentPage = 1;
    let pageSize = 20;
    let currentStationId = '';

    // 加载站点列表
    $(document).ready(function() {
        $.get(ctx + '/station/search', function(res) {
            if (res.code === 200 && res.data) {
                let options = '<option value="">全部站点</option>';
                res.data.forEach(function(station) {
                    options += '<option value="' + station.stationId + '">' + 
                        station.stationName + '</option>';
                });
                $('#stationFilter').html(options);
            }
        });
        
        loadList(1);
    });

    // 加载到站记录列表
    function loadList(page) {
        currentPage = page || 1;
        pageSize = parseInt($('#limitFilter').val()) || 20;
        currentStationId = $('#stationFilter').val() || '';
        
        $('#arrivalList').html('<div class="text-center text-muted py-4">加载中...</div>');
        
        $.get(ctx + '/arrivalRecord/latest/all', {
            stationId: currentStationId || null,
            pageNum: currentPage,
            pageSize: pageSize
        }, function(r) {
            if(r.code === 200 && r.data) {
                if(r.data.list && r.data.list.length > 0) {
                    let html = '';
                    r.data.list.forEach(function(record) {
                        const delayClass = (record.delayMinutes || 0) <= 0 ? 'delay-on-time' : 'delay-late';
                        const delayText = (record.delayMinutes || 0) <= 0 ? '准时' : '延误' + record.delayMinutes + '分钟';
                        const arrivalTime = record.actualArrivalTime || '';
                        const departureTime = record.actualDepartureTime || '<span class="text-muted">未出发</span>';
                        const stationName = record.stationName || ('站点ID: ' + record.stationId);
                        const licensePlate = record.licensePlate || ('车辆ID: ' + record.vehicleId);
                        
                        html += '<div class="arrival-card">' +
                            '<div class="station-name">' + stationName + '</div>' +
                            '<div class="row">' +
                            '<div class="col-md-3">' +
                            '<div><strong>车辆:</strong> ' + licensePlate + '</div>' +
                            '<div class="mt-2"><strong>班次ID:</strong> ' + record.scheduleId + '</div>' +
                            '</div>' +
                            '<div class="col-md-3">' +
                            '<div class="arrival-time">到达: ' + arrivalTime + '</div>' +
                            '<div class="mt-2">出发: ' + departureTime + '</div>' +
                            '</div>' +
                            '<div class="col-md-3">' +
                            '<div><span class="delay-badge ' + delayClass + '">' + delayText + '</span></div>' +
                            '<div class="mt-2">上下车: ' + (record.passengerIn || 0) + '/' + (record.passengerOut || 0) + '</div>' +
                            '</div>' +
                            '<div class="col-md-3 text-end">' +
                            '<small class="text-muted">记录ID: ' + record.recordId + '</small>' +
                            '</div>' +
                            '</div>' +
                            '</div>';
                    });
                    $('#arrivalList').html(html);
                    
                    // 渲染分页
                    renderPagination(r.data.total, r.data.pageNum, r.data.pageSize);
                } else {
                    $('#arrivalList').html('<div class="text-center text-muted py-4">暂无到站记录</div>');
                    $('#pagination').html('');
                }
            } else {
                $('#arrivalList').html('<div class="text-center text-danger py-4">加载失败: ' + (r.msg || '未知错误') + '</div>');
            }
        });
    }

    // 渲染分页
    function renderPagination(total, pageNum, pageSize) {
        const totalPages = Math.ceil(total / pageSize);
        let html = '';
        
        if (totalPages <= 1) {
            $('#pagination').html('');
            return;
        }

        // 上一页
        html += '<li class="page-item' + (pageNum <= 1 ? ' disabled' : '') + '">' +
            '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + (pageNum - 1) + ')">上一页</a>' +
            '</li>';

        // 页码
        const startPage = Math.max(1, pageNum - 2);
        const endPage = Math.min(totalPages, pageNum + 2);
        
        if (startPage > 1) {
            html += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="loadList(1)">1</a></li>';
            if (startPage > 2) {
                html += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
        }

        for (let i = startPage; i <= endPage; i++) {
            html += '<li class="page-item' + (i === pageNum ? ' active' : '') + '">' +
                '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + i + ')">' + i + '</a>' +
                '</li>';
        }

        if (endPage < totalPages) {
            if (endPage < totalPages - 1) {
                html += '<li class="page-item disabled"><span class="page-link">...</span></li>';
            }
            html += '<li class="page-item"><a class="page-link" href="javascript:void(0)" onclick="loadList(' + totalPages + ')">' + totalPages + '</a></li>';
        }

        // 下一页
        html += '<li class="page-item' + (pageNum >= totalPages ? ' disabled' : '') + '">' +
            '<a class="page-link" href="javascript:void(0)" onclick="loadList(' + (pageNum + 1) + ')">下一页</a>' +
            '</li>';

        $('#pagination').html(html);
    }

    // 站点筛选
    $('#stationFilter').change(function() {
        loadList(1);
    });

    // 数量筛选
    $('#limitFilter').change(function() {
        loadList(1);
    });
</script>
</body>
</html>

