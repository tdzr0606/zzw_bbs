<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%--顶部菜单--%>
<div class="layui-header">
    <div class="layui-logo"><img src="/design/images/logo_title.png" width="318" height="56">
    </div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left">
        <li class="layui-nav-item"><a href="/webAdmin/index"><i class="layui-icon">&#xe68e;</i> 首页</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right" lay-filter="topMenu">
        <li class="layui-nav-item"><a href="javascript:;"><i class="layui-icon">&#xe614;</i> 系统管理</a>
            <dl class="layui-nav-child">
                <dd><a href="/webAdmin/role/toPage"><i class="fa fa-cogs"></i>角色管理</a></dd>
                <dd><a href="/webAdmin/function/toPage"><i class="fa fa-code"></i>功能管理</a></dd>
                <dd><a href="/webAdmin/log/toPage"><i class="fa fa-file-o"></i>系统日志</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">
                您好，<i class="item-impt">${sessionScope.loginUser.name}</i>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:;" id="passModify">修改密码</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="javascript:;" id="loginOut">退出</a></li>
    </ul>
</div>

<div class="layui-side  layui-bg-black">
    <div class="layui-side-scroll" lay-filter="leftMainMenu">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" id="leftMainMenu">

        </ul>
    </div>
</div>
