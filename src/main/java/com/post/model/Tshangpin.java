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
 * Tshangpin entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tshangpin", catalog = "cwfx")
public class Tshangpin implements java.io.Serializable {

	// Fields

	private String cid;
	private String cname;
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);

	// Constructors

	/** default constructor */
	public Tshangpin() {
	}

	/** minimal constructor */
	public Tshangpin(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tshangpin(String cid, String cname, Set<Tcost> tcosts) {
		this.cid = cid;
		this.cname = cname;
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

	@Column(name = "CNAME", length = 50)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tshangpin")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

}