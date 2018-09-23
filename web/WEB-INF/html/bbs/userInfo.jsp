<%--
  zzw_bbs
  userInfo
  User: 竺志伟
  Date: 2018-09-23 16:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<%@ taglib prefix="fn" uri="/WEB-INF/tld/fn.tld" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<body>
<jsp:include page="/WEB-INF/html/inc/bbs/menu.jsp"/>

<div class="fly-home fly-panel">
    <c:if test="${not empty requestScope.bbsUser.imgUrl}">
        <img src="${requestScope.bbsUser.imgUrl}" alt="${requestScope.bbsUser.userName}">
    </c:if>
    <c:if test="${empty requestScope.bbsUser.imgUrl}">
        <img src="/design/bbs/images/header.jpg">
    </c:if>
    <i class="iconfont icon-renzheng" title="Fly社区认证"></i>
    <h1>
        ${requestScope.bbsUser.userName}
        <c:if test="${! requestScope.bbsUser.isUse}">
            <span>（该号已被封）</span>
        </c:if>
    </h1>

    <p style="padding: 10px 0; color: #5FB878;"></p>

    <p class="fly-home-info">
        <i class="iconfont icon-shijian"></i><span>
        <fmt:formatDate value="${requestScope.bbsUser.registerDate}" pattern="yyyy-MM-dd"></fmt:formatDate>
        加入</span>
    </p>

    <p class="fly-home-sign">（${requestScope.bbsUser.note}）</p>

    <div class="fly-sns" data-user="">
    </div>

</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md6 fly-home-jie">
            <div class="fly-panel">
                <h3 class="fly-panel-title">${requestScope.bbsUser.userName} 最近的帖子</h3>
                <ul class="jie-row">
                    <c:if test="${requestScope.mainBbsPage.count > 0}">
                        <c:forEach var="bbs" items="${requestScope.mainBbsPage.data}">
                            <li>
                                <a href="/toBbsDetail?bbsId=${bbs.id}" class="jie-title"> ${bbs.title}</a>
                                <i>${bbs.createDateTime}</i>
                                <em class="layui-hide-xs">${bbs.replyNum}答</em>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${requestScope.mainBbsPage.count == 0}">
                        <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><i
                                style="font-size:14px;">没有发表任何帖子</i>
                        </div>
                    </c:if>
                </ul>
            </div>
        </div>

        <div class="layui-col-md6 fly-home-da">
            <div class="fly-panel">
                <h3 class="fly-panel-title">${requestScope.bbsUser.userName} 最近的回答</h3>
                <ul class="home-jieda">
                    <c:if test="${not empty requestScope.subBbs}">
                        <c:forEach var="bbs" items="${requestScope.subBbs}">
                            <li>
                                <p>
                                    <span>${bbs.createDateTime}</span>在<a href="/toBbsDetail?bbsId=${bbs.replyId}"
                                                                          target="_blank">${bbs.title}</a>中回答：
                                </p>
                                <div class="home-dacontent">
                                        ${fn:substring(bbs.content,0, 100)}
                                </div>
                            </li>
                        </c:forEach>
                    </c:if>
                    <c:if test="${empty requestScope.subBbs}">
                        <div class="fly-none" style="min-height: 50px; padding:30px 0; height:auto;"><span>没有回答任何帖子</span></div>
                    </c:if>
                </ul>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>
</body>
</html>
