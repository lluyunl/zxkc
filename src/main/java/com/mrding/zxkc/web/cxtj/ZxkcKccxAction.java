package com.mrding.zxkc.web.cxtj;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.server.cxtj.ZxkcKccxManager;
import com.mrding.zxkc.vo.cxtj.ZxkKccxVo;

public class ZxkcKccxAction extends ActionSupport<ZxkKccxVo, ZxkcKccxManager> {
    
    public String list() {
        return "kccx";
    }


}
