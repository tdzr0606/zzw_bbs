<%--
  zzw_bbs
  bbsTime
  User: 竺志伟
  Date: 2018-09-23 17:15
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/popular/head.jsp"/>
<body>
<ul class="layui-timeline" style="margin-top: 20px;">
    <li class="layui-timeline-item">
        <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
        <div class="layui-timeline-content layui-text">
            <h3 class="layui-timeline-title">${requestScope.mainBbs.createDateTime}&nbsp;&nbsp;<i>${requestScope.mainBbs.createName}
            </i>&nbsp;&nbsp;<font color="red">楼主</font>
            </h3>
            <p>${requestScope.mainBbs.content}</p>
        </div>
    </li>
    <c:forEach var="bbs" items="${requestScope.subBbs}">
        <li class="layui-timeline-item">
            <i class="layui-icon layui-timeline-axis">&#xe63f;</i>
            <div class="layui-timeline-content layui-text">
                <h3 class="layui-timeline-title">${bbs.createDateTime}&nbsp;&nbsp;<i>${bbs.createName}</i></h3>
                <p>${bbs.content}</p>
            </div>
        </li>
    </c:forEach>
    <li class="layui-timeline-item">
        <i class="layui-icon layui-timeline-axis">&#xe617;</i>
        <div class="layui-timeline-content layui-text">
            <h3 class="layui-timeline-title">现在</h3>
        </div>
    </li>
</ul>
<jsp:include page="/WEB-INF/html/inc/popular/foot.jsp"/>
</body>
</html>
