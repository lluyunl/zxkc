//判空
function fnIsBlank(sValue) {
	var value_str = sValue.toString();
	return value_str == undefined || value_str == null || fnTrim(value_str) == "";
};

function fnTrim(sValue) {
    return sValue.replace(/(^\s*)|(\s*$)/g, "");
}
