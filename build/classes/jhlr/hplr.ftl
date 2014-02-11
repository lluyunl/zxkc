<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<script type="text/javascript">
	Ext.onReady(function() {
	
		//var store = new Ext.data.Store({
		//	proxy: new Ext.data.HttpProxy({url: '${ctxPath}/jhlr/hplr_loadHpSelect.shtml'}),
		//	reader: new Ext.data.ArrayReader({}, [
		//		{name: 'value'},
		//		{name: 'text'}
		//	])
		//});
	
		//var form = new Ext.form.FormPanel({
		//	renderTo: 'queryCrt',
		//	labelAlign: 'right',
		//	labelWidth: 200,
		//	width: 1000,
		//	frame: true,
		//	layout: 'column',
		//	items: [{
		//		columnWidth: .8,
		//		items: [{
		//			xtype: 'combo',
		//			name: 'hpbh',
		//			fieldLabel: '货品',
		//			emptyText: '请选择',
		//			store: store,
		//			mode: 'remote',
		//			valueField: 'value',
		//			displayField: 'text'
		//		}]
		//	}]
		//});	
		
		
		var gridStore = new Ext.data.JsonStore({
			url: '${ctxPath}/jhlr/hplr_listHpxx.shtml',
			root: 'hpxxList',
			fields: ['hpbh', 'hpmc', 'bzgg', 'dw', 'zxdw', 'ts', 'lrr', 'xgr', 'xgsj']
		});
		gridStore.load();
		
		var hpxxGrid = new Ext.grid.GridPanel({
			renderTo: 'hpxxList',
			ds: gridStore,
			columns: [
				{header: '货品编号', dataIndex: 'hpbh', width: 100},
				{header: '货品名称', dataIndex: 'hpmc', width: 120},
				{header: '包装规格', dataIndex: 'bzgg', width: 80},
				{header: '单位', dataIndex: 'dw', width: 80},
				{header: '最小单位', dataIndex: 'zxdw', width: 80},
				{header: '录入时间', dataIndex: 'ts', width: 100},
				{header: '录入人', dataIndex: 'lrr', width: 100},
				{header: '修改人', dataIndex: 'xgr', width: 100},
				{header: '修改时间', dataIndex: 'xgsj', width: 100}
			],
			viewConfit: {
				forceFit: true
			},
			width: 1000,
			height: 300,
			frame: true,
			tbar: new Ext.Toolbar([
				'-',
				{
					text: '新增',
					handler: function() {
						var addWindow = new Ext.Window({
							title: '新增货品',
							width: 800,
							height: 150,
							modal: true,
							closeAction: 'hide',
							layout: 'form',
							items: [{
								layout: 'column',
								border: false,
								style: 'padding-top:5px',
								items: [
									{	
										columnWidth: 0.3,
										labelWidth: 80,
										labelAlign: 'right',
										layout: 'form',
										border: false,
										items: [
											{
												xtype: 'textfield',
												name: 'hpbh',
												fieldLabel: '货品编号'
											}, {
												xtype: 'textfield',
												name: 'bzgg',
												fieldLabel: '包装规格'
											}
										]
									}, {	
										columnWidth: 0.3,
										labelWidth: 80,
										labelAlign: 'right',
										layout: 'form',
										border: false,
										items: [
											{
												xtype: 'textfield',
												name: 'hpmc',
												fieldLabel: '货品名称'
											}, {
												xtype: 'textfield',
												name: 'zxdw',
												fieldLabel: '最小单位'
											}
										]
									},{	
										columnWidth: 0.3,
										labelWidth: 80,
										labelAlign: 'right',
										layout: 'form',
										border: false,
										items: [
											{
												xtype: 'textfield',
												name: 'dw',
												fieldLabel: '单位'
											}
										]
									}
								],
								buttonAlign: 'center',
								buttons: [
                                    {text: '取消'},
                                    {text: '确定'}
								]
							}]
						});
						addWindow.show();
					}
				},
				'-',
				{
					text: '修改',
					handler: function() {
						alert(2);
					}
				},
				'-',
				{
					text: '删除',
					handler: function() {
						alert(3);
					}
				},
				'-'
			])
		});
	});
</script>
</head>
<body>
<div id="hpxxList"></div>
</body>
</html>
