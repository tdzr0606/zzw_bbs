<%--
  zzw_bbs
  index
  User: 竺志伟
  Date: 2018-09-06 10:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<body>
<jsp:include page="/WEB-INF/html/inc/bbs/menu.jsp"/>


<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">

            <div class="fly-panel">
                <div class="fly-panel-title fly-filter">
                    <a>通知公告</a>
                </div>
                <ul class="fly-list">
                    <c:if test="${not empty requestScope.notices}">
                        <c:forEach items="${requestScope.notices}" var="notice" varStatus="status">
                            <li style="height: 40px;padding-left: 30px;">
                                <a href="/showNoticeDetail/${notice.id}" target="_blank">${notice.title}</a>
                                <div class="fly-list-info">
                                    <span>${notice.createName}</span>
                                    <span class="fly-list-nums">
                                            ${notice.createDate}
                                    </span>
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.notices}">
                        <div class="fly-none">没有相关数据</div>
                    </c:if>
                </ul>
            </div>

            <div class="fly-panel" style="margin-bottom: 0;">
                <div class="fly-panel-title fly-filter">
                    <a>主题</a>
                </div>
                <ul class="fly-list">
                    <c:if test="${not empty requestScope.bbstype}">
                        <c:forEach items="${requestScope.bbstype}" var="bbstype">
                            <li style="height: 60px;">
                                <a href="javascript:void(0);" class="fly-avatar">
                                    <img src="${bbstype.imgUrl}"/>
                                </a>
                                <h2>
                                    <a href="javascript:void(0)">${bbstype.title}</a>
                                </h2>
                                <div class="fly-list-info">
                                    <span>${bbstype.note}</span>
                                    <span class="fly-list-nums">
                                    <a href="javascript:void(0)" link>
                                        <cite>${bbstype.lastPoster}</cite>
                                    </a>
                                     <span>${bbstype.lastPostDate}</span>
                                    <i class="iconfont icon-pinglun1" title="帖子数量"></i> ${bbstype.postNum}
                                </span>
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.bbstype}">
                        <div class="fly-none">没有相关数据</div>
                    </c:if>
                </ul>
            </div>
        </div>
        <div class="layui-col-md4">

            <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
                <h3 class="fly-panel-title">回贴榜</h3>
                <dl>
                    <c:if test="${not empty requestScope.backuser}">
                        <c:forEach var="user" items="${requestScope.backuser}">
                            <dd>
                                <a href="javascript:void(0);">
                                    <c:if test="${not empty user.imgUrl}">
                                        <img src="${user.imgUrl}"
                                             style="width: 65px;height: 65px;">
                                    </c:if>
                                    <c:if test="${empty user.imgUrl}">
                                        <img src="/design/bbs/images/header.jpg"
                                             style="width: 65px;height: 65px;">
                                    </c:if>
                                    <cite>${user.userName}</cite><i>${user.backNum}次回答</i>
                                </a>
                            </dd>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.backuser}">
                        <div class="fly-none">没有相关数据</div>
                    </c:if>
                </dl>
            </div>

            <dl class="fly-panel fly-list-one">
                <dt class="fly-panel-title">热议榜</dt>
                <c:if test="${empty requestScope.hotbbs }">
                    <div class="fly-none">没有相关数据</div>
                </c:if>
                <c:if test="${ not empty requestScope.hotbbs}">
                    <c:forEach items="${requestScope.hotbbs}" var="bbs">
                        <dd>
                            <a href="javascript:void(0);">${bbs.title}</a>
                            <span><i class="iconfont icon-pinglun1"></i> ${bbs.replyNum}</span>
                        </dd>
                    </c:forEach>
                </c:if>
            </dl>

            <div class="fly-panel fly-link">
                <h3 class="fly-panel-title">友情链接</h3>
                <dl class="fly-panel-main">
                    <c:forEach var="friend" items="${requestScope.friends}">
                    <dd><a href="${friend.linkUrl}" target="_blank">${friend.title}</a>
                    <dd>
                        </c:forEach>
                </dl>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>


</body>
</html>
