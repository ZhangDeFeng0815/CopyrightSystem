<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>研发人员后台管理</title>
	<style>
	.ext_item{padding:5px;width:150px;margin:5px;background-size:cover;}
	.ext_item .l-btn-icon {background-size:cover;}
	.icon-res{
		background:url('./acwsui/img/trans/documents_to_go1.png') no-repeat center center;
	}
	.icon-menu{
		background:url('./acwsui/img/trans/froyodots2_0.png') no-repeat center center;
	}
	.icon-pool{
		background:url('./acwsui/img/trans/keifficon_huddlehub.png') no-repeat center center;
	}
	.icon-task{
		background:url('./acwsui/img/trans/keifficon_dialer.png') no-repeat center center;
	}
	</style>
	<script>
	function onButtonClick(type){
		var url="";
		var title="";
		if(type==3){
			title="线程池管理";
			url="./acwsui/thread/threadpool.jsp";
		}else if(type==4){
			title="任务管理";
			url="./acwsui/thread/threadtask.jsp";
		} else {
			_alert("建设中");
			return;
		}
		top.addPage(url,title,true);	
	}
	
	</script>
</head>
	
<body>
	<div style="margin:auto auto;padding:50px;10px;10px;50px;">
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-res',size:'large'" onclick="onButtonClick(1)">资源管理</a><span>配置菜单用的资源</span><br>
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-menu',size:'large'" onclick="onButtonClick(2)">菜单管理</a><span>配置菜单</span><br>
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-pool',size:'large'" onclick="onButtonClick(3)">线程池管理</a><span>配置线程池</span><br>
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-task',size:'large'" onclick="onButtonClick(4)">任务管理</a><span>配置任务</span><br>
	</div>
</body>
</html>