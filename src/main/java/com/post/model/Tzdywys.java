package com.post.model;

import java.sql.Timestamp;
import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Tzdywys entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tzdywys", catalog = "cwfx")
public class Tzdywys implements java.io.Serializable {

	// Fields

	private String cid;
	private Date cmakedate;
	private String cfilenumber;
	private String cfilename;
	private String ccontent;
	private String ccycle;
	private String czhuanye;
	private String cproject;
	private Double cywls;
	private Double ccost;
	private Double cprofit;
	private Date cplandate;
	private Timestamp ccreatedatetime;
	private Timestamp cmodifydatetime;
	private String ccreateuser;

	// Constructors

	/** default constructor */
	public Tzdywys() {
	}

	/** minimal constructor */
	public Tzdywys(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tzdywys(String cid, Date cmakedate, String cfilenumber, String cfilename, String ccontent, String ccycle, String czhuanye, String cproject, Double cywls, Double ccost, Double cprofit, Date cplandate, Timestamp ccreatedatetime, Timestamp cmodifydatetime, String ccreateuser) {
		this.cid = cid;
		this.cmakedate = cmakedate;
		this.cfilenumber = cfilenumber;
		this.cfilename = cfilename;
		this.ccontent = ccontent;
		this.ccycle = ccycle;
		this.czhuanye = czhuanye;
		this.cproject = cproject;
		this.cywls = cywls;
		this.ccost = ccost;
		this.cprofit = cprofit;
		this.cplandate = cplandate;
		this.ccreatedatetime = ccreatedatetime;
		this.cmodifydatetime = cmodifydatetime;
		this.ccreateuser = ccreateuser;
	}

	// Property accessors
	@Id
	@Column(name = "CID", unique = true, nullable = false, length = 36)
	public String getCid() {
		return this.cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CMAKEDATE", length = 10)
	public Date getCmakedate() {
		return this.cmakedate;
	}

	public void setCmakedate(Date cmakedate) {
		this.cmakedate = cmakedate;
	}

	@Column(name = "CFILENUMBER", length = 30)
	public String getCfilenumber() {
		return this.cfilenumber;
	}

	public void setCfilenumber(String cfilenumber) {
		this.cfilenumber = cfilenumber;
	}

	@Column(name = "CFILENAME", length = 100)
	public String getCfilename() {
		return this.cfilename;
	}

	public void setCfilename(String cfilename) {
		this.cfilename = cfilename;
	}

	@Column(name = "CCONTENT", length = 65535)
	public String getCcontent() {
		return this.ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	@Column(name = "CCYCLE", length = 16)
	public String getCcycle() {
		return this.ccycle;
	}

	public void setCcycle(String ccycle) {
		this.ccycle = ccycle;
	}

	@Column(name = "CZHUANYE", length = 36)
	public String getCzhuanye() {
		return this.czhuanye;
	}

	public void setCzhuanye(String czhuanye) {
		this.czhuanye = czhuanye;
	}

	@Column(name = "CPROJECT", length = 36)
	public String getCproject() {
		return this.cproject;
	}

	public void setCproject(String cproject) {
		this.cproject = cproject;
	}

	@Column(name = "CYWLS", precision = 10)
	public Double getCywls() {
		return this.cywls;
	}

	public void setCywls(Double cywls) {
		this.cywls = cywls;
	}

	@Column(name = "CCOST", precision = 10)
	public Double getCcost() {
		return this.ccost;
	}

	public void setCcost(Double ccost) {
		this.ccost = ccost;
	}

	@Column(name = "CPROFIT", precision = 10)
	public Double getCprofit() {
		return this.cprofit;
	}

	public void setCprofit(Double cprofit) {
		this.cprofit = cprofit;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CPLANDATE", length = 10)
	public Date getCplandate() {
		return this.cplandate;
	}

	public void setCplandate(Date cplandate) {
		this.cplandate = cplandate;
	}

	@Column(name = "CCREATEDATETIME", length = 19)
	public Timestamp getCcreatedatetime() {
		return this.ccreatedatetime;
	}

	public void setCcreatedatetime(Timestamp ccreatedatetime) {
		this.ccreatedatetime = ccreatedatetime;
	}

	@Column(name = "CMODIFYDATETIME", length = 19)
	public Timestamp getCmodifydatetime() {
		return this.cmodifydatetime;
	}

	public void setCmodifydatetime(Timestamp cmodifydatetime) {
		this.cmodifydatetime = cmodifydatetime;
	}

	@Column(name = "CCREATEUSER", length = 36)
	public String getCcreateuser() {
		return this.ccreateuser;
	}

	public void setCcreateuser(String ccreateuser) {
		this.ccreateuser = ccreateuser;
	}

}