package com.mrding.zxkc.server.jhlr;

import java.util.*;

import com.mrding.zxkc.dao.jhlr.ZxkcHplrDao;
import com.mrding.zxkc.model.ZxkcYwHpxx;

public class ZxkcHplrManager {
    
    ZxkcHplrDao dao = new ZxkcHplrDao();

    /**
     * 查询所有货品信息
     * @return
     */
    public List<ZxkcYwHpxx> listHpxx() {
	return dao.listHpxx();
    }

}
