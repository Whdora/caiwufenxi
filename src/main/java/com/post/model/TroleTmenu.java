package com.post.model;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

/**
 * TroleTmenu entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "trole_tmenu", catalog = "cwfx")
public class TroleTmenu implements java.io.Serializable {

	// Fields

	private String cid;
	private Tmenu tmenu;
	private Trole trole;

	// Constructors

	/** default constructor */
	public TroleTmenu() {
	}

	/** minimal constructor */
	public TroleTmenu(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public TroleTmenu(String cid, Tmenu tmenu, Trole trole) {
		this.cid = cid;
		this.tmenu = tmenu;
		this.trole = trole;
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
	@JoinColumn(name = "CMENUID")
	public Tmenu getTmenu() {
		return this.tmenu;
	}

	public void setTmenu(Tmenu tmenu) {
		this.tmenu = tmenu;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "CROLEID")
	public Trole getTrole() {
		return this.trole;
	}

	public void setTrole(Trole trole) {
		this.trole = trole;
	}

}