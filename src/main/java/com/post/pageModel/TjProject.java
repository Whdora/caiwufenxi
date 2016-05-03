package com.post.pageModel;

import java.io.Serializable;

public class TjProject implements Serializable {

	private String cid;
	private String cname;
	private Double bntotal;
	private Double bnnb;
	private Double bnwb;
	private Double bytotal;
	private Double bynb;
	private Double bywb;
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

	public Double getBnnb() {
		return bnnb;
	}

	public void setBnnb(Double bnnb) {
		this.bnnb = bnnb;
	}

	public Double getBnwb() {
		return bnwb;
	}

	public void setBnwb(Double bnwb) {
		this.bnwb = bnwb;
	}

	public Double getBytotal() {
		return bytotal;
	}

	public void setBytotal(Double bytotal) {
		this.bytotal = bytotal;
	}

	public Double getBynb() {
		return bynb;
	}

	public void setBynb(Double bynb) {
		this.bynb = bynb;
	}

	public Double getBywb() {
		return bywb;
	}

	public void setBywb(Double bywb) {
		this.bywb = bywb;
	}

}
