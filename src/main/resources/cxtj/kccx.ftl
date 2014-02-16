<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<#include "/commons/commonJs.ftl"/>
<script type="text/javascript">
	
	Ext.onReady(function() {

		var hpbhSelectStore = new Ext.data.JsonStore({
			url:"${ctxPath}/jhlr/hprk_loadHpbhSelect.shtml",
			root:"hpbhSelect",
			fields:["hpbh", "hpmc"]
		});
		hpbhSelectStore.load();

		var hpbhSelect = new Ext.form.ComboBox({
			store:hpbhSelectStore, emptyText:"请选择", mode:"local", valueField:"hpbh", displayField:"hpmc", fieldLabel:"货品名称", width:200 
		}); 	
		var queryForm = new Ext.form.FormPanel({
			labelAlign:"right", width:1000, frame:false, border:false, renderTo:"queryCrt", labelWidth:80,
			items:[{
				layout:"column",
				xtype:"fieldset",
				checkboxToggle:true,
				title:"查询条件",
				autoHeight:true,
				items:[{
					columnWidth:.4,
					layout:"form",
					border:false,
					items:[hpbhSelect]
				}, {
					columnWidth:.4,
					layout:"form",
                    border:false,
					items:[{
						xtype:"datefield",
						fieldLabel:"截止日期",
						width:200
					}]
				}, {
					columnWidth:.2,
                    border:false,
					items:[{
						xtype:"button",
						text:"查询",
						width:50
					}]
				}]
			}]
		});
	
		var data = [
			["04", "茄子", "50斤/袋", "10", "袋"],
			["08", "黄瓜", "25斤/袋", "28", "袋"]
		];
		
		var gridStore = new Ext.data.Store({
			proxy: new Ext.data.MemoryProxy(data),
			reader: new Ext.data.ArrayReader({}, [
				{name:"hpbh"},
				{name:"hpmc"},
				{name:"bzgg"},
				{name:"kcsl"},
				{name:"dw"}
			])
		});
		gridStore.load();
		
		var hpxxGrid = new Ext.grid.GridPanel({
			renderTo: 'kcListGrid',
			ds: gridStore,
			loadMask: true,
			sm: new Ext.grid.RowSelectionModel({singleSelect: true}),
			columns: [
				new Ext.grid.RowNumberer(),
				{dataIndex: 'ukey', hidden: true},
				{header: '货品编号', dataIndex: 'hpbh', width: 100},
				{header: '货品名称', dataIndex: 'hpmc', width: 220},
				{header: '包装规格', dataIndex: 'bzgg', width: 100},
				{header: '库存数量', dataIndex: 'kcsl', width: 60},
				{header: '单位', dataIndex: 'dw', width: 80},
			],
			viewConfig: {
				forceFit: true
			},
			width: 1000,
			height: 300,
			frame: true
		});
	});
	

</script>
</head>
<body>
<div style="width:1000px;text-align:center"><font size="2">库存查询</font></div>
<div id="queryCrt"></div>
<div id="kcListGrid"></div>
</body>
</html>
