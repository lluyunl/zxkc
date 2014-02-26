package com.mrding.zxkc.dao;

import java.util.List;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.vo.ZxkcYxtjVo;

public class ZxkcYxtjDao {

	/**
	 * 查询店面
	 * @return
	 */
	public List<Object[]> queryDmList() {
		return DaoUtils.queryBySql("select CKDM,CKMC from zxkc_dm_ck where DR=0 order by CKDM", DSFactory.CURRENT);
	}

	/**
	 * 查询营销统计数据
	 * @param model
	 * @return
	 */
	public List<Object[]> queryYxtjList(ZxkcYxtjVo model) {
		return DaoUtils.queryBySql("select bb.HPMC," +
				createYxtjSqlHead(model.getDmList()) +
                " from (" +
                " select HPBH,RKSJ as sj,HPSL as sl,ck as CK from zxkc_yw_hprk where DR=0  " +
                " union all" +
                " select HPBH,CKSJ as sj,HPSL * (-1) as sl,CK from zxkc_yw_hpck where DR=0" +
                " ) aa " +
                " left join zxkc_yw_hpxx bb on aa.HPBH=bb.HPBH and bb.DR=0" +
                " where 1=1 " +
                (model.getHpbh() != null && !String.valueOf(model.getHpbh()).equals("") ? DaoUtils.sqlEq("aa.HPBH", model.getHpbh()) : "") +
                (CommonUtils.strIsNotBlank(model.getQsrq_str()) ? DaoUtils.sqlGe("aa.sj", model.getQsrq_str()) : "") +
                (CommonUtils.strIsNotBlank(model.getJzrq_str()) ? DaoUtils.sqlLe("aa.sj", model.getJzrq_str()) : "") +
                " group by bb.HPMC", 
				DSFactory.CURRENT);
	}

	private String createYxtjSqlHead(List<Object[]> dmList) {
		StringBuilder head = new StringBuilder("");
		if (CommonUtils.listIsNotBlank(dmList)) {
			for (Object[] objs : dmList) {
				head.append(" sum(case when CK='" + (String) objs[0] + "' then sl else 0 end) as '" + (String) objs[1] + "',");
			}
		}
		return head.substring(0, head.length() - 1);
	}

}
