package com.post.model;

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

/**
 * Tkind entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tkind", catalog = "cwfx")
public class Tkind implements java.io.Serializable {

	// Fields

	private String cid;
	private Tkind tkind;
	private String cname;
	private Integer cseq;
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);
	private Set<Tkind> tkinds = new HashSet<Tkind>(0);

	// Constructors

	/** default constructor */
	public Tkind() {
	}

	/** minimal constructor */
	public Tkind(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tkind(String cid, Tkind tkind, String cname, Integer cseq, Set<Tcost> tcosts, Set<Tkind> tkinds) {
		this.cid = cid;
		this.tkind = tkind;
		this.cname = cname;
		this.cseq = cseq;
		this.tcosts = tcosts;
		this.tkinds = tkinds;
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
	@JoinColumn(name = "PID")
	public Tkind getTkind() {
		return this.tkind;
	}

	public void setTkind(Tkind tkind) {
		this.tkind = tkind;
	}

	@Column(name = "CNAME", length = 30)
	public String getCname() {
		return this.cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	@Column(name = "CSEQ")
	public Integer getCseq() {
		return this.cseq;
	}

	public void setCseq(Integer cseq) {
		this.cseq = cseq;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tkind")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tkind")
	public Set<Tkind> getTkinds() {
		return this.tkinds;
	}

	public void setTkinds(Set<Tkind> tkinds) {
		this.tkinds = tkinds;
	}

}