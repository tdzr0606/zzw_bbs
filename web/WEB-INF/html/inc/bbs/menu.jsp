<%--
  zzw_bbs
  menu
  User: 竺志伟
  Date: 2018-09-20 20:11
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" style="margin-left: -10px;" href="/">
            <img src="/design/bbs/images/logo.png" alt="重大昆明社区">
        </a>
        <ul class="layui-nav fly-nav layui-hide-xs">
            <li class="layui-nav-item layui-this">
                <a href="/"><i class="iconfont icon-jiaoliu"></i>交流</a>
            </li>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <c:if test="${empty sessionScope.bbsUser}">
                <!-- 未登入的状态 -->
                <li class="layui-nav-item">
                    <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
                </li>
                <li class="layui-nav-item">
                    <a href="/tologin">登入</a>
                </li>
                <li class="layui-nav-item">
                    <a href="/toRegist">注册</a>
                </li>
            </c:if>

            <!-- 登入后的状态 -->
            <c:if test="${not empty sessionScope.bbsUser}">
                <li class="layui-nav-item">
                    <a class="fly-nav-avatar" href="javascript:;">
                        <cite class="layui-hide-xs">${sessionScope.bbsUser.userName}</cite>
                        <c:if test="${not empty sessionScope.bbsUser.imgUrl}">
                            <img src="${sessionScope.bbsUser.imgUrl}">
                        </c:if>
                        <c:if test="${empty sessionScope.bbsUser.imgUrl}">
                            <img src="/design/bbs/images/header.jpg" style="width: 24px;height: 24px">
                        </c:if>

                    </a>
                    <dl class="layui-nav-child">
                        <dd><a href="user/set.html"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
                            <%--<dd><a href="user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>--%>
                            <%--<dd><a href="user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>--%>
                        <hr style="margin: 5px 0;">
                        <dd><a href="/logout" style="text-align: center;">退出</a></dd>
                    </dl>
                </li>
            </c:if>
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
            <li class="layui-hide-xs layui-this"><a href="/">首页</a></li>
            <%--<li><a href="jie/index.html">提问</a></li>--%>
            <%--<li><a href="jie/index.html">分享<span class="layui-badge-dot"></span></a></li>--%>
            <%--<li><a href="jie/index.html">讨论</a></li>--%>
            <%--<li><a href="jie/index.html">建议</a></li>--%>
            <%--<li><a href="jie/index.html">公告</a></li>--%>
            <%--<li><a href="jie/index.html">动态</a></li>--%>
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"
                style="margin-left: 60%"><span class="fly-mid"></span></li>

            <!-- 用户登入后显示 -->
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="user/index.html">我发表的贴</a></li>
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="user/index.html#collection">我收藏的贴</a>
            </li>
        </ul>
        <div class="fly-column-right layui-hide-xs">
            <a href="jie/add.html" class="layui-btn">发表新帖</a>
        </div>
    </div>
</div>