<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>天翼文化合作伙伴门户</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<link rel="stylesheet" type="text/css" href="./css/cpweb.css"/>
	<style>
		#header{background-color:#3E8CE4;padding:0px 0px 0px 50px;
			height:60px;overflow:hidden;
			background: #fff url(./images/header_bg.png) repeat-x center top;
    		font-size:28px;color:#000;font-family: 微软雅黑;}
		#header #logo{float: left; margin: 8px 0;}

		.greetingtext{font-size: 13px;float:left;padding:10px 20px 0px 10px}

		.mainMenu{float:right;width:auto;height:60px;line-height:60px;
			padding-right:10px;display:none;margin-top:5px}

		#left .easyui-linkbutton{margin:10px auto;width:80px}
		
		.acws-menu{
			RIGHT: 10px; POSITION: absolute; TOP: 0px
		}
		.acws-menu .menuitem{
		  border: none!important;
		  width:50px;height:50px;line-height:50px;border:none;
		  margin:5px 0px;
		  background-image:none;/*url(./images/ba.png)!important*/;
		  filter:none;
		  background-color:transparent;
		  padding:0 0 0 0;
		  margin:0 0 0 0;
		  display:none;
		}
		.acws-menu .l-btn-icon{
			top:0px;
			left:10px;
		}
		.acws-menu .menu-split{
			width: 2px;
			height: 80%;
			display: inline-flex;
			background:url(./images/menu_split.gif) no-repeat center ;
			filter:"progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod='scale')";
			background-size: 100% 100%;
			-webkit-background-size: 100% 100%;
			font-size:1px;overflow:hidden;cursor:default;margin:0 2px 0;border:0;
		}
		.acws-menu .menuitem:hover,.acws-menu .l-btn-selected {
		  background-image:none/*url(./images/bb.png)!important*/;
		}
				
		.acws-menu .menuitem span.l-btn-left {
		  background-position: 0 0;
		  padding: 0px 0px 0px 0px;
		  line-height: 16px;
		  height: 50px;
		  width:50px;
		}
		.acws-menu .menuitem span.l-btn-left span.l-btn-text {
			height:48px;
			width:48px;
		  	margin: 0;
		  	text-align: center;
		  	padding:1px;
		}		
		.acws-menu .menuitem span.l-btn-left span.l-btn-text .l-btn-icon{
			width:32px;
			height:32px;
			margin: 0 auto;
		}
		
		.acws-menu .menuitem span.l-btn-left span.l-btn-text .l-btn-label{
			width:100%;
			height:16px;
			position: absolute;
			top: 28px;
			left: 0px;
		}
		
		.acws-menu .menuitem span.l-btn-left span.l-btn-text .l-btn-status{
			display:none;
			height:2px;
			background-color:red;
			width:100%;
			position: absolute;
			top: 48px;
			left: 0px;
		}
		
		.acws-menu a:hover span.l-btn-left span.l-btn-text .l-btn-status,
		.acws-menu a.l-btn-selected span.l-btn-left span.l-btn-text .l-btn-status{
			display:block;
		}
		
		.acws-menu a.l-btn-selected, .acws-menu a:hover.l-btn-selected,
		.acws-menu a.l-btn, .acws-menu a.l-btn:hover,
		.acws-menu a:hover.l-btn-selected{
		 background-position: 0 0; 
		}
		
		.acws-menu .l-btn-left{
			position: relative;
			vertical-align: top;
			background-image:none!important;
		}
		.acws-menu .l-btn-selected .l-btn-text{color:#f00!important;}

		.acws-menu .menuitem:hover .l-btn-text{color:red}
		
		.icon-ty{
			background:url('./images/32/logo_ty.png') no-repeat center center;
		}
		.icon-ts{
			background:url('./images/32/logo_ts.png') no-repeat center center;
		}
		.icon-sw{
			background:url('./images/32/logo_sw.png') no-repeat center center;
		}
		
		.icon-yejs{
			background:url('./images/32/db_appdrawer.png') no-repeat center center;
		}
		.icon-yesq{
			background:url('./images/32/xiialive_0.png') no-repeat center center;
		}
		.icon-flsm{
			background:url('./images/32/keifficon_libra.png') no-repeat center center;
		}
		.icon-hzhb{
			background:url('./images/32/myspace_logo_2.png') no-repeat center center;
		}
		.icon-gsjs{
			background:url('./images/32/company.png') no-repeat center center;
		}
		.icon-gswh{
			background:url('./images/32/wow2.png') no-repeat center center;
		}
		.icon-gsdjs{
			background:url('./images/32/stocks_0.png') no-repeat center center;
		}
		.icon-lxwm{
			background:url('./images/32/froyophone2_1.png') no-repeat center center;
		}
		
		.icon-menu-home{
			background:url('./images/32/home.png') no-repeat center center;}
		.icon-menu-coopration{
			background:url('./images/32/hand.png') no-repeat center center;}
		.icon-menu-company{
			background:url('./images/32/company.png') no-repeat center center;}
		.icon-menu-lianxi{
			background:url('./images/32/froyophone2_1.png') no-repeat center center;}
		.icon-menu-cpplatform{
			background:url('./images/32/hi_im_logo_2.png') no-repeat center center;}		
			
		#left .submenu{display:none}
		
	</style>
</head>

<body class="easyui-layout" data-options="fit:true,border:false">
    <div id="header" data-options="region:'north',border:false">
    	<img id="logo" alt="合作伙伴门户" src="./images/logo-dxty.png"/>
		<span style="line-height: 60px;vertical-align: middle;padding-left:10px">合作伙伴门户</span>
	    
		<div class="acws-menu mainMenu">
			<span class="greetingtext">您好！请<a class="link" onclick="onLoginClick()">登陆</a>或<a class="link" onclick="onRegistClick()">注册</a></span>
	        <a id="menu1" href="javascript:void(0)" class="easyui-linkbutton menuitem" 
	        	data-options="toggle:true,group:'mainMenu'" 
	        	onclick="showSubMenu(1,false)">
	        	<div class="l-btn-icon icon-menu-home">&nbsp;</div>
	        	<span class="l-btn-label">首页</span>
	        	<span class="l-btn-status">&nbsp;</span>
	        </a>
	        <a id="menu2" href="javascript:void(0)" class="easyui-linkbutton menuitem" 
	        	data-options="toggle:true,group:'mainMenu'" 
	        	onclick="showSubMenu(2,true)">
	        	<div class="l-btn-icon icon-menu-coopration">&nbsp;</div>
	        	<span class="l-btn-label">业务合作</span>
	        	<span class="l-btn-status">&nbsp;</span>
	        </a>
	        <span class="menu-split">&nbsp;</span>
	        <a id="menu3"  href="javascript:void(0)" class="easyui-linkbutton menuitem" 
	        	data-options="toggle:true,group:'mainMenu'" 
	        	onclick="showSubMenu(3,true)">
	        	<div class="l-btn-icon icon-menu-cpplatform">&nbsp;</div>
	        	<span class="l-btn-label">产品服务</span>
	        	<span class="l-btn-status">&nbsp;</span>
	        </a>
	        <span class="menu-split">&nbsp;</span>
	        <a id="menu4"  href="javascript:void(0)" class="easyui-linkbutton menuitem" 
	        	data-options="toggle:true,group:'mainMenu'" 
	        	onclick="showSubMenu(4, true)">
	        	<div class="l-btn-icon icon-menu-company">&nbsp;</div>
	        	<span class="l-btn-label">公司介绍</span>
	        	<span class="l-btn-status">&nbsp;</span>
	        </a>
	        <span class="menu-split">&nbsp;</span>
	        <a  id="menu5"  href="javascript:void(0)" class="easyui-linkbutton menuitem" 
	        	data-options="toggle:true,group:'mainMenu'" 
	        	onclick="showSubMenu(5,true)">
	        	<div class="l-btn-icon icon-menu-lianxi">&nbsp;</div>
	        	<span class="l-btn-label">联系我们</span>
	        	<span class="l-btn-status">&nbsp;</span>
	        </a>
		</div>
	</div>
	
	<div id="left" style="width:120px;text-align:center;" title="功能菜单"
		data-options="region:'west',split:false,collapsible:false,iconCls:'icon-home',border:true">
	    <a id="menu1001"  href="javascript:void(0)" iconCls='icon-home' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g1',size:'large',iconAlign:'top',selected:true" 
	    	data-url='./default/home.jsp'
	    	onclick="showPage(this)">业务介绍</a>
	    <a id="menu2001"  href="javascript:void(0)" iconCls='icon-yejs' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g1',size:'large',iconAlign:'top',selected:true" 
	    	data-url='./default/cooperation/introduce.jsp'
	    	onclick="showPage(this)">业务介绍</a>
	    <a id="menu2002"  href="javascript:void(0)" iconCls='icon-yesq' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g1',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/reward/reward.jsp"
	    	onclick="showPage(this)">业务申请</a>
	    <a id="menu2003"  href="javascript:void(0)" iconCls='icon-flsm' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g1',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/cooperation/law.jsp"
	    	onclick="showPage(this)">法律申明</a>
	    <a id="menu2004"  href="javascript:void(0)" iconCls='icon-hzhb' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g1',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/cooperation/partner.jsp"
	    	onclick="showPage(this)">合作伙伴</a>
        <a id="menu3001"  href="javascript:void(0)" iconCls='icon-ty' 
        	class="easyui-linkbutton submenu" 
        	data-options="toggle:true,group:'g2',size:'large',iconAlign:'top',selected:true"
        	data-url="./default/prodect/service_ty.jsp"
        	onclick="showPage(this)">天翼阅读</a>
        <a id="menu3002"  href="javascript:void(0)" iconCls='icon-ts' 
        	class="easyui-linkbutton submenu" 
        	data-options="toggle:true,group:'g2',size:'large',iconAlign:'top'" 
        	data-url="./default/prodect/service_ts.jsp"
        	onclick="showPage(this)">氧气听书</a>
        <a id="menu3003"  href="javascript:void(0)" iconCls='icon-sw' 
        	class="easyui-linkbutton submenu" 
        	data-options="toggle:true,group:'g2',size:'large',iconAlign:'top'" 
        	data-url="./default/prodect/service_sw.jsp"
        	onclick="showPage(this)">政企书屋</a>

	    <a id="menu4001" href="javascript:void(0)"  iconCls='icon-gsjs' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g3',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/company/introduce.jsp"
	    	onclick="showPage(this)">公司简介</a>
	    <a id="menu4002" href="javascript:void(0)"  iconCls='icon-gswh' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g3',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/company/culture.jsp"
	    	onclick="showPage(this)">公司文化</a>
	    <a id="menu4003" href="javascript:void(0)"  iconCls='icon-gsdjs' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g3',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/company/bigevent.jsp"
	    	onclick="showPage(this)">公司大记事</a>
	    <a id="menu5001" href="javascript:void(0)"  iconCls='icon-lxwm' 
	    	class="easyui-linkbutton submenu" 
	    	data-options="toggle:true,group:'g3',size:'large',iconAlign:'top',selected:true" 
	    	data-url="./default/company/contact_us.jsp"
	    	onclick="showPage(this)">联系我们</a>
	</div>

	<div id="main" data-options="region:'center'" style="overflow:hidden;" title="">
		<iframe id="mainFrame" scrolling="no" frameborder="0" border="0" style="width:100%;height:100%;" 
			onreadystatechange="maskInIE(this);" onload="maskInFF(this);"
			src="./home/home.jsp"></iframe>
	</div>
	
	<div data-options="region:'south',border:false" style="height:24px;text-align: center;">
		 <div style="padding-top:5px;">&copy; 中国电信 天翼阅读文化传播有限公司 版权所有</div>
	</div>
	
	<script>
	<%--首页初始化--%>
	$(function(){
		//初始化后再显示、防止因网络慢而导致显示样式错乱
		$(".mainMenu").show();
		$("#menu1").show();
		$("#menu2").show();
		$("#menu3").show();
		$("#menu4").show();
		$("#menu5").show();
		
		showSubMenu(1, false);
	});

	//注册按钮事件
	function onRegistClick(){
		showSubMenu(2, true,"menu2002");
	}

	//登陆按钮事件
	function onLoginClick(){
		location.replace("./default/login.jsp");
	}
	
	<%--组件点击事件--%>
	var curUrl="";
	function showPage(el, showTitle){
		if(typeof(showTitle)=="undefined")showTitle=true;
		if(el && $(el).hasClass("l-btn-selected") && curUrl == $(el).data("url")){
			return;
		}

		var opts = $('#left').panel('options')||{};
		var firstMenu = opts.title;
		var scendMenu = $(".l-btn-text",el).html();
		if(showTitle){
			$("#main").panel({title:"当前位置:"+firstMenu + ">" + scendMenu});
		} else {
			$("#main").panel({title:""});
		}
		$("body").layout("resize");
		
		Acws.mask("#main");
		var jqFrame=$("#mainFrame");
		jqFrame.attr("src","about:blank");
		if($.browser.webkit || $.browser.mozilla){
			try{jqFrame[0].document.write('');}catch(e){}; 
			try{jqFrame[0].document.clear(); }catch(e){};
			//以上可以清除大部分的内存和文档节点记录数了 
		}
				
		curUrl = $(el).data("url");
		jqFrame.attr("src",curUrl);
	}

	function showSubMenu(id, havSubMenu,subMenuId){
		var jqFirstMenu = $("#menu"+id);
		if(jqFirstMenu.length==0 || jqFirstMenu.hasClass("l-btn-selected")){
			return;
		}
		
		var el= jqFirstMenu[0];
		jqFirstMenu.linkbutton("select")

		curUrl="";
		if(havSubMenu){
			$('body').layout("show","west");   
		}else{
			$('body').layout("hidden","west");   
		}

		$("body").layout('panel', 'west').panel({ title: $(".l-btn-label",el).html() });

		$("#left a").hide();

		subMenuId=subMenuId||("menu"+id+"001");
		$("#left a[id^=menu"+id+"]").css("display", "block");
	

		var subMenu = $("#left a[id^="+subMenuId+"]");
		
		subMenu.linkbutton('select');
		if(subMenu.length>0){
			showPage(subMenu[0], havSubMenu);
		}
	}

	function maskInIE(_frame){ 
		if (_frame.readyState=="complete"){
			Acws.unmask("#main");
	  	}
	}
	function maskInFF(_frame){
		Acws.unmask("#main");
	}

	function clearIframe(jqFrame){
	}
		
	</script>
</body>
</html>
