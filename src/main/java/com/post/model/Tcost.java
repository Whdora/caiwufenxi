package com.post.model;

import java.sql.Timestamp;
import java.util.Date;
import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Tcost entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tcost", catalog = "cwfx")
public class Tcost implements java.io.Serializable {

	// Fields

	private String cid;
	private Tdept tdept;
	private Tsubject tsubject;
	private Tbudget tbudget;
	private Tuser tuser;
	private Tkind tkind;
	private Tzrzx tzrzx;
	private Tshangpin tshangpin;
	private Tproject tproject;
	private String cbh;
	private Date cdate;
	private String clzfs;
	private String cshiyou;
	private Double camount;
	private Double csj;
	private String cxz;
	private String cpzh;
	private String crzsx;
	private Integer cprogress;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private Integer ciszd;
	private String cfx;
	private Set<Tkmlz> tkmlzs = new HashSet<Tkmlz>(0);

	// Constructors

	/** default constructor */
	public Tcost() {
	}

	/** minimal constructor */
	public Tcost(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tcost(String cid, Tdept tdept, Tsubject tsubject, Tbudget tbudget, Tuser tuser, Tkind tkind, Tzrzx tzrzx, Tshangpin tshangpin, Tproject tproject, String cbh, Date cdate, String clzfs, String cshiyou, Double camount, Double csj, String cxz, String cpzh, String crzsx, Integer cprogress, Timestamp ccreatedate, Timestamp cmodifydate, Integer ciszd, String cfx, Set<Tkmlz> tkmlzs) {
		this.cid = cid;
		this.tdept = tdept;
		this.tsubject = tsubject;
		this.tbudget = tbudget;
		this.tuser = tuser;
		this.tkind = tkind;
		this.tzrzx = tzrzx;
		this.tshangpin = tshangpin;
		this.tproject = tproject;
		this.cbh = cbh;
		this.cdate = cdate;
		this.clzfs = clzfs;
		this.cshiyou = cshiyou;
		this.camount = camount;
		this.csj = csj;
		this.cxz = cxz;
		this.cpzh = cpzh;
		this.crzsx = crzsx;
		this.cprogress = cprogress;
		this.ccreatedate = ccreatedate;
		this.cmodifydate = cmodifydate;
		this.ciszd = ciszd;
		this.cfx = cfx;
		this.tkmlzs = tkmlzs;
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

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CDEPTMENT")
	public Tdept getTdept() {
		return this.tdept;
	}

	public void setTdept(Tdept tdept) {
		this.tdept = tdept;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CKJKM")
	public Tsubject getTsubject() {
		return this.tsubject;
	}

	public void setTsubject(Tsubject tsubject) {
		this.tsubject = tsubject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CGSYS")
	public Tbudget getTbudget() {
		return this.tbudget;
	}

	public void setTbudget(Tbudget tbudget) {
		this.tbudget = tbudget;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CUSERID")
	public Tuser getTuser() {
		return this.tuser;
	}

	public void setTuser(Tuser tuser) {
		this.tuser = tuser;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CGUILEI")
	public Tkind getTkind() {
		return this.tkind;
	}

	public void setTkind(Tkind tkind) {
		this.tkind = tkind;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CZRZX")
	public Tzrzx getTzrzx() {
		return this.tzrzx;
	}

	public void setTzrzx(Tzrzx tzrzx) {
		this.tzrzx = tzrzx;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CSHANGPIN")
	public Tshangpin getTshangpin() {
		return this.tshangpin;
	}

	public void setTshangpin(Tshangpin tshangpin) {
		this.tshangpin = tshangpin;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CPROJECT")
	public Tproject getTproject() {
		return this.tproject;
	}

	public void setTproject(Tproject tproject) {
		this.tproject = tproject;
	}

	@Column(name = "CBH", length = 20)
	public String getCbh() {
		return this.cbh;
	}

	public void setCbh(String cbh) {
		this.cbh = cbh;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CDATE", length = 10)
	public Date getCdate() {
		return this.cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	@Column(name = "CLZFS", length = 20)
	public String getClzfs() {
		return this.clzfs;
	}

	public void setClzfs(String clzfs) {
		this.clzfs = clzfs;
	}

	@Column(name = "CSHIYOU", length = 65535)
	public String getCshiyou() {
		return this.cshiyou;
	}

	public void setCshiyou(String cshiyou) {
		this.cshiyou = cshiyou;
	}

	@Column(name = "CAMOUNT", precision = 10)
	public Double getCamount() {
		return this.camount;
	}

	public void setCamount(Double camount) {
		this.camount = camount;
	}

	@Column(name = "CSJ", precision = 10)
	public Double getCsj() {
		return this.csj;
	}

	public void setCsj(Double csj) {
		this.csj = csj;
	}

	@Column(name = "CXZ", length = 8)
	public String getCxz() {
		return this.cxz;
	}

	public void setCxz(String cxz) {
		this.cxz = cxz;
	}

	@Column(name = "CPZH", length = 30)
	public String getCpzh() {
		return this.cpzh;
	}

	public void setCpzh(String cpzh) {
		this.cpzh = cpzh;
	}

	@Column(name = "CRZSX", length = 4)
	public String getCrzsx() {
		return this.crzsx;
	}

	public void setCrzsx(String crzsx) {
		this.crzsx = crzsx;
	}

	@Column(name = "CPROGRESS")
	public Integer getCprogress() {
		return this.cprogress;
	}

	public void setCprogress(Integer cprogress) {
		this.cprogress = cprogress;
	}

	@Column(name = "CCREATEDATE", length = 19)
	public Timestamp getCcreatedate() {
		return this.ccreatedate;
	}

	public void setCcreatedate(Timestamp ccreatedate) {
		this.ccreatedate = ccreatedate;
	}

	@Column(name = "CMODIFYDATE", length = 19)
	public Timestamp getCmodifydate() {
		return this.cmodifydate;
	}

	public void setCmodifydate(Timestamp cmodifydate) {
		this.cmodifydate = cmodifydate;
	}

	@Column(name = "CISZD")
	public Integer getCiszd() {
		return this.ciszd;
	}

	public void setCiszd(Integer ciszd) {
		this.ciszd = ciszd;
	}

	@Column(name = "CFX", length = 10)
	public String getCfx() {
		return this.cfx;
	}

	public void setCfx(String cfx) {
		this.cfx = cfx;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tcost")
	public Set<Tkmlz> getTkmlzs() {
		return this.tkmlzs;
	}

	public void setTkmlzs(Set<Tkmlz> tkmlzs) {
		this.tkmlzs = tkmlzs;
	}

}