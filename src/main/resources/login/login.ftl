<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>登录</title>
<#include "/commons/ext.ftl"/>
<script type="text/javascript">

	function fnLogin() {
		Ext.Ajax.request({
			form: 'loginForm',
			success: fnCheckLogin
		});
	}
	
	function fnEnterLogin(event) {
		if (event.keyCode == 13) {
			fnLogin();
		}
	}
	
	function fnCheckLogin(response, options) {
		var data = Ext.decode(response.responseText);
		if (data.success) {
			window.location.href = "index.shtml";
        } else {
        	Ext.Msg.alert("系统提示", data.loginErrorMsg);
        	return ;
        }
	}
	
</script>
</head>
<body>
	<div id="loginDiv" style="text-align:center; position:absolute; left:400px; top:200px; height:200px">	
		<form action="/zxkc/login.shtml" id="loginForm">
			用户名：<input type="text" id="username" name="username"/>
			密码：<input type="text" id="password" name="password" onKeyPress="fnEnterLogin(event)"/>
			<input type="button" id="loginBtn" onclick="fnLogin()" value="登录"/> 
		</form>
	</div>
</body>
</html>
