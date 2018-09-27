<%--
  zzw_bbs
  userSet
  User: 竺志伟
  Date: 2018-09-22 10:52
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

<div class="layui-container fly-marginTop fly-user-main">
    <ul class="layui-nav layui-nav-tree layui-inline" lay-filter="user">
        <li class="layui-nav-item">
            <a href="/bbs/toUserCenter">
                <i class="layui-icon">&#xe612;</i>
                用户中心
            </a>
        </li>
        <li class="layui-nav-item layui-this">
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
                <li class="layui-this" lay-id="info">我的资料</li>
                <li lay-id="avatar">头像</li>
                <li lay-id="pass">密码</li>
            </ul>
            <div class="layui-tab-content" style="padding: 20px 0;">
                <div class="layui-form layui-form-pane layui-tab-item layui-show">
                    <form method="post" name="infoForm" id="infoForm">
                        <div class="layui-form-item">
                            <label for="userName" class="layui-form-label">昵称</label>
                            <div class="layui-input-inline" style="width: 290px;">
                                <input type="text" id="userName" name="userName" autocomplete="off" readonly
                                       value="${sessionScope.bbsUser.userName}" class="layui-input readonly">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="loginName" class="layui-form-label">用户名</label>
                            <div class="layui-input-inline" style="width: 290px;">
                                <input type="text" id="loginName" name="loginName" autocomplete="off" readonly
                                       value="${sessionScope.bbsUser.loginName}" class="layui-input readonly">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="mobile" class="layui-form-label">手机号</label>
                            <div class="layui-input-inline" style="width: 290px;">
                                <input type="text" id="mobile" name="mobile" autocomplete="off"
                                       value="${sessionScope.bbsUser.mobile}" class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="postNum" class="layui-form-label">发帖数</label>
                            <div class="layui-input-inline" style="width: 290px;">
                                <input type="text" id="postNum" name="postNum" autocomplete="off"
                                       value="${sessionScope.bbsUser.postNum}"
                                       class="layui-input readonly"
                                       readonly>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="backNum" class="layui-form-label">回帖数</label>
                            <div class="layui-input-inline" style="width: 290px;">
                                <input type="text" id="backNum" name="backNum" autocomplete="off"
                                       value="${sessionScope.bbsUser.backNum}"
                                       class="layui-input readonly"
                                       readonly>
                            </div>
                        </div>
                        <div class="layui-form-item layui-form-text">
                            <label for="note" class="layui-form-label" style="width:400px;">签名</label>
                            <div class="layui-input-block">
                            <textarea placeholder="随便写些什么刷下存在感" id="note" name="note" autocomplete="off" class="layui-textarea"
                                      style="height: 80px;width:400px">${sessionScope.bbsUser.note}</textarea>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <button class="layui-btn" key="set-mine" lay-filter="infoForm" lay-submit>确认修改</button>
                        </div>
                    </form>
                </div>

                <div class="layui-form layui-form-pane layui-tab-item">
                    <form method="post" name="imgForm" id="imgForm">
                        <div class="layui-form-item">
                            <div class="avatar-add">
                                <p>建议尺寸168*168，支持jpg、png、gif，最大不能超过50KB</p>
                                <button type="button" class="layui-btn upload-img" id="upImg">
                                    <i class="layui-icon">&#xe67c;</i>上传头像
                                </button>
                                <c:if test="${not empty sessionScope.bbsUser.imgUrl}">
                                    <img id="headImg" src="${sessionScope.bbsUser.imgUrl}" style="width: 168px;height: 168px;">
                                </c:if>
                                <c:if test="${empty sessionScope.bbsUser.imgUrl}">
                                    <img id="headImg" src="/design/bbs/images/header.jpg" style="width: 168px;height: 168px;">
                                </c:if>
                                <span class="loading"></span>
                                <input type="hidden" name="imgUrl" id="imgUrl" value="${sessionScope.bbsUser.imgUrl}"/>
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <button class="layui-btn" key="set-mine" lay-filter="imgForm" lay-submit>确认修改</button>
                        </div>
                    </form>
                </div>

                <div class="layui-form layui-form-pane layui-tab-item">
                    <form method="post" name="passForm" id="passForm">
                        <div class="layui-form-item">
                            <label for="nowPass" class="layui-form-label">当前密码</label>
                            <div class="layui-input-inline">
                                <input type="password" id="nowPass" name="nowPass" required lay-verify="required"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="newPass" class="layui-form-label">新密码</label>
                            <div class="layui-input-inline">
                                <input type="password" id="newPass" name="newPass" required lay-verify="required"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <label for="passA" class="layui-form-label">确认密码</label>
                            <div class="layui-input-inline">
                                <input type="password" id="passA" required lay-verify="required"
                                       autocomplete="off"
                                       class="layui-input">
                            </div>
                        </div>
                        <div class="layui-form-item">
                            <button class="layui-btn" key="set-mine" lay-filter="passForm" lay-submit>确认修改</button>
                        </div>
                    </form>
                </div>

            </div>

        </div>
    </div>
</div>
<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>
<script>
    layui.use(['jquery', 'element', 'layer', 'form', 'upload'], function ()
    {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;
        // 图片上传
        upload.render({
            elem: '#upImg'
            , size: 6000 //限制文件大小，单位 KB
            , exts: 'png|jpg' //只允许上传doc和docx  //如果不需要,是任意文件,请删除这一行
            , url: '/system/upload/img?childFile=bbsUser&sessionId=' + new Date().getTime()
            , accept: 'file'
            , done: function (res, index, upload)
            {
                if (res.success)
                {
                    $('#headImg').attr('src', res.data.serverPath);
                    $("#imgUrl").val(res.data.serverPath);
                }
                else
                {
                    layer.alert(res.message);
                }
            }
        });
        //form 基本信息 提交
        form.on('submit(infoForm)', function (data)
        {
            $.ajax({
                type: 'post',
                data: $("#infoForm").serialize(),
                url: '/bbs/userInfoUpdate',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/bbs/toUserSet";
                    }
                    else
                    {
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
        // 头像表单 提交
        form.on('submit(imgForm)', function (data)
        {
            $.ajax({
                type: 'post',
                data: $("#imgForm").serialize(),
                url: '/bbs/userImgUpdate',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/bbs/toUserSet";
                    }
                    else
                    {
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
        // 密码表单提交
        form.on('submit(passForm)', function (data)
        {
            if ($('#passA').val() != $('#newPass').val())
            {
                layer.msg('两次密码不一致');
                return false;
            }
            $.ajax({
                type: 'post',
                data: $("#passForm").serialize(),
                url: '/bbs/userPassUpdate',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/bbs/toUserSet";
                    }
                    else
                    {
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

</body>
</html>