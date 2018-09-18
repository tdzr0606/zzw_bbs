<%--
   user
   User:竺志伟
   Date:2018-09-14 22:01:25
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>管理员管理</legend>
        </fieldset>
        <div id="userMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="new">新建</button>
                        <button class="layui-btn" data-method="modify">修改</button>
                        <%--<button class="layui-btn" data-method="delete">删除</button>--%>
                        <button class="layui-btn" data-method="use">启用/禁用</button>
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
        <table class="layui-hidden" id="userTable" lay-filter="userTable"></table>
    </div>
</div>

<form class="layui-form" id="userForm" style="display:none;padding:10px 40px 10px 0px; ">
    <div class="layui-form-item">
        <label class="layui-form-label">姓名</label>
        <div class="layui-input-block">
            <input type="text" name="userName" required="required" lay-verify="required" placeholder="请输入姓名" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">登录名</label>
        <div class="layui-input-block">
            <input type="text" name="loginName" id="loginName" required="required" lay-verify="required" placeholder="请输入登录名"
                   autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">登录密码</label>
        <div class="layui-input-block">
            <input type="password" name="loginPass" required="required" lay-verify="required" placeholder="请输入登录密码"
                   autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">联系电话</label>
        <div class="layui-input-block">
            <input type="text" name="mobile" required="required" lay-verify="required" placeholder="请输入联系电话" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>

    <div class="layui-form-item">
        <label class="layui-form-label">备注</label>
        <div class="layui-input-block">
            <textarea class="layui-textarea" name="note" autocomplete="off"></textarea>
        </div>
    </div>

    <input type="hidden" name="id" id="id" value="0"/>
    <input type="hidden" name="actionUrl" id="actionUrl" value=""/>
    <input type="hidden" name="isUse"/>

    <div class="layui-form-item">
        <div class="layui-input-block">
            <button class="layui-btn" lay-submit="lay-submit" lay-filter="userForm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="layer.closeAll()">取消</button>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>

<script type="text/html" id="isUseTpl">
    {{# if(d.isUse) { }}
    <font color="green">启用</font>
    {{# } else { }}
    <font color="red">停用</font>
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
    layui.use(['element', 'table', 'layer', 'form'], function ()
    {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var userTable = table.render({
            elem: '#userTable'
            , id: 'userTable'
            , url: '/webAdmin/user/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 80, sort: true}
                , {field: 'userName', title: '姓名', width: 120, sort: true}
                , {field: 'loginName', title: '登录名', width: 120, sort: true}
                , {field: 'mobile', title: '联系电话', width: 120, sort: true}
                , {field: 'isUse', title: '状态', width: 80, sort: true, templet: '#isUseTpl'}
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
                userTable.reload({where: {key: keyValue}});
            }
            , new: function ()
            {
                $('#userForm')[0].reset();
                $('#userForm input').val('');
                $('#actionUrl').val("new");
                $('#id').val('0');
                $('#loginName').removeAttr('readonly');
                $('#loginName').removeClass('readonly');
                form.render();
                layer.open({
                    type: 1
                    , title: "新建"
                    , closeBtn: 1
                    , area: '650px;'
                    , shade: 0.2
                    , id: 'userFormWindow'
                    , moveType: 1
                    , content: $('#userForm')
                });
            }
            , modify: function ()
            {
                var checkStatus = table.checkStatus('userTable'), data = checkStatus.data;
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
                else if(data[0].isUse)
                {
                    layer.msg('当前数据已经启用,不能修改');
                    return false;
                }
                else
                {
                    var id = data[0].id;
                    $.ajax({
                        type: 'get',
                        url: '/webAdmin/user/info?id=' + id + '&sessionId=' + new Date().getTime(),
                        success: function (json)
                        {
                            if (json.success)
                            {
                                $('#userForm input').val('');
                                form.loadData(json.data, 'userForm');
                                $('#actionUrl').val("modify");
                                $('#loginName').attr('readonly', 'readonly');
                                $('#loginName').addClass('readonly');
                                form.render();
                                layer.open({
                                    type: 1
                                    , title: "修改"
                                    , closeBtn: 1
                                    , area: '650px;'
                                    , shade: 0.2
                                    , id: 'userFormWindow'
                                    , moveType: 1
                                    , content: $('#userForm')
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
                var checkStatus = table.checkStatus('userTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须最少选中一条需要删除的记录');
                    return false;
                }
                layer.open({
                    type: 1
                    , id: 'userDeleteAccept'
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
                            url: '/webAdmin/user/delete',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        userTable.reload();
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
                var checkStatus = table.checkStatus('userTable');
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
                            url: '/webAdmin/user/use',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        userTable.reload();
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
        $('#userMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //form submit新建修改事件提交
        form.on('submit(userForm)', function (data)
        {
            var actionUrl = "/webAdmin/user/" + $('#actionUrl').val();
            $.ajax({
                type: 'post',
                data: $('#userForm').serialize(),
                url: actionUrl,
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.alert(json.msg, {closeBtn: 0}, function ()
                        {
                            layer.closeAll();
                            userTable.reload();
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
