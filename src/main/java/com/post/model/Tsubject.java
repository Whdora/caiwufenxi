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
 * Tsubject entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tsubject", catalog = "cwfx")
public class Tsubject implements java.io.Serializable {

	// Fields

	private String cid;
	private Tsubject tsubject;
	private String cname;
	private Integer cseq;
	private Set<Tkmlz> tkmlzs = new HashSet<Tkmlz>(0);
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);
	private Set<Tsubject> tsubjects = new HashSet<Tsubject>(0);

	// Constructors

	/** default constructor */
	public Tsubject() {
	}

	/** minimal constructor */
	public Tsubject(String cid) {
		this.cid = cid;
	}

	/** full constructor */
	public Tsubject(String cid, Tsubject tsubject, String cname, Integer cseq, Set<Tkmlz> tkmlzs, Set<Tcost> tcosts, Set<Tsubject> tsubjects) {
		this.cid = cid;
		this.tsubject = tsubject;
		this.cname = cname;
		this.cseq = cseq;
		this.tkmlzs = tkmlzs;
		this.tcosts = tcosts;
		this.tsubjects = tsubjects;
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
	@JoinColumn(name = "CPID")
	public Tsubject getTsubject() {
		return this.tsubject;
	}

	public void setTsubject(Tsubject tsubject) {
		this.tsubject = tsubject;
	}

	@Column(name = "CNAME", length = 50)
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

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsubject")
	public Set<Tkmlz> getTkmlzs() {
		return this.tkmlzs;
	}

	public void setTkmlzs(Set<Tkmlz> tkmlzs) {
		this.tkmlzs = tkmlzs;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsubject")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tsubject")
	public Set<Tsubject> getTsubjects() {
		return this.tsubjects;
	}

	public void setTsubjects(Set<Tsubject> tsubjects) {
		this.tsubjects = tsubjects;
	}

}