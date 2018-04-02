if(typeof PartnerUtils=="undefined"){
	PartnerUtils = {};
}
//选择合作商
PartnerUtils.selectOne=function(name, callback){
	Acws.showDialog({url:'./common/partnerOneSelect.jsp',title:"合作商",
		width:800,height:600,modal:true,
		dialogParams:{NAME:name},
		dialogEvent:{onOkClick:callback},onClose:function(){}});
}
