package com.post.pageModel;

import java.io.Serializable;
import java.util.Date;

public class File implements Serializable {

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	private String ids;
	private String cid;
	private String cfilenumber;
	private String cname;
	private String ccontent;
	private String cfilepath;
	private int page;// 当前页
	private int rows;// 每页显示记录数
	private String sort;// 排序字段名
	private String order;// 按什么排序(asc,desc)
	private Date ccreatedate;
	private String deptId;
	private Date cdate;
	private String deptName;
	private Date cstartdate;
	private Date cenddate;
	private Date createStartDate;
	private Date createEndDate;
	
	
	
	

	public String getCfilepath() {
		return cfilepath;
	}

	public void setCfilepath(String cfilepath) {
		this.cfilepath = cfilepath;
	}

	public Date getCreateStartDate() {
		return createStartDate;
	}

	public void setCreateStartDate(Date createStartDate) {
		this.createStartDate = createStartDate;
	}

	public Date getCreateEndDate() {
		return createEndDate;
	}

	public void setCreateEndDate(Date createEndDate) {
		this.createEndDate = createEndDate;
	}

	public Date getCstartdate() {
		return cstartdate;
	}

	public void setCstartdate(Date cstartdate) {
		this.cstartdate = cstartdate;
	}

	public Date getCenddate() {
		return cenddate;
	}

	public void setCenddate(Date cenddate) {
		this.cenddate = cenddate;
	}

	public String getDeptName() {
		return deptName;
	}

	public void setDeptName(String deptName) {
		this.deptName = deptName;
	}

	public Date getCdate() {
		return cdate;
	}

	public void setCdate(Date cdate) {
		this.cdate = cdate;
	}

	public String getDeptId() {
		return deptId;
	}

	public void setDeptId(String deptId) {
		this.deptId = deptId;
	}

	public Date getCcreatedate() {
		return ccreatedate;
	}

	public void setCcreatedate(Date ccreatedate) {
		this.ccreatedate = ccreatedate;
	}

	public String getCfilenumber() {
		return cfilenumber;
	}

	public void setCfilenumber(String cfilenumber) {
		this.cfilenumber = cfilenumber;
	}

	public String getCcontent() {
		return ccontent;
	}

	public void setCcontent(String ccontent) {
		this.ccontent = ccontent;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
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

}
