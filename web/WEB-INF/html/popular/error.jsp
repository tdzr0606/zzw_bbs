<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>UNI2K 信息价值的守护者</title>
</head>
<script language="javascript" type="text/javascript">
    var i = 5;
    var intervalid;
    intervalid = setInterval("fun()", 1000);

    function fun()
    {
        if (i == 0)
        {
            window.location.href = "/webAdmin";
            clearInterval(intervalid);
        }
        document.getElementById("mes").innerHTML = i;
        i--;
    }
</script>
<body>

<div style="width: 400px;margin: 120px auto;">
    <div style="text-align: center">
        <img src="/design/webAdmin/images/105.png" />
    </div>
    <div style="text-align: center;margin-top: 20px;color: #C1BDBD">
        登录超时或者未登录,请重新登录<br/>
        页面将在<font color="red" id="mes">5</font>秒后返回首页
    </div>
    <div style="text-align: center;margin: 20px;">
        <a href="/webAdmin"><img src="/design/webAdmin/images/ann.png"/></a>
    </div>
</div>
</body>
</html>