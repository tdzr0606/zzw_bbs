<%--
   bbsBbs
   User:竺志伟
   Date:2018-09-20 13:45:48
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>帖子管理</legend>
        </fieldset>
        <div id="bbsBbsMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="show">展示</button>
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
        <table class="layui-hidden" id="bbsBbsTable" lay-filter="bbsBbsTable"></table>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>

<script type="text/html" id="isPublicTpl">
    {{# if(d.isPublic) { }}
    <font color="green">正常</font>
    {{# } else { }}
    <font color="red">封贴</font>
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
        var bbsBbsTable = table.render({
            elem: '#bbsBbsTable'
            , id: 'bbsBbsTable'
            , url: '/webAdmin/bbsBbs/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'typeTitle', title: '主题', width: 120, sort: true}
                , {field: 'title', title: '标题', width: 400, sort: true}
                , {field: 'createName', title: '发帖人', width: 120, sort: true}
                , {field: 'createDateTime', title: '发帖时间', width: 180, sort: true}
                , {field: 'replyNum', title: '回帖数量', width: 80, sort: true}
                , {field: 'isPublic', title: '状态', width: 80, sort: true}
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
                bbsBbsTable.reload({where: {key: keyValue}});
            }
            , use: function ()
            {
                var checkStatus = table.checkStatus('bbsBbsTable');
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
                            url: '/webAdmin/bbsBbs/use',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        bbsBbsTable.reload();
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
            , show: function ()
            {
                var checkStatus = table.checkStatus('bbsBbsTable'), data = checkStatus.data;
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
                    layer.open({
                        type: 1
                        , title: "展示"
                        , closeBtn: 1
                        , area: ['800px', '600px']
                        , shade: 0.2
                        , id: 'bbsBbsFormWindow'
                        , moveType: 1
                        , content: 'aaa'
                        , success: function (layero)
                        {
                        }
                    });
                }
            }
        };
        //总体上调用,是那个按钮激活哪个
        $('#bbsBbsMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
    });
</script>

</body>
</html>
