package com.mrding.zxkc.dao;

import java.util.List;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.vo.ZxkcKccxVo;

public class ZxkcKccxDao {

	/**
	 * 查询库存信息
	 * @param model
	 * @return
	 */
	public List<Object[]> queryKclist(ZxkcKccxVo model) {
		String sql = "select bb.HPBH,bb.HPMC,bb.BZGG,sum(ifnull(aa.sl,0)) as kc_zxdw, round(sum(ifnull(aa.sl,0)) / bb.DWZHL,2) as kc_dw from ( " +
                " select HPBH,HPSL as sl,CK,RKSJ as sj " +
                " from zxkc_yw_hprk where DR=0 " +
                " union all  " +
                " select HPBH,HPSL * (-1) as sl,CK,CKSJ as sj " +
                " from zxkc_yw_hpck where DR=0 " +
                " ) aa left join zxkc_yw_hpxx bb on aa.HPBH=bb.HPBH " +
                " where bb.DR=0 " +
                (CommonUtils.isNotBlank(model.getHpbh())  ? DaoUtils.sqlEq("aa.HPBH", model.getHpbh()) : "") +
                (CommonUtils.isNotBlank(model.getCk()) ? DaoUtils.sqlEq("aa.CK", model.getCk()) : "") +
                (CommonUtils.isNotBlank(model.getJzrq_str()) ? DaoUtils.sqlLe("aa.sj", model.getJzrq_str()) : "") +
                " group by bb.HPBH,bb.HPMC,bb.BZGG " +
                " having sum(ifnull(aa.sl,0)) <> 0" +
                " order by bb.HPBH";
		return DaoUtils.queryBySql(sql, DSFactory.CURRENT);
	}

}
