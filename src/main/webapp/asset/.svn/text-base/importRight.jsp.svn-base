<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>版权资产权利批量新增</title>
	<style>
		#memo20150723{margin:100px 0 0 20px;}
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
		<input type="hidden" data-field="IMPORT_TYPE" ></input>
		合同编号<span class="bitian">*</span>：
		<input type="text" data-field="CONTRACT_CD"  maxlength=25 valid="required" style="height:30px;line-height:30px;width:200px"></input><br><br>
	
		<a class="easyui-linkbutton" data-options="iconCls:'icon-excel'" style="padding:10px;width:280px" onclick="onRightImportClick()">点击上传版权权利</a><br><br>
		<a class="easyui-linkbutton" data-options="iconCls:'icon-help'" style="padding:10px;width:280px" onclick="onHelpClick()">导入步骤说明&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</a>
	
		<a class="acws-excel" id="rightImport" style="padding:10px;width:200px;display:none"	data-options="iconCls:'icon-excel',service:'$assetRightDImport',pluploader:{max_file_size:'5mb'}">点击上传版权权利</a>

	</div>
	<div id="memo20150723">
		<span style="width:480px;font-size:20px;color:#000">注意事项:</span><br>
		<span>1.如果该合同编号未曾导入过权利、则视为新增权利；</span><br>
		<span>2.如果该合同编号已经导入过权利、则视为修改权利；</span><br>
		<span>&nbsp;&nbsp;&nbsp;即放弃前一次的导入，以本次导入为准；</span><br>
		<span>3.导入文件仅限EXCEL（*.xlsx）格式；</span><br>
		<span>4.单个文件仅限5M大小；</span><br>
	</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
//弹出窗口初始化事件
function onAcwsDialogInit(params){
	$A("CONTRACT_CD").focus();
	$("#rightImport").off("onClickBefore").on("onClickBefore",
		function onImportBefore(){
			//此处可以取得参数、校验参数、校验失败返回false、校验成功返回json
			//可以参照excel下载的demo
			return {contractCd:$A("CONTRACT_CD").getAcwsValue(),importType:$A("IMPORT_TYPE").getAcwsValue()};
	});
}
function onRightImportClick(){
	if(!Acws.valid("#condition"))return;
	//调用后台校验合同编号的有效性
	$A("IMPORT_TYPE").setAcwsValue("");
     Acws.ajax("./asset/checkContractCdOfAsset.ajax", {contractCd:$A("CONTRACT_CD").getAcwsValue()},function(outputData){
   		if (outputData.success){
   			var assetIds=outputData.assetIds;
   			if(assetIds){
   				$A("IMPORT_TYPE").setAcwsValue("edit");
   			}else{
   				$A("IMPORT_TYPE").setAcwsValue("add");
   			}
   	    } else {
   	        _err("无效的合同编号，请重新输入");
   	        $A("CONTRACT_CD").focus();
   	        return false;
   	    }
   	},{async:false});  
      
      if($A("IMPORT_TYPE").getAcwsValue()==="edit"){
    	  _confirm("合同编号：("+$A("CONTRACT_CD").getAcwsValue()+")的权利已经存在、您确认覆盖导入吗？",function(r){
				if(!r)return;
				$("#rightImport").click();
			});
      }else{
    	  _confirm("合同编号：("+$A("CONTRACT_CD").getAcwsValue()+")的权利尚未存在、您确认导入吗？",function(r){
				if(!r)return;
				$("#rightImport").click();
			});
      }
}

//帮助
function onHelpClick(){
	Acws.showDialog({url:'./asset/importRightHelp.jsp',title:'帮助',width:600,height:500,modal:true,iconCls:'icon-help',dialogParams:{}});
}

</script>
</body>
</html>