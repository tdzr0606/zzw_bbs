<%--
  zzw_bbs
  foot
  User: 竺志伟
  Date: 2018-09-06 11:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<div class="fly-footer">
    <p>重大网络教育·昆明社区 2018 &copy; </p> nature.com出品
</div>

<script src="/design/bbs/layui/layui.js" charset="utf-8"></script>

<script type="text/javascript">
    layui.use(['jquery', 'element', 'layer', 'form', 'element', 'util'], function ()
    {
        var $ = layui.jquery
            , layer = layui.layer
            , form = layui.form
            , element = layui.element
            , util = layui.util
            , device = layui.device();
        if (device.ie && device.ie < 8)
        {
            layer.alert('如果您非得使用 IE 浏览器访问Fly社区，那么请使用 IE8+');
        }

        util.fixbar({
            bar1: true
            , css: {right: 20, bottom: 50}
            , bgcolor: '#009688'
            , click: function (type)
            {
                console.log(type == 'bar1');
                if (type == 'bar1')
                {
                    layer.msg('icon是可以随便换的');
                }
            }
        });
    });
</script>
