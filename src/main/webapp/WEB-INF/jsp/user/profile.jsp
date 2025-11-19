<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html xmlns:th="http://www.thymeleaf.org">
<head>
    <meta charset="UTF-8">
    <title>个人中心 - 公交管理系统</title>
    <link rel="stylesheet" href="/css/bootstrap.min.css">
</head>
<body>
<!-- 引入头部导航 -->
<div th:replace="common/header.jsp"></div>

<div class="container mt-4">
    <div class="row">
        <!-- 左侧菜单 -->
        <div class="col-md-3">
            <div class="card">
                <div class="card-header">个人中心</div>
                <ul class="list-group list-group-flush">
                    <li class="list-group-item active">基本信息</li>
                    <li class="list-group-item">
                        <a href="/user/loginLogs" class="text-decoration-none text-dark">登录日志</a>
                    </li>
                </ul>
            </div>
        </div>

        <!-- 右侧内容 -->
        <div class="col-md-9">
            <!-- 基本信息表单 -->
            <div class="card mb-4">
                <div class="card-header">基本信息</div>
                <div class="card-body">
                    <form id="infoForm">
                        <div class="mb-3">
                            <label for="username" class="form-label">用户名</label>
                            <input type="text" class="form-control" id="username"
                                   th:value="${user.username}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="roleName" class="form-label">用户角色</label>
                            <input type="text" class="form-control" id="roleName"
                                   th:value="${user.roleName}" disabled>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">手机号</label>
                            <input type="tel" class="form-control" id="phone"
                                   th:value="${user.phone}">
                        </div>
                        <div class="mb-3">
                            <label for="createTime" class="form-label">注册时间</label>
                            <input type="text" class="form-control" id="createTime"
                                   th:value="${user.createTime}" disabled>
                        </div>
                        <button type="submit" class="btn btn-primary">保存修改</button>
                    </form>
                </div>
            </div>

            <!-- 修改密码表单 -->
            <div class="card">
                <div class="card-header">修改密码</div>
                <div class="card-body">
                    <form id="pwdForm">
                        <div class="mb-3">
                            <label for="oldPwd" class="form-label">原密码</label>
                            <input type="password" class="form-control" id="oldPwd" required>
                        </div>
                        <div class="mb-3">
                            <label for="newPwd" class="form-label">新密码</label>
                            <input type="password" class="form-control" id="newPwd"
                                   minlength="6" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPwd" class="form-label">确认新密码</label>
                            <input type="password" class="form-control" id="confirmPwd"
                                   minlength="6" required>
                        </div>
                        <button type="submit" class="btn btn-primary">确认修改</button>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<!-- 引入页脚 -->
<div th:replace="common/footer.jsp"></div>

<script src="/js/bootstrap.bundle.min.js"></script>
<script src="/js/jquery.min.js"></script>
<script>
    // 保存基本信息
    $(function() {
        $('#infoForm').submit(function(e) {
            e.preventDefault();
            const phone = $('#phone').val();
            $.post('/user/updateInfo', {
                userId: [[${user.userId}]],
                phone: phone
            }, function(res) {
                if (res.success) {
                    alert('信息修改成功');
                } else {
                    alert(res.msg);
                }
            });
        });

        // 修改密码
        $('#pwdForm').submit(function(e) {
            e.preventDefault();
            const oldPwd = $('#oldPwd').val();
            const newPwd = $('#newPwd').val();
            const confirmPwd = $('#confirmPwd').val();

            if (newPwd !== confirmPwd) {
                alert('两次输入的新密码不一致');
                return;
            }

            $.post('/user/updatePassword', {
                userId: [[${user.userId}]],
                oldPassword: oldPwd,
                newPassword: newPwd
            }, function(res) {
                if (res.success) {
                    alert('密码修改成功，请重新登录');
                    window.location.href = '/user/logout';
                } else {
                    alert(res.msg);
                }
            });
        });
    });
</script>
</body>
</html>