// 全局变量
let particles = [];
let particleSystem;

// 页面加载完成后初始化
document.addEventListener('DOMContentLoaded', function() {
    initializeParticleSystem();
    initializeFormHandlers();
    initializeAnimations();
    loadRememberedUser();
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
    const rememberMeCheckbox = document.getElementById('rememberMe');
    const loginBtn = document.getElementById('loginBtn');

    // 自动聚焦用户名输入框
    usernameInput.focus();

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

    // 实时验证密码
    passwordInput.addEventListener('input', function() {
        validatePassword(this.value);
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
    form.addEventListener('submit', async function(e) {
        e.preventDefault();

        const username = usernameInput.value.trim();
        const password = passwordInput.value;
        const rememberMe = rememberMeCheckbox.checked;

        // 清除之前的错误信息
        hideErrorMessage();

        // 验证输入
        if (!validateForm(username, password)) {
            return;
        }

        // 显示加载状态
        showLoadingState();

        try {
            // 模拟登录请求
            const result = await simulateLogin(username, password);

            if (result.success) {
                // 登录成功
                handleLoginSuccess(username, rememberMe);
            } else {
                // 登录失败
                showErrorMessage(result.message);
                shakeForm();
            }
        } catch (error) {
            showErrorMessage('网络连接失败，请检查网络后重试');
            shakeForm();
        } finally {
            hideLoadingState();
        }
    });
}

// 验证用户名
function validateUsername(username) {
    const errorElement = document.getElementById('username-error');

    if (!username || username.length < 3) {
        errorElement.textContent = '用户名长度至少3位';
        errorElement.classList.remove('hidden');
        return false;
    } else {
        errorElement.classList.add('hidden');
        return true;
    }
}

// 验证密码
function validatePassword(password) {
    const errorElement = document.getElementById('password-error');
    const strengthElement = document.getElementById('password-strength');

    if (!password) {
        errorElement.classList.add('hidden');
        strengthElement.classList.add('hidden');
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
        return false;
    } else {
        errorElement.classList.add('hidden');
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

// 隐藏加载状态
function hideLoadingState() {
    const btnText = document.getElementById('btn-text');
    const spinner = document.getElementById('loading-spinner');
    const loginBtn = document.getElementById('loginBtn');

    btnText.classList.remove('hidden');
    spinner.classList.add('hidden');
    loginBtn.disabled = false;
    loginBtn.classList.remove('opacity-75');
}

// 显示错误信息
function showErrorMessage(message) {
    const errorContainer = document.getElementById('error-message');
    const errorText = document.getElementById('error-text');

    errorText.textContent = message;
    errorContainer.classList.remove('hidden');

    // 3秒后自动隐藏
    setTimeout(() => {
        hideErrorMessage();
    }, 3000);
}

// 隐藏错误信息
function hideErrorMessage() {
    const errorContainer = document.getElementById('error-message');
    errorContainer.classList.add('hidden');
}

// 表单抖动效果
function shakeForm() {
    const form = document.getElementById('loginForm');
    form.classList.add('error-shake');

    setTimeout(() => {
        form.classList.remove('error-shake');
    }, 500);
}

// 模拟登录请求
function simulateLogin(username, password) {
    return new Promise((resolve) => {
        setTimeout(() => {
            // 模拟登录逻辑
            const mockUsers = [
                { username: 'admin', password: 'admin123', role: 'admin' },
                { username: 'user', password: 'user123', role: 'user' },
                { username: 'driver', password: 'driver123', role: 'driver' }
            ];

            const user = mockUsers.find(u => u.username === username && u.password === password);

            if (user) {
                resolve({
                    success: true,
                    user: user,
                    message: '登录成功'
                });
            } else {
                resolve({
                    success: false,
                    message: '用户名或密码错误'
                });
            }
        }, 1500);
    });
}

// 处理登录成功
function handleLoginSuccess(username, rememberMe) {
    // 记住用户名
    if (rememberMe) {
        localStorage.setItem('rememberedUsername', username);
    } else {
        localStorage.removeItem('rememberedUsername');
    }

    // 显示成功消息
    showSuccessMessage();

    // 延迟跳转到主页
    setTimeout(() => {
        // 这里应该跳转到实际的主页
        alert('登录成功！即将跳转到系统主页...');
        // window.location.href = '/dashboard';
    }, 1000);
}

// 显示成功消息
function showSuccessMessage() {
    const loginBtn = document.getElementById('loginBtn');
    const originalText = loginBtn.innerHTML;

    loginBtn.innerHTML = `
        <svg class="w-5 h-5 mr-2" fill="none" stroke="currentColor" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M5 13l4 4L19 7"></path>
        </svg>
        登录成功
    `;
    loginBtn.classList.add('bg-green-600', 'hover:bg-green-700');
    loginBtn.classList.remove('bg-blue-800', 'hover:bg-blue-900');
}

// 加载记住的用户名
function loadRememberedUser() {
    const rememberedUsername = localStorage.getItem('rememberedUsername');
    if (rememberedUsername) {
        document.getElementById('username').value = rememberedUsername;
        document.getElementById('rememberMe').checked = true;
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