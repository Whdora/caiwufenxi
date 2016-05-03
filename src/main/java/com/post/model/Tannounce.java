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
 * Tannounce entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tannounce", catalog = "cwfx")
public class Tannounce implements java.io.Serializable {

	// Fields

	private String cid;
	private Tuser tuser;
	private Timestamp ccreatedate;
	private Timestamp cmodifydate;
	private String ctitle;
	private String ccontent;

	// Constructors

	/** default constructor */
	public Tannounce() {
	}

	/** minimal constructor */
	public Tannounce(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tannounce(String cid, Tuser tuser, Timestamp ccreatedate, Timestamp cmodifydate, String ctitle, String ccontent) {
		this.cid = cid;
		this.tuser = tuser;
		this.ccreatedate = ccreatedate;
		this.cmodifydate = cmodifydate;
		this.ctitle = ctitle;
		this.ccontent = ccontent;
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
	@JoinColumn(name = "USERID")
	public Tuser getTuser() {
		return this.tuser;
	}

	public void setTuser(Tuser tuser) {
		this.tuser = tuser;
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

	@Column(name = "CTITLE", length = 200)
	public String getCtitle() {
		return this.ctitle;
	}

	public void setCtitle(String ctitle) {
		this.ctitle = ctitle;
	}

	@Column(name = "CCONTENT", length = 65535)
	public String getCcontent() {
		return this.ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

}