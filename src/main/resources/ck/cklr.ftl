<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<#include "/commons/commonJs.ftl"/>
<script type="text/javascript">
	
	Ext.onReady(function() {

		Ext.util.Format.comboRenderer = function(combo) {
			return function(value) {
				var record = combo.findRecord(combo.valueField, value);
				return record ? record.get(combo.displayField) : combo.valueNotFoundText;
			}
		}
		
		var dwSelectStore = new Ext.data.Store({
			proxy:new Ext.data.MemoryProxy([["dw", "单位"], ["zxdw", "最小单位"]]),
			reader:new Ext.data.ArrayReader({}, [{name: "dwlx"}, {name: "dwlxmc"}])
		});
		dwSelectStore.load();
		
		var dwSelect = new Ext.form.ComboBox({
			store:dwSelectStore, emptyText:"请选择", mode:"local", valueField:"dwlx", displayField:"dwlxmc", allowBlank:false
		});

		
		var ckyyComboStore = new Ext.data.Store({
			proxy:new Ext.data.MemoryProxy([["xs", "销售"], ["sh", "损坏"], ["ds", "丢失"], ["other", "其他"]]),
			reader:new Ext.data.ArrayReader({}, [{name: "ckyy"}, {name: "ckyymc"}])
		});
		ckyyComboStore.load();
		var ckyyCombo = new Ext.form.ComboBox({
			store:ckyyComboStore, emptyText:"请选择", mode:"local", valueField:"ckyy", displayField:"ckyymc", triggerAction:"all", allowBlank:false
		});
		
		var hpckCm = new Ext.grid.ColumnModel([
			{header:"货品名称", dataIndex:"hpbh", width:70, editor:hpbhSelect, renderer:Ext.util.Format.comboRenderer(hpbhSelect)},
			{header:"出库原因", dataIndex:"ckyy", editor:ckyyCombo, renderer:Ext.util.Format.comboRenderer(ckyyCombo)},
			{header:"出库店面", dataIndex:"ck", editor:ckSelect, renderer:Ext.util.Format.comboRenderer(ckSelect)},
			{header:"货品数量", dataIndex:"hpsl", editor:new Ext.form.NumberField({allowBlank:false, precision:2})},
			{header:"出库时间", dataIndex:"cksj", sortable:true, editor:new Ext.form.DateField({allowBlank:false, format:"Y-m-d"}), renderer:new Ext.util.Format.dateRenderer('Y-m-d')},
			{header:"出库人", dataIndex:"ckr", editor:new Ext.form.TextField({allowBlank:false})},
			{header:"备注", dataIndex:"bz", editor:new Ext.form.TextField({})}
		]);
		
		var colArray = [{name:"hpbh"}, {name:"ckyy"}, {name:"ck"}, {name:"hpsl"}, {name:"cksj"}, {name:"ckr"}, {name:"bz"}];
		
		var HpckRecord = Ext.data.Record.create(colArray);
		
		var emptyStore = new Ext.data.Store({
			proxy: new Ext.data.MemoryProxy(null),
			reader: new Ext.data.ArrayReader({}, colArray)
		});
		emptyStore.load();

		var hpckList = new Ext.grid.EditorGridPanel({
            title:"货品出库", renderTo:"hpckList", cm:hpckCm, ds:emptyStore, frame:true, height:500, width:1000,
            sm:new Ext.grid.RowSelectionModel({singleSelect:true}),
            viewConfig:{forceFit:true},
            tbar:new Ext.Toolbar(["-", {
                text:"添加一行", 
                handler:function(){
                	var row = new HpckRecord({ hpbh:"", ckyy:"", ck:"", hpsl:"", cksj:"", ckr:"", bz:""});
                	hpckList.stopEditing();
                	hpckList.getStore().insert(0, row);
                	hpckList.startEditing(0, 0);
                }
            }, "-", {
                text:"删除一行", 
                handler:function(){
                	var selectedRow = hpckList.getSelectionModel().getSelected();
                	if (selectedRow == null) {
                		Ext.Msg.alert("系统提示", "请先选择要删除的记录！");
                		return ;
                	}
                	Ext.Msg.confirm("系统提示", "确定删除选中行?", function(opt) {
                		if (opt == "yes") {
                            hpckList.getStore().remove(hpckList.getSelectionModel().getSelected());
                		}
                	});
                }
            }, "-", "->", "-", {
            	text:"保存",
            	handler: function() {
            		var flag = true;
            		var hpckListStore = hpckList.getStore();
					hpckListStore.each(function(item) {
						if (!fnCheckHpckRecord(item)) {
							flag = false;
							return ;
						}
					});
					if (!flag) {
						return ;
					}
					var dataArray = [];
					hpckListStore.each(function(item) {
						dataArray.push(item.data);
					});
					if (hpckListStore.getCount() == 0) {
                        Ext.Msg.alert("系统提示", "请先录入出库信息！");
                        return ;
					}
					Ext.Ajax.request({url:"${ctxPath}/ck/cklr_saveHpck.shtml",
						params:{data:encodeURIComponent(Ext.encode(dataArray))},
						success:function(response) {
							var data = Ext.decode(response.responseText);
							if (data.success) {
								Ext.Msg.alert("系统提示", "保存成功！");
								hpckList.getStore().removeAll();
							} else {
								Ext.Msg.alert("系统提示", "保存失败！");
							}
						}
					});
            	}
            }, "-"])
        });
        
        function fnCheckHpckRecord(record) {
        	if (fnIsBlank(record.get("hpbh").toString())) {
        		Ext.Msg.alert("系统提示", "货品名称不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("ckyy"))) {
        		Ext.Msg.alert("系统提示", "出库原因不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("ck"))) {
        		Ext.Msg.alert("系统提示", "出库店面不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("hpsl").toString())) {
        		Ext.Msg.alert("系统提示", "货品数量不能为空！");
        		return ;
        	}
        	if (record.get("cksj") == null || record.get("cksj") == "") {
        		Ext.Msg.alert("系统提示", "出库时间不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("ckr"))) {
        		Ext.Msg.alert("系统提示", "出库人不能为空！");
        		return ;
        	}
        	return true;
        }

	});

</script>
</head>
<body>
<div id="hpckList"></div>
</body>
</html>
