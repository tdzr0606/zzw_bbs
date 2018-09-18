<%--
   friend
   User:竺志伟
   Date:2018-09-18 20:06:47
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>友情链接</legend>
        </fieldset>
        <div id="friendMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="new">新建</button>
                        <button class="layui-btn" data-method="modify">修改</button>
                        <button class="layui-btn" data-method="delete">删除</button>
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
        <table class="layui-hidden" id="friendTable" lay-filter="friendTable"></table>
    </div>
</div>

<form class="layui-form" id="friendForm" style="display:none;padding:10px 40px 10px 0px; ">
    <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" required="required" lay-verify="required" placeholder="请输入标题" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">链接地址</label>
        <div class="layui-input-block">
            <input type="text" name="linkUrl" required="required" lay-verify="required|url" placeholder="请输入链接地址"
                   autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
            <input type="number" name="sortNum" required="required" lay-verify="required" placeholder="请输入排序" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>

    <input type="hidden" name="id" id="id" value="0"/>
    <input type="hidden" name="actionUrl" id="actionUrl" value=""/>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="lay-submit" lay-filter="friendForm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="layer.closeAll()">取消</button>
        </div>
    </div>
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
        var friendTable = table.render({
            elem: '#friendTable'
            , id: 'friendTable'
            , url: '/webAdmin/friend/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 80, sort: true}
                , {field: 'title', title: '标题', width: 300, sort: true}
                , {field: 'linkUrl', title: '链接地址', width: 300, sort: true}
                , {field: 'sortNum', title: '排序', width: 80, sort: true}
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
                friendTable.reload({where: {key: keyValue}});
            }
            , new: function ()
            {
                $('#friendForm')[0].reset();
                $('#friendForm input').val('');
                $('#actionUrl').val("new");
                $('#id').val('0');
                layer.open({
                    type: 1
                    , title: "新建"
                    , closeBtn: 1
                    , area: ['800px', '600px']
                    , shade: 0.2
                    , id: 'friendFormWindow'
                    , moveType: 1
                    , content: $('#friendForm')
                });
            }
            , modify: function ()
            {
                var checkStatus = table.checkStatus('friendTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须选中一条需要修改的记录');
                    return false;
                }
                else if (data.length > 1)
                {
                    layer.msg('您在修改的时候,不能选中多条记录');
                    return false;
                }
                else
                {
                    var id = data[0].id;
                    $.ajax({
                        type: 'get',
                        url: '/webAdmin/friend/info?id=' + id + '&sessionId=' + new Date().getTime(),
                        success: function (json)
                        {
                            if (json.success)
                            {
                                $('#friendForm input').val('');
                                form.loadData(json.data, 'friendForm');
                                $('#actionUrl').val("modify");
                                form.render();
                                layer.open({
                                    type: 1
                                    , title: "修改"
                                    , closeBtn: 1
                                    , area: ['800px', '600px']
                                    , shade: 0.2
                                    , id: 'friendFormWindow'
                                    , moveType: 1
                                    , content: $('#friendForm')
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
            , delete: function ()
            {
                var checkStatus = table.checkStatus('friendTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须最少选中一条需要删除的记录');
                    return false;
                }
                layer.open({
                    type: 1
                    , id: 'friendDeleteAccept'
                    , content: '<div style="padding: 20px 30px;">是否真的要删除选中的记录?</div>'
                    , btn: ['确定', '取消']
                    , btnAlign: 'c'
                    , shade: 0.2
                    , yes: function ()
                    {
                        layer.closeAll();
                        var idArray = new Array();
                        for (var i = 0; i < data.length; i++)
                        {
                            idArray[i] = data[i].id;
                        }
                        $.ajax({
                            type: 'post',
                            data: {ids: idArray.toString()},
                            url: '/webAdmin/friend/delete',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        friendTable.reload();
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
                    }
                });
            }
        };
        //总体上调用,是那个按钮激活哪个
        $('#friendMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //form submit新建修改事件提交
        form.on('submit(friendForm)', function (data)
        {
            var actionUrl = "/webAdmin/friend/" + $('#actionUrl').val();
            $.ajax({
                type: 'post',
                data: $('#friendForm').serialize(),
                url: actionUrl,
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.alert(json.msg, {closeBtn: 0}, function ()
                        {
                            layer.closeAll();
                            friendTable.reload();
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

</body>
</html>
