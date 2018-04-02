<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>系统监控</title>
	<style>
	.ext_item{padding:5px;width:150px;margin:5px;background-size:cover;}
	.ext_item .l-btn-icon {background-size:cover;}
	.icon-inst{
		background:url('./acwsui/img/trans/scanlife1.png') no-repeat center center;
	}
	.icon-log{
		background:url('./acwsui/img/trans/tweet.png') no-repeat center center;
	}
	</style>
	<script>
	function onButtonClick(type){
		var url="";
		var title="";
		if(type==1){
			title="任务实例管理";
			url="./acwsui/thread/threadinst.jsp";
		}else if(type==2){
			title="任务执行日志";
			url="./acwsui/thread/threadlog.jsp";
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
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-inst',size:'large'" onclick="onButtonClick(1)">任务实例管理</a><span>监控任务实例</span><br>
        <a class="easyui-linkbutton ext_item" data-options="iconCls:'icon-log',size:'large'" onclick="onButtonClick(2)">任务执行日志</a><span>查看任务执行日志</span><br>
	</div>
</body>
</html>