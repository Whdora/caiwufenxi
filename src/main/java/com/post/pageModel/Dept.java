package com.post.pageModel;

import java.io.Serializable;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

public class Dept implements Serializable {

	private String cid;
	private String pid;
	private String id;
	private String text;
	private Integer cseq;
	private String pdeptName;
	private String cdeptName;
	private Timestamp ccreateDatetime;
	private Timestamp cmodifyDatetime;
	private String state;

	public Integer getCseq() {
		return cseq;
	}

	public void setCseq(Integer cseq) {
		this.cseq = cseq;
	}

	public Timestamp getCcreateDatetime() {
		return ccreateDatetime;
	}

	public void setCcreateDatetime(Timestamp ccreateDatetime) {
		this.ccreateDatetime = ccreateDatetime;
	}

	public Timestamp getCmodifyDatetime() {
		return cmodifyDatetime;
	}

	public void setCmodifyDatetime(Timestamp cmodifyDatetime) {
		this.cmodifyDatetime = cmodifyDatetime;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getText() {
		return text;
	}

	public void setText(String text) {
		this.text = text;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	private List<Dept> children;

	public String getPdeptName() {
		return pdeptName;
	}

	public void setPdeptName(String pdeptName) {
		this.pdeptName = pdeptName;
	}

	public List<Dept> getChildren() {
		return children;
	}

	public void setChildren(List<Dept> children) {
		this.children = children;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getCdeptName() {
		return cdeptName;
	}

	public void setCdeptName(String cdeptName) {
		this.cdeptName = cdeptName;
	}

}
