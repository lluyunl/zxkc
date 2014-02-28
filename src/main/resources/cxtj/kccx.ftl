<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<#include "/commons/commonJs.ftl"/>
<script type="text/javascript">
	
	Ext.onReady(function() {
	
		var queryForm = new Ext.form.FormPanel({
			renderTo:"queryForm", width:1000, autoHeight:true, frame:false, border:false, labelWidth:80, labelAlign:"right", buttonAlign:"center", items:[
				{layout:"column", anchor:"100%,100%", title:"查询条件", xtype:"fieldset", checkboxToggle:true, items:[
					{layout:"form", border:false, columnWidth:.33, items:[
						hpbhSelect
    				]},
					{layout:"form", border:false, columnWidth:.33, items:ckSelect},
					{layout:"form", border:false, columnWidth:.33, items:[new Ext.form.DateField({id:"jzrq", name:"jzrq_str", fieldLabel:"截止日期", width:200, format:"Y-m-d"})]}
				]} 
			], buttons:[{text:"查询", handler:function() {
				fnQueryKc();
			}}]
		});
		
		//查询库存信息
		function fnQueryKc() {
			kclistGrid.getStore().load({params:{hpbh:hpbhSelect.getValue(), ck:ckSelect.getValue(), jzrq_str:Ext.getCmp("jzrq").getValue()}});
		}
		
		var kclistGridCm = new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
			{header:"hpbh", dataIndex:"hpbh", hidden:true},
			{header:"货品名称", dataIndex:"hpmc", width:150},
			{header:"包装规格", dataIndex:"bzgg", width:100},
			{header:"数量(单位)", dataIndex:"hpsl_dw", sortable:true},
			{header:"数量(入库最小单位)", dataIndex:"hpsl", sortable:true}
        ]);
		
		var kclistGridDs = new Ext.data.JsonStore({
			url:"${ctxPath}/cxtj/kccx_loadKclist.shtml", root:"kclist", 
			fields:["hpbh", "hpmc", "bzgg", "hpsl_dw", "hpsl"]
		});
		
		var kclistGrid = new Ext.grid.GridPanel({
			renderTo:"kclistGrid", title:"库存信息", width:1000, frame:true, height:350, cm:kclistGridCm, ds:kclistGridDs, loadMask:true, viewConfig:{forceFit:true}
		});
		
	});
	

</script>
</head>
<body>
<div style="width:1000px;text-align:center"><font size="2">库存查询</font></div>
<div id="queryForm"></div>
<div id="kclistGrid"></div>
</body>
</html>
 