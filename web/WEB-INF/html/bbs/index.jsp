<%--
  zzw_bbs
  index
  User: 竺志伟
  Date: 2018-09-06 10:30
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<jsp:include page="/WEB-INF/html/inc/bbs/head.jsp"/>
<body>
<div class="fly-header layui-bg-black">
    <div class="layui-container">
        <a class="fly-logo" style="margin-left: -10px;" href="/">
            <img src="/design/bbs/images/logo.png" alt="重大昆明社区">
        </a>
        <ul class="layui-nav fly-nav layui-hide-xs">
            <li class="layui-nav-item layui-this">
                <a href="/"><i class="iconfont icon-jiaoliu"></i>交流</a>
            </li>
        </ul>

        <ul class="layui-nav fly-nav-user">

            <!-- 未登入的状态 -->
            <li class="layui-nav-item">
                <a class="iconfont icon-touxiang layui-hide-xs" href="user/login.html"></a>
            </li>
            <li class="layui-nav-item">
                <a href="/">登入</a>
            </li>
            <li class="layui-nav-item">
                <a href="/">注册</a>
            </li>


            <!-- 登入后的状态 -->

            <!--
            <li class="layui-nav-item">
              <a class="fly-nav-avatar" href="javascript:;">
                <cite class="layui-hide-xs">贤心</cite>
                <i class="iconfont icon-renzheng layui-hide-xs" title="认证信息：layui 作者"></i>
                <i class="layui-badge fly-badge-vip layui-hide-xs">VIP3</i>
                <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg">
              </a>
              <dl class="layui-nav-child">
                <dd><a href="user/set.html"><i class="layui-icon">&#xe620;</i>基本设置</a></dd>
                <dd><a href="user/message.html"><i class="iconfont icon-tongzhi" style="top: 4px;"></i>我的消息</a></dd>
                <dd><a href="user/home.html"><i class="layui-icon" style="margin-left: 2px; font-size: 22px;">&#xe68e;</i>我的主页</a></dd>
                <hr style="margin: 5px 0;">
                <dd><a href="/user/logout/" style="text-align: center;">退出</a></dd>
              </dl>
            </li>
            -->
        </ul>
    </div>
</div>

<div class="fly-panel fly-column">
    <div class="layui-container">
        <ul class="layui-clear">
            <%--<li class="layui-hide-xs layui-this"><a href="/">首页</a></li>--%>
            <%--<li><a href="jie/index.html">提问</a></li>--%>
            <%--<li><a href="jie/index.html">分享<span class="layui-badge-dot"></span></a></li>--%>
            <%--<li><a href="jie/index.html">讨论</a></li>--%>
            <%--<li><a href="jie/index.html">建议</a></li>--%>
            <%--<li><a href="jie/index.html">公告</a></li>--%>
            <%--<li><a href="jie/index.html">动态</a></li>--%>
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"
                style="margin-left: 65%"><span class="fly-mid"></span></li>

            <!-- 用户登入后显示 -->
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="user/index.html">我发表的贴</a></li>
            <li class="layui-hide-xs layui-hide-sm layui-show-md-inline-block"><a href="user/index.html#collection">我收藏的贴</a>
            </li>
        </ul>

        <div class="fly-column-right layui-hide-xs">
            <a href="jie/add.html" class="layui-btn">发表新帖</a>
        </div>
    </div>
</div>

<div class="layui-container">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="fly-panel" style="margin-bottom: 0;">
                <ul class="fly-list">

                    <li style="height: 120px;">
                        <a href="user/home.html" class="fly-avatar">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"
                                 alt="贤心">
                        </a>
                        <h2>
                            <a class="layui-badge">分享</a>
                            <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                        </h2>
                        <div class="fly-list-info">
                            <a href="user/home.html" link>
                                <cite>贤心</cite>
                                <!--
                                <i class="iconfont icon-renzheng" title="认证信息：XXX"></i>
                                <i class="layui-badge fly-badge-vip">VIP3</i>
                                -->
                            </a>
                            <span>刚刚</span>

                            <span class="fly-list-kiss layui-hide-xs" title="悬赏飞吻"><i
                                    class="iconfont icon-kiss"></i> 60</span>
                            <!--<span class="layui-badge fly-badge-accept layui-hide-xs">已结</span>-->
                            <span class="fly-list-nums">
                                <i class="iconfont icon-pinglun1" title="回答"></i> 66
                            </span>
                        </div>
                        <div class="fly-list-badge">
                            <!--<span class="layui-badge layui-bg-red">精帖</span>-->
                        </div>
                    </li>

                </ul>
            </div>
        </div>
        <div class="layui-col-md4">

            <div class="fly-panel fly-rank fly-rank-reply" id="LAY_replyRank">
                <h3 class="fly-panel-title">回贴周榜</h3>
                <dl>
                    <!--<i class="layui-icon fly-loading">&#xe63d;</i>-->
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                    <dd>
                        <a href="user/home.html">
                            <img src="https://tva1.sinaimg.cn/crop.0.0.118.118.180/5db11ff4gw1e77d3nqrv8j203b03cweg.jpg"><cite>贤心</cite><i>106次回答</i>
                        </a>
                    </dd>
                </dl>
            </div>

            <dl class="fly-panel fly-list-one">
                <dt class="fly-panel-title">本周热议</dt>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>
                <dd>
                    <a href="jie/detail.html">基于 layui 的极简社区页面模版</a>
                    <span><i class="iconfont icon-pinglun1"></i> 16</span>
                </dd>

                <!-- 无数据时 -->
                <!--
                <div class="fly-none">没有相关数据</div>
                -->
            </dl>

            <div class="fly-panel fly-link">
                <h3 class="fly-panel-title">友情链接</h3>
                <dl class="fly-panel-main">
                    <dd><a href="http://www.layui.com/" target="_blank">layui</a>
                    <dd>
                    <dd><a href="http://layim.layui.com/" target="_blank">WebIM</a>
                    <dd>
                    <dd><a href="http://layer.layui.com/" target="_blank">layer</a>
                    <dd>
                    <dd><a href="http://www.layui.com/laydate/" target="_blank">layDate</a>
                    <dd>
                </dl>
            </div>

        </div>
    </div>
</div>

<jsp:include page="/WEB-INF/html/inc/bbs/foot.jsp"/>


</body>
</html>
