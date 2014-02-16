package com.mrding.zxkc.web.ck;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.manager.ZxkcCklrManager;
import com.mrding.zxkc.vo.ZxkcCklrVo;

public class ZxkcCklrAction extends ActionSupport<ZxkcCklrVo, ZxkcCklrManager> {
    
    public String list() {
	return "cklr";
    }

}
