<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>公司文化</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<link rel="stylesheet" type="text/css" href="./css/cpweb.css"/>
	<style>

.wrap {
    margin: 0 auto;
    width: 980px;
}
.clearfix {
    display: block;
}

.fl {
    float: left;
    _display: inline;
}

.index_aside {
    width: 400px;
    margin-left: -1px;
    border-left: 1px solid #dfdfdf;
}

.index_intro_box{ width: 980px; /*border-right: 1px solid #dfdfdf;*/}
.index_intro{ padding-top: 20px;}
.index_intro dl{ width: 900px; height: 100px; padding:0 14px 0 90px; margin: 0; float: left; _display: inline; _zoom:1;}
.index_intro dl dt{ height: 28px; line-height: 14px; font-size: 14px; color: #111; font-weight: bold;}
.index_intro dl dd{ }
.index_intro .title{color: #111;}
.index_intro .detail{ line-height: 22px; color: #b5b5b5;margin:0px}
.index_intro dl.icon_1{ background: url(images/64/logo-ty.png) no-repeat 0 0;}
.index_intro dl.icon_2{ background: url(images/64/logo-ts.png) no-repeat 0 0;}
.index_intro dl.icon_3{ background: url(images/64/logo-sw.png) no-repeat 0 0;}
.index_intro dl.icon_4{ background: url(images/64/Chart-icon.png) no-repeat 0 0;}


.index_intro_box .info_process dl{padding:36px 20px 0; }
	</style>
</head>

<body style="overflow-x:hidden;">
	<div class="easyui-panel" title="" fit=true>
	
	<div class="wrap info_detailBox clearfix">
		<div class="fl index_intro_box">
			<div class="clearfix index_intro">
				<dl class="icon_1">
					<dt>天翼阅读</dt>
					<dd class="detail">
						天翼阅读是一款面向用户提供数字化阅读服务的产品，覆盖android、ios、winphone、brew、wap、web等主流系统，以文字、图片、音频为主要介质载体，致力于为用户创造一个绿色、品质、正版的阅读环境。
						<a href="javascript:void(0)" onclick="top.showSubMenu(3, true,'menu3001')"><img src="./images/more.png"/></a>
					</dd>
				</dl><br>
				<dl class="icon_2">
					<dt>氧气听书</dt>
					<dd class="detail">
						氧气听书是一款面向用户提供听书服务的产品，拥有国内最大的正版有声书库，十万小时作品，二十个大类，全方位满足听书需求，并提供媲美CD音质的高保真收听体验。
						<a href="javascript:void(0)" onclick="top.showSubMenu(3, true,'menu3002')"><img src="./images/more.png"/></a>
					</dd>
				</dl><br>
				<dl class="icon_3">
					<dt>政企书屋</dt>
					<dd class="detail">
						政企书屋是一款面向政企客户，助力构建“学习型组织”的阅读产品。以提供专业化数字阅读为主，兼顾提供行业资讯、企业信息传播服务，致力于实现数字阅读服务与企业文化宣传的无缝结合。
						<a href="javascript:void(0)" onclick="top.showSubMenu(3, true,'menu3003')"><img src="./images/more.png"/></a>
					</dd>
				</dl>
				<dl  class="icon_4">
					<dt>合作流程<a class="link" onclick="top.showSubMenu(2, true,'menu2002')">在线申请</a></dt>
					<dd class="detail">
						<img src="./images/coflow3.png" />
					</dd>
				</dl>
			</div>
		</div>
		<!-- 
		<div class="fl index_aside">
			<div class="clearfix index_intro">
			<img src="./images/coflow2.png" />
			</div>
		</div>
		 -->
	</div>
</body>
</html>
