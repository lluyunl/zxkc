package com.mrding.zxkc.dao.jhlr;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.model.ZxkcYwHpxx;

public class ZxkcHplrDao {

    public List<ZxkcYwHpxx> listHpxx() {
	List<Object[]> list = DaoUtils.queryBySql("select * from zxkc_yw_hpxx", DSFactory.CURRENT);
	return convertList(list);
	
    }

    private List<ZxkcYwHpxx> convertList(List<Object[]> list) {
	List<ZxkcYwHpxx> beanList = new ArrayList<ZxkcYwHpxx>();
	if (CommonUtils.listIsNotBlank(list)) {
	    for (Object[] objs : list) {
		beanList.add(convert(objs));
	    }
	}
	return beanList;
    }

    private ZxkcYwHpxx convert(Object[] objs) {
	ZxkcYwHpxx bean = new ZxkcYwHpxx();
	bean.setUkey((String) objs[0]);
	bean.setHpbh((String) objs[1]);
	bean.setBzgg((String) objs[2]);
	bean.setDw((String) objs[3]);
	bean.setZxdw((String) objs[4]);
	bean.setDr((Integer) objs[5]);
	bean.setTs((Timestamp) objs[6]);
	bean.setLrr((String) objs[7]);
	bean.setXgr((String) objs[8]);
	bean.setXgsj((Timestamp) objs[9]);
	return bean;
    }

}
