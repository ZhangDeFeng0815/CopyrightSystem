<%@ include file="/acwsui/acws.doc.jsp"%>
<%@page language="java" pageEncoding="UTF-8"
	contentType="text/html; charset=UTF-8"%>
<html>
<head>
	<%@ include file="/acwsui/acws.jsp"%>
	<%@ include file="/common/myapp.jsp"%>
	<title>授权合同</title>
	<script type="text/javascript" src="./common/partner.select.js"></script>
</head>
<body>
<div class="easyui-layout" data-options="footer: '#dlg-buttons',border:false" fit=true>
<div data-options="region:'center',border:false,footer: '#dlg-buttons'" fit=true>
	<table id="conditionDiv" class="acws-layout">
		<colgroup>
			<col style="width: 20%">
			<col style="width: 80%">
		</colgroup>
		<tr>
			<td class="t">合同编号<span class="bitian">*</span></td>
			<td class="ts">
				<input class="text" data-field="contractCd"  maxlength="25" valid="required" style="width:250px;"/>
			</td>
		</tr>
		<tr>
			<td class="t">合作商名称<span class="bitian">*</span></td>
			<td class="ts">
				<input class="easyui-textbox" data-field="partnerName" data-options="editable:false,icons:[{iconCls:'icon-clear', handler: function(e){$(e.data.target).textbox('clear').textbox('textbox').focus();$('#partnerId').val('');}}],buttonText:'选择',onClickButton:onPartnerSelect"  valid="required" style="width:95%"></input>
				<input id="partnerId" type="hidden" data-field="partnerId"  valid="required"></input>
			</td>
		</tr>
		<tr>
			<td class="t">附件</td>
			<td class="ts">
				<input id="myfile" class="acws-filebox" service="$contractOutEdit" 
				data-options="buttonText:'选择',filetype:'zip',autoupload:false,FileUploaded:onFileUploaded,accept:'application/zip'" 
				    style="width:95%" /><btr>
			</td>
		</tr>
	</table>
</div>
</div>

<div id="dlg-buttons" class="buttons">
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-save'" onclick="javascript:onSaveClick()">保存</a>
	<a href="javascript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-cancel'" onclick="javascript:Acws.closeDialog()">关闭</a>
</div>
<script>
//弹出窗口初始化事件
function onAcwsDialogInit(params){
}
function onPartnerSelect(){
	PartnerUtils.selectOne("", function(rec){
		$A("partnerId").setAcwsValue(rec.partnerId);
		$A("partnerName").setAcwsValue(rec.partnerName);
	});
}
function onSaveClick(){
	if(!Acws.valid("#conditionDiv"))return;
	var inputData = Acws.getJson("#conditionDiv");
	$("#myfile").acwsfilebox("start", inputData);
}

function onFileUploaded(uploader,file,data){
	if(data.IS_SUCCESS==2 || data.success == false){
        _alert(data.bizMsg || data.msg);
        return;
    }
	_alert(data.INFO_MSG||"保存成功");
	Acws.closeDialog();
	Acws.triggerDialogEvent("onDialogClose",{});
}
</script>
</body>
</html>