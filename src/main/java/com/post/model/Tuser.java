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
import javax.persistence.UniqueConstraint;

/**
 * Tuser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "tuser", catalog = "cwfx", uniqueConstraints = @UniqueConstraint(columnNames = "CUSERNAME"))
public class Tuser implements java.io.Serializable {

	// Fields

	private String cid;
	private Tdept tdept;
	private Timestamp ccreatedatetime;
	private Timestamp cmodifydatetime;
	private String cusername;
	private String cpassword;
	private Integer crole;
	private Timestamp clastlogin;
	private Set<Tlink> tlinks = new HashSet<Tlink>(0);
	private Set<Tcost> tcosts = new HashSet<Tcost>(0);
	private Set<Tdownload> tdownloads = new HashSet<Tdownload>(0);
	private Set<TuserTrole> tuserTroles = new HashSet<TuserTrole>(0);
	private Set<Tannounce> tannounces = new HashSet<Tannounce>(0);
	private Set<Tbudget> tbudgets = new HashSet<Tbudget>(0);

	// Constructors

	/** default constructor */
	public Tuser() {
	}

	/** minimal constructor */
	public Tuser(String cid, Tdept tdept, String cusername, String cpassword) {
		this.cid = cid;
		this.tdept = tdept;
		this.cusername = cusername;
		this.cpassword = cpassword;
	}

	/** full constructor */
	public Tuser(String cid, Tdept tdept, Timestamp ccreatedatetime, Timestamp cmodifydatetime, String cusername, String cpassword, Integer crole, Timestamp clastlogin, Set<Tlink> tlinks, Set<Tcost> tcosts, Set<Tdownload> tdownloads, Set<TuserTrole> tuserTroles, Set<Tannounce> tannounces, Set<Tbudget> tbudgets) {
		this.cid = cid;
		this.tdept = tdept;
		this.ccreatedatetime = ccreatedatetime;
		this.cmodifydatetime = cmodifydatetime;
		this.cusername = cusername;
		this.cpassword = cpassword;
		this.crole = crole;
		this.clastlogin = clastlogin;
		this.tlinks = tlinks;
		this.tcosts = tcosts;
		this.tdownloads = tdownloads;
		this.tuserTroles = tuserTroles;
		this.tannounces = tannounces;
		this.tbudgets = tbudgets;
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
	@JoinColumn(name = "CDEPARTMENT", nullable = false)
	public Tdept getTdept() {
		return this.tdept;
	}

	public void setTdept(Tdept tdept) {
		this.tdept = tdept;
	}

	@Column(name = "CCREATEDATETIME", length = 19)
	public Timestamp getCcreatedatetime() {
		return this.ccreatedatetime;
	}

	public void setCcreatedatetime(Timestamp ccreatedatetime) {
		this.ccreatedatetime = ccreatedatetime;
	}

	@Column(name = "CMODIFYDATETIME", length = 19)
	public Timestamp getCmodifydatetime() {
		return this.cmodifydatetime;
	}

	public void setCmodifydatetime(Timestamp cmodifydatetime) {
		this.cmodifydatetime = cmodifydatetime;
	}

	@Column(name = "CUSERNAME", unique = true, nullable = false, length = 36)
	public String getCusername() {
		return this.cusername;
	}

	public void setCusername(String cusername) {
		this.cusername = cusername;
	}

	@Column(name = "CPASSWORD", nullable = false, length = 40)
	public String getCpassword() {
		return this.cpassword;
	}

	public void setCpassword(String cpassword) {
		this.cpassword = cpassword;
	}

	@Column(name = "CROLE")
	public Integer getCrole() {
		return this.crole;
	}

	public void setCrole(Integer crole) {
		this.crole = crole;
	}

	@Column(name = "CLASTLOGIN", length = 19)
	public Timestamp getClastlogin() {
		return this.clastlogin;
	}

	public void setClastlogin(Timestamp clastlogin) {
		this.clastlogin = clastlogin;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<Tlink> getTlinks() {
		return this.tlinks;
	}

	public void setTlinks(Set<Tlink> tlinks) {
		this.tlinks = tlinks;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<Tcost> getTcosts() {
		return this.tcosts;
	}

	public void setTcosts(Set<Tcost> tcosts) {
		this.tcosts = tcosts;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<Tdownload> getTdownloads() {
		return this.tdownloads;
	}

	public void setTdownloads(Set<Tdownload> tdownloads) {
		this.tdownloads = tdownloads;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<TuserTrole> getTuserTroles() {
		return this.tuserTroles;
	}

	public void setTuserTroles(Set<TuserTrole> tuserTroles) {
		this.tuserTroles = tuserTroles;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<Tannounce> getTannounces() {
		return this.tannounces;
	}

	public void setTannounces(Set<Tannounce> tannounces) {
		this.tannounces = tannounces;
	}

	@OneToMany(cascade = CascadeType.ALL, fetch = FetchType.LAZY, mappedBy = "tuser")
	public Set<Tbudget> getTbudgets() {
		return this.tbudgets;
	}

	public void setTbudgets(Set<Tbudget> tbudgets) {
		this.tbudgets = tbudgets;
	}

}