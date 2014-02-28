package com.mrding.zxkc.vo;

import java.math.BigDecimal;
import java.util.*;

public class ZxkcYxtjVo {
	
	//店面list,用于绘制表头和查询结果时的列
	private List<Object[]> dmList;
	
	private Integer hpbh;
	private String hpmc;
	private String qsrq_str;
	private String jzrq_str;
	private String dwlx;
	
	public String getDwlx() {
		return dwlx;
	}

	public void setDwlx(String dwlx) {
		this.dwlx = dwlx;
	}

	public String getHpmc() {
		return hpmc;
	}

	public void setHpmc(String hpmc) {
		this.hpmc = hpmc;
	}

	public Integer getHpbh() {
		return hpbh;
	}

	public void setHpbh(Integer hpbh) {
		this.hpbh = hpbh;
	}

	public String getJzrq_str() {
		return jzrq_str;
	}

	public void setJzrq_str(String jzrq_str) {
		this.jzrq_str = jzrq_str;
	}

	public String getQsrq_str() {
		return qsrq_str;
	}

	public void setQsrq_str(String qsrq_str) {
		this.qsrq_str = qsrq_str;
	}

	public List<Object[]> getDmList() {
		return dmList;
	}

	public void setDmList(List<Object[]> dmList) {
		this.dmList = dmList;
	}


}
