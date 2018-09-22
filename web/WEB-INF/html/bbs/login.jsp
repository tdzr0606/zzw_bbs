<%--
  zzw_bbs
  login
  User: 竺志伟
  Date: 2018-09-21 21:49
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

<div class="layui-container fly-marginTop">
    <div class="fly-panel fly-panel-user" pad20>
        <div class="layui-tab layui-tab-brief" lay-filter="user">
            <ul class="layui-tab-title">
                <li class="layui-this">登入</li>
                <li><a href="/toRegist">注册</a></li>
            </ul>
            <div class="layui-form layui-tab-content" style="padding: 20px 0;">
                <div class="layui-tab-item layui-show">
                    <div class="layui-form layui-form-pane">
                        <form method="post" lay-filter="loginForm" id="loginForm">
                            <div class="layui-form-item">
                                <label class="layui-form-label" style="width: 85px;height: 40px;">用户名</label>
                                <div class="layui-input-inline">
                                    <input type="text" name="loginName" id="loginName" required lay-verify="required"
                                           autocomplete="off" style="height: 40px;"
                                           class="layui-input">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <label class="layui-form-label"  style="width: 85px;height: 40px;">密码</label>
                                <div class="layui-input-inline" >
                                    <input type="password" name="loginPass" id="loginPass" required lay-verify="required"
                                           autocomplete="off" class="layui-input" style="height: 40px;">
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div id="silderpuzzle" style="position: relative;"></div>
                            </div>
                            <input class="loginin" id="loginBtn" value="登录" style="display:none" lay-submit
                                   style="width:100%;" type="button"
                                   lay-filter="loginForm">
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>

<script>
    layui.use(['jquery', 'element', 'layer', 'form'], function ()
    {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        //form 用户登录
        form.on('submit(loginForm)', function (data)
        {
            $.ajax({
                type: 'post',
                data: $("#loginForm").serialize(),
                url: '/login',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/";
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
            if ($('#loginName').val() && $('#loginPass').val())
            {
                $('#loginBtn').click();
            }
            else
            {
                imgPuzzle.reset();
                layer.alert('请填写用户名密码', function ()
                {
                    layer.closeAll();
                });
            }
            return false;
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
