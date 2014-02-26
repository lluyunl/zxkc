package com.mrding.zxkc.web.cxtj;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.server.ZxkcYxtjManger;
import com.mrding.zxkc.vo.ZxkcYxtjVo;

public class ZxkcYxtjAction extends ActionSupport<ZxkcYxtjVo, ZxkcYxtjManger> {
	
	public String list() {
		model.setDmList(manager.listDm());
		return "yxtj";
	}
	
	/**
	 * 查询营销统计数据
	 * @return
	 */
	public String loadYxtj() {
		jsonMap.put("yxtjList", manager.getYxtjList(model));
		return SUCCESS;
	}

}
