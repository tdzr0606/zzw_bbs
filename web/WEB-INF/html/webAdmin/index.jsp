<%@ page import="java.util.Date" %>
<%@ page import="com.nature.jet.utils.Tools" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp"/>
<body class="layui-layout-body">
<style>
    .showDiv { padding: 20px; color: #666 }

    .showTitle { font-size: 24px; line-height: 30px; font-weight: bold; text-align: center }

    .showNote { font-size: 20px; line-height: 40px; text-align: right; margin-bottom: 20px; padding-right:
            30px; }

    .showContent { font-size: 16px; line-height: 32px; text-align: left; text-indent: 2em }

    .showContent p { margin-bottom: 10px }
</style>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body no-foo-body">
        <!-- 内容主体区域 -->
        <div class="default-cont-tt">
        </div>
        <div class="default-cont-admin">
            <p>您好，<i class="admin-impt">${sessionScope.loginUser.name}</i></p>
            <p>今天是<%= Tools.getFormatDate(new Date(), "yyyy年MM月dd日")%>，欢迎使用系统</p>
        </div>
        <div class="default-cont-wrapper">
            <fieldset class="layui-elem-field layui-field-title">
                <legend>通知公告</legend>
            </fieldset>
            <%--<ul class="cont-news-li">--%>
                <%--<c:forEach var="item" items="${requestScope.noticeList}" varStatus="status">--%>
                    <%--<li class="showMessage" id="notice${item.id}">--%>
                        <%--<a href="#"><i class="fa fa-file-text"></i>${item.title}</a>--%>
                        <%--<span><fmt:formatDate value="${item.createDate}"--%>
                                              <%--pattern="yyyy-MM-dd HH:mm:ss"/></span>--%>
                    <%--</li>--%>
                <%--</c:forEach>--%>
            <%--</ul>--%>

            <fieldset class="layui-elem-field layui-field-title">
                <legend>快捷菜单</legend>
            </fieldset>
            <ul class="cont-menu-li cont-menu-li-user">
                <%--<li><a href="/admin/eaReport/toPerCheckPage"><i class="fa fa-file-text-o"></i>申报材料初审</a></li>--%>
                <%--<li><a href="/admin/eaReport/toPage"><i class="fa fa-files-o"></i>申报材料审核</a></li>--%>
                <%--<li><a href="/admin/eaPlan/toPage"><i class="fa fa-files-o"></i>培养计划审核</a></li>--%>
                <%--<li><a href="/admin/eaCheck/toPage"><i class="fa fa-files-o"></i>培养考核审核</a></li>--%>
            </ul>
        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>

<%--<c:forEach var="item" items="${requestScope.noticeList}" varStatus="status">--%>
    <%--<div class="showDiv" id="notice${item.id}Window" style="display: none">--%>
        <%--<div class="showTitle">${item.title}</div>--%>
        <%--<div class="showContent">${item.content}</div>--%>
        <%--<div--%>
                <%--class="showNote">${item.createName}&nbsp;&nbsp;<br><fmt:formatDate value="${item.createDate}"--%>
                                                                                   <%--pattern="yyyy-MM-dd HH:mm:ss"/>&nbsp;&nbsp;--%>
        <%--</div>--%>
    <%--</div>--%>
<%--</c:forEach>--%>

<script>
    layui.use(['jquery', 'layer'], function ()
    {
        var $ = layui.jquery;
        var layer = layui.layer;
        $(".showMessage").click(function ()
        {
            var id = $(this).attr("id") + "Window";
            layer.open({
                type: 1
                , title: "通知通告详情"
                , closeBtn: 1
                , shade: 0.2
                , area: ['800px;', '600px;']
                , id: 'showNoticeWindow'
                , moveType: 1
                , resize: false
                , content: $('#' + id)
            });
        });
    });
</script>
</body>
</html>
