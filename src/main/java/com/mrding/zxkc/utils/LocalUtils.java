package com.mrding.zxkc.utils;


import java.util.*;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;

public class LocalUtils {

	/**
	 * 根据货品编号获取货品名称
	 * @param hpbh
	 * @return
	 */
	public static String getHpmc(String hpbh) {
		String sql = "select HPMC from zxkc_yw_hpxx where DR=0 and HPBH='" + hpbh + "'";
		List<Object[]> list = DaoUtils.queryBySql(sql, DSFactory.CURRENT);
		if (CommonUtils.listIsNotBlank(list) && list.get(0) != null) {
			return (String) list.get(0)[0];
		} else {
			return "";
		}
	}

}
