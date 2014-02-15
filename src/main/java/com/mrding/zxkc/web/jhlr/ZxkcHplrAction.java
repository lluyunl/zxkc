package com.mrding.zxkc.web.jhlr;

import java.util.*;

import javax.servlet.ServletContext;

import com.mrding.common.CommonUtils;
import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.manager.ManagerFactory;
import com.mrding.zxkc.server.jhlr.ZxkcHplrManager;
import com.mrding.zxkc.vo.jhlr.ZxkcHplrVo.ZxkcHplrVo;
import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ModelDriven;

public class ZxkcHplrAction extends ActionSupport<ZxkcHplrVo, ZxkcHplrManager>{

    public String list() {
	return "hplr";
    }
    
    /**
     * 查询所有货品信息
     * @return
     */
    public String listHpxx() {
	if (CommonUtils.strIsNotBlank(model.getHpmc())) {
	    return queryHpxxByMc();
	}
	jsonMap.put("hpxxList", manager.listHpxx());
	return "success";
    }
    
    /**
     * 添加货品
     * @return
     */
    public String addHp() {
	try {
            manager.addHp(model);
            jsonMap.put("success", true);
	} catch(Exception e) {
	    e.printStackTrace();
	    jsonMap.put("success", false);
	}
	return "success";
    }
    
    /**
     * 删除货品
     * @return
     */
    public String deleteHp() {
	try {
	    manager.deleteHp(model.getUkey());
	    jsonMap.put("success", true);
	} catch(Exception e) {
	    e.printStackTrace();
	    jsonMap.put("success", false);
	}
	return "success";
    }
    
    public String queryHpxxByMc() {
	jsonMap.put("hpxxList", manager.queryHpxxByMc(model.getHpmc()));
	jsonMap.put("success", true);
	return SUCCESS;
    }
    
    
}
