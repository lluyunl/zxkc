package com.mrding.common;

import java.util.*;

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
	
	/**
	 * 对list判空
	 * @param list
	 * @return
	 */
	public static boolean listIsNotBlank(List<Object[]> list) {
	    return list != null && list.size() > 0;
	}

	/**
	 * 将list转换为下拉单数据
	 * @param list
	 * @return
	 */
	public static List<Map<String, Object>> convertSelectData(
		List<Object[]> list, String valueKey, String displayKey) {
	    List<Map<String, Object>> rtnList = new ArrayList<Map<String, Object>>();
	    if (listIsNotBlank(list)) {
		for (Object[] objs : list) {
		    Map<String, Object> map = new HashMap<String, Object>();
		    map.put(valueKey, objs[0]); 
		    map.put(displayKey, objs[1]); 
		    rtnList.add(map);
		}
	    }
	    return rtnList;
	}
	
}
