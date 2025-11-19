<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>公交管理系统 - 控制面板</title>
    <script src="https://cdn.tailwindcss.com"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/animejs/3.2.1/anime.min.js"></script>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <style>
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

        .card-hover {
            transition: all 0.3s ease;
        }

        .card-hover:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(30, 58, 138, 0.15);
        }

        .stat-card {
            background: linear-gradient(135deg, #1e3a8a 0%, #3b82f6 100%);
        }

        .chart-container {
            height: 300px;
        }
    </style>
</head>
<body class="gradient-bg min-h-screen">
<!-- 导航栏 -->
<nav class="glass-effect shadow-lg">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex justify-between items-center h-16">
            <div class="flex items-center">
                <div class="w-8 h-8 bg-blue-800 rounded-full flex items-center justify-center mr-3">
                    <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                        <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1V8a1 1 0 00-1-1h-3z"></path>
                    </svg>
                </div>
                <h1 class="text-xl font-bold text-slate-800">智慧公交管理系统</h1>
            </div>
            <div class="flex items-center space-x-4">
                <span class="text-slate-600">欢迎，${sessionScope.loginUser.username}</span>
                <a href="${pageContext.request.contextPath}/user/logout" class="bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg text-sm transition-colors">
                    退出登录
                </a>
            </div>
        </div>
    </div>
</nav>

<!-- 主要内容 -->
<div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- 统计卡片 -->
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6 mb-8">
        <div class="stat-card rounded-xl p-6 text-white card-hover">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-blue-100 text-sm">总车辆数</p>
                    <p class="text-3xl font-bold">156</p>
                </div>
                <div class="bg-white bg-opacity-20 rounded-full p-3">
                    <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M8 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0zM15 16.5a1.5 1.5 0 11-3 0 1.5 1.5 0 013 0z"></path>
                        <path d="M3 4a1 1 0 00-1 1v10a1 1 0 001 1h1.05a2.5 2.5 0 014.9 0H10a1 1 0 001-1V5a1 1 0 00-1-1H3zM14 7a1 1 0 00-1 1v6.05A2.5 2.5 0 0115.95 16H17a1 1 0 001-1V8a1 1 0 00-1-1h-3z"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-green-600 rounded-xl p-6 text-white card-hover">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-green-100 text-sm">运营线路</p>
                    <p class="text-3xl font-bold">42</p>
                </div>
                <div class="bg-white bg-opacity-20 rounded-full p-3">
                    <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M5.05 4.05a7 7 0 119.9 9.9L10 18.9l-4.95-4.95a7 7 0 010-9.9zM10 11a2 2 0 100-4 2 2 0 000 4z" clip-rule="evenodd"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-orange-600 rounded-xl p-6 text-white card-hover">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-orange-100 text-sm">今日乘客</p>
                    <p class="text-3xl font-bold">12,847</p>
                </div>
                <div class="bg-white bg-opacity-20 rounded-full p-3">
                    <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                        <path d="M9 6a3 3 0 11-6 0 3 3 0 016 0zM17 6a3 3 0 11-6 0 3 3 0 016 0zM12.93 17c.046-.327.07-.66.07-1a6.97 6.97 0 00-1.5-4.33A5 5 0 0119 16v1h-6.07zM6 11a5 5 0 015 5v1H1v-1a5 5 0 015-5z"></path>
                    </svg>
                </div>
            </div>
        </div>

        <div class="bg-purple-600 rounded-xl p-6 text-white card-hover">
            <div class="flex items-center justify-between">
                <div>
                    <p class="text-purple-100 text-sm">系统状态</p>
                    <p class="text-3xl font-bold">正常</p>
                </div>
                <div class="bg-white bg-opacity-20 rounded-full p-3">
                    <svg class="w-8 h-8" fill="currentColor" viewBox="0 0 20 20">
                        <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                    </svg>
                </div>
            </div>
        </div>
    </div>

    <!-- 主要内容区域 -->
    <div class="grid grid-cols-1 lg:grid-cols-3 gap-8">
        <!-- 左侧：功能菜单 -->
        <div class="lg:col-span-2">
            <div class="glass-effect rounded-xl p-6 mb-6">
                <h2 class="text-2xl font-bold text-slate-800 mb-6">系统功能</h2>
                <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
                    <div class="card-hover bg-white rounded-lg p-4 border border-slate-200 cursor-pointer" onclick="showComingSoon()">
                        <div class="flex items-center">
                            <div class="bg-blue-100 rounded-lg p-3 mr-4">
                                <svg class="w-6 h-6 text-blue-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 20l-5.447-2.724A1 1 0 013 16.382V5.618a1 1 0 011.447-.894L9 7m0 13l6-3m-6 3V7m6 10l4.553 2.276A1 1 0 0021 18.382V7.618a1 1 0 00-.553-.894L15 4m0 13V4m0 0L9 7"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="font-semibold text-slate-800">路线管理</h3>
                                <p class="text-sm text-slate-600">公交线路配置与优化</p>
                            </div>
                        </div>
                    </div>

                    <div class="card-hover bg-white rounded-lg p-4 border border-slate-200 cursor-pointer" onclick="showComingSoon()">
                        <div class="flex items-center">
                            <div class="bg-green-100 rounded-lg p-3 mr-4">
                                <svg class="w-6 h-6 text-green-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M8 7V3m8 4V3m-9 8h10M5 21h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v12a2 2 0 002 2z"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="font-semibold text-slate-800">调度管理</h3>
                                <p class="text-sm text-slate-600">车辆调度与排班管理</p>
                            </div>
                        </div>
                    </div>

                    <div class="card-hover bg-white rounded-lg p-4 border border-slate-200 cursor-pointer" onclick="showComingSoon()">
                        <div class="flex items-center">
                            <div class="bg-orange-100 rounded-lg p-3 mr-4">
                                <svg class="w-6 h-6 text-orange-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="font-semibold text-slate-800">数据分析</h3>
                                <p class="text-sm text-slate-600">运营数据统计分析</p>
                            </div>
                        </div>
                    </div>

                    <div class="card-hover bg-white rounded-lg p-4 border border-slate-200 cursor-pointer" onclick="showComingSoon()">
                        <div class="flex items-center">
                            <div class="bg-purple-100 rounded-lg p-3 mr-4">
                                <svg class="w-6 h-6 text-purple-600" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                    <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197m13.5-9a2.5 2.5 0 11-5 0 2.5 2.5 0 015 0z"></path>
                                </svg>
                            </div>
                            <div>
                                <h3 class="font-semibold text-slate-800">用户管理</h3>
                                <p class="text-sm text-slate-600">系统用户权限管理</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 运营概览 -->
            <div class="glass-effect rounded-xl p-6">
                <h2 class="text-2xl font-bold text-slate-800 mb-6">今日运营概览</h2>
                <div class="chart-container bg-white rounded-lg p-4 flex items-center justify-center">
                    <div class="text-center">
                        <svg class="w-16 h-16 text-slate-400 mx-auto mb-4" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z"></path>
                        </svg>
                        <p class="text-slate-600">数据可视化图表区域</p>
                        <p class="text-sm text-slate-500 mt-2">集成ECharts或其他图表库</p>
                    </div>
                </div>
            </div>
        </div>

        <!-- 右侧：系统信息 -->
        <div class="space-y-6">
            <!-- 快速操作 -->
            <div class="glass-effect rounded-xl p-6">
                <h3 class="text-lg font-bold text-slate-800 mb-4">快速操作</h3>
                <div class="space-y-3">
                    <button onclick="showComingSoon()" class="w-full text-left p-3 bg-blue-50 hover:bg-blue-100 rounded-lg transition-colors">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 text-blue-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 6v6m0 0v6m0-6h6m-6 0H6"></path>
                            </svg>
                            <span class="text-slate-700">添加新路线</span>
                        </div>
                    </button>

                    <button onclick="showComingSoon()" class="w-full text-left p-3 bg-green-50 hover:bg-green-100 rounded-lg transition-colors">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 text-green-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M18 9v3m0 0v3m0-3h3m-3 0h-3m-2-5a4 4 0 11-8 0 4 4 0 018 0zM3 20a6 6 0 0112 0v1H3v-1z"></path>
                            </svg>
                            <span class="text-slate-700">添加新司机</span>
                        </div>
                    </button>

                    <button onclick="showComingSoon()" class="w-full text-left p-3 bg-orange-50 hover:bg-orange-100 rounded-lg transition-colors">
                        <div class="flex items-center">
                            <svg class="w-5 h-5 text-orange-600 mr-3" fill="none" stroke="currentColor" viewBox="0 0 24 24">
                                <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M15.232 5.232l3.536 3.536m-2.036-5.036a2.5 2.5 0 113.536 3.536L6.5 21.036H3v-3.572L16.732 3.732z"></path>
                            </svg>
                            <span class="text-slate-700">修改排班</span>
                        </div>
                    </button>
                </div>
            </div>

            <!-- 系统状态 -->
            <div class="glass-effect rounded-xl p-6">
                <h3 class="text-lg font-bold text-slate-800 mb-4">系统状态</h3>
                <div class="space-y-4">
                    <div class="flex items-center justify-between">
                        <span class="text-slate-600">服务器状态</span>
                        <span class="flex items-center text-green-600">
                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                正常
                            </span>
                    </div>

                    <div class="flex items-center justify-between">
                        <span class="text-slate-600">数据库连接</span>
                        <span class="flex items-center text-green-600">
                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                正常
                            </span>
                    </div>

                    <div class="flex items-center justify-between">
                        <span class="text-slate-600">GPS服务</span>
                        <span class="flex items-center text-green-600">
                                <svg class="w-3 h-3 mr-1" fill="currentColor" viewBox="0 0 20 20">
                                    <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                                </svg>
                                正常
                            </span>
                    </div>

                    <div class="flex items-center justify-between">
                        <span class="text-slate-600">最后备份</span>
                        <span class="text-slate-800 font-medium">2024-11-19 02:00</span>
                    </div>
                </div>
            </div>

            <!-- 最近活动 -->
            <div class="glass-effect rounded-xl p-6">
                <h3 class="text-lg font-bold text-slate-800 mb-4">最近活动</h3>
                <div class="space-y-3">
                    <div class="flex items-start">
                        <div class="bg-blue-100 rounded-full p-2 mr-3 mt-1">
                            <svg class="w-3 h-3 text-blue-600" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <p class="text-sm text-slate-800">系统登录成功</p>
                            <p class="text-xs text-slate-500">刚刚</p>
                        </div>
                    </div>

                    <div class="flex items-start">
                        <div class="bg-green-100 rounded-full p-2 mr-3 mt-1">
                            <svg class="w-3 h-3 text-green-600" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <p class="text-sm text-slate-800">数据备份完成</p>
                            <p class="text-xs text-slate-500">1小时前</p>
                        </div>
                    </div>

                    <div class="flex items-start">
                        <div class="bg-orange-100 rounded-full p-2 mr-3 mt-1">
                            <svg class="w-3 h-3 text-orange-600" fill="currentColor" viewBox="0 0 20 20">
                                <path fill-rule="evenodd" d="M10 18a8 8 0 100-16 8 8 0 000 16zm3.707-9.293a1 1 0 00-1.414-1.414L9 10.586 7.707 9.293a1 1 0 00-1.414 1.414l2 2a1 1 0 001.414 0l4-4z" clip-rule="evenodd"></path>
                            </svg>
                        </div>
                        <div class="flex-1">
                            <p class="text-sm text-slate-800">路线配置更新</p>
                            <p class="text-xs text-slate-500">3小时前</p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    // 页面加载动画
    document.addEventListener('DOMContentLoaded', function() {
        anime({
            targets: '.card-hover',
            translateY: [30, 0],
            opacity: [0, 1],
            duration: 600,
            easing: 'easeOutExpo',
            delay: anime.stagger(100)
        });
    });

    // 显示即将推出提示
    function showComingSoon() {
        alert('该功能正在开发中，敬请期待！');
    }
</script>
</body>
</html>