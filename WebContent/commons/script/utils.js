//判空
function fnIsBlank(sValue) {
	if (sValue == null) {
		return true;
	}
	var value_str = sValue.toString();
	return value_str == null || value_str == undefined || fnTrim(value_str) == "";
};

function fnTrim(sValue) {
    return sValue.replace(/(^\s*)|(\s*$)/g, "");
}
