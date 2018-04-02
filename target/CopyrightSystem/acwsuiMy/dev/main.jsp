<%@page import="com.tyyd.framework.core.AcwsInfo"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<%@ include file="/acwsui/acws.doc.jsp"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<title><%=AcwsInfo.getAppName() %></title>
	<%@ include file="/common/myapp.jsp"%>
	<link rel="stylesheet" type="text/css" href="./acwsui/css/main.css" />
	<link rel="stylesheet" type="text/css" href="./css/home.css" />
	<style>
	#header{border:none;
	 background-repeat:no-repeat;
	 background-attachment:fixed;
	 }
	#divAppname{margin-left:210px;}
	.panel-icon{background-size: 16px 16px;}
	</style>
</head>
	
<body class="easyui-layout" data-options="fit:true,border:false" style="min-width:800px;overflow-x:auto;">
    <div id="header" data-options="region:'north',border:false"  style="padding-left:5px">
 		<div id="divAppname">
		<span id="appname"><%=AcwsInfo.getAppName()%></span><br>
		<span class="greetingtext"  style="padding-left:10px;font-weight:normal;">欢迎您,&nbsp;
			<a id="userName" href="javascript:toLogin()" >游客(请登录)</a>
			<input type="hidden" id="userId" ></input>
		</span>
		</div>
		
	    <div class="acws-menu mainMenu" style="display:none">
	        <a id="btnLogout" href="javascript:void(0)" class="easyui-linkbutton menuitem" style="display:none"
	        	data-options="size:'large',iconAlign:'top'" 
	        	iconCls='icon-menu-logout'
	        	onclick="logout()">退  出</a>
		</div>
		
	</div>
	<div id="left" data-options="region:'west',split:true,collapsible:false,iconCls:'icon-function',border:true,minWidth:120,maxWidth:300,width:120">
		<div id="subMenu" class="easyui-accordion" data-options="border:false,fit:true">
		</div>
	</div>
	<div id="divBottom" data-options="region:'south',border:false" class="toolbar" style="height:24px;text-align: center;display:none">
		 <div style="padding-top:5px;background-color:#F3F4F5">&copy;中国电信 天翼阅读文化传播有限公司 版权所有</div>
	</div>

	<div id="main" data-options="region:'center',border:true">
		<div id="panelMain" class="easyui-panel mainpanel" data-options="fit:true" style="display:none;overflow:hidden">
			<iframe id="mainFrame" scrolling="yes" frameborder="0" style="width:100%;height:100%;" src="about:blank"></iframe>
		</div>
		<div id="tabsMain" class="easyui-tabs mainpanel" data-options="fit:true,border:false,plain:true,tools:'#mainTabPanelTools'" style="overflow:hidden">
		</div>
		
	</div>
		
	</body>
<script type="text/javascript">
<%--首页初始化--%>
$(function(){
	//$("#left").panel("close",true);
	$("#divBottom").show();
	$("body").layout("resize", {
		width:"100%",
		height:"100%"
	});	

	Acws.ajax("./acws/dev/maininit.ajax",{}, function(out){
		var jqLogout = $("#btnLogout");
		$("#userName").html(out.userName);
		$("#userId").val(out.userId);
		if(out.userId && out.userId!=0){
			jqLogout.show();
		}
		loadMenus(out.menus);
	});
});


<%--添加一级菜单--%>
function addMainMenuItem(jq, p){
	jq.data("currentMenuId", "");
	p = p||{};
	if(!p.ID)return;
	var group = (p.child||[]).length>0;
       	
	var menuItem = $('<a  href="javascript:void(0)" class="easyui-linkbutton menuitem" iconCls="icon-menu">&nbsp;</a>');
	menuItem.html(p.NAME);
	var ap = {size:'large',iconAlign:'top'};
	if(group){
		$.extend(ap, {toggle:true,group:"mainMenu"});
	}
	if(p.selected){
		$.extend(ap, {selected:true});
	}
	if(p.ICON1){
		$.extend(ap, {iconCls:p.ICON1});
	}
	jq.before(menuItem);
	jq.before("<span class='menu-split'>&nbsp;</span>");
	menuItem.linkbutton(ap);
	menuItem.attr("id", p.ID);
	menuItem.off("click").on("click", function(){
		showSubmenu1(menuItem, p, jq);
		//选中第一个一级菜单的第一个二级菜单
		var firstSecondMenu = $("#left div#subMenu");
		firstSecondMenu.accordion("select", 0);
		//选中第一个一级菜单的第一个二级菜单的第一个三级菜单
		//var firstThridMenu = $("a.submenu:first",firstSecondMenu);
		//firstThridMenu.click();
	});
}

<%--添加二级菜单--%>
function showSubmenu1(menuItem, p, jq){
	if(!menuItem)return;
	menuItem.linkbutton("select");
	if(!p.child){
		return;
	}
	if(p.child.length==0){
		$("#left").panel("close",true);
		//showPage(menuItem, p, jq);
		return;
	}
	$("#left").panel("open",true);
	
	//当前已选中菜单单击后无反应
	var id = p.ID;
	if(jq.data("currentMenuId")==id){     
		return;
	}
	jq.data("currentMenuId",id);
	$("body").layout("resize", {
		width:"100%",
		height:"100%"
	});

	p.selected = p.selected || false;
	var subMenu1 = $("#subMenu");
	subMenu1.accordion("clear");
	
	<%--添加二级菜单项--%>
	$.each(p.child, function(i, item){
		showSubMenu1Item(item,id, p.URL);
	});

	subMenu1.accordion("select", 0);
}

