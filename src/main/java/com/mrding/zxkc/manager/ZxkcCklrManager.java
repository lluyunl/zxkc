package com.mrding.zxkc.manager;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.List;

import com.mrding.zxkc.dao.ck.ZxkcCklrDao;
import com.mrding.zxkc.vo.ZxkcCklrVo;

import net.sf.json.JSONArray;

public class ZxkcCklrManager {
	
	ZxkcCklrDao dao = new ZxkcCklrDao();

	public void saveHpckByJsonStr(String dataJson) throws SQLException, ParseException {
        JSONArray jsonArray = JSONArray.fromObject(dataJson);
        dao.saveListByJSONArray(jsonArray);
	}

	public List<ZxkcCklrVo> listHpck(ZxkcCklrVo model) {
		return dao.listhpck(model);
	}

	public void modifyHpck(ZxkcCklrVo model) throws SQLException {
		dao.updateHpck(model);
	}

	public void deleteHpck(String ukey) throws SQLException {
		dao.deleteByPk(ukey);
	}

}
