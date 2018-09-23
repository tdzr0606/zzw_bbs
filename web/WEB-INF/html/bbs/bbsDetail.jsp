<%--
  zzw_bbs
  bbsDetail
  User: 竺志伟
  Date: 2018-09-23 10:38
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<link rel="stylesheet" href="/design/slide/css/sliderImgPuzzle.css">
<body>
<jsp:include page="/WEB-INF/html/inc/bbs/menu.jsp"/>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8 content detail">
            <div class="fly-panel-title fly-filter">
                <span class="layui-breadcrumb">
                  <a href="/">首页</a>
                  <a href="/toBbsList?typeId=${bbsType.id}">${bbsType.title}</a>
                  <a><cite>${mainBbs.title}</cite></a>
                </span>
            </div>
            <div class="fly-panel detail-box">
                <h1>${mainBbs.title}</h1>
                <div class="fly-detail-info">
                    <c:if test="${mainBbs.isTop}">
                        <span class="layui-badge layui-bg-black">置顶</span>
                    </c:if>

                    <div class="fly-admin-box"></div>
                    <span class="fly-list-nums">
                        <a href="#comment"><i class="iconfont" title="回答">&#xe60c;</i> ${mainBbs.replyNum}</a>
                    </span>
                </div>
                <div class="detail-about">
                    <a class="fly-avatar" href="javascript:void(0);">
                        <c:if test="${not empty mainBbs.createImgUrl}">
                            <img src="${mainBbs.createImgUrl}" alt="${mainBbs.createName}">
                        </c:if>
                        <c:if test="${empty mainBbs.createImgUrl}">
                            <img src="/design/bbs/images/header.jpg"
                                 alt="${mainBbs.createName}">
                        </c:if>
                    </a>
                    <div class="fly-detail-user" style="height: 21px;">
                        <a href="javascript:void(0);" class="fly-link">
                            <cite>${mainBbs.createName}</cite>
                        </a>
                    </div>
                    <div class="detail-hits" style="height: 20px;">
                        <span>${mainBbs.createDateTime}</span>
                    </div>
                </div>
                <div class="detail-body photos">
                    ${mainBbs.content}
                </div>
            </div>

            <div class="fly-panel detail-box" id="flyReply">
                <fieldset class="layui-elem-field layui-field-title" style="text-align: center;">
                    <legend>回帖</legend>
                </fieldset>
                <c:if test="${not empty requestScope.subBbsPage && requestScope.count > 0}">
                    <ul class="jieda">
                        <c:forEach var="bbs" items="${requestScope.subBbsPage.data}">
                            <li class="jieda-daan">
                                <div class="detail-about detail-about-reply">
                                    <a class="fly-avatar" href="javascript:void(0);">
                                        <c:if test="${not empty bbs.createImgUrl}">
                                            <img src="${bbs.createImgUrl}" alt=" ">
                                        </c:if>
                                        <c:if test="${empty bbs.createImgUrl}">
                                            <img src="/design/bbs/images/header.jpg">
                                        </c:if>
                                    </a>
                                    <div class="fly-detail-user">
                                        <a href="javascript:void(0);" class="fly-link">
                                            <cite>${bbs.createName}</cite>
                                        </a>
                                    </div>
                                    <div class="detail-hits">
                                        <span>${bbs.createDateTime}</span>
                                    </div>
                                </div>
                                <div class="detail-body jieda-body photos">
                                    <p>${bbs.content}</p>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                    <div style="text-align: center">
                        <div class="laypage-main">
                            <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=1"
                               class="laypage-first">首页</a>
                            <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage - 1}"
                               class="laypage-prev">上一页</a>

                            <c:if test="${requestScope.nowPage-3>0}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage - 3}">
                                        ${requestScope.nowPage - 3}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage-2>0}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage - 2}">
                                        ${requestScope.nowPage - 2}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage-1>0}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage - 1}">
                                        ${requestScope.nowPage - 1}</a>
                            </c:if>
                            <span class="laypage-curr">${requestScope.nowPage}</span>
                            <c:if test="${requestScope.nowPage +1 <= requestScope.totalPage}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage + 1}">
                                        ${requestScope.nowPage + 1}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage +2 <= requestScope.totalPage}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage + 2}">
                                        ${requestScope.nowPage + 2}</a>
                            </c:if>
                            <c:if test="${requestScope.nowPage +3 <= requestScope.totalPage}">
                                <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage + 3}">
                                        ${requestScope.nowPage + 3}</a>
                            </c:if>

                            <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.nowPage + 1}"
                               class="laypage-next">下一页</a>
                            <a href="/toBbsDetail?bbsId=${requestScope.bbsId}&page=${requestScope.totalPage}"
                               class="laypage-last" title="尾页">尾页</a>
                        </div>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.subBbsPage || requestScope.count == 0}">
                    <div class="fly-none" style="min-height: 100px;">没有相关数据</div>
                </c:if>


                <div class="layui-form layui-form-pane">
                    <form method="post" id="replyForm" name="replyForm">
                        <div class="layui-form-item layui-form-text">
                            <div class="layui-input-block">
                                <textarea id="contentT" style="height: 150px;"></textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <input type="hidden" name="bbsId" id="bbsId" value="${requestScope.bbsId}">
                            <input type="hidden" name="content" id="content">
                            <button class="layui-btn" lay-filter="replyForm" id="replyBtn" style="display: none" lay-submit>提交回复
                            </button>
                        </div>
                        <div class="layui-form-item">
                            <div id="silderpuzzle" style="position: relative;"></div>
                        </div>
                    </form>
                </div>
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
                    <a href="javascript:void(0);"  class="fly-zanzhu"
                       time-limit="2017.09.25-2099.01.01" style="background-color: #5FB878;">重大昆明社区</a>
                </div>
            </div>

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
<script>
    layui.use(['jquery', 'element', 'layer', 'form', 'layedit'], function ()
    {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var layedit = layui.layedit;
        layedit.set({
            uploadImage: {
                url: '/system/upload/edit' //接口url
                , type: 'post' //默认post
            }
        });
        var editIndex = layedit.build('contentT');
        //form 用户登录
        form.on('submit(replyForm)', function (data)
        {
            $('#content').val(layedit.getContent(editIndex));//根据索引获取到富文本编辑器的内容
            if ($('#content').val() == '')
            {
                layer.msg("请填写回帖内容!");
                imgPuzzle.reset();
                return false;
            }
            $.ajax({
                type: 'post',
                data: $("#replyForm").serialize(),
                url: '/replyBbs',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/toBbsDetail?bbsId=" + $('#bbsId').val();
                    }
                    else
                    {
                        imgPuzzle.reset();
                        layer.alert(json.msg);
                        return false;
                    }
                },
                error: function (json)
                {
                    layer.alert("服务器连接错误", {closeBtn: 0}, function ()
                    {
                        layer.closeAll();
                        window.location.reload();
                    });
                }
            });
            return false;
        });
    });
</script>

<!-- 滑动验证  -->
<script src="/design/slide/js/jquery.min.js"></script>
<script src="/design/slide/js/sliderImgPuzzle.js"></script>
<script>
    //--------------------滑块拼图验证控件初始化-----
    var option = {
        onSuccess: function ()
        {
            $('#replyBtn').click();
        },
        onFail: function ()
        {
            layer.alert('验证失败', function ()
            {
                layer.closeAll();
                imgPuzzle.reset();
            });
            return false;
        },
        onRefresh: function ()
        {
            imgPuzzle.reset();
        }
    }
    $("#silderpuzzle").SliderImgPuzzle(option);
    //--------------------滑块拼图验证控件初始化完成-----
    var imgPuzzle = $("#silderpuzzle").data("LsSliderImgPuzzle");
    imgPuzzle.enablePuzzle(true);
</script>

</body>
</html>
