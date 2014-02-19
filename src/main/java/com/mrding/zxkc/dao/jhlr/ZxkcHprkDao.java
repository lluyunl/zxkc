package com.mrding.zxkc.dao.jhlr;

import java.math.BigDecimal;
import java.sql.*;
import java.text.*;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import com.mrding.common.CommonUtils;
import com.mrding.common.dao.DSFactory;
import com.mrding.common.dao.DaoUtils;
import com.mrding.zxkc.model.ZxkcYwHpxx;

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
        String sql = "insert into zxkc_yw_hprk values(?,?,?,?,?,?,?,?,?,?,?,?,?)";
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
                pstmt.setString(4, (String) jsonObj.get("ghsmc"));
                pstmt.setString(5, (String) jsonObj.get("shr"));
                pstmt.setString(6, (String) jsonObj.get("shrdh"));
                pstmt.setBigDecimal(7, new BigDecimal(String.valueOf(jsonObj.get("hpsl"))));
                pstmt.setString(8, (String) jsonObj.get("rkr"));
                pstmt.setDate(9, new java.sql.Date(format.parse((String) jsonObj.get("rksj")).getTime()));
                pstmt.setString(10, (String) jsonObj.get("bz"));
                pstmt.setInt(11, 0);
                pstmt.setTimestamp(12, new Timestamp(new java.util.Date().getTime()));
                pstmt.setString(13, jsonObj.getString("ck"));
                pstmt.addBatch();
            }
            pstmt.executeBatch();
            conn.commit();
            conn.setAutoCommit(true);
        } finally {
            DaoUtils.close(conn, pstmt, null);
        }
	
    }

}
