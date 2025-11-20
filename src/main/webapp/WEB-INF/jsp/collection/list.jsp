<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    Integer loginUserId = (Integer) session.getAttribute("loginUser.userId");
%>
<!doctype html>
<html>
<head>
    <title>我的收藏</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">我的收藏</span>
    <a href="<%=ctx%>/user/index" class="btn btn-sm btn-outline-light">返回首页</a>
</nav>
<div class="container mt-3">
    <div class="card">
        <div class="card-header">收藏列表</div>
        <ul class="list-group list-group-flush" id="list"></ul>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx='<%=ctx%>';
    const userId='<%=loginUserId%>';
    $.get(ctx+'/collection/list',{userId:userId},r=>{
        let html='';
        r.data.forEach(c=>{
            const name=c.collectionType===1?'线路':'站点';
            html+=`<li class="list-group-item d-flex justify-content-between">
                ${name} ID：${c.targetId}
                <button class="btn btn-sm btn-outline-danger" onclick="cancel(${c.collectionType},${c.targetId})">取消</button>
            </li>`;
        });
        $('#list').html(html);
    });
    function cancel(type,id){
        $.post(ctx+'/collection/cancel',{userId:userId,collectionType:type,targetId:id},r=>{
            if(r.code===200)location.reload();
        });
    }
</script>
</body>
</html>