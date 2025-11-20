<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.User loginUser = (org.example.busmanagement.model.entity.User) session.getAttribute("loginUser");
    Integer currentUserId = loginUser != null ? loginUser.getUserId() : null;
%>
<!doctype html>
<html>
<head>
    <title>发布通知</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">发布通知</span>
    <a href="<%=ctx%>/systemNotice/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <div class="mb-3"><label>标题</label><input name="title" class="form-control" required></div>
            <div class="mb-3"><label>内容</label><textarea name="content" class="form-control" rows="5" required></textarea></div>
            <% if (currentUserId != null) { %>
            <input type="hidden" name="publisherId" id="publisherId" value="<%=currentUserId%>">
            <div class="mb-3">
                <label>发布者</label>
                <input type="text" class="form-control" value="<%=loginUser.getUsername()%> (ID: <%=currentUserId%>)" readonly>
                <small class="text-muted">当前登录用户</small>
            </div>
            <% } else { %>
            <div class="mb-3">
                <label>发布者ID</label>
                <input name="publisherId" type="number" class="form-control" required>
                <small class="text-muted">请先登录或输入有效的用户ID</small>
            </div>
            <% } %>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" selected>发布中</option>
                    <option value="0">下架</option>
                </select>
            </div>
            <button class="btn btn-primary">发布</button>
        </form>
    </div>
</div>
<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    const ctx = '<%=ctx%>';
    $('#form').submit(function(){
        $.post(ctx+'/systemNotice/add', $(this).serialize(), r=>{
            if(r.code===200){
                alert('发布成功');
                location.href=ctx+'/systemNotice/manage';
            }else{
                alert(r.msg);
            }
        });
        return false;
    });
</script>
</body>
</html>

