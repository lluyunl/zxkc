package com.mrding.zxkc.dao;

import java.awt.Window.Type;
import java.math.BigDecimal;
import java.sql.*;
import java.text.*;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.tomcat.dbcp.dbcp.DbcpException;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.model.ZxkcYwHprk;
import com.mrding.zxkc.model.ZxkcYwHpxx;
import com.mrding.zxkc.utils.LocalUtils;
import com.mrding.zxkc.vo.ZxkcYwHprkVo;

public class ZxkcHprkDao {

    public List<Map<String, Object>> listHpbh() {
        String sql = "select distinct HPBH,HPMC from zxkc_yw_hpxx where DR=0 order by HPBH";
        return CommonUtils.convertSelectData(DaoUtils.queryBySql(sql, DSFactory.CURRENT), "hpbh", "hpmc");
    }

    /**
     * 将JSONArraay保存到数据库
     * @param jsonArray
     * @throws SQLException 
     * @throws ParseException 
     */
    public void saveListByJSONArray(JSONArray jsonArray) throws SQLException, ParseException {
        String sql = "insert into zxkc_yw_hprk values(?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
        Connection conn = DSFactory.CURRENT.getConn();
        PreparedStatement pstmt = null;
        try {
            pstmt = conn.prepareStatement(sql);
            conn.setAutoCommit(false);
            ZxkcHplrDao hplrDao = new ZxkcHplrDao();
            //日期格式器
            SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
            for (int i = 0, max = jsonArray.size(); i < max; i++) {
                JSONObject jsonObj = (JSONObject) jsonArray.get(i);
                //查询出货品信息，用于设值
                ZxkcYwHpxx hplrBean = hplrDao.queryByCol("HPBH", jsonObj.get("hpbh")).get(0);
                pstmt.setString(1, UUID.randomUUID().toString().replace("-", ""));
                pstmt.setInt(2, (int) jsonObj.get("hpbh"));
                pstmt.setString(3, hplrBean.getHpmc());
                pstmt.setString(4, jsonObj.getString("ghsmc"));
                pstmt.setString(5, "");
                pstmt.setString(6, "");
                pstmt.setBigDecimal(7, countHpsl(jsonObj.getInt("hpbh"), new BigDecimal(String.valueOf(jsonObj.get("hpsl"))), jsonObj.getString("dw")));
                pstmt.setString(8, jsonObj.getString("rkr"));
                pstmt.setDate(9, new java.sql.Date(format.parse(jsonObj.getString("rksj")).getTime()));
                pstmt.setString(10, (String) jsonObj.get("bz"));
                pstmt.setInt(11, 0);
                pstmt.setTimestamp(12, new Timestamp(new java.util.Date().getTime()));
                pstmt.setNull(13, Types.TIMESTAMP);
                pstmt.setString(14, jsonObj.getString("ck"));
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            conn.commit();
            conn.setAutoCommit(true);
        } finally {
            DaoUtils.close(conn, pstmt, null);
        }
	
    }

    /**
     * 根据条件查询货品入库信息
     * @param model
     * @return
     */
	public List<ZxkcYwHprkVo> listHprk(ZxkcYwHprkVo model) {
		return convertToVoList(DaoUtils.queryBySql(sqlListHprk(model), DSFactory.CURRENT));
	}

	/**
	 * 将查询结果转换为volist
	 * @param queryBySql
	 * @return
	 */
	private List<ZxkcYwHprkVo> convertToVoList(List<Object[]> list) {
		List<ZxkcYwHprkVo> voList = new ArrayList<ZxkcYwHprkVo>();
		if (CommonUtils.listIsNotBlank(list)) {
			for (Object[] objs : list) {
				voList.add(convertToVo(objs));
			}
		}
		return voList;
	}

	private ZxkcYwHprkVo convertToVo(Object[] objs) {
		ZxkcYwHprkVo voBean = new ZxkcYwHprkVo();
		voBean.setUkey((String) objs[0]);
		voBean.setHpbh((Integer) objs[1]);
		voBean.setHpmc((String) objs[2]);
		voBean.setGhsmc((String) objs[3]);
		voBean.setHpsl_zxdw((BigDecimal) objs[4]);
		voBean.setHpsl_dw((BigDecimal) objs[5]);
		voBean.setCk((String) objs[6]);
		voBean.setCkmc((String) objs[7]);
		voBean.setRkr((String) objs[8]);
		voBean.setRksj((java.sql.Date) objs[9]);
		voBean.setBz((String) objs[10]);
		return voBean;
	}

	/**
	 * 创建查询货品入库记录的sql
	 * @param model
	 * @return
	 */
	private String sqlListHprk(ZxkcYwHprkVo model) {
		return "select a.UKEY,a.HPBH,a.HPMC,a.GHSMC,a.HPSL as sl_zxdw, round((a.HPSL / b.DWZHL),2) as sl_dw,c.CKDM,c.CKMC,a.RKR,a.RKSJ,a.BZ" +
                " from zxkc_yw_hprk a " +
                " left join zxkc_yw_hpxx b on a.HPBH=b.HPBH and b.DR=0" +
                " left join zxkc_dm_ck c on a.CK=c.CKDM and c.DR=0" +
                " where a.DR=0" + 
                (CommonUtils.isNotBlank(model.getHpbh()) ? DaoUtils.sqlEq("a.HPBH", model.getHpbh()) : "") +
                (CommonUtils.isNotBlank(model.getCk()) ? DaoUtils.sqlEq("a.CK", model.getCk()) : "") +
                (CommonUtils.isNotBlank(model.getRksjq()) ? DaoUtils.sqlGe("a.RKSJ", model.getRksjq()) : "") +
                (CommonUtils.isNotBlank(model.getRksjz()) ? DaoUtils.sqlLe("a.RKSJ", model.getRksjz()) : "") + 
                (CommonUtils.isNotBlank(model.getGhsmc()) ? DaoUtils.sqlLike("a.GHSMC", "%" + model.getGhsmc() + "%") : "") +
                (CommonUtils.isNotBlank(model.getRkr()) ? DaoUtils.sqlLike("a.RKR", "%" + model.getRkr() + "%") : "") +
                " order by a.RKSJ";
	}

	/**
	 * 修改货品入库记录
	 * @param model
	 * @throws SQLException 
	 */
	public void updateHprk(ZxkcYwHprkVo model) throws SQLException {
		String sql = "update zxkc_yw_hprk set HPBH=?,HPMC=?,GHSMC=?,SHR=?,SHRDH=?,HPSL=?,RKR=?,RKSJ=?,BZ=?,CK=?,XGSJ=? where UKEY=?";
		Connection conn = DSFactory.CURRENT.getConn();
		PreparedStatement pstmt = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
            pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, model.getHpbh());
			pstmt.setString(2, LocalUtils.getHpmc(model.getHpbh()));
			pstmt.setString(3, model.getGhsmc());
			pstmt.setString(4, model.getShr());
			pstmt.setString(5, model.getShrdh());
			pstmt.setBigDecimal(6, countHpsl(model.getHpbh(), model.getHpsl(), model.getDwlx()));
			pstmt.setString(7, model.getRkr());
			pstmt.setTimestamp(8, new Timestamp(model.getRksj().getTime()));
			pstmt.setString(9, model.getBz());
			pstmt.setString(10, model.getCk());
			pstmt.setTimestamp(11, new Timestamp(new java.util.Date().getTime()));
			pstmt.setString(12, model.getUkey());
			pstmt.executeUpdate();
		} finally {
			DaoUtils.close(conn, pstmt, null);
		}
	}

	public BigDecimal countHpsl(Integer hpbh, BigDecimal hpsl, String dwlx) {
		if (dwlx != null && dwlx.equals("dw")) {
			//获取单位转换率
			BigDecimal dwzhl = new ZxkcHplrDao().getDwzhl(hpbh);
			return hpsl.multiply(dwzhl);
		} else {
			return hpsl;
		}
	}

	/**
	 * 根据主键删除记录
	 * @param ukey
	 * @throws SQLException 
	 */
	public void deleteByPk(String ukey) throws SQLException {
		String sql = "update zxkc_yw_hprk set DR=1 where UKEY='" + ukey + "'";
		DaoUtils.updateBySql(sql, DSFactory.CURRENT);
	}

}
