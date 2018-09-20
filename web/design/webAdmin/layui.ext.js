/**
 *
 * zzw_bbs
 * layui.ext
 * Author: 竺志伟
 * Date:   2018-09-19 13:22
 */

function showImage(imgUrl, title)
{
    layer.open({
        type: 1
        , title: title
        , area: ['400px', '300px']
        , id: 'showImgWin2' //防止重复弹出
        , content:
            '<div style="padding: 20px 30px;text-align: center" title="暂无图片"><img src="' + imgUrl +
            '" /></div>'
        , shade: 0.2 //显示遮罩
    });
}