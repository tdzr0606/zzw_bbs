<%@page pageEncoding="UTF-8" %>
<script src="/design/webAdmin/js/jquery-3.2.1.min.js"></script>
<script src="/design/webAdmin/js/ch233.min.js"></script>
<script src="/design/webAdmin/js/md5.js"></script>
<script src="/design/webAdmin/layui.js"></script>
<script src="/design/webAdmin/echarts.min.js"></script>
<script src="/design/webAdmin/layui.ext.js"></script>

<!-- 密码修改 表单 -->
<form class="layui-form" id="passwordModifyForm" style="display:none;padding:10px 40px 10px 0px; ">
    <div class="layui-form-item">
        <label class="layui-form-label">原始密码</label>

        <div class="layui-input-block">
            <input type="password" name="loginPass" required lay-verify="required" placeholder="请输入原始密码"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码</label>

        <div class="layui-input-block">
            <input type="password" name="loginPassN" id="loginPassN" required lay-verify="required"
                   placeholder="请输入新密码"
                   autocomplete="off" class="layui-input">
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">新密码验证</label>

        <div class="layui-input-block">
            <input type="password" id="loginPassA" required lay-verify="required" placeholder="请输入新密码验证"
                   autocomplete="off" class="layui-input">
        </div>
    </div>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <!--lay-filter 表示作用到 id:passwordModifyForm-->
            <button class="layui-btn" lay-submit lay-filter="passwordModifyForm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="layer.closeAll()">取消</button>
        </div>
    </div>
</form>
<script type="text/javascript">
    //注意：导航 依赖 element 模块，否则无法进行功能性操作
    layui.use(['element', 'layer', 'form'], function ()
    {
        var $ = layui.jquery;
        var element = layui.element;
        var layer = layui.layer;
        var form = layui.form;
        var active = {
            passModify: function ()
            {
                $('#passwordModifyForm')[0].reset();
                layer.open({
                    type: 1
                    , title: "密码修改" //不显示标题栏
                    , closeBtn: 1
                    , area: '500px;'
                    , shade: 0.2
                    , id: 'passwordModifyWindow' //设定一个id，防止重复弹出
                    , moveType: 1 //拖拽模式，0或者1
                    , content: $('#passwordModifyForm') //这里content是一个DOM，注意：最好该元素要存放在body最外层，否则可能被其它的相对元素所影响,winForm 指新建和修改的表单
                    , success: function (layero)
                    {
                        //这里去写完成后的事件
                    }
                });
            },
            //退出登陆
            logout: function ()
            {
                layer.open({
                    type: 1
                    , area: ['300px', '180px']
                    , id: 'logoutAccept' //防止重复弹出
                    , content: '<div style="padding: 20px 30px;">是否退出当前登录?</div>'
                    , btn: ['确定', '取消']
                    , btnAlign: 'c' //按钮居中
                    , shade: 0.2 //显示遮罩
                    , yes: function ()
                    {
                        layer.closeAll();
                        window.location.href = "/webAdmin/logout";
                    }
                });
            }
        };
        element.on('nav(topMenu)', function (elem)
        {
            var method = elem[0].childNodes[0].id;
            active[method] ? active[method].call(this, elem) : '';
        });
        //form submit新建修改事件提交
        form.on('submit(passwordModifyForm)', function (data)
        {
            var loginPassN = $('#loginPassN').val();
            var loginPassNA = $('#loginPassA').val();
            if (loginPassN != loginPassNA)
            {
                layer.msg('两次密码不一致');
                return false;
            }
            var actionUrl = "/webAdmin/user/passModify";
            $.ajax({
                type: 'post',
                data: data.field,
                url: actionUrl,
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.alert(json.msg, {closeBtn: 0}, function ()
                        {
                            layer.closeAll();
                            window.location.href = "/webAdmin?sessionId=" + new Date().getTime();
                        });
                    }
                    else
                    {
                        layer.alert(json.msg);
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
<script>
    layui.use(['jquery', 'element'], function ()
    {
        var $ = layui.jquery;
        var nowHref = window.location.pathname;
        $("#leftMainMenu").find('a').each(function ()
        {
            var tempHref = $(this).attr("href");
            if (nowHref == tempHref)
            {
                $(this).parent().addClass("layui-this");
            }
            else
            {
                $(this).parent().removeClass("layui-this");
            }
        });
        //以下是增加方法.让收起的菜单在新开页面中还是收起
        $(".layui-nav-item").click(function ()
        {
            var cookieName = hex_md5($(this).html());
            if ($(this).hasClass("layui-nav-itemed")) //如果Li是开启状态
            {
                document.cookie = cookieName + "=" + true + ";path=/;expires=7";
            }
            else
            {
                document.cookie = cookieName + "=" + false + ";path=/;expires=7";
            }
        });
        $("#leftMainMenu").find('.layui-nav-item').each(function ()
        {
            var cookieName = hex_md5($(this).html());
            var arr, reg = new RegExp("(^| )" + cookieName + "=([^;]*)(;|$)");
            if (arr = document.cookie.match(reg))
            {
                if (unescape(arr[2]) == 'true')
                {
                    $(this).addClass("layui-nav-itemed");
                }
                else
                {
                    $(this).removeClass("layui-nav-itemed");
                }
            }
        });
    });
</script>