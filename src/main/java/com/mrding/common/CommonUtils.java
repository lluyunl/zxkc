package com.mrding.common;

/**
 * 静态方法工具
 * @author Lenovo
 *
 */
public class CommonUtils {
	
	/**
	 * 判断字符串是否为空（“”或null）
	 * @param username
	 * @return
	 */
	public static boolean strIsNotBlank(String str) {
		return str != null && !str.equals("");
	}

	
	
}
