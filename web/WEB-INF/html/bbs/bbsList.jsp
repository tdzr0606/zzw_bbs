<%--
  zzw_bbs
  bbsList
  User: 竺志伟
  Date: 2018-09-22 15:29
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
            <div class="fly-panel-title fly-filter">
                <span class="layui-breadcrumb">
                  <a href="/">首页</a>
                  <a><cite>${bbsType.title}</cite></a>
                </span>
            </div>
            <div class="fly-panel" style="margin-bottom: 0;">
                <c:if test="${not empty requestScope.bbsPage && requestScope.count > 0}">
                    <ul class="fly-list">
                        <c:forEach var="bbs" items="${requestScope.bbsPage.data}">
                            <li style="padding-left: 20px;">
                                <h2>
                                    <a href="/toBbsDetail?bbsId=${bbs.id}">${bbs.title}</a>
                                </h2>
                                <div class="fly-list-info">
                                    <a href="javascript:void(0);" link>
                                        <cite>${bbs.createName}</cite>
                                    </a>
                                    <span>${bbs.createDateTime}</span>
                                    <span class="fly-list-nums">
                                        <i class="iconfont icon-pinglun1" title="回答"></i> ${bbs.replyNum}
                                    </span>
                                </div>
                                <div class="fly-list-badge">
                                    <c:if test="${bbs.isTop}">
                                        <span class="layui-badge layui-bg-black">置顶</span>
                                    </c:if>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>

                    <div style="text-align: center">
                        <div class="laypage-main">
                            <a href="/toBbsList?typeId=${requestScope.typeId}&page=1"
                               class="laypage-first">首页</a>
                            <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage - 1}"
                               class="laypage-prev">上一页</a>

                            <c:if test="${requestScope.nowPage-3>0}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage - 3}">
                                        ${requestScope.nowPage - 3}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage-2>0}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage - 2}">
                                        ${requestScope.nowPage - 2}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage-1>0}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage - 1}">
                                        ${requestScope.nowPage - 1}</a>
                            </c:if>
                            <span class="laypage-curr">${requestScope.nowPage}</span>
                            <c:if test="${requestScope.nowPage +1 <= requestScope.totalPage}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage + 1}">
                                        ${requestScope.nowPage + 1}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage +2 <= requestScope.totalPage}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage + 2}">
                                        ${requestScope.nowPage + 2}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage +3 <= requestScope.totalPage}">
                                <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage + 3}">
                                        ${requestScope.nowPage + 3}</a>
                            </c:if>

                            <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.nowPage + 1}"
                               class="laypage-next">下一页</a>
                            <a href="/toBbsList?typeId=${requestScope.typeId}&page=${requestScope.totalPage}"
                               class="laypage-last" title="尾页">尾页</a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.bbsPage || requestScope.count == 0}">
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
                            <a href="/toBbsDetail?bbsId=${bbs.id}">${bbs.title}</a>
                            <span style="float: right"><i class="iconfont icon-pinglun1"></i>&nbsp;&nbsp;${bbs.replyNum}</span>
                        </dd>
                    </c:forEach>
                </c:if>
            </dl>

            <div class="fly-panel">
                <div class="fly-panel-main">
                    <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">重大昆明社区</a>
                </div>
            </div>

            <div class="fly-panel fly-link">
                <h3 class="fly-panel-title">友情链接</h3>
                <dl class="fly-panel-main">
                    <dl class="fly-panel-main">
                        <c:forEach var="friend" items="${requestScope.friends}">
                        <dd><a href="${friend.linkUrl}" target="_blank">${friend.title}</a>
                        <dd></c:forEach>
                    </dl>
                </dl>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>
</body>
</html>

