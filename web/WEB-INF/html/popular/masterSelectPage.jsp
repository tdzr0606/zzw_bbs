<%--
  zzw_bbs
  masterSelectPage
  User: 竺志伟
  Date: 2018-09-19 11:14
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/popular/head.jsp"/>
<body>
<form class="layui-form" id="masterSelectForm" style="padding:10px 40px 0px 0px;">
    <div class="layui-form-item">
        <label class="layui-form-label">选中人员：</label>
        <div class="layui-input-inline" style="width: 400px;">
            <input type="text" name="masterName" id="masterName" class="layui-input" autocomplete="off"
                   readonly="readonly"
                   placeholder="请在下方搜索并选择人员">
        </div>
    </div>
</form>
<hr>
<div class="layui-row" style="padding-right: 12px">
    <table align="right">
        <tr>
            <td style="padding-right:10px">搜索:</td>
            <td><input class="layui-input" style="height:30px;width:300px;float:right" name="key"
                       id="searchKey" autocomplete="off">
            </td>
            <td style="padding-left:10px">
                <button class="layui-btn layui-btn-sm" data-method="search" type="button" id="searchBtn"
                        style="float:right">搜索
                </button>
            </td>
        </tr>
    </table>
</div>

<div class="table-cont">
    <table class="layui-table" id="masterSelectTable" lay-filter="masterSelectTable"></table>
</div>

<jsp:include page="/WEB-INF/html/inc/popular/foot.jsp"/>

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
           onclick="javascript:showImage('{{d.imgUrl}}','头像展示');"
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
    layui.use(['element', 'table', 'layer', 'form'], function ()
    {
        var $ = layui.jquery;
        var table = layui.table;
        var masterSelectTable = table.render({
            elem: '#masterSelectTable'
            , id: 'masterSelectTable'
            , url: '/popular/master/listMaster'
            , cols: [[
                {checkbox: true, fixed: true}
                , {field: 'id', title: 'ID', width: 80, sort: true}
                , {field: 'userName', title: '用户名', width: 120, sort: true}
                , {field: 'loginName', title: '登录名', width: 120, sort: true}
                , {field: 'mobile', title: '手机', width: 120, sort: true}
                , {field: 'registerDate', title: '注册时间', width: 180, sort: true}
                , {field: 'imgUrl', title: '头像', width: 80, sort: true, templet: '#imgUrlTpl'}
                , {field: 'lastLoginIP', title: '登录IP', width: 160, sort: true}
                , {field: 'lastLoginTime', title: '登录时间', width: 180, sort: true}
                , {field: 'postNum', title: '发帖数量', width: 120, sort: true}
                , {field: 'backNum', title: '回帖数量', width: 120, sort: true}
                , {field: 'note', title: '备注', width: 80, sort: true}
            ]]
            , height: '300'
            , limit: 40
            , limits: [40]
            , page: true
        });
        table.on('checkbox(masterSelectTable)', function (obj)
        {
            $('#masterName').val(obj.data.userName);
            window.parent.document.returnValue = obj.data;
        });
        $('#searchBtn').on('click', function ()
        {
            $('#masterName').val('');
            var keyValue = $('#searchKey').val();
            masterSelectTable.reload({where: {key: keyValue}});
        });
    });
</script>
</body>
</html>
