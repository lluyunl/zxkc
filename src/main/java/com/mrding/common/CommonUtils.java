package com.mrding.common;

import java.util.List;

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

	public static boolean listIsNotBlank(List<Object[]> list) {
	    return list != null && list.size() > 0;
	}

	
	
}
