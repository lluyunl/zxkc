//判空
function fnIsBlank(sValue) {
	return sValue == undefined || sValue == null || fnTrim(sValue) == "";
};

function fnTrim(sValue) {
	return sValue.replace(/(^\s*)|(\s*$)/g, "");
}