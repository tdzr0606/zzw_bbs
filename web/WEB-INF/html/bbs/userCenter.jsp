<%--
  zzw_bbs
  userCenter
  User: 竺志伟
  Date: 2018-09-23 15:34
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<body>
<jsp:include page="/WEB-INF/html/inc/bbs/menu.jsp"/>

<div class="layui-container fly-marginTop fly-user-main">
    <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
        <li class="layui-nav-item layui-this">
            <a href="/bbs/toUserCenter">
                <i class="layui-icon">&#xe612;</i>
                用户中心
            </a>
        </li>
        <li class="layui-nav-item">
            <a href="/bbs/toUserSet">
                <i class="layui-icon">&#xe620;</i>
                基本设置
            </a>
        </li>
    </ul>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>

    <div class="site-tree-mobile layui-hide">
        <i class="layui-icon">&#xe602;</i>
    </div>
    <div class="site-mobile-shade"></div>


    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title" id="LAY_mine">
                <li data-type="mine-jie" lay-id="index" class="layui-this">我发的帖（<span>${requestScope.count}</span>）</li>
            </ul>
            <div class="layui-tab-content" style="padding: 20px 0;">
                <c:if test="${not empty requestScope.bbsPage && requestScope.count > 0}">
                    <div class="layui-tab-item layui-show">
                        <ul class="mine-view jie-row">
                            <c:forEach var="bbs" items="${requestScope.bbsPage.data}">
                                <li>
                                    <a class="jie-title" href="/toBbsDetail?bbsId=${bbs.id}" target="_blank">${bbs.title}</a>
                                    <i>${bbs.createDateTime}</i>
                                    <em>${bbs.replyNum}答</em>
                                </li>
                            </c:forEach>
                        </ul>
                        <div style="text-align: center">
                            <div class="laypage-main">
                                <a href="/bbs/toUserCenter?page=1"
                                   class="laypage-first">首页</a>
                                <a href="/bbs/toUserCenter?page=${requestScope.nowPage - 1}"
                                   class="laypage-prev">上一页</a>

                                <c:if test="${requestScope.nowPage-3>0}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage - 3}">
                                            ${requestScope.nowPage - 3}</a>
                                </c:if>
                                <c:if test="${requestScope.nowPage-2>0}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage - 2}">
                                            ${requestScope.nowPage - 2}</a>
                                </c:if>
                                <c:if test="${requestScope.nowPage-1>0}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage - 1}">
                                            ${requestScope.nowPage - 1}</a>
                                </c:if>
                                <span class="laypage-curr">${requestScope.nowPage}</span>
                                <c:if test="${requestScope.nowPage +1 <= requestScope.totalPage}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage + 1}">
                                            ${requestScope.nowPage + 1}</a>
                                </c:if>
                                <c:if test="${requestScope.nowPage +2 <= requestScope.totalPage}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage + 2}">
                                            ${requestScope.nowPage + 2}</a>
                                </c:if>
                                <c:if test="${requestScope.nowPage +3 <= requestScope.totalPage}">
                                    <a href="/bbs/toUserCenter?page=${requestScope.nowPage + 3}">
                                            ${requestScope.nowPage + 3}</a>
                                </c:if>

                                <a href="/bbs/toUserCenter?page=${requestScope.nowPage + 1}"
                                   class="laypage-next">下一页</a>
                                <a href="/bbs/toUserCenter?page=${requestScope.totalPage}"
                                   class="laypage-last" title="尾页">尾页</a>
                            </div>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.bbsPage || requestScope.count == 0}">
                    <div class="fly-none">没有相关数据</div>
                </c:if>
            </div>
        </div>
    </div>
</div>


<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>
</body>
</html>
