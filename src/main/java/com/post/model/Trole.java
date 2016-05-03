package com.post.model;

import java.util.HashSet;
import java.util.Set;
import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.Table;

/**
 * Trole entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "trole", catalog = "cwfx")
public class Trole implements java.io.Serializable {

	// Fields

	private String cid;
	private String cdesc;
	private String cname;
	private Set<TroleTauth> troleTauths = new HashSet<TroleTauth>(0);
	private Set<TroleTmenu> troleTmenus = new HashSet<TroleTmenu>(0);
	private Set<TuserTrole> tuserTroles = new HashSet<TuserTrole>(0);

	// Constructors

	/** default constructor */
	public Trole() {
	}

	/** minimal constructor */
	public Trole(String cid, String cname) {
		this.cid = cid;
		this.cname = cname;
	}

	/** full constructor */
	public Trole(String cid, String cdesc, String cname, Set<TroleTauth> troleTauths, Set<TroleTmenu> troleTmenus, Set<TuserTrole> tuserTroles) {
		this.cid = cid;
		this.cdesc = cdesc;
		this.cname = cname;
		this.troleTauths = troleTauths;
		this.troleTmenus = troleTmenus;
		this.tuserTroles = tuserTroles;
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

	@Column(name = "CDESC", length = 200)
	public String getCdesc() {
		return this.cdesc;
	}

	public void setCdesc(String cdesc) {
		this.cdesc = cdesc;
	}

	@Column(name = "CNAME", nullable = false, length = 100)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "trole")
	public Set<TroleTauth> getTroleTauths() {
		return this.troleTauths;
	}

	public void setTroleTauths(Set<TroleTauth> troleTauths) {
		this.troleTauths = troleTauths;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "trole")
	public Set<TroleTmenu> getTroleTmenus() {
		return this.troleTmenus;
	}

	public void setTroleTmenus(Set<TroleTmenu> troleTmenus) {
		this.troleTmenus = troleTmenus;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "trole")
	public Set<TuserTrole> getTuserTroles() {
		return this.tuserTroles;
	}

	public void setTuserTroles(Set<TuserTrole> tuserTroles) {
		this.tuserTroles = tuserTroles;
	}

}