<%--添加二级菜单--%>
function showSubMenu1Item(item, pid, url){
	if(!item || !pid) return;
	var menuId = 'menu'+pid+'_'+item.ID;
	var subMenu1 = $("#subMenu");
	try{
	subMenu1.accordion("add", {
		title: item.NAME,
		border:false,
		content: "",
		collapsible:true,
		selected: true,
		iconCls:item.ICON1||'icon-menu-32'
	});
	}catch(e){alert(e.message)}

	var pc=subMenu1.accordion("panels").length;
	var panel=subMenu1.accordion("getPanel", pc-1);
	var panelBody = panel.panel("body");
	panelBody.css("textAlign","center");
	panelBody.show();

	<%--添加三级菜单--%>
	var hasSelected = false;
	$.each(item.child, function(i, sitem){
		var type = sitem.type||"button";
		if(type=="button"){
			//仅选择第一个selected为true的菜单
			addPageButton(sitem, panelBody, false);
		} else if(type=="tree"){
			addPageTree(sitem);
		} else {
			_alert("不支持的菜单类型："+type);
		}
	});
}

<%--添加按钮形式菜单--%>
function addPageButton(item, jqDiv,selected){
	var menuId = 'menu_'+item.PID+'_'+item.ID;
	var menuItem = $('<a class="easyui-linkbutton submenu" iconCls="'+(item.ICON1||"icon-menu-32")+'" id='+menuId+'></a>');
	menuItem.html(item.NAME);
	menuItem.attr("id", menuId);
	var mp={toggle:true,group:item.PID,size:'large',iconAlign:'top',selected:selected};
	menuItem.linkbutton(mp);
	menuItem.off("click").on("click",function(){
		addPage(item,true);
		menuItem.linkbutton("select");
	});
	jqDiv.append(menuItem);

	if(selected){
		addPage(item,true);
	}
}

<%--
打开Tab：没有打开时添加新的Tab、已经打开时、激活该Tab
--%>
function addPage(item,closeable){
	var id=item.ID;
	var url="./acws/default/to.do?id="+item.RID;
	var title=item.NAME;
	var type=item.type;
	if(type=="panel"){
		$("#panelMain").show();
		$("#tabsMain").hide();
		var jqFrame=$("#panelMain #mainFrame");
		jqFrame.attr("src","about:blank");
		if($.browser.webkit || $.browser.mozilla){
			try{jqFrame[0].document.write('');}catch(e){}; 
			try{jqFrame[0].document.clear(); }catch(e){};
			//以上可以清除大部分的内存和文档节点记录数了 
		}
		addPanelPage(id, url,title);
	} else {
		$("#panelMain").hide();
		$("#tabsMain").show();
		addTabsPage(url,title,closeable);
	}
}

<%--添加单个页面--%>
function addPanelPage(url,title,closeable){

}

<%--添加Tabpanel页面--%>
var timeClickStart = {};
function addTabsPage(url,title,closeable){
	var id = url;
	if(url == '' || title == '') return ;
	closeable = typeof(closeable)=='undefined'?true:closeable;
	var isExists = false;
	var tabs=$("#tabsMain").tabs('tabs');
	$.each(tabs, function(){
		var tabId = $("iframe",this).prop("id");
		if(tabId == id){
			isExists = true;
			var index = $("#tabsMain").tabs("getTabIndex",$(this));
			$("#tabsMain").tabs("select", index);
			try{
				if(!timeClickStart[tabId] || (new Date().getTime() - timeClickStart[tabId].getTime()>1000)){
					$("iframe",this)[0].contentWindow.location.reload();
				}
				timeClickStart[tabId] = new Date();
			}catch(e){}
			return false;
        }
    });
    if(isExists)return;
    var $context =$('<iframe scrolling="auto" frameborder="0" style="width:100%;height:100%;" onreadystatechange="maskInIE(this);" onload="maskInFF(this);"></iframe>');
    $context.prop("src", url);
    $context.prop("id", id);
	var objTab = $('#tabsMain').tabs('add',{
		title:title,
		content:$context,
		closable:closeable,
		id:id
	});
}

function toLogin(){
	var userId = $("#userId").val();
	if(userId && userId!=0){
		return true;
	}
	location.replace("./acwsui/login.jsp");
}
//退出
function logout(){
	 _confirm("您确定要退出系统吗？",function(r){
		 if(!r)return;
		 Acws.ajax("./acws/default/logout.ajax", {},function(res){
         		if(res.success){
         			 window.location.href = "./acwsui/default/login.jsp";
         		}else{
         			_alert("登出登陆失败!");
         		}				 
		});
	 });
 }

function loadMenus(menus){
	menus=menus||[];
	var len=menus.length;
	var jqLogout = $("#btnLogout");
	$.each(menus, function(i, item){
		try{addMainMenuItem(jqLogout, item);}catch(e){alert(e.message)}
	});
	
	<%--显示主菜单、防止菜单在初始显示时出现从a到linkbutton的变化过程--%>
	var jqMainMenu = $(".acws-menu");
	jqMainMenu.show();

	//选中第一个一级菜单
	var firstTopMenu = $(".acws-menu .menuitem:first");
	if(firstTopMenu && firstTopMenu.length>0 && firstTopMenu[0].ID!='btnLogout'){
		firstTopMenu.click();
	}

}
</script>
</body>
</html>
