<%--
   logs
   User:竺志伟
   Date:2018-09-18 10:30:23
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>系统日志</legend>
        </fieldset>
        <div id="logsMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="show">展示</button>
                    </div>
                </div>
                <div class="layui-col-md6">
                    搜索：
                    <div class="layui-inline" style="width:70%">
                        <input class="layui-input" name="key" id="searchKey" autocomplete="off" style="width:100%;"/>
                    </div>
                    <button class="layui-btn" data-method="search" id="searchBtn">搜索</button>
                </div>
            </div>
        </div>
        <table class="layui-hidden" id="logsTable" lay-filter="logsTable"></table>
    </div>
</div>

<form class="layui-form" id="logsForm" style="display:none;padding:10px 40px 10px 0px; ">

    <div class="layui-form-item">
        <label class="layui-form-label">时间</label>
        <div class="layui-input-block">
            <input type="text" name="createTime" required="required" lay-verify="required" placeholder="请输入字段名" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">访问人</label>
        <div class="layui-input-block">
            <input type="text" name="loginName" required="required" lay-verify="required" placeholder="请输入字段名" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">访问IP</label>
        <div class="layui-input-block">
            <input type="text" name="ip" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">执行类</label>
        <div class="layui-input-block">
            <input type="text" name="className" required="required" lay-verify="required" placeholder="请输入字段名" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">执行方法</label>
        <div class="layui-input-block">
            <input type="text" name="methodName" required="required" lay-verify="required" placeholder="请输入字段名" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">参数</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" name="paramStr" autocomplete="off"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">结果</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" name="resultStr" autocomplete="off"></textarea>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <input type="text" class="layui-input" name="note" autocomplete="off">
        </div>
    </div>
    <input type="hidden" name="id" id="id" value="0"/>

</form>


<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>

<script type="text/javascript">
    $(function ()
    {
        $('#searchKey').keyup(function (event)
        {
            if (event.keyCode == 13)
            {
                $('#searchBtn').click();
            }
        });
    });
    layui.use(['element', 'table', 'layer', 'form'], function ()
    {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var logsTable = table.render({
            elem: '#logsTable'
            , id: 'logsTable'
            , url: '/webAdmin/logs/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'createTime', title: '时间', width: 180, sort: true}
                , {field: 'ip', title: 'IP', width: 180, sort: true}
                , {field: 'loginName', title: '访问人', width: 120, sort: true}
                , {field: 'className', title: '类名', width: 200, sort: true}
                , {field: 'methodName', title: '方法名', width: 180, sort: true}
                , {field: 'note', title: '备注', width: 200, sort: true}
            ]]
            , height: 'full-240'
            , limit: 40
            , limits: [40]
            , page: true
        });
        //触发事件
        var active = {
            search: function ()
            {
                var keyValue = $('#searchKey').val();
                logsTable.reload({where: {key: keyValue}});
            }
            , show: function ()
            {
                var checkStatus = table.checkStatus('logsTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须选中一条需要展示的记录');
                    return false;
                }
                else if (data.length > 1)
                {
                    layer.msg('您在展示的时候,不能选中多条记录');
                    return false;
                }
                else
                {
                    var id = data[0].id;
                    $.ajax({
                        type: 'get',
                        url: '/webAdmin/logs/info?id=' + id + '&sessionId=' + new Date().getTime(),
                        success: function (json)
                        {
                            if (json.success)
                            {
                                $('#logsForm input').val('');
                                form.loadData(json.data, 'logsForm');
                                $('#actionUrl').val("modify");
                                form.render();
                                layer.open({
                                    type: 1
                                    , title: "展示"
                                    , closeBtn: 1
                                    , area: ['800px', '600px']
                                    , shade: 0.2
                                    , id: 'logsFormWindow'
                                    , moveType: 1
                                    , content: $('#logsForm')
                                    , success: function (layero)
                                    {
                                    }
                                });
                            }
                            else
                            {
                                layer.msg(json.msg);
                            }
                        },
                        error: function (json)
                        {
                            layer.alert("未知的错误！", {closeBtn: 0}, function ()
                            {
                                layer.closeAll();
                            });
                        }
                    });
                }
            }
        };
        //总体上调用,是那个按钮激活哪个
        $('#logsMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });
</script>

</body>
</html>
