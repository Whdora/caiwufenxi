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
 * Tfile entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tfile", catalog = "cwfx")
public class Tfile implements java.io.Serializable {

	// Fields

	private String cid;
	private Tdept tdept;
	private String cfilenumber;
	private String cname;
	private Timestamp ccreatedate;
	private Date cdate;
	private Timestamp cmodifydate;
	private Date cstartdate;
	private Date cenddate;
	private Integer cpass;
	private String cfilepath;
	private Set<Tbudget> tbudgets = new HashSet<Tbudget>(0);

	// Constructors

	/** default constructor */
	public Tfile() {
	}

	/** minimal constructor */
	public Tfile(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tfile(String cid, Tdept tdept, String cfilenumber, String cname, Timestamp ccreatedate, Date cdate, Timestamp cmodifydate, Date cstartdate, Date cenddate, Integer cpass, String cfilepath, Set<Tbudget> tbudgets) {
		this.cid = cid;
		this.tdept = tdept;
		this.cfilenumber = cfilenumber;
		this.cname = cname;
		this.ccreatedate = ccreatedate;
		this.cdate = cdate;
		this.cmodifydate = cmodifydate;
		this.cstartdate = cstartdate;
		this.cenddate = cenddate;
		this.cpass = cpass;
		this.cfilepath = cfilepath;
		this.tbudgets = tbudgets;
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
	@JoinColumn(name = "CDEPTID")
	public Tdept getTdept() {
		return this.tdept;
	}

	public void setTdept(Tdept tdept) {
		this.tdept = tdept;
	}

	@Column(name = "CFILENUMBER", length = 30)
	public String getCfilenumber() {
		return this.cfilenumber;
	}

	public void setCfilenumber(String cfilenumber) {
		this.cfilenumber = cfilenumber;
	}

	@Column(name = "CNAME", length = 60)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "CCREATEDATE", length = 19)
	public Timestamp getCcreatedate() {
		return this.ccreatedate;
	}

	public void setCcreatedate(Timestamp ccreatedate) {
		this.ccreatedate = ccreatedate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CDATE", length = 10)
	public Date getCdate() {
		return this.cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	@Column(name = "CMODIFYDATE", length = 19)
	public Timestamp getCmodifydate() {
		return this.cmodifydate;
	}

	public void setCmodifydate(Timestamp cmodifydate) {
		this.cmodifydate = cmodifydate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CSTARTDATE", length = 10)
	public Date getCstartdate() {
		return this.cstartdate;
	}

	public void setCstartdate(Date cstartdate) {
		this.cstartdate = cstartdate;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CENDDATE", length = 10)
	public Date getCenddate() {
		return this.cenddate;
	}

	public void setCenddate(Date cenddate) {
		this.cenddate = cenddate;
	}

	@Column(name = "CPASS")
	public Integer getCpass() {
		return this.cpass;
	}

	public void setCpass(Integer cpass) {
		this.cpass = cpass;
	}

	@Column(name = "CFILEPATH", length = 240)
	public String getCfilepath() {
		return this.cfilepath;
	}

	public void setCfilepath(String cfilepath) {
		this.cfilepath = cfilepath;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tfile")
	public Set<Tbudget> getTbudgets() {
		return this.tbudgets;
	}

	public void setTbudgets(Set<Tbudget> tbudgets) {
		this.tbudgets = tbudgets;
	}

}