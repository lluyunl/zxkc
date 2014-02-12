<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<script type="text/javascript">
	Ext.onReady(function() {
	var addForm = new Ext.form.FormPanel({
		url: '${ctxPath}/jhlr/hplr_addHp.shtml',
		labelAlign: 'right',
		labelWidth: 200,
		width: 800,
		height: 150,
		frame: true,
		layout: 'form',
		buttonAlign: 'center',
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
							name: 'hpmc',
							id: 'hpmc',
							allowBlank: false,
							fieldLabel: '货品名称'
						}, {
							xtype: 'textfield',
							allowBlank: false,
							id: 'zxdw',
							name: 'zxdw',
							fieldLabel: '最小单位'
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
							name: 'dw',
							id: 'dw',
							allowBlank: false,
							fieldLabel: '单位'
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
							name: 'bzgg',
							id: 'bzgg',
							allowBlank: false,
							fieldLabel: '包装规格'
						}
					]
				}
			],
			buttonAlign: 'center',
			buttons: [
                {
                	text: '取消',
                	handler: function() {
                		addWindow.hide();
                	}
                },
                {
                	text: '确定',
                	handler: function() {
                		Ext.Msg.confirm("系统提示", "确认保存？", function(opt) {
                            if (opt == "yes" && fnCheckBlank()) {
                                addForm.getForm().submit({
                                    success: function() {
                                        addWindow.hide();   
                                        hpxxGrid.getStore().load();
                                        fnInitAddWindow();
                                        Ext.Msg.alert("系统提示", "保存成功！");
                                    },
                                    failure: function() {
                                        Ext.Msg.alert("系统提示", "保存失败，请联系系统管理员！");
                                    }
                                });
                            }
                		});
                	}
                }
			]
		}, new Ext.form.Hidden({id:'ukey', name:'ukey'})]
	});
	
	function fnInitAddWindow() {
        Ext.getCmp("hpmc").setValue("");
        Ext.getCmp("dw").setValue("");
        Ext.getCmp("bzgg").setValue("");
        Ext.getCmp("zxdw").setValue("");
        Ext.getCmp("ukey").setValue("");
	}
	
	function fnCheckBlank() {
		if (!Ext.getCmp("hpmc").validate()) {
			Ext.Msg.alert("系统提示", "货品名称不能为空！");
			return false;
		}
		if (!Ext.getCmp("dw").validate()) {
			Ext.Msg.alert("系统提示", "单位不能为空！");
			return false;
		}
		if (!Ext.getCmp("bzgg").validate()) {
			Ext.Msg.alert("系统提示", "包装规格不能为空！");
			return false;
		}
		if (!Ext.getCmp("zxdw").validate()) {
			Ext.Msg.alert("系统提示", "最小单位不能为空！");
			return false;
		}
		return true;
	}

    var addWindow = new Ext.Window({
        width: 800,
        height: 150,
        modal: true,
        closeAction: 'hide',
        layout: 'form',
        items: [addForm]
    });
	
		var gridStore = new Ext.data.JsonStore({
			url: '${ctxPath}/jhlr/hplr_listHpxx.shtml',
			root: 'hpxxList',
			fields: ['ukey', 'hpbh', 'hpmc', 'bzgg', 'dw', 'zxdw', 'ts']
		});
		gridStore.load();
		
		var hpxxGrid = new Ext.grid.GridPanel({
			renderTo: 'hpxxList',
			ds: gridStore,
			loadMask: true,
			sm: new Ext.grid.RowSelectionModel({singleSelect: true}),
			columns: [
				new Ext.grid.RowNumberer(),
				{dataIndex: 'ukey', hidden: true},
				{header: '货品编号', dataIndex: 'hpbh', width: 100},
				{header: '货品名称', dataIndex: 'hpmc', width: 220},
				{header: '包装规格', dataIndex: 'bzgg', width: 100},
				{header: '单位', dataIndex: 'dw', width: 80},
				{header: '最小单位', dataIndex: 'zxdw', width: 80},
				{header: '录入时间', dataIndex: 'ts', width: 300, renderer: new Ext.util.Format.dateRenderer('Y-m-d H:m:s'), sortable: true},
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
						addWindow.setTitle("新增货品");
						addWindow.show();
					}
				},
				'-',
				{
					text: '修改',
					handler: function() {
						var hpxxBean = hpxxGrid.getSelectionModel().getSelected();
						if (hpxxBean == null) {
							Ext.Msg.alert("系统提示", "请先选择一条记录！");
							return ;
						}
						Ext.getCmp("hpmc").setValue(hpxxBean.get("hpmc"));
						Ext.getCmp("dw").setValue(hpxxBean.get("dw"));
						Ext.getCmp("bzgg").setValue(hpxxBean.get("bzgg"));
						Ext.getCmp("zxdw").setValue(hpxxBean.get("zxdw"));
						Ext.getCmp("ukey").setValue(hpxxBean.get("zxdw"));
						addWindow.setTitle("修改货品");
						addWindow.show();
					}
				},
				'-',
				{
					text: '删除',
					handler: function() {
                        var hpxxBean = hpxxGrid.getSelectionModel().getSelected();
						if (hpxxBean == null) {
							Ext.Msg.alert("系统提示", "请先选择一条记录！");
							return ;
						}
						Ext.Msg.confirm("系统提示", "确定删除选择的记录？", function(opt) {
							if (opt == "yes") {
								Ext.Ajax.request({
									url: '${ctxPath}/jhlr/hplr_deleteHp.shtml',
									params: {ukey: hpxxBean.get("ukey")},
									success: function(response) {
										var result = Ext.decode(response.responseText); 
										if (result.success) {
											Ext.Msg.alert("系统提示", "删除成功！");
											hpxxGrid.getStore().load();
										} else {
											Ext.Msg.alert("系统提示", "删除失败！");
										}
									}
								});		
							}
						})
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
