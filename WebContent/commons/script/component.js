//货品编号下拉单
var hpbhSelectStore = new Ext.data.JsonStore({
    url:ctxPath + "/jhlr/hprk_loadHpbhSelect.shtml",
    root:"hpbhSelect",
    fields:["hpbh", "hpmc"]
});
hpbhSelectStore.load();
var hpbhSelect = new Ext.form.ComboBox({
    store:hpbhSelectStore, triggerAction:"all", name:"hpbh", id:"hpbh", fieldLabel:"货品名称", emptyText:"请选择", 
    mode:"local", valueField:"hpbh", displayField:"hpmc"
}); 	

//仓库下拉单
var ckSelectStore = new Ext.data.JsonStore({
        url:ctxPath + "/jhlr/hprk_loadCkSelect.shtml",
        root:"ckSelect",
        fields:["ck", "ckmc"]
});
ckSelectStore.load();
var ckSelect = new Ext.form.ComboBox({
        store:ckSelectStore, triggerAction:"all", emptyText:"请选择", mode:"local", fieldLabel:"店面", name:"ck", id:"ck", valueField:"ck", displayField:"ckmc"
});

var dwSelectStore = new Ext.data.Store({
    proxy:new Ext.data.MemoryProxy([["dw", "单位"], ["zxdw", "入库最小单位"]]),
    reader:new Ext.data.ArrayReader({}, [{name: "dwlx"}, {name: "dwlxmc"}])
});
dwSelectStore.load();
var dwSelect = new Ext.form.ComboBox({
    store:dwSelectStore, id:"dwlx", hiddenName:"dwlx", triggerAction:"all", emptyText:"请选择", mode:"local", valueField:"dwlx", displayField:"dwlxmc", fieldLabel:"单位类型", allowBlank:false
});

