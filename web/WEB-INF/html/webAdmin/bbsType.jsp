<%--
   bbsType
   User:竺志伟
   Date:2018-09-19 09:57:51
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<jsp:include page="/WEB-INF/html/inc/webAdmin/head.jsp" flush="true"/>
<body>
<div class="layui-layout layui-layout-admin">
    <jsp:include page="/WEB-INF/html/inc/webAdmin/menu.jsp"/>
    <div class="layui-body" style="padding:10px">
        <fieldset class="layui-elem-field layui-field-title">
            <legend>主题管理</legend>
        </fieldset>
        <div id="bbsTypeMenuBar">
            <div class="layui-row">
                <div class="layui-col-md6">
                    <div class="layui-btn-group">
                        <button class="layui-btn" data-method="new">新建</button>
                        <button class="layui-btn" data-method="modify">修改</button>
                        <button class="layui-btn" data-method="delete">删除</button>
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
        <table class="layui-hidden" id="bbsTypeTable" lay-filter="bbsTypeTable"></table>
    </div>
</div>

<form class="layui-form" id="bbsTypeForm" style="display:none;padding:10px 40px 10px 0px; ">

    <div class="layui-form-item">
        <label class="layui-form-label">标题</label>
        <div class="layui-input-block">
            <input type="text" name="title" required="required" lay-verify="required" placeholder="请输入标题" autocomplete="off"
                   class="layui-input"/>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">展示图片</label>
        <div class="layui-input-inline" style="width: 430px;">
            <input type="text" name="imgUrl" id="imgUrl" autocomplete="off" class="layui-input readonly" readonly/>
        </div>
        <div class="layui-input-inline" style="width:200px;">
            <span id="upImg" style="cursor:pointer" class="layui-btn">
                <i class="layui-icon">&#xe681;</i>上传
            </span>
            <span id="showImg" style="cursor: pointer" class="layui-btn">
                <i class="layui-icon">&#xe64a;</i>展示
            </span>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">版主</label>
        <div class="layui-input-inline" style="width: 530px;">
            <input type="text" name="masterName" id="masterName" placeholder="请选择版主" autocomplete="off"
                   class="layui-input readonly" readonly/>
            <input type="hidden" name="masterId" id="masterId"/>
        </div>
        <div class="layui-input-inline" style="width:100px;">
            <span id="masterSBtn" style="cursor:pointer" class="layui-btn">
                <i class="layui-icon">&#xe681;</i>选择
            </span>
        </div>
    </div>
    <div class="layui-form-item">
        <label class="layui-form-label">排序</label>
        <div class="layui-input-block">
            <input type="number" name="sortNum" lay-verity="required" autocomplete="off"
                   class="layui-input">
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
            <button class="layui-btn" lay-submit="lay-submit" lay-filter="bbsTypeForm">确定</button>
            <button type="reset" class="layui-btn layui-btn-primary" onclick="layer.closeAll()">取消</button>
        </div>
    </div>
</form>


<jsp:include page="/WEB-INF/html/inc/webAdmin/foot.jsp"/>

