package com.mrding.zxkc.server.jhlr;

import java.sql.SQLException;
import java.text.ParseException;
import java.util.Collection;
import java.util.List;
import java.util.Map;

import net.sf.json.JSONArray;

import com.mrding.common.CommonUtils;
import com.mrding.zxkc.dao.jhlr.ZxkcHprkDao;
import com.mrding.zxkc.dm.CkDmBean;
import com.mrding.zxkc.model.ZxkcYwHprk;
import com.mrding.zxkc.model.ZxkcYwHpxx;
import com.mrding.zxkc.vo.jhlr.ZxkcYwHprkVo;

public class ZxkcHprkManager {

    private ZxkcHprkDao dao = new ZxkcHprkDao();
    
    /**
     * 查询货品编号下拉框
     * @return
     */
    public List<Map<String, Object>> listHpbhSelect() {
        return dao.listHpbh();
    }

    /**
     * 解析json字符串并保存货品入库信息
     * @param dataJson
     * @throws ParseException 
     * @throws SQLException 
     */
    public void saveHprkByJsonStr(String dataJson) throws SQLException, ParseException {
        JSONArray jsonArray = JSONArray.fromObject(dataJson);
        dao.saveListByJSONArray(jsonArray);
    }

    /**
     * 查询仓库下拉单
     * @return
     */
	public List<Map<String, String>> listCkSelect() {
		return CkDmBean.instance().listSelect();
	}

	/**
	 * 查询货品入库记录
	 * @param model
	 * @return
	 */
	public List<ZxkcYwHprkVo> listHprk(ZxkcYwHprkVo model) {
		return dao.listHprk(model);
	}

	/**
	 * 修改货品入库记录
	 * @param model
	 * @throws SQLException 
	 */
	public void modifyHprk(ZxkcYwHprkVo model) throws SQLException {
		dao.updateHprk(model);
	}

	/**
	 * 根据主键删除货品入库记录
	 * @param ukey
	 * @throws SQLException 
	 */
	public void deleteHprk(String ukey) throws SQLException {
		dao.deleteByPk(ukey);
	}

}
