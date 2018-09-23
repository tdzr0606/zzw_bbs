<%--
  zzw_bbs
  newBbs
  User: 竺志伟
  Date: 2018-09-22 17:02
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="/WEB-INF/tld/c.tld" %>
<%@ taglib prefix="fmt" uri="/WEB-INF/tld/fmt.tld" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<link rel="stylesheet" href="/design/slide/css/sliderImgPuzzle.css">
<body>
<jsp:include page="/WEB-INF/html/inc/bbs/menu.jsp"/>

<div class="layui-container fly-marginTop">
    <div class="fly-panel" pad20 style="padding-top: 5px;">
        <div class="layui-form layui-form-pane">
            <div class="layui-tab layui-tab-brief" lay-filter="user">
                <ul class="layui-tab-title">
                    <li class="layui-this">发表新帖<!-- 编辑帖子 --></li>
                </ul>
                <div class="layui-form layui-tab-content" id="LAY_ucm" style="padding: 20px 0;">
                    <div class="layui-tab-item layui-show">
                        <form method="post" id="bbsForm" name="bbsForm">
                            <div class="layui-row layui-col-space15 layui-form-item">
                                <div class="layui-col-md3">
                                    <label class="layui-form-label">所在专栏</label>
                                    <div class="layui-input-block">
                                        <select lay-verify="required" name="typeId" id="typeId" lay-filter="typeId">
                                            <option></option>
                                            <c:forEach items="${requestScope.bbsType}" var="bbsType">
                                                <option value="${bbsType.id}">${bbsType.title}</option>
                                            </c:forEach>
                                        </select>
                                        <input type="hidden" name="typeTitle" id="typeTitle"/>
                                    </div>
                                </div>
                                <div class="layui-col-md9">
                                    <label for="title" class="layui-form-label">标题</label>
                                    <div class="layui-input-block">
                                        <input type="text" id="title" name="title" required lay-verify="required"
                                               autocomplete="off" class="layui-input">
                                    </div>
                                </div>
                            </div>
                            <div class="layui-form-item layui-form-text">
                                <div class="layui-input-block">
                                    <textarea id="contentT"
                                              style="height: 260px;display: none"></textarea>
                                    <input type="hidden" name="content" id="content"/>
                                </div>
                            </div>
                            <div class="layui-form-item">
                                <div id="silderpuzzle" style="position: relative;"></div>
                            </div>
                            <div class="layui-form-item">
                                <button class="layui-btn" style="display: none" id="bbsFormBtn" lay-filter="bbsForm" lay-submit>
                                    立即发布
                                </button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>

<script>
    layui.use(['jquery', 'element', 'layer', 'form', 'layedit'], function ()
    {
        var $ = layui.jquery;
        var layer = layui.layer;
        var form = layui.form;
        var layedit = layui.layedit;
        layedit.set({
            uploadImage: {
                url: '/system/upload/edit' //接口url
                , type: 'post' //默认post
            }
        });
        var editIndex = layedit.build('contentT');
        form.on('select(typeId)', function (data)
        {
            $('#typeTitle').val($(data.elem).find("option:selected").text());
        });
        //form 用户登录
        form.on('submit(bbsForm)', function (data)
        {
            $('#content').val(layedit.getContent(editIndex));//根据索引获取到富文本编辑器的内容
            $.ajax({
                type: 'post',
                data: $("#bbsForm").serialize(),
                url: '/bbs/newBbs',
                success: function (json)
                {
                    if (json.success)
                    {
                        layer.closeAll();
                        window.location.href = "/toBbsList?typeId=" + $('#typeId').val();
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
                    layer.alert("服务器连接错误", {closeBtn: 0}, function ()
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
            if ($('#typeId').val() && $('#title').val())
            {
                $('#bbsFormBtn').click();
            }
            else
            {
                imgPuzzle.reset();
                layer.alert('请填写所有字段', function ()
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