<script type="text/html" id="isUseTpl">
    {{# if(d.isUse) { }}
    <font color="green">启用</font>
    {{# } else { }}
    <font color="red">禁用</font>
    {{# } }}
</script>

<script type="text/html" id="imgUrlTpl">
    {{# if(d.imgUrl) { }}
    <image src="{{ d.imgUrl }}" style="width:30px;height:30px;cursor: pointer"
           onclick="javascript:showImage('{{d.imgUrl}}');"
           title="点击查看大图"/>
    {{# } else { }}

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
    layui.use(['element', 'table', 'layer', 'form', 'upload'], function ()
    {
        var $ = layui.jquery;
        var table = layui.table;
        var layer = layui.layer;
        var form = layui.form;
        var upload = layui.upload;
        // 图片上传
        upload.render({
            elem: '#upImg'
            , size: 6000 //限制文件大小，单位 KB
            , exts: 'png|jpg' //只允许上传doc和docx  //如果不需要,是任意文件,请删除这一行
            , url: '/system/upload/img?childFile=bbsType&sessionId=' + new Date().getTime()
            , accept: 'file'
            , done: function (res, index, upload)
            {
                if (res.success)
                {
                    $("#imgUrl").val(res.data.serverPath);
                    $('#showImg').click();
                }
                else
                {
                    layer.alert(res.message);
                }
            }
        });
        $('#showImg').click(function ()
        {
            var imgUrl = $('#imgUrl').val();
            if ('' == imgUrl)
            {
                imgUrl = '/design/webAdmin/images/noimghead.jpg';
            }
            layer.open({
                type: 1
                , title: '头像展示'
                , area: ['400px', '300px']
                , id: 'showImgWin' //防止重复弹出
                , content:
                    '<div style="padding: 20px 30px;text-align: center" title="暂无图片"><img src="' + imgUrl +
                    '" /></div>'
                , shade: 0.2 //显示遮罩
            });
        });
        var bbsTypeTable = table.render({
            elem: '#bbsTypeTable'
            , id: 'bbsTypeTable'
            , url: '/webAdmin/bbsType/list'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 80, sort: true}
                , {field: 'title', title: '标题', width: 200, sort: true}
                , {field: 'masterName', title: '版主', width: 120, sort: true}
                , {field: 'imgUrl', title: '展示图片', width: 120, sort: true, templet: '#imgUrlTpl'}
                , {field: 'createDate', title: '创建时间', width: 180, sort: true}
                , {field: 'isUse', title: '状态', width: 80, sort: true, templet: '#isUseTpl'}
                , {field: 'sortNum', title: '排序', width: 80}
                , {field: 'postNum', title: '帖子数量', width: 120, sort: true}
                , {field: 'lastPoster', title: '最后发帖者', width: 160, sort: true}
                , {field: 'lastPostDate', title: '最后发帖时间', width: 160, sort: true}
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
                bbsTypeTable.reload({where: {key: keyValue}});
            }
            , new: function ()
            {
                $('#bbsTypeForm')[0].reset();
                $('#bbsTypeForm input').val('');
                $('#actionUrl').val("new");
                $('#id').val('0');
                layer.open({
                    type: 1
                    , title: "新建"
                    , closeBtn: 1
                    , area: ['800px', '600px']
                    , shade: 0.2
                    , id: 'bbsTypeFormWindow'
                    , moveType: 1
                    , content: $('#bbsTypeForm')
                });
            }
            , modify: function ()
            {
                var checkStatus = table.checkStatus('bbsTypeTable'), data = checkStatus.data;
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
                    layer.msg('当前数据已经启用,禁止修改');
                    return false;
                }
                else
                {
                    var id = data[0].id;
                    $.ajax({
                        type: 'get',
                        url: '/webAdmin/bbsType/info?id=' + id + '&sessionId=' + new Date().getTime(),
                        success: function (json)
                        {
                            if (json.success)
                            {
                                $('#bbsTypeForm input').val('');
                                form.loadData(json.data, 'bbsTypeForm');
                                $('#actionUrl').val("modify");
                                form.render();
                                layer.open({
                                    type: 1
                                    , title: "修改"
                                    , closeBtn: 1
                                    , area: ['800px', '600px']
                                    , shade: 0.2
                                    , id: 'bbsTypeFormWindow'
                                    , moveType: 1
                                    , content: $('#bbsTypeForm')
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
                var checkStatus = table.checkStatus('bbsTypeTable'), data = checkStatus.data;
                if (data.length < 1)
                {
                    layer.msg('您必须最少选中一条需要删除的记录');
                    return false;
                }
                layer.open({
                    type: 1
                    , id: 'bbsTypeDeleteAccept'
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
                            url: '/webAdmin/bbsType/delete',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        bbsTypeTable.reload();
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
                var checkStatus = table.checkStatus('bbsTypeTable');
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
                            url: '/webAdmin/bbsType/use',
                            success: function (json)
                            {
                                if (json.success)
                                {
                                    layer.alert(json.msg, {closeBtn: 0}, function ()
                                    {
                                        layer.closeAll();
                                        bbsTypeTable.reload();
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
        $('#bbsTypeMenuBar .layui-btn').on('click', function ()
        {
            var othis = $(this), method = othis.data('method');
            active[method] ? active[method].call(this, othis) : '';
        });
        //form submit新建修改事件提交
        form.on('submit(bbsTypeForm)', function (data)
        {
            var actionUrl = "/webAdmin/bbsType/" + $('#actionUrl').val();
            $.ajax({
                type: 'post',
                data: $('#bbsTypeForm').serialize(),
                url: actionUrl,
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.alert(json.msg, {closeBtn: 0}, function ()
                        {
                            layer.closeAll();
                            bbsTypeTable.reload();
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
        // 版主选择
        $('#masterSBtn').click(function ()
        {
            layer.open({
                type: 2,
                anim: 5,
                shade: .2,
                id: 'collegeSelectW',
                title: '版主选择',
                btn: ['确定', '取消'],
                area: ['800px', '600px'],
                content: "/popular/toMasterSelectPage?sessionId=" + new Date().getTime(),
                resize: false,
                yes: function (index, layero)
                {
                    $('#masterId').val(document.returnValue.id);
                    $('#masterName').val(document.returnValue.userName);
                    layer.close(index);
                },
                cancel: function (index, layero)
                {
                    layer.close(index);
                    return false;
                }
            });
        });
    });

</script>

</body>
</html>
