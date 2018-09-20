<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<meta charset="UTF-8">
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp"/>
<link rel="stylesheet" href="/design/webAdmin/css/login.css">
<link rel="stylesheet" href="/design/slide/css/sliderImgPuzzle.css">

<style type="text/css">
    .layui-input:hover, .layui-textarea:hover {
        border-color: none;
    }
</style>


<body class="login-bg">

<div class="login">
    <div class="message"><b>重大昆明社区</b></div>
    <div id="darkbannerwrap"></div>
    <form method="post" class="layui-form" id="loginForm">
        <input id="loginName" name="loginName" placeholder="用户名" type="text" lay-verify="required" class="layui-input"
               autocomplete="off" aria-required="true">
        <hr class="hr15">
        <input type="password" id="loginPass" name="loginPass" lay-verify="required" placeholder="密码"
               class="layui-input" autocomplete="off" aria-required="true">
        <hr class="hr15">
        <div>
            <div id="silderpuzzle" style="position: relative;"></div>
        </div>
        <hr class="hr15">
        <input class="loginin" id="loginBtn" value="登录" style="display:none" lay-submit
               style="width:100%;" type="button"
               lay-filter="loginForm">
    </form>
    <div class="linkOther" style="margin-top: 10px;">
        <span style="float: right;margin-right:5px;"><a href="/"><i
                class="layui-icon">&#xe631;</i>&nbsp;返回首页</a></span>
    </div>
</div>
</body>
<script type="text/javascript" src="/design/webAdmin/layui.js"></script>
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
                url: '/webAdmin/login',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/webAdmin/index";
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
                    layer.alert("登录超时,请重新登录！", {closeBtn: 0}, function ()
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