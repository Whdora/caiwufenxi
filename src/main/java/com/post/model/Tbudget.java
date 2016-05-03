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
 * Tbudget entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tbudget", catalog = "cwfx")
public class Tbudget implements java.io.Serializable {

	// Fields

	private String cid;
	private Tproject tproject;
	private Tfile tfile;
	private Tzrzx tzrzx;
	private Tuser tuser;
	private Tdept tdept;
	private Double cyjywls;
	private Double cyjfy;
	private Double cyjlr;
	private Date cyjqssj;
	private Date csjqssj;
	private Double csjfy;
	private Double cfycy;
	private Double cyt;
	private Double cytcy;
	private Double csj;
	private Double ctotal;
	private Integer cstate;
	private Date cdate;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private String cauditfilename;
	private String cauditfilepath;
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);

	// Constructors

	/** default constructor */
	public Tbudget() {
	}

	/** minimal constructor */
	public Tbudget(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tbudget(String cid, Tproject tproject, Tfile tfile, Tzrzx tzrzx, Tuser tuser, Tdept tdept, Double cyjywls, Double cyjfy, Double cyjlr, Date cyjqssj, Date csjqssj, Double csjfy, Double cfycy, Double cyt, Double cytcy, Double csj, Double ctotal, Integer cstate, Date cdate, Timestamp ccreatedate, Timestamp cmodifydate, String cauditfilename, String cauditfilepath, Set<Tcost> tcosts) {
		this.cid = cid;
		this.tproject = tproject;
		this.tfile = tfile;
		this.tzrzx = tzrzx;
		this.tuser = tuser;
		this.tdept = tdept;
		this.cyjywls = cyjywls;
		this.cyjfy = cyjfy;
		this.cyjlr = cyjlr;
		this.cyjqssj = cyjqssj;
		this.csjqssj = csjqssj;
		this.csjfy = csjfy;
		this.cfycy = cfycy;
		this.cyt = cyt;
		this.cytcy = cytcy;
		this.csj = csj;
		this.ctotal = ctotal;
		this.cstate = cstate;
		this.cdate = cdate;
		this.ccreatedate = ccreatedate;
		this.cmodifydate = cmodifydate;
		this.cauditfilename = cauditfilename;
		this.cauditfilepath = cauditfilepath;
		this.tcosts = tcosts;
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
	@JoinColumn(name = "CPROJECTID")
	public Tproject getTproject() {
		return this.tproject;
	}

	public void setTproject(Tproject tproject) {
		this.tproject = tproject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CFILEID")
	public Tfile getTfile() {
		return this.tfile;
	}

	public void setTfile(Tfile tfile) {
		this.tfile = tfile;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CZRZXID")
	public Tzrzx getTzrzx() {
		return this.tzrzx;
	}

	public void setTzrzx(Tzrzx tzrzx) {
		this.tzrzx = tzrzx;
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
	@JoinColumn(name = "CDEPTID")
	public Tdept getTdept() {
		return this.tdept;
	}

	public void setTdept(Tdept tdept) {
		this.tdept = tdept;
	}

	@Column(name = "CYJYWLS", precision = 16)
	public Double getCyjywls() {
		return this.cyjywls;
	}

	public void setCyjywls(Double cyjywls) {
		this.cyjywls = cyjywls;
	}

	@Column(name = "CYJFY", precision = 16)
	public Double getCyjfy() {
		return this.cyjfy;
	}

	public void setCyjfy(Double cyjfy) {
		this.cyjfy = cyjfy;
	}

	@Column(name = "CYJLR", precision = 16)
	public Double getCyjlr() {
		return this.cyjlr;
	}

	public void setCyjlr(Double cyjlr) {
		this.cyjlr = cyjlr;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CYJQSSJ", length = 10)
	public Date getCyjqssj() {
		return this.cyjqssj;
	}

	public void setCyjqssj(Date cyjqssj) {
		this.cyjqssj = cyjqssj;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CSJQSSJ", length = 10)
	public Date getCsjqssj() {
		return this.csjqssj;
	}

	public void setCsjqssj(Date csjqssj) {
		this.csjqssj = csjqssj;
	}

	@Column(name = "CSJFY", precision = 16)
	public Double getCsjfy() {
		return this.csjfy;
	}

	public void setCsjfy(Double csjfy) {
		this.csjfy = csjfy;
	}

	@Column(name = "CFYCY", precision = 16)
	public Double getCfycy() {
		return this.cfycy;
	}

	public void setCfycy(Double cfycy) {
		this.cfycy = cfycy;
	}

	@Column(name = "CYT", precision = 16)
	public Double getCyt() {
		return this.cyt;
	}

	public void setCyt(Double cyt) {
		this.cyt = cyt;
	}

	@Column(name = "CYTCY", precision = 16)
	public Double getCytcy() {
		return this.cytcy;
	}

	public void setCytcy(Double cytcy) {
		this.cytcy = cytcy;
	}

	@Column(name = "CSJ", precision = 16)
	public Double getCsj() {
		return this.csj;
	}

	public void setCsj(Double csj) {
		this.csj = csj;
	}

	@Column(name = "CTOTAL", precision = 16)
	public Double getCtotal() {
		return this.ctotal;
	}

	public void setCtotal(Double ctotal) {
		this.ctotal = ctotal;
	}

	@Column(name = "CSTATE")
	public Integer getCstate() {
		return this.cstate;
	}

	public void setCstate(Integer cstate) {
		this.cstate = cstate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CDATE", length = 10)
	public Date getCdate() {
		return this.cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
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

	@Column(name = "CAUDITFILENAME", length = 200)
	public String getCauditfilename() {
		return this.cauditfilename;
	}

	public void setCauditfilename(String cauditfilename) {
		this.cauditfilename = cauditfilename;
	}

	@Column(name = "CAUDITFILEPATH", length = 200)
	public String getCauditfilepath() {
		return this.cauditfilepath;
	}

	public void setCauditfilepath(String cauditfilepath) {
		this.cauditfilepath = cauditfilepath;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tbudget")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

}