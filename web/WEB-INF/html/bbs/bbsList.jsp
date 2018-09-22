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
            <div class="fly-panel" style="margin-bottom: 0;">
                <c:if test="${not empty requestScope.bbsPage && requestScope.count > 0}">
                    <ul class="fly-list">
                        <c:forEach var="bbs" items="${requestScope.bbsPage.data}">
                            <li>
                                <a href="user/home.html" class="fly-avatar">
                                    <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"
                                         alt="贤心">
                                </a>
                                <h2>
                                    <a class="layui-badge">分享</a>
                                    <a href="detail.html">基于 layui 的极简社区页面模版</a>
                                </h2>
                                <div class="fly-list-info">
                                    <a href="user/home.html" link>
                                        <cite>贤心</cite>
                                        <!--
                                        <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                                        <i class="layui-badge fly-badge-vip">VIP3</i>
                                        -->
                                    </a>
                                    <span>刚刚</span>

                                    <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i
                                            class="iconfont icon-kiss"></i> 60</span>
                                    <!--<span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
                                    <span class="fly-list-nums">
                <i class="iconfont icon-pinglun1" title="回答"></i> 66
              </span>
                                </div>
                                <div class="fly-list-badge">
                                    <span class="layui-badge layui-bg-black">置顶</span>
                                    <!--<span class="layui-badge layui-bg-red">精帖</span>-->
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
                            <a href="javascript:void(0);">${bbs.title}</a>
                            <span><i class="iconfont icon-pinglun1"></i> ${bbs.replyNum}</span>
                        </dd>
                    </c:forEach>
                </c:if>
            </dl>

            <div class="fly-panel">
                <div class="fly-panel-title">
                    这里可作为广告区域
                </div>
                <div class="fly-panel-main">
                    <a href="" target="_blank" class="fly-zanzhu" style="background-color: #393D49;">虚席以待</a>
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

