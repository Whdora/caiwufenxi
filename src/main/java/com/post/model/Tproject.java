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
 * Tproject entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tproject", catalog = "cwfx")
public class Tproject implements java.io.Serializable {

	// Fields

	private String cid;
	private String cname;
	private Set<Tbudget> tbudgets = new HashSet<Tbudget>(0);
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);

	// Constructors

	/** default constructor */
	public Tproject() {
	}

	/** minimal constructor */
	public Tproject(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tproject(String cid, String cname, Set<Tbudget> tbudgets, Set<Tcost> tcosts) {
		this.cid = cid;
		this.cname = cname;
		this.tbudgets = tbudgets;
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

	@Column(name = "CNAME", length = 100)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tproject")
	public Set<Tbudget> getTbudgets() {
		return this.tbudgets;
	}

	public void setTbudgets(Set<Tbudget> tbudgets) {
		this.tbudgets = tbudgets;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tproject")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

}