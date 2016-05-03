package com.post.pageModel;

import java.io.Serializable;

public class TjNormal implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String cid;
	private String cname;
	private Double bntotal;
	private Double bytotal;
	private String deptName;
	
	

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
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

	public Double getBntotal() {
		return bntotal;
	}

	public void setBntotal(Double bntotal) {
		this.bntotal = bntotal;
	}


	public Double getBytotal() {
		return bytotal;
	}

	public void setBytotal(Double bytotal) {
		this.bytotal = bytotal;
	}


}
