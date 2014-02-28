package com.mrding.zxkc.dm;

import java.util.*;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;

/**
 * 仓库代码实例
 * @author mrding
 *
 */
public class CkDmBean {
	
	private static CkDmBean instance = new CkDmBean();
	
	public static Map<String, String> map = new HashMap<String, String>();
	
	public List<Map<String, String>> listSelect() {
		initMap();
		return CommonUtils.createSelect("ck", "ckmc");
	}

	private CkDmBean() {

	}
	
	public static CkDmBean instance() {
		return instance;
	}
	
	private void initMap() {
		if (CommonUtils.mapIsBlank(map)) {
            List<Object[]> list = DaoUtils.queryBySql("select ckdm,ckmc from zxkc_dm_ck where DR=0", DSFactory.CURRENT);
            map = CommonUtils.listToMap(list);
		}
	}
	
}
