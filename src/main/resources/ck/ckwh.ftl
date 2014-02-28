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
					columnWidth:.33, layout:"form", border:false, items:[hpbhSelect, ckSelect]
                }, {
                	columnWidth:.33, layout:"form", border:false, items:[new Ext.form.DateField({fieldLabel:"出库时间起",anchor:"90%", format:"Y-m-d", name:"cksjq", id:"cksjq"}), new Ext.form.TextField({fieldLabel:"出库人", anchor:"90%", name:"ckr", id:"ckr"}) ] 
                }, {
                	columnWidth:.33, layout:"form", border:false, items:[new Ext.form.DateField({fieldLabel:"出库时间止",anchor:"90%", format:"Y-m-d", name:"cksjz", id:"cksjz"})] 
                }]
            }], buttons:[{text:"查询", handler:fnQueryHprk}]
    	});
    	
    	function fnQueryHprk() {
            hpckList.getStore().load(
            	{params:{hpbh:hpbhSelect.getValue(), cksjq:Ext.get("cksjq").getValue(), cksjz:Ext.get("cksjz").getValue(), 
            	ck:ckSelect.getValue(), ckr:Ext.get("ckr").getValue()}}
            );
        }

		var hpckCm = new Ext.grid.ColumnModel([
			new Ext.grid.RowNumberer(),
			{header:"ukey", dataIndex:"ukey", hidden:true},
			{header:"货品编号", dataIndex:"hpbh", hidden:true},
			{header:"货品名称", dataIndex:"hpmc", width:70},
			{header:"ckyy", dataIndex:"ckyy", width:150, hidden:true},
			{header:"出库原因", dataIndex:"ckyymc", width:150},
			{header:"ck", dataIndex:"ck", hidden:true},
			{header:"出库店面", dataIndex:"ckmc"},
			{header:"货品数量(入库最小单位)", dataIndex:"hpsl_zxdw", width:150},
			{header:"货品数量(单位)", dataIndex:"hpsl_dw"},
			{header:"出库时间", dataIndex:"cksj",sortable:true, renderer:new Ext.util.Format.dateRenderer("Y-m-d")},
			{header:"出库人", dataIndex:"ckr"},
			{header:"备注", dataIndex:"bz"}
		]);
		
		var hpckStore = new Ext.data.JsonStore({
			url:"${ctxPath}/ck/cklr_loadHpckList.shtml",
			root:"hpckList",
			fields:["ukey", "hpbh", "hpmc", "ckyy", "ckyymc", "ck", "ckmc", "hpsl_zxdw", "hpsl_dw", "cksj", "ckr", "bz"]
		});

		var ckyyComboStore = new Ext.data.Store({
			proxy:new Ext.data.MemoryProxy([["xs", "销售"], ["sh", "损坏"], ["ds", "丢失"], ["other", "其他"]]),
			reader:new Ext.data.ArrayReader({}, [{name: "ckyy"}, {name: "ckyymc"}])
		});
		ckyyComboStore.load();
		var ckyyCombo = new Ext.form.ComboBox({
			store:ckyyComboStore, emptyText:"请选择", mode:"local", valueField:"ckyy", displayField:"ckyymc", triggerAction:"all", allowBlank:false
		});

        var modifyForm = new Ext.form.FormPanel({
        	url:"${ctxPath}/ck/cklr_modifyHpck.shtml", height:200, frame:true, border:false, items:[{
        		layout:"column", xtype:"fieldset", labelWidth:80, labelAlign:"right", border:false, buttonAlign:"center", items:[
                    {layout:"form", columnWidth:.33, items:[
                    	new Ext.form.Hidden({id:"modifyUkey", name:"ukey"}),
                    	new Ext.form.ComboBox({store:hpbhSelectStore, anchor:"90%", triggerAction:"all",id:"modifyHpbh", hiddenName:"hpbh", fieldLabel:"<font color='red'>*</font>货品名称", emptyText:"请选择", mode:"local", valueField:"hpbh", displayField:"hpmc"}),
                    	new Ext.form.ComboBox({id:"modifyCkyy", hiddenName:"ckyy", store:ckyyComboStore, anchor:"90%", triggerAction:"all", fieldLabel:"<font color='red'>*</font>出库原因", mode:"local", valueField:"ckyy", displayField:"ckyymc", emptyText:"请选择"}), 
                    	new Ext.form.ComboBox({id:"modifyCk", hiddenName:"ck", anchor:"90%", store:ckSelectStore, triggerAction:"all",mode:"local", valueField:"ck", displayField:"ckmc", emptyText:"请选择", fieldLabel:"<font color='red'>*</font>出库店面"})
                    ]}, {layout:"form", columnWidth:.33, items:[
                        new Ext.form.ComboBox({store:dwSelectStore, id:"modifyDwlx", hiddenName:"dwlx", triggerAction:"all", emptyText:"请选择", mode:"local", valueField:"dwlx", displayField:"dwlxmc", fieldLabel:"<font color='red'>*</font>单位类型", anchor:"90%"}),
                    	new Ext.form.NumberField({id:"modifyHpsl", name:"hpsl", anchor:"90%", fieldLabel:"<font color='red'>*</font>货品数量"}), 
                    	new Ext.form.DateField({id:"modifyCksj", name:"cksj", anchor:"90%", fieldLabel:"<font color='red'>*</font>出库时间", format:"Y-m-d"})
                    ]}, {layout:"form", columnWidth:.33, items:[
                    	new Ext.form.TextField({id:"modifyCkr",anchor:"90%", name:"ckr", fieldLabel:"<font color='red'>*</font>出库人"}),
                    	new Ext.form.TextField({id:"modifyBz", name:"bz", anchor:"90%", fieldLabel:"备注"})
                    ]}
                ], buttons:[{text:"保存", handler:function() {
                    if (!checkModifyFormBlank()) {
                            return ;
                    }
                    Ext.Msg.confirm("系统提示", "确认保存？", function(opt) {
                        if (opt == "yes") {
							modifyForm.getForm().submit({
								success:function() {
									modifyFormWindow.hide();
									fnQueryHprk();
									Ext.Msg.alert("系统提示", "保存成功！");
								},
								failure:function() {
									Ext.Msg.alert("系统提示", "保存失败，请联系系统管理员！");
								}
							});
                        }
                    });
                }
                }, {text:"取消", handler:function() {
                	modifyFormWindow.hide();
                }}]  
        	}]
        });
        
		function checkModifyFormBlank() {
            if (Ext.getCmp("modifyHpbh").getValue() == null || Ext.getCmp("modifyHpbh").getValue() == undefined || Ext.getCmp("modifyHpbh").getValue() == "") {
            	Ext.Msg.alert("系统提示", "货品名称不能为空！");
            	return ;
            }
            if (fnIsBlank(Ext.getCmp("modifyCkyy").getValue())) {
            	Ext.Msg.alert("系统提示", "出库原因不能为空！");
            	return ;
            }
            if (fnIsBlank(Ext.getCmp("modifyCk").getValue())) {
            	Ext.Msg.alert("系统提示", "出库店面不能为空！");
            	return ;
            }
            if (fnIsBlank(Ext.getCmp("modifyDwlx").getValue())) {
            	Ext.Msg.alert("系统提示", "单位类型不能为空！");
            	return ;
            }
            if (fnIsBlank(Ext.getCmp("modifyHpsl").getValue())) {
            	Ext.Msg.alert("系统提示", "货品数量不能为空！");
            	return ;
            }
            if (Ext.getCmp("modifyCksj").getValue() == null || Ext.getCmp("modifyCksj").getValue() == "") {
            	Ext.Msg.alert("系统提示", "出库时间不能为空！");
            	return ;
            }
            if (fnIsBlank(Ext.getCmp("modifyCkr").getValue())) {
            	Ext.Msg.alert("系统提示", "出库人不能为空！");
            	return ;
            }
            return true;
		}
		
        var modifyFormWindow = new Ext.Window({
        	title:"货品出库修改", width:900, height:200, resizable:false, modal:true, layout:"form", closeAction:"hide", items:[modifyForm]
        });

		var hpckList = new Ext.grid.GridPanel({
            title:"货品出库记录",renderTo:"hpckList", cm:hpckCm, ds:hpckStore, frame:true, height:300, width:1000, loadMask:true,
            sm:new Ext.grid.RowSelectionModel({singleSelect:true}),
            viewConfig:{forceFit:true},
            tbar:["-", {text:"修改", handler:function() {
            	var hpckBean = hpckList.getSelectionModel().getSelected();
            	if (hpckBean == null) {
            		Ext.Msg.alert("系统提示", "请先选择要修改的记录！");
            		return ;
            	}
            	setModifyForm(hpckBean);
            	modifyFormWindow.show();
            }}, "-", {text:"删除", handler:function() {
            	var hpckBean = hpckList.getSelectionModel().getSelected();
            	if (hpckBean == null) {
            		Ext.Msg.alert("系统提示", "请先选择要删除的记录！");
            		return ;
            	}
            	Ext.Msg.confirm("系统提示", "确认删除？", function(opt) {
            		if (opt == "yes") {
                        Ext.Ajax.request({
                            url:"${ctxPath}/ck/cklr_deleteHpck.shtml", params:{ukey:hpckBean.get("ukey")}, 
                            success:function(response) {
                                var rtnObj = Ext.decode(response.responseText);
                                if (rtnObj.success) {
                                        Ext.Msg.alert("系统提示", "删除成功！");
                                        fnQueryHprk();
                                } else {
                                        Ext.Msg.alert("系统提示", "删除失败，请与系统管理员联系");
                                }
                            }
                        });
            		}
            	});
            }}, "-"]
        });
        
        function setModifyForm(hpckBean) {
            Ext.getCmp("modifyUkey").setValue(hpckBean.get("ukey"));
            Ext.getCmp("modifyHpbh").setValue(hpckBean.get("hpbh"));
            Ext.getCmp("modifyCkyy").setValue(hpckBean.get("ckyy"));
            Ext.getCmp("modifyDwlx").setValue("zxdw");
            Ext.getCmp("modifyHpsl").setValue(hpckBean.get("hpsl_zxdw"));
            Ext.getCmp("modifyCk").setValue(hpckBean.get("ck"));
            Ext.getCmp("modifyCkr").setValue(hpckBean.get("ckr"));
            Ext.getCmp("modifyCksj").setValue(hpckBean.get("cksj").substring(0, 10));
            Ext.getCmp("modifyBz").setValue(hpckBean.get("bz"));
        }
        
	});

</script>
</head>
<body>
<div style="width:1000px;text-align:center"><font size="2">货品出库维护</font></div>
<div id="queryForm"></div>
<div id="hpckList"></div>
</body>
</html>
