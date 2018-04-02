<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8" contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<title>文本框</title>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<script>
	//保存事件
	function onSaveClick(){
		if(Acws.valid("body")){
			var data = Acws.getJson("body");
			Acws.triggerDialogEvent("onSaveClick", data);
			Acws.closeDialog();
		}
	}
	</script>
</head>
<body>
	<div class="easyui-panel" data-options="iconCls: 'icon-edit',footer: '#dlg-buttons'" fit=true>
		<textarea data-field="context" style="height:98%;width:98%"></textarea>
	</div>
	
	<div id="dlg-buttons" class="buttons">
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-ok'" onclick="onSaveClick()">确定</a>
		<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
	</div>
</body>
</html>
