<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
%>
<!doctype html>
<html>
<head>
    <title>到站记录管理</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">到站记录管理</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header d-flex justify-content-between">
            <span>到站记录列表</span>
            <a href="<%=ctx%>/arrivalRecord/add" class="btn btn-sm btn-success">新增记录</a>
        </div>
        <div class="card-body p-0">
            <table class="table table-hover mb-0">
                <thead class="table-light">
                <tr>
                    <th>ID</th>
                    <th>车辆ID</th>
                    <th>站点ID</th>
                    <th>班次ID</th>
                    <th>到达时间</th>
                    <th>出发时间</th>
                    <th>延误(分钟)</th>
                    <th>上车/下车</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody id="tb"></tbody>
            </table>
        </div>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    function loadList(){
        $.get(ctx+'/arrivalRecord/list', function(r){
            if(r.code===200 && r.data){
                let html='';
                r.data.list.forEach(record=>{
                    html+='<tr>' +
                        '<td>'+record.recordId+'</td>' +
                        '<td>'+record.vehicleId+'</td>' +
                        '<td>'+record.stationId+'</td>' +
                        '<td>'+record.scheduleId+'</td>' +
                        '<td>'+(record.actualArrivalTime || '')+'</td>' +
                        '<td>'+(record.actualDepartureTime || '未出发')+'</td>' +
                        '<td>'+(record.delayMinutes || 0)+'</td>' +
                        '<td>'+(record.passengerIn || 0)+'/'+(record.passengerOut || 0)+'</td>' +
                        '<td>' +
                            '<button onclick="deleteRecord('+record.recordId+')" class="btn btn-sm btn-danger">删除</button>' +
                        '</td>' +
                        '</tr>';
                });
                $('#tb').html(html);
            }else{
                $('#tb').html('<tr><td colspan="9" class="text-center">暂无数据</td></tr>');
            }
        });
    }
    
    loadList();
    
    // 删除记录
    function deleteRecord(recordId){
        if(confirm('确定要删除这条到站记录吗？')){
            $.post(ctx+'/arrivalRecord/delete/'+recordId, function(r){
                if(r.code===200){
                    alert('删除成功');
                    loadList();
                }else{
                    alert(r.msg);
                }
            });
        }
    }
</script>
</body>
</html>

