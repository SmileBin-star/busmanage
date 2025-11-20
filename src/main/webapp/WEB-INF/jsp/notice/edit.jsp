<%@ page contentType="text/html;charset=UTF-8" %>
<%
    String ctx = request.getContextPath();
    org.example.busmanagement.model.entity.SystemNotice notice = (org.example.busmanagement.model.entity.SystemNotice) request.getAttribute("notice");
%>
<!doctype html>
<html>
<head>
    <title>编辑通知</title>
    <meta charset="utf-8"/>
    <link rel="stylesheet" href="<%=ctx%>/static/css/bootstrap.min.css">
</head>
<body class="bg-light">
<nav class="navbar navbar-dark bg-primary text-white px-3">
    <span class="navbar-brand mb-0 h1">编辑通知</span>
    <a href="<%=ctx%>/systemNotice/manage" class="btn btn-sm btn-outline-light">返回</a>
</nav>
<div class="container mt-3">
    <div class="card p-3">
        <form id="form">
            <input type="hidden" name="noticeId" value="<%=notice.getNoticeId()%>">
            <div class="mb-3"><label>标题</label><input name="title" class="form-control" value="<%=notice.getTitle()!=null?notice.getTitle():""%>" required></div>
            <div class="mb-3"><label>内容</label><textarea name="content" class="form-control" rows="5" required><%=notice.getContent()!=null?notice.getContent():""%></textarea></div>
            <div class="mb-3">
                <label>发布者ID</label>
                <input name="publisherId" type="number" class="form-control" value="<%=notice.getPublisherId()!=null?notice.getPublisherId():""%>" required readonly>
                <small class="text-muted">发布者ID不可修改</small>
            </div>
            <div class="mb-3">
                <label>状态</label>
                <select name="status" class="form-control" required>
                    <option value="1" <%=notice.getStatus()!=null&&notice.getStatus()==1?"selected":""%>>发布中</option>
                    <option value="0" <%=notice.getStatus()!=null&&notice.getStatus()==0?"selected":""%>>下架</option>
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
        $.post(ctx+'/systemNotice/update', $(this).serialize(), r=>{
            if(r.code===200){
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

