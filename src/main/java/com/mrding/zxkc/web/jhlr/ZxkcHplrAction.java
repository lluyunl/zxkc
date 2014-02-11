package com.mrding.zxkc.web.jhlr;

import java.util.*;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.manager.ManagerFactory;
import com.mrding.zxkc.server.jhlr.ZxkcHplrManager;
import com.mrding.zxkc.vo.jhlr.ZxkcHplrVo.ZxkcHplrVo;
import com.opensymphony.xwork2.ModelDriven;

public class ZxkcHplrAction extends ActionSupport<ZxkcHplrVo, ZxkcHplrManager>{

    public String list() {
	return "hplr";
    }
    
    public String listHpxx() {
	jsonMap.put("hpxxList", manager.listHpxx());
	return "success";
    }
    
}
