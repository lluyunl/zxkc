<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<#include "/commons/commonJs.ftl"/>
<script type="text/javascript">
	
	Ext.onReady(function() {
		
		var queryForm = new Ext.form.FormPanel({
			renderTo:"queryForm", border:false, frame:false, width:1000, autoHeight:true, labelWidth:80, labelAlign:"right", buttonAlign:"center",
			items:[{
				layout:"column", xtype:"fieldset", title:"查询条件", checkboxToggle:true,
				items:[{
					columnWidth:.3, layout:"form", border:false, items:[hpbhSelect, ckSelect]
                }, {
                	columnWidth:.3, layout:"form", border:false, items:[new Ext.form.DateField({format:"Y-m-d", name:"rksjq", id:"rksjq", width:157}), new Ext.form.TextField({name:"ghsmc", id:"ghsmc"})] 
                }, {
                	columnWidth:.4, layout:"form", border:false, items:[new Ext.form.DateField({format:"Y-m-d", name:"rksjz", id:"rksjz", width:157}), new Ext.form.TextField({name:"rkr", id:"rkr"})] 
                }]
            }], buttons:[{text:"查询"}]
    	});

//		var hprkCm = new Ext.grid.ColumnModel([
//			{header:"货品名称", dataIndex:"hpbh", width:70},
//			{header:"供货商名称", dataIndex:"ghsmc", width:150},
//			{header:"送货人", dataIndex:"shr", width:50},
//			{header:"送货人电话", dataIndex:"shrdh"},
//			{header:"货品数量", dataIndex:"hpsl"},
//			{header:"单位类型", dataIndex:"dw"},
//			{header:"仓库", dataIndex:"ck"},
//			{header:"入库人", dataIndex:"rkr"},
//			{header:"入库时间", dataIndex:"rksj", renderer:new Ext.util.Format.dateRenderer("Y-m-d H:m:s")},
//			{header:"备注", dataIndex:"bz"}
//		]);
//		
//		var colArray = [{name:"hpbh"}, {name:"ghsmc"}, {name:"shr"}, {name:"shrdh"}, {name:"hpsl"}, {name:"dw"}, {name:"ck"}, {name:"rkr"}, {name:"rksj"}, {name:"bz"}];
//		
//		var HprkRecord = Ext.data.Record.create(colArray);
//		
//		var hprkStore = new Ext.data.JsonStore({
//			url:"${ctxPath}/jhlr/hprk_loadHprkList.shtml",
//			params:{hpbh:Ext.get("hpbh").getValue(), rksjq:Ext.get("rksjq").getValue(), rksjz:Ext.get("rksjz").getValue(), 
//				ck:Ext.get("ck").getValue(), ghsmc:Ext.get("ghsmc").getValue(), shr:Ext.get("shr").getValue()},
//			fields:["hpbh", "hpmc", "ghsmc", "shr", "shrdh", "hpsl", "dw", "ck", "rkr", "rksj", "bz"]
//		});
//		hprkStore.load();
//
//		var hprkList = new Ext.grid.EditorGridPanel({
//            title:"货品入库", renderTo:"hprkList", cm:hprkCm, ds:hprkStore, frame:true, height:500, width:1000,
//            sm:new Ext.grid.RowSelectionModel({singleSelect:true}),
//            viewConfig:{forceFit:true},
//        });
        
	});

</script>
</head>
<body>
<div style="width:1000px;text-align:center"><font size="2">货品入库维护</font></div>
<div id="queryForm"></div>
<div id="hprkList"></div>
</body>
</html>
