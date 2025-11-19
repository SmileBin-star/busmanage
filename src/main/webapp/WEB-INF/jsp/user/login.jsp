<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<script src="https://cdn.jsdelivr.net/npm/jquery@3.7.1/dist/jquery.min.js"></script>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>公交管理系统 - 登录</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/p5.js/1.4.0/p5.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
        /* 保留原有样式 */
        * {
            font-family: 'Inter', sans-serif;
        }

        .gradient-bg {
            background: linear-gradient(135deg, #f1f5f9 0%, #e2e8f0 50%, #f8fafc 100%);
        }

        .glass-effect {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            border: 1px solid rgba(255, 255, 255, 0.2);
        }

        .input-focus {
            transition: all 0.3s ease;
        }

        .input-focus:focus {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(30, 58, 138, 0.15);
        }

        .btn-hover {
            transition: all 0.3s ease;
        }

        .btn-hover:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 25px rgba(30, 58, 138, 0.25);
        }

        .floating-animation {
            animation: float 6s ease-in-out infinite;
        }

        @keyframes float {
            0%, 100% { transform: translateY(0px); }
            50% { transform: translateY(-10px); }
        }

        .particle-canvas {
            position: absolute;
            top: 0;
            left: 0;
            width: 100%;
            height: 100%;
            z-index: 1;
            pointer-events: none;
        }

        .content-layer {
            position: relative;
            z-index: 2;
        }

        .password-strength {
            height: 4px;
            border-radius: 2px;
            transition: all 0.3s ease;
        }

        .strength-weak { background: #ef4444; }
        .strength-medium { background: #f59e0b; }
        .strength-strong { background: #10b981; }

        .error-shake {
            animation: shake 0.5s ease-in-out;
        }

        @keyframes shake {
            0%, 100% { transform: translateX(0); }
            25% { transform: translateX(-5px); }
            75% { transform: translateX(5px); }
        }

        .loading-spinner {
            animation: spin 1s linear infinite;
        }

        @keyframes spin {
            from { transform: rotate(0deg); }
            to { transform: rotate(360deg); }
        }

        .input-error {
            border-color: #ef4444 !important;
        }

        .success-message {
            background-color: #10b981;
            color: white;
        }
    </style>
</head>
<body class="gradient-bg min-h-screen overflow-hidden">
<!-- 粒子背景画布 -->
<div id="particle-container" class="particle-canvas"></div>

<!-- 主要内容 -->
<div class="content-layer min-h-screen flex items-center justify-center p-4">
    <div class="w-full max-w-7xl mx-auto">
        <div class="grid grid-cols-1 lg:grid-cols-2 gap-8 items-center">

            <!-- 左侧品牌展示区域 -->
            <div class="text-center lg:text-left floating-animation">
                <div class="mb-8">
                    <div class="w-24 h-24 mx-auto lg:mx-0 mb-6 bg-blue-800 rounded-full flex items-center justify-center">
                        <svg class="w-12 h-12 text-white" fill="currentColor" viewBox="0 0 20 20">
                            <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                            <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1V8a1 1 0 00-1-1h-3z"></path>
                        </svg>
                    </div>
                    <h1 class="text-5xl font-bold text-slate-800 mb-4">
                        智慧公交
                        <span class="text-blue-800">管理系统</span>
                    </h1>
                    <p class="text-xl text-slate-600 leading-relaxed max-w-lg">
                        高效、智能、可靠的公共交通管理平台，
                        为城市出行提供全方位的数字化解决方案。
                    </p>
                </div>

                <!-- 功能特色 -->
                <div class="grid grid-cols-2 gap-4 mt-12">
                    <div class="glass-effect rounded-lg p-4 text-center">
                        <div class="text-2xl font-bold text-blue-800 mb-2">实时监控</div>
                        <div class="text-sm text-slate-600">车辆位置实时追踪</div>
                    </div>
                    <div class="glass-effect rounded-lg p-4 text-center">
                        <div class="text-2xl font-bold text-orange-500 mb-2">智能调度</div>
                        <div class="text-sm text-slate-600">优化路线资源配置</div>
                    </div>
                    <div class="glass-effect rounded-lg p-4 text-center">
                        <div class="text-2xl font-bold text-green-600 mb-2">数据分析</div>
                        <div class="text-sm text-slate-600">运营数据深度分析</div>
                    </div>
                    <div class="glass-effect rounded-lg p-4 text-center">
                        <div class="text-2xl font-bold text-purple-600 mb-2">用户服务</div>
                        <div class="text-sm text-slate-600">提升乘客出行体验</div>
                    </div>
                </div>
            </div>

            <!-- 右侧登录表单区域 -->
            <div class="glass-effect rounded-2xl p-8 shadow-2xl">
                <div class="text-center mb-8">
                    <h2 class="text-3xl font-bold text-slate-800 mb-2">欢迎登录</h2>
                    <p class="text-slate-600">请输入您的登录信息</p>
                </div>

                <!-- 登录表单 -->
                <form id="loginForm" action="javascript:;"  method="post" class="space-y-6">
                    <!-- 用户名输入 -->
                    <div class="form-group">
                        <label for="username" class="block text-sm font-medium text-slate-700 mb-2">
                            用户名
                        </label>
                        <div class="relative">
                            <input
                                    type="text"
                                    id="username"
                                    name="username"
                                    class="input-focus w-full px-4 py-3 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none ${not empty param.usernameError ? 'input-error' : ''}"
                                    placeholder="请输入用户名"
                                    required
                                    value="${param.username != null ? param.username : cookie.rememberedUsername.value}"
                            >
                            <div id="username-error" class="text-red-500 text-sm mt-1 hidden">
                                请输入有效的用户名
                            </div>
                            <c:if test="${not empty param.usernameError}">
                                <div class="text-red-500 text-sm mt-1">
                                        ${param.usernameError}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 密码输入 -->
                    <div class="form-group">
                        <label for="password" class="block text-sm font-medium text-slate-700 mb-2">
                            密码
                        </label>
                        <div class="relative">
                            <input
                                    type="password"
                                    id="password"
                                    name="password"
                                    class="input-focus w-full px-4 py-3 pr-12 border border-slate-300 rounded-lg focus:ring-2 focus:ring-blue-500 focus:border-transparent outline-none ${not empty param.passwordError ? 'input-error' : ''}"
                                    placeholder="请输入密码"
                                    required
                            >
                            <button
                                    type="button"
                                    id="togglePassword"
                                    class="absolute right-3 top-3 text-slate-400 hover:text-slate-600"
                            >
                                <svg id="eye-icon" class="w-6 h-6" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                                </svg>
                            </button>
                            <div id="password-strength" class="password-strength bg-slate-200 rounded-full mt-2 hidden"></div>
                            <div id="password-error" class="text-red-500 text-sm mt-1 hidden">
                                密码长度至少6位
                            </div>
                            <c:if test="${not empty param.passwordError}">
                                <div class="text-red-500 text-sm mt-1">
                                        ${param.passwordError}
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <!-- 记住我和忘记密码 -->
                    <div class="flex items-center justify-between">
                        <label class="flex items-center">
                            <input
                                    type="checkbox"
                                    id="rememberMe"
                                    name="rememberMe"
                                    class="w-4 h-4 text-blue-600 border-slate-300 rounded focus:ring-blue-500"
                            ${not empty cookie.rememberedUsername ? 'checked' : ''}
                            >
                            <span class="ml-2 text-sm text-slate-600">记住我</span>
                        </label>
                        <a href="${pageContext.request.contextPath}/user/forgotPassword" class="text-sm text-blue-600 hover:text-blue-800 transition-colors">
                            忘记密码？
                        </a>
                    </div>

                    <!-- 登录按钮 -->
                    <button
                            type="submit"
                            id="loginBtn"
                            class="btn-hover w-full bg-blue-800 hover:bg-blue-900 text-white font-semibold py-3 px-6 rounded-lg focus:outline-none focus:ring-2 focus:ring-blue-500 focus:ring-offset-2"
                    >
                        <span id="btn-text">登录</span>
                        <svg id="loading-spinner" class="loading-spinner w-5 h-5 mx-auto hidden" fill="none" viewBox="0 0 24 24">
                            <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
                            <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
                        </svg>
                    </button>

                    <!-- 系统消息展示 -->
                    <c:choose>
                        <c:when test="${not empty param.success}">
                            <div class="bg-green-50 border border-green-200 rounded-lg p-3">
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-green-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                    </svg>
                                    <span class="text-sm text-green-800">${param.success}</span>
                                </div>
                            </div>
                        </c:when>
                        <c:when test="${not empty param.error}">
                            <div id="error-message" class="bg-red-50 border border-red-200 rounded-lg p-3">
                                <div class="flex items-center">
                                    <svg class="w-5 h-5 text-red-400 mr-2" fill="currentColor" viewBox="0 0 20 20">
                                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zM8.707 7.293a1 1 0 00-1.414 1.414L8.586 10l-1.293 1.293a1 1 0 101.414 1.414L10 11.414l1.293 1.293a1 1 0 001.414-1.414L11.414 10l1.293-1.293a1 1 0 00-1.414-1.414L10 8.586 8.707 7.293z" clip-rule="evenodd"></path>
                                    </svg>
                                    <span id="error-text" class="text-sm text-red-800">${param.error}</span>
                                </div>
                            </div>
                        </c:when>
                    </c:choose>
                </form>

                <!-- 系统信息 -->
                <div class="mt-8 pt-6 border-t border-slate-200 text-center">
                    <p class="text-sm text-slate-500">
                        © 2024 智慧公交管理系统 | 技术支持：公交科技团队
                    </p>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 全局变量
    let particles = [];
    let particleSystem;

    // 页面加载完成后初始化
    document.addEventListener('DOMContentLoaded', function() {
        initializeParticleSystem();
        initializeFormHandlers();
        initializeAnimations();

        // 显示表单验证错误时的动画效果
        <c:if test="${not empty param.error || not empty param.usernameError || not empty param.passwordError}">
        document.getElementById('loginForm').classList.add('error-shake');
        setTimeout(() => {
            document.getElementById('loginForm').classList.remove('error-shake');
        }, 500);
        </c:if>
    });

    // 初始化粒子系统
    function initializeParticleSystem() {
        const sketch = (p) => {
            p.setup = () => {
                const canvas = p.createCanvas(window.innerWidth, window.innerHeight);
                canvas.parent('particle-container');

                // 创建粒子
                for (let i = 0; i < 50; i++) {
                    particles.push({
                        x: p.random(p.width),
                        y: p.random(p.height),
                        vx: p.random(-0.5, 0.5),
                        vy: p.random(-0.5, 0.5),
                        size: p.random(2, 4),
                        opacity: p.random(0.1, 0.3)
                    });
                }
            };

            p.draw = () => {
                p.clear();

                // 绘制粒子
                particles.forEach(particle => {
                    p.fill(30, 58, 138, particle.opacity * 255);
                    p.noStroke();
                    p.circle(particle.x, particle.y, particle.size);

                    // 更新粒子位置
                    particle.x += particle.vx;
                    particle.y += particle.vy;

                    // 边界检测
                    if (particle.x < 0 || particle.x > p.width) particle.vx *= -1;
                    if (particle.y < 0 || particle.y > p.height) particle.vy *= -1;
                });

                // 绘制连接线
                for (let i = 0; i < particles.length; i++) {
                    for (let j = i + 1; j < particles.length; j++) {
                        const dist = p.dist(particles[i].x, particles[i].y, particles[j].x, particles[j].y);
                        if (dist < 100) {
                            const alpha = p.map(dist, 0, 100, 0.1, 0);
                            p.stroke(30, 58, 138, alpha * 255);
                            p.strokeWeight(1);
                            p.line(particles[i].x, particles[i].y, particles[j].x, particles[j].y);
                        }
                    }
                }
            };

            p.windowResized = () => {
                p.resizeCanvas(window.innerWidth, window.innerHeight);
            };
        };

        particleSystem = new p5(sketch);
    }

    // 初始化表单处理程序
    function initializeFormHandlers() {
        const form = document.getElementById('loginForm');
        const usernameInput = document.getElementById('username');
        const passwordInput = document.getElementById('password');
        const togglePasswordBtn = document.getElementById('togglePassword');
        const loginBtn = document.getElementById('loginBtn');

        // 密码显示/隐藏切换
        togglePasswordBtn.addEventListener('click', function() {
            const passwordField = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');

            if (passwordField.type === 'password') {
                passwordField.type = 'text';
                eyeIcon.innerHTML = `
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M13.875 18.825A10.05 10.05 0 0112 19c-4.478 0-8.268-2.943-9.543-7a9.97 9.97 0 011.563-3.029m5.858.908a3 3 0 114.243 4.243M9.878 9.878l4.242 4.242M9.878 9.878L3 3m6.878 6.878L21 21"></path>
                    `;
            } else {
                passwordField.type = 'password';
                eyeIcon.innerHTML = `
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15 12a3 3 0 11-6 0 3 3 0 016 0z"></path>
                        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M2.458 12C3.732 7.943 7.523 5 12 5c4.478 0 8.268 2.943 9.542 7-1.274 4.057-5.064 7-9.542 7-4.477 0-8.268-2.943-9.542-7z"></path>
                    `;
            }
        });

        // 实时验证用户名
        usernameInput.addEventListener('blur', function() {
            validateUsername(this.value);
        });

        usernameInput.addEventListener('input', function() {
            // 清除错误样式
            if (this.classList.contains('input-error')) {
                this.classList.remove('input-error');
            }
        });

        // 实时验证密码
        passwordInput.addEventListener('input', function() {
            validatePassword(this.value);
            // 清除错误样式
            if (this.classList.contains('input-error')) {
                this.classList.remove('input-error');
            }
        });

        // 回车键登录
        usernameInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                passwordInput.focus();
            }
        });

        passwordInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                form.dispatchEvent(new Event('submit'));
            }
        });

        // 表单提交处理
        // ✅ 阻止默认提交，统一走 AJAX
        form.addEventListener('submit', function(e) {
            e.preventDefault(); // 关键：阻止浏览器默认提交

            const username = usernameInput.value.trim();
            const password = passwordInput.value;

            // 简单非空校验
            if (!username || !password) {
                alert('请输入用户名和密码');
                return;
            }

            // 显示加载动画
            showLoadingState();

            // ✅ 发 AJAX 登录请求
            $.post('/bus/user/login', {username, password}, function (res) {
                if (res.code === 200 && res.data) {
                    // ✅ 登录成功，跳转
                    window.location.href = res.data;
                } else {
                    alert(res.msg || '登录失败');
                    // 恢复按钮
                    $('#btn-text').removeClass('hidden');
                    $('#loading-spinner').addClass('hidden');
                    $('#loginBtn').prop('disabled', false);
                }
            }).fail(function () {
                alert('网络错误，请重试');
                $('#btn-text').removeClass('hidden');
                $('#loading-spinner').addClass('hidden');
                $('#loginBtn').prop('disabled', false);
            });
        });
    }

    // 验证用户名
    function validateUsername(username) {
        const errorElement = document.getElementById('username-error');
        const usernameInput = document.getElementById('username');

        if (!username) {
            errorElement.textContent = '用户名不能为空';
            errorElement.classList.remove('hidden');
            usernameInput.classList.add('input-error');
            return false;
        } else if (username.length < 3) {
            errorElement.textContent = '用户名长度至少3位';
            errorElement.classList.remove('hidden');
            usernameInput.classList.add('input-error');
            return false;
        } else if (username.length > 20) {
            errorElement.textContent = '用户名长度不能超过20位';
            errorElement.classList.remove('hidden');
            usernameInput.classList.add('input-error');
            return false;
        } else if (!/^[a-zA-Z0-9_]+$/.test(username)) {
            errorElement.textContent = '用户名只能包含字母、数字和下划线';
            errorElement.classList.remove('hidden');
            usernameInput.classList.add('input-error');
            return false;
        } else {
            errorElement.classList.add('hidden');
            usernameInput.classList.remove('input-error');
            return true;
        }
    }

    // 验证密码
    function validatePassword(password) {
        const errorElement = document.getElementById('password-error');
        const strengthElement = document.getElementById('password-strength');
        const passwordInput = document.getElementById('password');

        if (!password) {
            errorElement.textContent = '密码不能为空';
            errorElement.classList.remove('hidden');
            strengthElement.classList.add('hidden');
            passwordInput.classList.add('input-error');
            return false;
        }

        // 显示密码强度
        strengthElement.classList.remove('hidden');

        let strength = 0;
        if (password.length >= 6) strength++;
        if (password.length >= 8) strength++;
        if (/[a-z]/.test(password) && /[A-Z]/.test(password)) strength++;
        if (/[0-9]/.test(password)) strength++;
        if (/[^A-Za-z0-9]/.test(password)) strength++;

        // 更新强度显示
        strengthElement.className = 'password-strength rounded-full mt-2';
        if (strength < 2) {
            strengthElement.classList.add('strength-weak');
            strengthElement.style.width = '33%';
        } else if (strength < 4) {
            strengthElement.classList.add('strength-medium');
            strengthElement.style.width = '66%';
        } else {
            strengthElement.classList.add('strength-strong');
            strengthElement.style.width = '100%';
        }

        // 验证基本要求
        if (password.length < 6) {
            errorElement.textContent = '密码长度至少6位';
            errorElement.classList.remove('hidden');
            passwordInput.classList.add('input-error');
            return false;
        } else if (password.length > 20) {
            errorElement.textContent = '密码长度不能超过20位';
            errorElement.classList.remove('hidden');
            passwordInput.classList.add('input-error');
            return false;
        } else {
            errorElement.classList.add('hidden');
            passwordInput.classList.remove('input-error');
            return true;
        }
    }

    // 验证整个表单
    function validateForm(username, password) {
        let isValid = true;

        if (!validateUsername(username)) {
            isValid = false;
        }

        if (!validatePassword(password)) {
            isValid = false;
        }

        return isValid;
    }

    // 显示加载状态
    function showLoadingState() {
        const btnText = document.getElementById('btn-text');
        const spinner = document.getElementById('loading-spinner');
        const loginBtn = document.getElementById('loginBtn');

        btnText.classList.add('hidden');
        spinner.classList.remove('hidden');
        loginBtn.disabled = true;
        loginBtn.classList.add('opacity-75');
    }

    // 隐藏错误信息
    function hideErrorMessage() {
        const errorContainer = document.getElementById('error-message');
        if (errorContainer) {
            errorContainer.classList.add('hidden');
        }
    }

    // 初始化动画
    function initializeAnimations() {
        // 页面加载动画
        anime({
            targets: '.floating-animation',
            translateY: [-50, 0],
            opacity: [0, 1],
            duration: 1000,
            easing: 'easeOutExpo',
            delay: 300
        });

        // 表单动画
        anime({
            targets: '.glass-effect',
            scale: [0.9, 1],
            opacity: [0, 1],
            duration: 800,
            easing: 'easeOutExpo',
            delay: 600
        });

        // 功能特色卡片动画
        anime({
            targets: '.glass-effect',
            translateY: [30, 0],
            opacity: [0, 1],
            duration: 600,
            easing: 'easeOutExpo',
            delay: anime.stagger(100, {start: 800})
        });
    }
</script>
</body>
</html>