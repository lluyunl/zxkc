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
		
		var hprkCm = new Ext.grid.ColumnModel([
			{header:"货品名称", dataIndex:"hpbh", width:150, editor:hpbhSelect, renderer:Ext.util.Format.comboRenderer(hpbhSelect)},
			{header:"供货商名称", dataIndex:"ghsmc", width:150, editor:new Ext.form.TextField({})},
			{header:"单位类型", dataIndex:"dw", editor:dwSelect, renderer:Ext.util.Format.comboRenderer(dwSelect)},
			{header:"货品数量", dataIndex:"hpsl", editor:new Ext.form.NumberField({allowBlank:false, precision:2})},
			{header:"店面", dataIndex:"ck", editor:ckSelect, renderer:Ext.util.Format.comboRenderer(ckSelect)},
			{header:"入库人", dataIndex:"rkr", editor:new Ext.form.TextField({allowBlank:false})},
			{header:"入库时间", dataIndex:"rksj", sortable:true, editor:new Ext.form.DateField({allowBlank:false, format:"Y-m-d"}), renderer:new Ext.util.Format.dateRenderer('Y-m-d')},
			{header:"备注", dataIndex:"bz", editor:new Ext.form.TextField({})}
		]);
		
		var colArray = [{name:"hpbh"}, {name:"ghsmc"}, {name:"hpsl"}, {name:"dw"}, {name:"ck"}, {name:"rkr"}, {name:"rksj"}, {name:"bz"}];
		
		var HprkRecord = Ext.data.Record.create(colArray);
		
		var emptyStore = new Ext.data.Store({
			proxy: new Ext.data.MemoryProxy(null),
			reader: new Ext.data.ArrayReader({}, colArray)
		});
		emptyStore.load();

		var hprkList = new Ext.grid.EditorGridPanel({
            title:"货品入库", renderTo:"hprkList", cm:hprkCm, ds:emptyStore, frame:true, height:500, width:1000,
            sm:new Ext.grid.RowSelectionModel({singleSelect:true}),
            viewConfig:{forceFit:true},
            tbar:new Ext.Toolbar(["-", {
                text:"添加一行", 
                handler:function(){
                	var row = new HprkRecord({ hpbh:"", ghsmc:"", hpsl:"", ck:"", dwlx:"", rkr:"", rksj:""});
                	hprkList.stopEditing();
                	hprkList.getStore().insert(0, row);
                	hprkList.startEditing(0, 0);
                }
            }, "-", {
                text:"删除一行", 
                handler:function(){
                	var selectedRow = hprkList.getSelectionModel().getSelected();
                	if (selectedRow == null) {
                		Ext.Msg.alert("系统提示", "请先选择要删除的记录！");
                		return ;
                	}
                	Ext.Msg.confirm("系统提示", "确定删除选中行?", function(opt) {
                		if (opt == "yes") {
                            hprkList.getStore().remove(hprkList.getSelectionModel().getSelected());
                		}
                	});
                }
            }, "-", "->", "-", {
            	text:"保存",
            	handler: function() {
            		var flag = true;
            		var hprkListStore = hprkList.getStore();
					hprkListStore.each(function(item) {
						if (!fnCheckHprkRecord(item)) {
							flag = false;
							return ;
						}
					});
					if (!flag) {
						return ;
					}
					var dataArray = [];
					hprkListStore.each(function(item) {
						dataArray.push(item.data);
					});
					if (hprkListStore.getCount() == 0) {
                        Ext.Msg.alert("系统提示", "请先录入入库信息！");
                        return ;
					}
					Ext.Ajax.request({url:"${ctxPath}/jhlr/hprk_saveHprkList.shtml",
						params:{data:encodeURIComponent(Ext.encode(dataArray))},
						success:function(response) {
							var data = Ext.decode(response.responseText);
							if (data.success) {
								Ext.Msg.alert("系统提示", "保存成功！");
								hprkList.getStore().removeAll();
							} else {
								Ext.Msg.alert("系统提示", "保存失败！");
							}
						}
					});
            	}
            }, "-"])
        });
        
        function fnCheckHprkRecord(record) {
        	if (fnIsBlank(record.get("hpbh"))) {
        		Ext.Msg.alert("系统提示", "货品名称不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("hpsl"))) {
        		Ext.Msg.alert("系统提示", "货品数量不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("dw"))) {
        		Ext.Msg.alert("系统提示", "单位类型不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("ck"))) {
        		Ext.Msg.alert("系统提示", "店面不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("rkr"))) {
        		Ext.Msg.alert("系统提示", "入库人不能为空！");
        		return ;
        	}
        	if (fnIsBlank(record.get("rksj"))) {
        		Ext.Msg.alert("系统提示", "入库时间不能为空！");
        		return ;
        	}
        	return true;
        }

	});

</script>
</head>
<body>
<div id="hprkList"></div>
</body>
</html>
