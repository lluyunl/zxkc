package com.mrding.zxkc.web.ck;

import java.net.URLDecoder;

import com.mrding.common.web.ActionSupport;
import com.mrding.zxkc.server.ZxkcCklrManager;
import com.mrding.zxkc.vo.ZxkcCklrVo;

public class ZxkcCklrAction extends ActionSupport<ZxkcCklrVo, ZxkcCklrManager> {
    
    public String list() {
	return "cklr";
    }
    
    public String saveHpck() {
        try {
            String dataJson = URLDecoder.decode(request.getParameter("data"), "utf-8");
            manager.saveHpckByJsonStr(dataJson);
            jsonMap.put("success", true);
        } catch(Exception e) {
            e.printStackTrace();
            jsonMap.put("success", false);
        }
        return SUCCESS;
    }
    
    public String funcCkwh() {
    	return "ckwh";
    }
    
    
    public String loadHpckList() {
    	jsonMap.put("hpckList", manager.listHpck(model));
    	return SUCCESS;
    }
    
    public String modifyHpck() {
        try {
    		manager.modifyHpck(model);
    		jsonMap.put("success", true);
    	} catch(Exception e) {
    		e.printStackTrace();
    		jsonMap.put("success", false);
    	}
    	return SUCCESS;
    }
    
    public String deleteHpck() {
        try {
            manager.deleteHpck(model.getUkey());
            jsonMap.put("success", true);
    	} catch(Exception e) {
    		e.printStackTrace();
            jsonMap.put("success", false);
    	}
    	return SUCCESS;
    }

}
