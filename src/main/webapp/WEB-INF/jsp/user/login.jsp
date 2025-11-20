<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String ctx = request.getContextPath();   //  /bus
%>
<!DOCTYPE html>
<html>
<head>
    <title>公交系统-登录</title>
    <meta charset="utf-8"/>
    <style>
        body{
            font-family: Arial, serif;background:#f2f2f2;margin:0;padding:0}
        .box{width:360px;margin:10% auto;background:#fff;padding:30px;border-radius:6px;box-shadow:0 0 10px #ccc}
        .box h2{text-align:center;margin-bottom:25px}
        .box input[type=text],.box input[type=password]{width:100%;padding:10px;margin:8px 0;border:1px solid #ccc;border-radius:4px}
        .box button{width:100%;padding:10px;background:#007bff;color:#fff;border:0;border-radius:4px;cursor:pointer}
        .box button:hover{background:#0056b3}
        .err{color:red;text-align:center;margin-top:10px}
    </style>
</head>
<body>
<div class="box">
    <h2>公交管理系统登录</h2>
    <form id="loginForm" onsubmit="return false;">
        <label for="username"></label><input type="text" name="username" id="username" placeholder="用户名" required/>
        <label for="password"></label><input type="password" name="password" id="password" placeholder="密码" required/>
        <button onclick="doLogin()">登录</button>
        <div id="msg" class="err"></div>
    </form>
</div>

<script src="<%=ctx%>/static/js/jquery-3.6.0.min.js"></script>
<script>
    function doLogin(){
        const u = $.trim($('#username').val());
        const p = $.trim($('#password').val());
        if(!u||!p){$('#msg').text('请填写完整');return;}
        $.post('<%=ctx%>/user/login',{username:u,password:p},function(res){
            console.log('res.data 类型：', typeof res.data);
            console.log('res.data 值：', res.data);
            if(res.code===200){
                location.href = res.data;   // 后端已经带 /bus，不再拼 ctx
            }else{
                $('#msg').text(res.msg||'登录失败');
            }
        },'json');
    }
    // 回车触发
    $('#loginForm').on('keypress',function(e){if(e.which===13)doLogin();});
</script>
</body>
</html>