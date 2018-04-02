<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产批量新增</title>
	<style>
		#memo20150723{margin:20px;}
		#memo20150723 span{
			color:red;
			font-size:14px;
			margin: 10px 0px 0px 0px;
			
		}
	</style>
</head>
<body>
<div class="easyui-panel" data-options="iconCls: 'icon-save',footer: '#dlg-buttons',border:false" fit=true>
	<div style="margin-top:20px;height:60px;text-align: center;">
		<a id="btnImport" class="acws-excel" style="padding:10px;width:200px"	data-options="iconCls:'icon-excel',service:'$assetImport',customerr:false,pluploader:{max_file_size:'5mb'}">点击上传版权资产列表</a>
		<a class="acws-download"  style="padding:10px;width:200px" data-options="iconCls:'icon-download',service:'$assetImport',filename:'新增资产列表.xlsx'" >下载导入模板</a>
	</div>
	<div id="memo20150723">
			<span style="width:480px;font-size:20px;color:#000">注意事项:</span><br><br>
   			<span>1.该功能只能用于新增资产、不能对资产进行修改；</span><br>
   			<span>2.导出文件仅限excel*.xlsx格式；</span><br>
   			<span>3.单个文件仅限5M大小；</span><br>
	</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="onCancleClick()">关闭</a>
</div>
<script>
function onCancleClick(){
    Acws.triggerDialogEvent("onDialogClose", {});
    Acws.closeDialog();
}
</script>
</body>
</html>