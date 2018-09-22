<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>UNI2K 信息价值的守护者</title>
</head>
<body>
<script language="javascript" type="text/javascript">
    var i = 5;
    var intervalid;
    intervalid = setInterval("fun()", 1000);

    function fun()
    {
        if (i == 0)
        {
            window.location.href = "/";
            clearInterval(intervalid);
        }
        document.getElementById("mes").innerHTML = i;
        i--;
    }
</script>
<div style="width: 400px;margin: 150px auto;">
    <div style="text-align: center">
        <img src="/design/webAdmin/images/404.png"/>
    </div>
    <div style="text-align: center;margin-top: 20px;color: #C1BDBD">
        访问的页面已经被删除,暂时不可用,请联系管理员<br/>
        页面将在<font color="red" id="mes">5</font>秒后返回首页
    </div>
    <div style="text-align: center;margin: 20px;">
        <a href="/"><img src="/design/webAdmin/images/ann.png"/></a>
    </div>
</div>
</body>
</html>