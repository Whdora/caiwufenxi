package com.post.model;

import java.sql.Timestamp;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * Tlink entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tlink", catalog = "cwfx")
public class Tlink implements java.io.Serializable {

	// Fields

	private String cid;
	private Tuser tuser;
	private String ctitle;
	private String curl;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;

	// Constructors

	/** default constructor */
	public Tlink() {
	}

	/** minimal constructor */
	public Tlink(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tlink(String cid, Tuser tuser, String ctitle, String curl, Timestamp ccreatedate, Timestamp cmodifydate) {
		this.cid = cid;
		this.tuser = tuser;
		this.ctitle = ctitle;
		this.curl = curl;
		this.ccreatedate = ccreatedate;
		this.cmodifydate = cmodifydate;
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
	@JoinColumn(name = "CUSERID")
	public Tuser getTuser() {
		return this.tuser;
	}

	public void setTuser(Tuser tuser) {
		this.tuser = tuser;
	}

	@Column(name = "CTITLE", length = 150)
	public String getCtitle() {
		return this.ctitle;
	}

	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}

	@Column(name = "CURL", length = 200)
	public String getCurl() {
		return this.curl;
	}

	public void setCurl(String curl) {
		this.curl = curl;
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

}