<%--
   notice
   User:竺志伟
   Date:2018-09-18 15:54:02
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>通知管理</legend>
        </fieldset>
        <div id="noticeMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="new">新建</button>
                        <button class="layui-btn" data-method="modify">修改</button>
                        <button class="layui-btn" data-method="delete">删除</button>
                        <button class="layui-btn" data-method="use">发布/取消</button>
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
        <table class="layui-hidden" id="noticeTable" lay-filter="noticeTable"></table>
    </div>
</div>

<form class="layui-form" id="noticeForm" style="display:none;padding:10px 40px 10px 0px; ">

    <div class="layui-form-item">
        <label class="layui-form-label">名称</label>
        <div class="layui-input-block">
            <input type="text" name="title" required="required" lay-verify="required" placeholder="请输入名称" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">内容</label>
        <div class="layui-input-block">
            <textarea id="contentT" style="display: none"></textarea>
            <input type="hidden" name="content" id="content">
        </div>
    </div>

    <input type="hidden" name="id" id="id" value="0"/>
    <input type="hidden" name="actionUrl" id="actionUrl" value=""/>
    <input type="hidden" name="isPublic"/>
    <input type="hidden" name="createName"/>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="lay-submit" lay-filter="noticeForm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="layer.closeAll()">取消</button>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>


<script type="text/html" id="isPublicTpl">
    {{# if(d.isPublic) { }}
    <font color="green">已发布</font>
    {{# } else { }}
    <font color="red">未发布</font>
    {{# } }}
</script>

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
    layui.use(['element', 'table', 'layer', 'form', 'layedit'], function ()
    {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var layedit = layui.layedit;
        layedit.set({
            uploadImage: {
                url: '/system/upload/edit' //接口url
                , type: 'post' //默认post
            }
        });
        var editIndex = 0;
        var noticeTable = table.render({
            elem: '#noticeTable'
            , id: 'noticeTable'
            , url: '/webAdmin/notice/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 80, sort: true}
                , {field: 'title', title: '名称', width: 250, sort: true}
                , {field: 'createName', title: '创建人', width: 120, sort: true}
                , {field: 'createDate', title: '创建时间', width: 180, sort: true}
                , {field: 'isPublic', title: '状态', width: 80, sort: true, templet: '#isPublicTpl'}
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
                noticeTable.reload({where: {key: keyValue}});
            }
            , new: function ()
            {
                $('#noticeForm')[0].reset();
                $('#noticeForm input').val('');
                $('#actionUrl').val("new");
                $('#id').val('0');
                form.render();
                layer.open({
                    type: 1
                    , title: "新建"
                    , closeBtn: 1
                    , area: ['800px', '600px']
                    , shade: 0.2
                    , id: 'noticeFormWindow'
                    , moveType: 1
                    , content: $('#noticeForm')
                    , success: function (layero)
                    {
                        editIndex = layedit.build('contentT'); //建立编辑器
                    }
                });
            }
            , modify: function ()
            {
                var checkStatus = table.checkStatus('noticeTable'), data = checkStatus.data;
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
                else if (data[0].isPublic)
                {
                    layer.msg('当前数据已经发布,不能修改');
                    return false;
                }
                else
                {
                    var id = data[0].id;
                    $.ajax({
                        type: 'get',
                        url: '/webAdmin/notice/info?id=' + id + '&sessionId=' + new Date().getTime(),
                        success: function (json)
                        {
                            if (json.success)
                            {
                                $('#noticeForm input').val('');
                                form.loadData(json.data, 'noticeForm');
                                $('#actionUrl').val("modify");
                                $('#contentT').val(json.data.content);
                                form.render();
                                layer.open({
                                    type: 1
                                    , title: "修改"
                                    , closeBtn: 1
                                    , area: ['800px', '600px']
                                    , shade: 0.2
                                    , id: 'noticeFormWindow'
                                    , moveType: 1
                                    , content: $('#noticeForm')
                                    , success: function (layero)
                                    {
                                        editIndex = layedit.build('contentT'); //建立编辑器
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
                var checkStatus = table.checkStatus('noticeTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须最少选中一条需要删除的记录');
                    return false;
                }
                layer.open({
                    type: 1
                    , id: 'noticeDeleteAccept'
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
                            url: '/webAdmin/notice/delete',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        noticeTable.reload();
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
            , use: function ()
            {
                var checkStatus = table.checkStatus('noticeTable');
                var data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须最少选中一条需要处理的记录');
                    return false;
                }
                layer.open({
                    type: 1
                    , id: 'useAccept' //防止重复弹出
                    , content: '<div style="padding: 20px 30px;">是否真的要处理选中的记录?</div>'
                    , btn: ['确定', '取消']
                    , btnAlign: 'c' //按钮居中
                    , shade: 0.2 //显示遮罩
                    , resize: false
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
                            data: {ids: idArray.toString()}, //这里只能用Tostring 才会是 1,2,3,4,其它的会有[]
                            url: '/webAdmin/notice/use',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        noticeTable.reload();
                                    });
                                }
                                else
                                {
                                    layer.alert(json.msg);
                                }
                            },
                            error: function (json)
                            {
                                console.error(json);
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
        $('#noticeMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //form submit新建修改事件提交
        form.on('submit(noticeForm)', function (data)
        {
            var actionUrl = "/webAdmin/notice/" + $('#actionUrl').val();
            $('#content').val(layedit.getContent(editIndex));//根据索引获取到富文本编辑器的内容
            $.ajax({
                type: 'post',
                data: $('#noticeForm').serialize(),
                url: actionUrl,
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.alert(json.msg, {closeBtn: 0}, function ()
                        {
                            layer.closeAll();
                            noticeTable.reload();
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
