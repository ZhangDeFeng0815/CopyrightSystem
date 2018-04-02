<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>导入收入</title>
	<style>
		#memo20150723{margin:95px 0 0 20px;}
		#memo20150723 span{
			color:red;
			font-size:14px;
			margin: 10px 0px 0px 0px;
			
		}
	</style>
</head>
<body>
<div class="easyui-panel" data-options="iconCls: 'icon-save',footer: '#dlg-buttons',border:false" fit=true>
	<div style="margin-top:20px;height:60px;text-align: center;" id="condition">
		合同编号<span class="bitian">*</span>：
		<input class="easyui-textbox" data-field="CONTRACT_CD" data-options="prompt:'合同编号'"  maxlength=20 valid="required" style="height:30px;line-height:30px;width:200px"></input><br><br>
		<a id="incAssetInport" class="easyui-linkbutton" data-options="iconCls:'icon-excel'" style="padding:10px;width:280px">点击导入资产收入</a><br><br>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-help'" style="padding:10px;width:280px" onclick="onHelpClick()">导入步骤说明&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
	
		<a class="acws-excel" id="incomeImport" style="padding:10px;width:200px;display:none" onClickBefore="onImportBefore()"
		data-options="iconCls:'icon-excel',service:'$assetIncomeImport',pluploader:{max_file_size:'5mb'},maxrow:10000">点击上传资产收入列表</a>
	</div>
	<div id="memo20150723">
		<span style="width:480px;font-size:20px;color:#000">导入说明:</span><br>
		<span>1.同一合同可以多次导入收入、系统会对每次导入的收入进行累加；</span><br>
		<span>2.各种收入的金额可以是正数、也可以是负数（用于修正前一次导入的多余收入）；</span><br>
		<span>3.导入文件仅限EXCEL（*.xlsx）格式；</span><br>
		<span>4.单个文件仅限5M大小；</span><br>
	</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>

	$(function() {
		$('#incAssetInport').on('click', function(){
			onIncomeImportClick();
		});
	});

	//弹出窗口初始化事件
	function onAcwsDialogInit(params) {
		$A("CONTRACT_CD").focus();
		$("#incomeImport").off("onClickBefore").on("onClickBefore",
				function onImportBefore() {
					//此处可以取得参数、校验参数、校验失败返回false、校验成功返回json
					//可以参照excel下载的demo
					return {
						CONTRACT_CD : $A("CONTRACT_CD").getAcwsValue()
					};
				});
	}

	function onIncomeImportClick() {
		if (!Acws.valid("#condition"))
			return;
		var inputData = Acws.getJson("#condition");
		var success = false;
		Acws.ajax("./value/outContractCdExistsChk.ajax", inputData, function(
				outputData) {
			if (outputData.success) {
				success = outputData.success;
			} else {
				_alert("合同编号有效性校验失败，请确认合同编号是否有效。");
				$A("CONTRACT_CD").focus();
				return;
			}
		},{async:false});
	    if (success) {
	    	$("#incomeImport").click();
		}
	}

	//导出权利
	function onHelpClick() {
		Acws.showDialog({
			url : './value/importIncomeHelp.jsp',
			title : '帮助',
			width : 600,
			height : 400,
			modal : true,
			iconCls : 'icon-help',
			dialogParams : {}
		});
	}
</script>
</body>
</html>