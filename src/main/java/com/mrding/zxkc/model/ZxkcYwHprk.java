package com.mrding.zxkc.model;

import java.math.BigDecimal;
import java.sql.Date;
import java.sql.Timestamp;

/**
 * 货品入库
 * @author mrding
 *
 */
public class ZxkcYwHprk {
    
    private String ukey;
    private Integer hpbh;
    private String hpmc;
    private String ghsmc;
    private String shr;
    private String shrdh;
    private BigDecimal hpsl;
    private String rkr;
    private Date rksj;
    private String bz;
    private int dr;
    private Timestamp ts;
    private String ck;

    public String getShr() {
		return shr;
	}
	public void setShr(String shr) {
		this.shr = shr;
	}
	public String getCk() {
		return ck;
	}
	public void setCk(String ck) {
		this.ck = ck;
	}
	public String getUkey() {
        return ukey;
    }
    public void setUkey(String ukey) {
        this.ukey = ukey;
    }
    public String getHpmc() {
        return hpmc;
    }
    public Integer getHpbh() {
		return hpbh;
	}
	public void setHpbh(Integer hpbh) {
		this.hpbh = hpbh;
	}
	public void setHpmc(String hpmc) {
        this.hpmc = hpmc;
    }
    public String getGhsmc() {
        return ghsmc;
    }
    public void setGhsmc(String ghsmc) {
        this.ghsmc = ghsmc;
    }
    public String getShrdh() {
        return shrdh;
    }
    public void setShrdh(String shrdh) {
        this.shrdh = shrdh;
    }
    public String getRkr() {
        return rkr;
    }
    public BigDecimal getHpsl() {
		return hpsl;
	}
	public void setHpsl(BigDecimal hpsl) {
		this.hpsl = hpsl;
	}
	public void setRkr(String rkr) {
        this.rkr = rkr;
    }
    public String getBz() {
        return bz;
    }
    public Date getRksj() {
		return rksj;
	}
	public void setRksj(Date rksj) {
		this.rksj = rksj;
	}
	public void setBz(String bz) {
        this.bz = bz;
    }
    public int getDr() {
        return dr;
    }
    public void setDr(int dr) {
        this.dr = dr;
    }
    public Timestamp getTs() {
        return ts;
    }
    public void setTs(Timestamp ts) {
        this.ts = ts;
    }

}
