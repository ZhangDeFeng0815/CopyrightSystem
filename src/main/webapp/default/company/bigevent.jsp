<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>公司大事记</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<link rel="stylesheet" type="text/css" href="./css/cpweb.css"/>
	<style>
	.msgBox,.msgBox_2 {
		border-color: #b4daf4;
		border-width: 0 0 1px 5px;
		border-style: solid;
		width: 615px;
		padding: 20px;
	}
	
	.msgBox .imgBox {
		width: 185px;
		height: 100px;
		background: #eaeaea;
		border: 5px solid #fff;
	}
	
	.msgBox .msg {
		width: 405px;
		margin-left: 15px;
		line-height: 25px;;
	}
	
	.msgBox_2 .msg {
		width: 605px;
		margin-left: 0;
		line-height: 30px;
	}
	
	.msgBox .msg .title,.msgBox_2 .msg .title {
		margin-bottom: 10px;
		font-weight: 700;
		color: #1a73b5;
		font-size: 14px;
	}
	
	.date {
		width: 80px;
		position: relative;
		padding-top: 27px;
		color: #1a73b5;
	}
	
	.date .tag {
		width: 10px;
		height: 10px;
		display: block;
		position: absolute;
		right: -7px;
		top: 30px;
		background: #2589cf;
		border-radius: 10px;;
	}
	
	li {
		display: inline;
	}
	
	.ft {
		margin-top: 30px;
		clear: both;
	}
	
	.ft a {
		display: block;
		float: left;
		width: 24%;
		text-align: center;
		height: 25px;
		line-height: 25px;
	}
	
	.ft .normalBtn {
		width: 50px;
		margin: 0 40px;
	}
	
	.nav {
		border-bottom: none;
	}
	
	.clearfix{zoom:1}
.clearfix:after{content:"";display:block;height:0;clear:both;visibility:hidden}
.left{float:left}
.right{float:right}
.clear{clear:both}
.hide{display:none}
.show{display:block}
</style>
</head>

<body style="overflow-x:hidden;">
	<div class="easyui-panel ts" title="" fit=true>
	<div class="views">
	<div class="main">
        <div class="container clearfix">
        <div class="sliderNavContent left">
        <div class="sq">
        <h2>
        <strong>公司大事记</strong>
        </h2>
        <ul class="clearfix">
        <li class="clearfix">
        <span class="date left">
        2010.5.26
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <%--<div class="imgBox left">--%>
        <%--<img src="" alt=""/>--%>
        <%--</div>--%>
        <div class="msg left">
        <%--<p class="title">--%>
        <%--中国电信正式发文成立中国电信阅读中心--%>
        <%--</p>--%>
        <p>
        中国电信正式发文成立中国电信阅读中心 </p>
        </div>
        </div>
        </li>
        <li class="clearfix">
        <span class="date left">
        2010.7.27
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        中国电信作为首个通信运营商与国家新闻出版总署签订战略合作备忘录，国家新闻出版总署署长柳斌杰和中国电信王晓初董事长作为两方代表进行了签字 </p>
        </div>
        </div>
        </li>

        <li class="clearfix">
        <span class="date left">
        2010.9.8
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读产品在杭州正式发布</p>
        </div>
        </div>
        </li>

        <li class="clearfix">
        <span class="date left">
        2011.8.22
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读有声版在北京发布</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2011.8.31
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读参展“2011年北京国际图书博览会”，时任中央政治局常委李长春视察天翼阅读站台</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2012.8.7
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读文化传播有限公司注册成立</p>
        </div>
        </div>
        </li>



        <li class="clearfix">
        <span class="date left">
        2012.11.22
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读文化传播有限公司正式揭牌，启动腾飞计划</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2013.1.14
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读获得新浪微博“年度影响力企业”殊荣，是数字阅读行业唯一一家获得此荣誉的企业</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2013.7.10
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读获第五届中国数字出版博览会创新奖</p>
        </div>
        </div>
        </li>

        <li class="clearfix">
        <span class="date left">
        2013.8.28
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读有声版发布新品牌“氧气听书”</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2013.9.2
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读政企书屋业务正式接入中国农业银行杭州解放路支行，实现了零的突破，填补了政企集团市场的产品空白</p>
        </div>
        </div>
        </li>


        <li class="clearfix">
        <span class="date left">
        2013.12.20
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        天翼阅读文化传播有限公司荣获第三届中国出版政府奖先进出版单位奖，此奖项是我国出版业最高奖项</p>
        </div>
        </div>
        </li>

        <li class="clearfix">
        <span class="date left">
        2014.1.10
        <span class="tag"></span>
        </span>
        <div class="msgBox_2 clearfix left">
        <div class="msg left">
        <p>

        氧气听书获得“首届中国创意工业创新奖”评选活动“新产品奖金奖”</p>
        </div>
        </div>
        </li>
        </ul>
        </div>
        </div>
        </div>
        </div>
	</div>
</body>
</html>
