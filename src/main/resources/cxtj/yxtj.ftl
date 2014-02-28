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
						new Ext.form.ComboBox({store:hpbhSelectStore, triggerAction:"all", name:"hpbh", id:"hpbh", fieldLabel:"货品名称", emptyText:"请选择", 
                            mode:"local", valueField:"hpbh", displayField:"hpmc"}),
                        new Ext.form.ComboBox({store:dwSelectStore, id:"dwlx", hiddenName:"dwlx", triggerAction:"all", emptyText:"请选择", mode:"local", valueField:"dwlx", displayField:"dwlxmc", fieldLabel:"<font color='red'>*</font>单位类型", allowBlank:false})
    				]},
					{layout:"form", border:false, columnWidth:.33, items:[new Ext.form.DateField({id:"qsrq", name:"qsrq_str", fieldLabel:"起始日期", width:200, format:"Y-m-d"})]},
					{layout:"form", border:false, columnWidth:.33, items:[new Ext.form.DateField({id:"jzrq", name:"jzrq_str", fieldLabel:"截止日期", width:200, format:"Y-m-d"})]}
				]} 
			], buttons:[{text:"查询", handler:function() {
				fnQueryKc();
			}}]
		});
		
		//查询营销信息
		function fnQueryKc() {
			if (fnIsBlank(Ext.getCmp("dwlx").getValue())) {
				Ext.Msg.alert("系统提示", "单位类型不能为空！");
				return ;
			}
			kclistGrid.getStore().load({params:{hpbh:Ext.getCmp("hpbh").getValue(), qsrq_str:Ext.getCmp("qsrq").getValue(), jzrq_str:Ext.getCmp("jzrq").getValue(), dwlx:Ext.getCmp("dwlx").getValue()}});
		}
		
		var yxtjGridCm = new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
			{header:"货品名称", dataIndex:"hpmc", width:200},
			<#if dmList??>
				<#list dmList as dmObj>
					{header:"${dmObj[1]!}", dataIndex:"${dmObj[0]!}"},
				</#list>
			</#if>
        ]);
		
		var yxtjGridDs = new Ext.data.JsonStore({
			url:"${ctxPath}/cxtj/yxtj_loadYxtj.shtml", root:"yxtjList", 
			fields:["hpmc", <#if dmList??><#list dmList as dmObj>"${dmObj[0]!}",</#list></#if>]
		});
		
		var kclistGrid = new Ext.grid.GridPanel({
			renderTo:"yxtjGrid", title:"营销信息", width:1000, frame:true, height:350, cm:yxtjGridCm, ds:yxtjGridDs, loadMask:true, viewConfig:{forceFit:true}
		});
		
	});
	

</script>
</head>
<body>
<div style="width:1000px;text-align:center"><font size="2">营销统计</font></div>
<div id="queryForm"></div>
<div id="yxtjGrid"></div>
</body>
</html>
 
