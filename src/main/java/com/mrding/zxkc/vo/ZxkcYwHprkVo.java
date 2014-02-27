package com.mrding.zxkc.vo;

import java.math.BigDecimal;

import com.mrding.zxkc.model.ZxkcYwHprk;

public class ZxkcYwHprkVo extends ZxkcYwHprk {
	
	private String rksjq;
	private String rksjz;
	private String ckmc;
	private BigDecimal hpsl_zxdw;
	private BigDecimal hpsl_dw;
	private String dwlx;

	public String getDwlx() {
		return dwlx;
	}
	public void setDwlx(String dwlx) {
		this.dwlx = dwlx;
	}
	public BigDecimal getHpsl_zxdw() {
		return hpsl_zxdw;
	}
	public void setHpsl_zxdw(BigDecimal hpsl_zxdw) {
		this.hpsl_zxdw = hpsl_zxdw;
	}
	public BigDecimal getHpsl_dw() {
		return hpsl_dw;
	}
	public void setHpsl_dw(BigDecimal hpsl_dw) {
		this.hpsl_dw = hpsl_dw;
	}
	public String getCkmc() {
		return ckmc;
	}
	public void setCkmc(String ckmc) {
		this.ckmc = ckmc;
	}
	public String getRksjq() {
		return rksjq;
	}
	public void setRksjq(String rksjq) {
		this.rksjq = rksjq;
	}
	public String getRksjz() {
		return rksjz;
	}
	public void setRksjz(String rksjz) {
		this.rksjz = rksjz;
	}

}
