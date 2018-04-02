<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>导出版权权利</title>
	<style>
		#memo20150723{margin:300px 0 0 20px;}
		#memo20150723 span{
			color:red;
			font-size:14px;
			margin: 10px 0px 0px 0px;
		}
	</style>
</head>
<body style="overflow:hidden">
<div class="easyui-panel" data-options="iconCls: 'icon-save',footer: '#dlg-buttons',border:false" fit=true>
	<div style="margin-top:20px;height:60px;text-align: center;" id="condition">
		<div class="acws-radio acws-label" data-field="OP_TYPE" valid="required">
			<div>
				<label style="display: block; float: left; font-size:18px">
					<input type="radio" value="1" name="OP_TYPE" checked/>
					按资产编号导出<br><span style="font-size:16px;color:blue">（适用于新增权利）</span>
				</label>
				<textarea class="easyui-textbox" data-field="ASSET_CD" multiline="true" data-options="prompt:'资产编号\n\n一行一个资产编号\n最多输入200行'"" style="height:150px;line-height:20px;width:200px"></textarea>
			</div><br><br>
			<div>
				<label style="display: block; float: left;font-size:18px">
					<input type="radio" value="2" name="OP_TYPE"/>
					按合同编号导出<br><span style="font-size:16px;color:blue">（适用于修改权利）</span>
				</label>
				<input class="easyui-textbox" data-field="CONTRACT_CD"  maxlength=20 valid="required" data-options="prompt:'合同编号'" style="height:35px;line-height:35px;width:200px"></input>
			</div>
		</div><br><br>
	<a id="btnAssetRightExport"  class="easyui-linkbutton acws-exceldownload" 
		data-options="iconCls:'icon-excel'" 
		data-service="$assetRightLibExport"
		data-filename="版权资产权利.xlsx"
		data-contextType=""
		data-confirmmsg="批量导出开始后无法结束并且导出时间偏长，确定导出？"
		onClickBefore="onAssetRightDownloadClickBefore()"
		style="padding:10px;width:280px">点击导出权利信息</a><br><br>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-help'" style="padding:10px;width:280px" onclick="onHelpClick()">权利导入步骤说明</a>
		
</div>
	<div id="memo20150723">
			<span style="width:480px;font-size:20px;color:#000">注意事项：</span><br>
   			<span>1、该功能是为了导入版权权利用的；</span><br>
	</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
function onAssetRightDownloadClickBefore(){
	var inputData = Acws.getJson("#condition");
	inputData.ASSET_CD=$A("ASSET_CD").getAcwsValue();
	inputData.CONTRACT_CD=$A("CONTRACT_CD").getAcwsValue();
	var opType=$A("OP_TYPE").getAcwsValue();
	if(inputData.OP_TYPE==1){
		var acds=getAssetCds(inputData);
		if(acds==null || acds.length==0){
			_alert("按资产编号导出时、资产编号不能为空");
			return false;
		}
		return {ASSET_CDS:acds.join(","),opType:opType};
	} else if(inputData.OP_TYPE==2){
		if(!(inputData.CONTRACT_CD||"").trim()){
			_alert("按合同编号导出时、合同编号不能为空");
			return false;
		}
		return {CONTRACT_CD:inputData.CONTRACT_CD,opType:opType};
	} else {
		return false;
	}
}

//帮助
function onHelpClick(){
	Acws.showDialog({url:'./asset/importRightHelp.jsp',title:'帮助',width:600,height:500,modal:true,iconCls:'icon-help',dialogParams:{}});
}

function getAssetCds(inputData){
	if(!inputData.ASSET_CD) return null;
	var acds=(inputData.ASSET_CD||"").split("\n");
	if(acds.length>200){
		_alert("最多只能输入200个资产编号，当前已输入"+acds.length+"个资产编号");
		return false;
	}
	var ret=new Array();
	for (var i=0;i<acds.length;i++){
		if((acds[i].trim())){
			ret.push((acds[i].trim()));
		}
	}
	if(ret.length>0)return ret;
	return null;
}
</script>
</body>
</html>