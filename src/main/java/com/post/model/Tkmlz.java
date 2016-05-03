package com.post.model;

import java.util.Date;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

/**
 * Tkmlz entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tkmlz", catalog = "cwfx")
public class Tkmlz implements java.io.Serializable {

	// Fields

	private String cid;
	private Tsubject tsubject;
	private Tcost tcost;
	private Double camount;
	private Date cdate;
	private String cpzh;

	// Constructors

	/** default constructor */
	public Tkmlz() {
	}

	/** minimal constructor */
	public Tkmlz(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tkmlz(String cid, Tsubject tsubject, Tcost tcost, Double camount, Date cdate, String cpzh) {
		this.cid = cid;
		this.tsubject = tsubject;
		this.tcost = tcost;
		this.camount = camount;
		this.cdate = cdate;
		this.cpzh = cpzh;
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
	@JoinColumn(name = "CKJKM")
	public Tsubject getTsubject() {
		return this.tsubject;
	}

	public void setTsubject(Tsubject tsubject) {
		this.tsubject = tsubject;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CCOST")
	public Tcost getTcost() {
		return this.tcost;
	}

	public void setTcost(Tcost tcost) {
		this.tcost = tcost;
	}

	@Column(name = "CAMOUNT", precision = 12)
	public Double getCamount() {
		return this.camount;
	}

	public void setCamount(Double camount) {
		this.camount = camount;
	}

	@Temporal(TemporalType.DATE)
	@Column(name = "CDATE", length = 10)
	public Date getCdate() {
		return this.cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	@Column(name = "CPZH", length = 20)
	public String getCpzh() {
		return this.cpzh;
	}

	public void setCpzh(String cpzh) {
		this.cpzh = cpzh;
	}

}