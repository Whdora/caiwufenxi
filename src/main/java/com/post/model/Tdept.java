package com.post.model;

import java.sql.Timestamp;
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
 * Tdept entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tdept", catalog = "cwfx")
public class Tdept implements java.io.Serializable {

	// Fields

	private String cid;
	private Tdept tdept;
	private String cdeptName;
	private Integer cseq;
	private Timestamp ccreateDatetime;
	private Timestamp cmodifyDatetime;
	private Set<Tdept> tdepts = new HashSet<Tdept>(0);
	private Set<Tbudget> tbudgets = new HashSet<Tbudget>(0);
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);
	private Set<Tuser> tusers = new HashSet<Tuser>(0);
	private Set<Tfile> tfiles = new HashSet<Tfile>(0);

	// Constructors

	/** default constructor */
	public Tdept() {
	}

	/** minimal constructor */
	public Tdept(String cid, String cdeptName) {
		this.cid = cid;
		this.cdeptName = cdeptName;
	}

	/** full constructor */
	public Tdept(String cid, Tdept tdept, String cdeptName, Integer cseq, Timestamp ccreateDatetime, Timestamp cmodifyDatetime, Set<Tdept> tdepts, Set<Tbudget> tbudgets, Set<Tcost> tcosts, Set<Tuser> tusers, Set<Tfile> tfiles) {
		this.cid = cid;
		this.tdept = tdept;
		this.cdeptName = cdeptName;
		this.cseq = cseq;
		this.ccreateDatetime = ccreateDatetime;
		this.cmodifyDatetime = cmodifyDatetime;
		this.tdepts = tdepts;
		this.tbudgets = tbudgets;
		this.tcosts = tcosts;
		this.tusers = tusers;
		this.tfiles = tfiles;
	}

	// Property accessors
	@Id
	@Column(name = "Cid", unique = true, nullable = false, length = 36)
	public String getCid() {
		return this.cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "Pid")
	public Tdept getTdept() {
		return this.tdept;
	}

	public void setTdept(Tdept tdept) {
		this.tdept = tdept;
	}

	@Column(name = "CdeptName", nullable = false, length = 40)
	public String getCdeptName() {
		return this.cdeptName;
	}

	public void setCdeptName(String cdeptName) {
		this.cdeptName = cdeptName;
	}

	@Column(name = "Cseq")
	public Integer getCseq() {
		return this.cseq;
	}

	public void setCseq(Integer cseq) {
		this.cseq = cseq;
	}

	@Column(name = "CcreateDatetime", length = 19)
	public Timestamp getCcreateDatetime() {
		return this.ccreateDatetime;
	}

	public void setCcreateDatetime(Timestamp ccreateDatetime) {
		this.ccreateDatetime = ccreateDatetime;
	}

	@Column(name = "CmodifyDatetime", length = 19)
	public Timestamp getCmodifyDatetime() {
		return this.cmodifyDatetime;
	}

	public void setCmodifyDatetime(Timestamp cmodifyDatetime) {
		this.cmodifyDatetime = cmodifyDatetime;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tdept")
	public Set<Tdept> getTdepts() {
		return this.tdepts;
	}

	public void setTdepts(Set<Tdept> tdepts) {
		this.tdepts = tdepts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tdept")
	public Set<Tbudget> getTbudgets() {
		return this.tbudgets;
	}

	public void setTbudgets(Set<Tbudget> tbudgets) {
		this.tbudgets = tbudgets;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tdept")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tdept")
	public Set<Tuser> getTusers() {
		return this.tusers;
	}

	public void setTusers(Set<Tuser> tusers) {
		this.tusers = tusers;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tdept")
	public Set<Tfile> getTfiles() {
		return this.tfiles;
	}

	public void setTfiles(Set<Tfile> tfiles) {
		this.tfiles = tfiles;
	}

}