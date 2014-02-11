<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<#include "/commons/ext.ftl"/>
<script type="text/javascript">

	Ext.onReady(function() {
		var indexFrame = new Ext.Viewport({
			layout: 'border',
			items: [
				{
					region:'north', 
				    html:"<iframe id='head' src='/zxkc/index_head.shtml' style='width:100%; height:100%; border:none; background-color:#dbeaf9'/>",
				    height:80 
				},
				{
					region:'west',
				    html:"<iframe id='menu' src='/zxkc/index_menu.shtml' style='width:100%; height:100%; border:none'/>",
				 	width:250,
					title: "菜单",
					split: true,
					maxSize: 400,
					collapsible: true
				},
				{
					region:'center',
				    html:"<iframe id='func' src='/zxkc/index_home.shtml' style='width:100%; height:100%; border:none'/>",
				    title: '功能'
				}, 
				{
					region: 'south',
					height: 30,
					style: 'text-align:center; margin-top:5px',
					title: 'copyright@mrding'
				}
			]
		});
	});

</script>
</head>
<body>

</body>
</html>
