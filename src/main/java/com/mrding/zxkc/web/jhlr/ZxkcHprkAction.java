package com.mrding.zxkc.web.jhlr;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.xml.crypto.URIDereferencer;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.model.ZxkcYwHprk;
import com.mrding.zxkc.server.jhlr.ZxkcHprkManager;

/**
 * 货品入库
 * @author mrding
 *
 */
public class ZxkcHprkAction extends ActionSupport<ZxkcYwHprk, ZxkcHprkManager> {
    
    public String list() {
        return "list";
    }
    
    /**
     * 加载货品编号下拉单
     * @return
     */
    public String loadHpbhSelect() {
	jsonMap.put("hpbhSelect", manager.listHpbhSelect());
	jsonMap.put("success", true);
	return SUCCESS;
    }
    
    public String saveHprkList() {
	try {
            String dataJson = URLDecoder.decode(request.getParameter("data"), "utf-8");
            manager.saveHprkByJsonStr(dataJson);
            jsonMap.put("success", true);
	} catch(Exception e) {
            jsonMap.put("success", false);
	}
        return SUCCESS;
    }

}
