package com.post.pageModel;

import java.io.Serializable;
import java.util.List;

public class Kind implements Serializable {

	private String cid;
	private String cname;
	private Integer cseq;
	private String pid;
	private String pname;
	private String state = "open";
	private String id;
	private String text;
	private List<Kind> children;
	
	

	public Integer getCseq() {
		return cseq;
	}

	public void setCseq(Integer cseq) {
		this.cseq = cseq;
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

	public List<Kind> getChildren() {
		return children;
	}

	public void setChildren(List<Kind> children) {
		this.children = children;
	}

	public String getCid() {
		return cid;
	}

	public void setCid(String cid) {
		this.cid = cid;
	}

	public String getCname() {
		return cname;
	}

	public void setCname(String cname) {
		this.cname = cname;
	}

	public String getPid() {
		return pid;
	}

	public void setPid(String pid) {
		this.pid = pid;
	}

	public String getPname() {
		return pname;
	}

	public void setPname(String pname) {
		this.pname = pname;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

}
