<%@page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%--顶部菜单--%>
<div class="layui-header">
    <div class="layui-logo" style="padding: 0px;"><img src="/design/webAdmin/images/logo.png" style="width: 318px;height:
    56px;"></div>
    <!-- 头部区域（可配合layui已有的水平导航） -->
    <ul class="layui-nav layui-layout-left" style="left:200px;">
        <li class="layui-nav-item"><a href="/webAdmin/index"><i class="layui-icon">&#xe68e;</i>首页</a></li>
    </ul>
    <ul class="layui-nav layui-layout-right" lay-filter="topMenu">
        <li class="layui-nav-item"><a href="javascript:;"><i class="layui-icon">&#xe614;</i>系统管理</a>
            <dl class="layui-nav-child">
                <dd><a href="/webAdmin/user/toPage"><i class="fa fa-cogs"></i>&nbsp;管理员管理</a></dd>
                <dd><a href="/webAdmin/logs/toPage"><i class="fa fa-file-o"></i>&nbsp;系统日志</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item">
            <a href="javascript:;">
                您好，<i class="item-impt">${sessionScope.webUser.loginName}</i>
            </a>
            <dl class="layui-nav-child">
                <dd><a href="javascript:;" id="passModify">修改密码</a></dd>
            </dl>
        </li>
        <li class="layui-nav-item"><a href="javascript:;" id="logout">退出</a></li>
    </ul>
</div>

<div class="layui-side  layui-bg-black">
    <div class="layui-side-scroll" lay-filter="leftMainMenu">
        <!-- 左侧导航区域（可配合layui已有的垂直导航） -->
        <ul class="layui-nav layui-nav-tree" id="leftMainMenu">
            <li class="layui-nav-item layui-nav-itemed">
                <a class="layui-nav-item-first" href="javascript:;"><i class="fa fa-user-o"></i>&nbsp;论坛管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="/webAdmin/bbsUser/toPage"><i class="fa fa-angle-right"></i>&nbsp;用户管理</a></dd>
                    <dd><a href="/"><i class="fa fa-angle-right"></i>&nbsp;主题管理</a></dd>
                    <dd><a href="/"><i class="fa fa-angle-right"></i>&nbsp;帖子管理</a></dd>
                </dl>
            </li>
            <li class="layui-nav-item layui-nav-itemed">
                <a class="layui-nav-item-first" href="javascript:;"><i class="fa fa-user-o"></i>&nbsp;系统管理</a>
                <dl class="layui-nav-child">
                    <dd><a href="/webAdmin/notice/toPage"><i class="fa fa-angle-right"></i>&nbsp;通知管理</a></dd>
                    <dd><a href="/webAdmin/friend/toPage"><i class="fa fa-angle-right"></i>&nbsp;友情链接</a></dd>
                </dl>
            </li>
        </ul>
    </div>
</div>

