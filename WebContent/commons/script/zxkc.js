//应用根路径
var ctxPath = "/zxkc";

//货品编号下拉单
var hpbhSelectStore = new Ext.data.JsonStore({
    url:"${ctxPath}/jhlr/hprk_loadHpbhSelect.shtml",
    root:"hpbhSelect",
    fields:["hpbh", "hpmc"]
});
hpbhSelectStore.load();
var hpbhSelect = new Ext.form.ComboBox({
    store:hpbhSelectStore, emptyText:"请选择", mode:"local", name:"hpbh", id:"hpbh", valueField:"hpbh", displayField:"hpmc", allowBlank:false
}); 	

//仓库下拉单
var ckSelectStore = new Ext.data.JsonStore({
        url:"${ctxPath}/jhlr/hprk_loadCkSelect.shtml",
        root:"ckSelect",
        fields:["ck", "ckmc"]
});
ckSelectStore.load();
var ckSelect = new Ext.form.ComboBox({
        store:ckSelectStore, emptyText:"请选择", mode:"local", valueField:"ck", displayField:"ckmc", allowBlank:false
});
