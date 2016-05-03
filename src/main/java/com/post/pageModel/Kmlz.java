package com.post.pageModel;

import java.io.Serializable;
import java.util.Date;

public class Kmlz implements Serializable{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;

	private String cid;
	private String ids;
	private String pzhs;
	private String cpzh;
	private Double camount;
	private Date cdate;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private String kjkmId;
	private String kjkmName;
	private String costId;
	private String filename;
	
	
	
	public String getPzhs() {
		return pzhs;
	}
	public void setPzhs(String pzhs) {
		this.pzhs = pzhs;
	}
	public String getCpzh() {
		return cpzh;
	}
	public void setCpzh(String cpzh) {
		this.cpzh = cpzh;
	}
	public String getFilename() {
		return filename;
	}
	public void setFilename(String filename) {
		this.filename = filename;
	}
	public String getCid() {
		return cid;
	}
	public void setCid(String cid) {
		this.cid = cid;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public Double getCamount() {
		return camount;
	}
	public void setCamount(Double camount) {
		this.camount = camount;
	}
	public Date getCdate() {
		return cdate;
	}
	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}
	public int getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}
	public String getSort() {
		return sort;
	}
	public void setSort(String sort) {
		this.sort = sort;
	}
	public String getOrder() {
		return order;
	}
	public void setOrder(String order) {
		this.order = order;
	}
	public String getKjkmId() {
		return kjkmId;
	}
	public void setKjkmId(String kjkmId) {
		this.kjkmId = kjkmId;
	}
	public String getKjkmName() {
		return kjkmName;
	}
	public void setKjkmName(String kjkmName) {
		this.kjkmName = kjkmName;
	}
	public String getCostId() {
		return costId;
	}
	public void setCostId(String costId) {
		this.costId = costId;
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	
	
	
}
