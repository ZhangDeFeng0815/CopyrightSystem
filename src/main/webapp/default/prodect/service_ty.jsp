<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>天翼阅读</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<link rel="stylesheet" type="text/css" href="./css/cpweb.css"/>
</head>

<body>
	<div class="easyui-panel ts" title="" fit=true>
        <div class="sliderNavContent left">
            <div class="tabView">
                <div class="views">
                    <div class="view currentView">
                        <div class="body sq">
                        <h2>
                            <table width="100%">
                                <tr>
                                    <td>
                                        <img src="<%=basePath%>images/logo1.png" alt=""/>
                                    </td>
                                    <td style="text-align:right;">
                                        <img src="<%=basePath%>images/logo1-qr.jpg" alt=""/>
                                    </td>
                                </tr>
                            </table>
                            
                            <p style="text-indent: 25px;">
                              天翼阅读是一款面向用户提供数字化阅读服务的产品，覆盖android、ios、winphone、brew、wap、web等主流系统，以文字、图片、音频为主要介质载体，致力于为用户创造一个绿色、品质、正版的阅读环境。
                            </p>
                            </h2>
                            <h3>
    产品特点
                            </h3>
                            <ul>
    <li>1.  一键式注册登录：省去输入账号、密码的麻烦，不用再为记住冗长的密码而烦恼。</li>
    <li>2.  云端自动同步：PC、手机、平板、TV、电纸书不同终端数据无缝对接，实现阅读的连惯性，再也不用担心不知道上次阅读到哪等类似的事情发生了。</li>
    <li>3.  个性化书架：随时随地记录阅读章节，自动生成书签，根据个人偏好构建独一无二的阅读空间。</li>
    <li>4.  离线阅读：支持下载书籍到本地阅读，避免无网络或网络慢时的烦恼，获得更流畅的阅读体验。</li>
    <li>5.  外部书籍导入：支持导入PC、手机等外部设备上的电子书，让阅读不再有任何限制。</li>
    <li>6.  智能阅读器：提供白天、晚上的阅读模式，能调整字体、行间距、背景颜色，让长时间看书眼睛不再疲劳，更好地保护眼睛。</li>
    <li>7.  给好友赠书：把喜欢的书赠送给好友，附上一段话，读书心得或者祝福话语，与好友一起分享阅读乐趣，也可以在节日作为礼物送给心中的她（他），搭起爱的桥梁。</li>
    </ul>
    <h3>
    产品优势
    </h3>
    <ul>
    <li>1.  多屏互动：覆盖电脑屏、手机屏、电视屏，三屏互动，完美切换，随心阅读。</li>
    <li>2.  海量书库：30万册正版图书任意选，12万小时高品质音频随意听，原创小说、出版图书一应俱全，杂志、漫画、报刊、资讯应有尽有。</li>
    <li>3.  边读边听：既有纯文字的原创小说，又有图文并茂的杂志漫画，还有音频的幽默笑话与评书相声，同一本书既可以阅读又能收听，看与听随时切换。</li>
    <li>4.  便捷支付：支持手机话费、手机充值卡、阅点、支付宝、翼支付等多种支付方式，只要轻轻一点即可完成支付，让买书更加简单。</li>
    </ul>
                        </div>
                    </div>
<!--  
                    <div class="view">
                        <h3>
                            iOS版介绍
                        </h3>
                        <div class="body">
                            <table width="100%">
                                <tr>
                                    <td width="92">
                                        <img src="http://cdn.image.market.hiapk.com/data/upload/2013/10_08/23/201310082317090181.png" alt=""/>
                                    </td>
                                    <td width="170">
                                        <b>天翼阅读</b>
                                        <p>大ss小：6.6MB 	             </p>
                                        <p>
                                            更新时间：2014-03-19
                                        </p>
                                    </td>
                                    <td class="version_os">
                                        <p>版本：3.0.1</p>
                                        <p>
                                            系统要求：Android2.1及以上
                                        </p>
                                    </td>
                                </tr>
                            </table>
                            <p>
                                我们只为您看好书！我们只为您好找书！我们只为您舒心的读书！天翼阅是读汇聚小说、杂志、漫画为一体的数字图书馆，支持全主流阅读格式。更有强大的云书架，永久珍藏你读过的经典。【产品特点】1.  流畅舒适的仿真翻页效果,快速导入本地图书；2.  支持在线阅读,下载阅读,连载更新,切换字体,切换背景等功能;3.  书架分类管理,阅读界面划词,复制,高亮,笔记,分享,赠书等;4.  玄幻,修…...
                            </p>
                            <h3>
                                产品优势
                            </h3>
                            <p>
                                我们只为您看好书！我们只为您好找书！我们只为您舒心的读书！天翼阅是读汇聚小说、杂志、漫画为一体的数字图书馆，支持全主流阅读格式。更有强大的云书架，永久珍藏你读过的经典。【产品特点】1.  流畅舒适的仿真翻页效果,快速导入本地图书；2.  支持在线阅读,下载阅读,连载更新,切换字体,切换背景等功能;3.  书架分类管理,阅读界面划词,复制,高亮,笔记,分享,赠书等;4.  玄幻,修…...
                            </p>
                        </div>
                    </div>
-->
                </div>
            </div>	
	</div>
</body>
</html>
