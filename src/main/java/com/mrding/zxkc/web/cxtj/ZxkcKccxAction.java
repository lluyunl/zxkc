package com.mrding.zxkc.web.cxtj;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.server.ZxkcKccxManager;
import com.mrding.zxkc.vo.ZxkcKccxVo;

public class ZxkcKccxAction extends ActionSupport<ZxkcKccxVo, ZxkcKccxManager> {
    
    public String list() {
        return "kccx";
    }
    
    public String loadKclist() {
    	jsonMap.put("kclist", manager.loadKclist(model));
    	return SUCCESS;
    }


}
