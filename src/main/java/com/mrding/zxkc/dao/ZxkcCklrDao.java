package com.mrding.zxkc.dao;

import java.math.BigDecimal;
import java.sql.*;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.model.ZxkcYwHpxx;
import com.mrding.zxkc.vo.ZxkcCklrVo;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class ZxkcCklrDao {
	
	private static Map<String, String> ckyyMap = new HashMap<String, String>();
	static {
		ckyyMap.put("xs", "销售");
		ckyyMap.put("sh", "损坏");
		ckyyMap.put("ds", "丢失");
		ckyyMap.put("other", "其他");
	}

	public void saveListByJSONArray(JSONArray jsonArray) throws SQLException, ParseException {
        String sql = "insert into zxkc_yw_hpck values(?,?,?,?,?,?,?,?,?,?,?)";
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
                pstmt.setInt(2, jsonObj.getInt("hpbh"));
                pstmt.setString(3, jsonObj.getString("ckyy"));
                pstmt.setString(4, jsonObj.getString("ck"));
                pstmt.setBigDecimal(5, new ZxkcHprkDao().countHpsl(jsonObj.getInt("hpbh"), new BigDecimal(String.valueOf(jsonObj.get("hpsl"))), jsonObj.getString("dwlx")));
                pstmt.setDate(6, new java.sql.Date(format.parse(jsonObj.getString("cksj")).getTime()));
                pstmt.setString(7, (String) jsonObj.get("bz"));
                pstmt.setInt(8, 0);
                pstmt.setTimestamp(9, new Timestamp(new java.util.Date().getTime()));
                pstmt.setNull(10, Types.TIMESTAMP);
                pstmt.setString(11, jsonObj.getString("ckr"));
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            conn.commit();
            conn.setAutoCommit(true);
        } finally {
            DaoUtils.close(conn, pstmt, null);
        }
	
	}

	public List<ZxkcCklrVo> listhpck(ZxkcCklrVo model) {
		return convertToVoList(DaoUtils.queryBySql(sqlListHpck(model), DSFactory.CURRENT));
	}

	private List<ZxkcCklrVo> convertToVoList(List<Object[]> list) {
		List<ZxkcCklrVo> voList = new ArrayList<ZxkcCklrVo>();
		if (CommonUtils.listIsNotBlank(list)) {
			for (Object[] objs : list) {
				voList.add(convertToVo(objs));
			}
		}
		return voList;
	}

	private ZxkcCklrVo convertToVo(Object[] objs) {
		ZxkcCklrVo voBean = new ZxkcCklrVo();
		voBean.setUkey((String) objs[0]);
		voBean.setHpbh((Integer) objs[1]);
		voBean.setHpmc((String) objs[2]);
		voBean.setCkyy((String) objs[3]);
		voBean.setCkyymc(getCkyy((String) objs[3]));
		voBean.setCk((String) objs[4]);
		voBean.setCkmc((String) objs[5]);
		voBean.setHpsl_zxdw((BigDecimal) objs[6]);
		voBean.setHpsl_dw((BigDecimal) objs[7]);
		voBean.setCksj((java.sql.Date) objs[8]);
		voBean.setCkr((String) objs[9]);
		voBean.setBz((String) objs[10]);
		return voBean;
	}

	private String getCkyy(String string) {
		return ckyyMap.get(string);
	}

	private String sqlListHpck(ZxkcCklrVo model) {
        return "SELECT a.UKEY,a.HPBH,b.HPMC,a.CKYY,c.CKDM,c.CKMC,a.HPSL as sl_zxdw, round(a.HPSL / b.DWZHL, 2) as sl_dw,a.CKSJ,a.CKR,a.BZ FROM zxkc_yw_hpck a " +
                " left join zxkc_yw_hpxx b on a.HPBH=b.HPBH and b.DR=0" +
                " left join zxkc_dm_ck c on a.CK=c.CKDM and c.DR=0" +
                " where a.DR=0" + 
                (CommonUtils.isNotBlank(model.getHpbh()) ? DaoUtils.sqlEq("a.HPBH", model.getHpbh()) : "") +
                (CommonUtils.isNotBlank(model.getCk()) ? DaoUtils.sqlEq("a.CK", model.getCk()) : "") +
                (CommonUtils.isNotBlank(model.getCksjq()) ? DaoUtils.sqlGe("a.CKSJ", model.getCksjq()) : "") +
                (CommonUtils.isNotBlank(model.getCksjz()) ? DaoUtils.sqlLe("a.CKSJ", model.getCksjz()) : "") + 
                (CommonUtils.isNotBlank(model.getCkr()) ? DaoUtils.sqlLike("a.CKR", "%" + model.getCkr() + "%") : "");
	}

	public void updateHpck(ZxkcCklrVo model) throws SQLException {
		String sql = "update zxkc_yw_hpck set HPBH=?,CKYY=?,CK=?,HPSL=?,CKSJ=?,BZ=?,CKR=?,XGSJ=? where DR=0 and UKEY=?";
		Connection conn = DSFactory.CURRENT.getConn();
		PreparedStatement pstmt = null;
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		try {
            pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, model.getHpbh());
			pstmt.setString(2, model.getCkyy());
			pstmt.setString(3, model.getCk());
			pstmt.setBigDecimal(4, new ZxkcHprkDao().countHpsl(model.getHpbh(), model.getHpsl(), model.getDwlx()));
			pstmt.setTimestamp(5, new Timestamp(model.getCksj().getTime()));
			pstmt.setString(6, model.getBz());
			pstmt.setString(7, model.getCkr());
			pstmt.setTimestamp(8, new Timestamp(new java.util.Date().getTime()));
			pstmt.setString(9, model.getUkey());
			pstmt.executeUpdate();
		} finally {
			DaoUtils.close(conn, pstmt, null);
		}
	}

	public void deleteByPk(String ukey) throws SQLException {
		String sql = "update zxkc_yw_hpck set DR=1 where UKEY='" + ukey + "'";
		DaoUtils.updateBySql(sql, DSFactory.CURRENT);
	}

}
