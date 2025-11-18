<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://jakarta.apache.org/taglibs/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>公交管理系统 - 登录</title>
    <!-- 引入静态资源 -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/bootstrap.min.css">
    <script src="${pageContext.request.contextPath}/static/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath}/static/js/bootstrap.min.js"></script>
    <style>
        body {
            background-color: #f5f5f5;
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100vh;
            margin: 0;
        }
        .login-container {
            background-color: white;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
            width: 100%;
            max-width: 400px;
        }
        .login-title {
            text-align: center;
            margin-bottom: 25px;
            color: #333;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .error-message {
            color: #dc3545;
            text-align: center;
            margin-bottom: 15px;
            padding: 10px;
            background-color: #f8d7da;
            border-radius: 4px;
            display: none;
        }
        .error-message.show {
            display: block;
        }
    </style>
</head>
<body>
<div class="login-container">
    <h2 class="login-title">公交管理系统</h2>

    <!-- 错误提示 -->
    <div class="error-message" id="errorMsg"></div>

    <form id="loginForm">
        <div class="form-group">
            <label for="username">用户名</label>
            <input type="text" class="form-control" id="username" name="username"
                   placeholder="请输入用户名" required>
        </div>
        <div class="form-group">
            <label for="password">密码</label>
            <input type="password" class="form-control" id="password" name="password"
                   placeholder="请输入密码" required>
        </div>
        <button type="submit" class="btn btn-primary btn-block">登录</button>
    </form>
</div>

<script>
    $(function() {
        // 处理表单提交
        $("#loginForm").submit(function(e) {
            e.preventDefault(); // 阻止表单默认提交

            // 获取表单数据
            const username = $("#username").val().trim();
            const password = $("#password").val().trim();

            // 简单验证
            if (!username) {
                showError("请输入用户名");
                return;
            }
            if (!password) {
                showError("请输入密码");
                return;
            }

            // 发送登录请求
            $.ajax({
                url: "${pageContext.request.contextPath}/user/login",
                type: "POST",
                data: {
                    username: username,
                    password: password
                },
                dataType: "json",
                success: function(result) {
                    if (result.success) {
                        // 登录成功，跳转到首页（根据实际需求修改跳转路径）
                        window.location.href = "${pageContext.request.contextPath}/index";
                    } else {
                        // 显示错误信息
                        showError(result.message);
                    }
                },
                error: function() {
                    showError("登录失败，请稍后重试");
                }
            });
        });

        // 显示错误信息
        function showError(message) {
            const $errorMsg = $("#errorMsg");
            $errorMsg.text(message).addClass("show");
            // 3秒后自动隐藏
            setTimeout(() => {
                $errorMsg.removeClass("show");
            }, 3000);
        }

        // 输入时清除错误提示
        $("input").on("input", function() {
            $("#errorMsg").removeClass("show");
        });
    });
</script>
</body>
</html>