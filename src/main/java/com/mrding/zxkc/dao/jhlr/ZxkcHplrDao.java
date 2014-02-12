package com.mrding.zxkc.dao.jhlr;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.model.ZxkcYwHpxx;
import com.mrding.zxkc.vo.jhlr.ZxkcHplrVo.ZxkcHplrVo;

public class ZxkcHplrDao {

    public List<ZxkcYwHpxx> listHpxx() {
	List<Object[]> list = DaoUtils.queryBySql("select * from zxkc_yw_hpxx where DR=0", DSFactory.CURRENT);
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
	bean.setHpbh((Integer) objs[1]);
	bean.setHpmc((String) objs[2]);
	bean.setBzgg((String) objs[3]);
	bean.setDw((String) objs[4]);
	bean.setZxdw((String) objs[5]);
	bean.setDr((Integer) objs[6]);
	bean.setTs((Timestamp) objs[7]);
	bean.setLrr((String) objs[8]);
	bean.setXgr((String) objs[9]);
	bean.setXgsj((Timestamp) objs[10]);
	return bean;
    }

    public void save(ZxkcYwHpxx model) throws SQLException {
	if (CommonUtils.strIsNotBlank(model.getUkey())) {
	    update(model);
	} else {
            String sql = "insert into zxkc_yw_hpxx values(?,?,?,?,?,?,?,?,?,?,?)";
            Connection conn = DSFactory.CURRENT.getConn();
            PreparedStatement pstmt = null;
            try {
                pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, UUID.randomUUID().toString().replace("-", ""));
                pstmt.setInt(2, createHpbh());
                pstmt.setString(3, model.getHpmc());
                pstmt.setString(4, model.getBzgg());
                pstmt.setString(5, model.getDw());
                pstmt.setString(6, model.getZxdw());
                pstmt.setInt(7, 0);
                pstmt.setTimestamp(8, new Timestamp(new java.util.Date().getTime()));
                pstmt.setString(9, "");
                pstmt.setString(10, "");
                pstmt.setTimestamp(11, new Timestamp(new java.util.Date().getTime()));
                pstmt.executeUpdate();
            } finally {
                DaoUtils.close(conn, pstmt, null);
            }
	}
    }

    /**
     * 更新货品信息
     * @param model
     * @throws SQLException 
     */
    private void update(ZxkcYwHpxx model) throws SQLException {
        String sql = "update zxkc_yw_hpxx set HPMC=?,BZGG=?,DW=?,ZXDW=?,XGSJ=? where DR=0 and UKEY='" + model.getUkey() + "'";
        Connection conn = DSFactory.CURRENT.getConn();
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, model.getHpmc());
            pstmt.setString(2, model.getBzgg());
            pstmt.setString(3, model.getDw());
            pstmt.setString(4, model.getZxdw());
            pstmt.setTimestamp(5, new Timestamp(new java.util.Date().getTime()));
            pstmt.executeUpdate();
        } finally {
            DaoUtils.close(conn, pstmt, null);
        }
	
    }

    /**
     * 创建一个新的货品编号
     * @return
     */
    private int createHpbh() {
	List<Object[]> list = DaoUtils.queryBySql("select max( HPBH) from zxkc_yw_hpxx", DSFactory.CURRENT);
	if (CommonUtils.listIsNotBlank(list) && list.get(0)[0] != null) {
	    return ((Integer) list.get(0)[0]) + 1;
	} else {
	    return 1;
	}
    }

    /**
     * 根据主键删除货品
     * @param ukey
     * @throws SQLException 
     */
    public void deleteByPk(String ukey) throws SQLException {
	String sql = "update zxkc_yw_hpxx set DR=1 where UKEY='" + ukey + "'";
	DaoUtils.updateBySql(sql, DSFactory.CURRENT);
    }

}
