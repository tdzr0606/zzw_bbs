<%--
  zzw_bbs
  noticeDetail
  User: 竺志伟
  Date: 2018-09-20 20:13
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
        <div class="layui-col-md8 content detail">
            <div class="fly-panel-title fly-filter">
                <span class="layui-breadcrumb">
                  <a href="javascript:void(0);">首页</a>
                  <a href="javascript:void(0);">通知公告</a>
                  <a><cite>正文</cite></a>
                </span>
            </div>
            <div class="fly-panel detail-box">
                <c:if test="${not empty requestScope.notice}">
                    <h1>${requestScope.notice.title}</h1>
                    <div class="detail-about">
                        <div class="fly-detail-user" style="text-align: right;">
                            <cite>${notice.createName}</cite>
                            &nbsp;&nbsp;
                            <span>${notice.createDate}</span>
                        </div>
                    </div>
                    <div class="detail-body photos">
                            ${notice.content}
                    </div>
                </c:if>
                <c:if test="${empty requestScope.notice}">
                    <div class="fly-none">没有相关数据</div>
                </c:if>
            </div>
        </div>
        <div class="layui-col-md4">
            <dl class="fly-panel fly-list-one">
                <dt class="fly-panel-title">热议榜</dt>
                <c:if test="${empty requestScope.hotbbs }">
                    <div class="fly-none">没有相关数据</div>
                </c:if>
                <c:if test="${ not empty requestScope.hotbbs}">
                    <c:forEach items="${requestScope.hotbbs}" var="bbs">
                        <dd>
                            <a href="javascript:void(0)">${bbs.title}</a>
                            <span><i class="iconfont icon-pinglun1"></i>${bbs.replyNum}</span>
                        </dd>
                    </c:forEach>
                </c:if>
            </dl>

        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>
</body>
</html>
