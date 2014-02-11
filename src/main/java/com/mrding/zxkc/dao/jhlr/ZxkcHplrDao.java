package com.mrding.zxkc.dao.jhlr;

import java.util.ArrayList;
import java.util.List;

import com.mrding.zxkc.model.ZxkcYwHpxx;

public class ZxkcHplrDao {

    public List<ZxkcYwHpxx> listHpxx() {
	List<ZxkcYwHpxx> rtnList = new ArrayList<ZxkcYwHpxx>();
	ZxkcYwHpxx bean = new ZxkcYwHpxx();
	bean.setHpbh("0001");
	bean.setHpmc("大白菜");
	bean.setBzgg("箱");
	rtnList.add(bean);
	return rtnList;
    }

}
