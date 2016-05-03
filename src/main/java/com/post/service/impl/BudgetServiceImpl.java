package com.post.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.model.Tbudget;
import com.post.model.Tcost;
import com.post.model.Tdept;
import com.post.model.Tfile;
import com.post.model.Tproject;
import com.post.model.Tuser;
import com.post.model.Tzrzx;
import com.post.pageModel.Budget;
import com.post.pageModel.DataGrid;
import com.post.service.BudgetServiceI;
import com.post.util.DoubleUtil;

@Service("budgetService")
public class BudgetServiceImpl implements BudgetServiceI {

	private BaseDaoI<Tbudget> budgetDao;
	private BaseDaoI<Tdept> deptDao;
	private BaseDaoI<Tuser> userDao;
	private BaseDaoI<Tzrzx> zrzxDao;
	private BaseDaoI<Tproject> projectDao;
	private BaseDaoI<Tfile> fileDao;
	private BaseDaoI<Tcost> costDao;
	
	

	public BaseDaoI<Tcost> getCostDao() {
		return costDao;
	}

	@Autowired
	public void setCostDao(BaseDaoI<Tcost> costDao) {
		this.costDao = costDao;
	}

	public BaseDaoI<Tdept> getDeptDao() {
		return deptDao;
	}

	@Autowired
	public void setDeptDao(BaseDaoI<Tdept> deptDao) {
		this.deptDao = deptDao;
	}

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	public BaseDaoI<Tzrzx> getZrzxDao() {
		return zrzxDao;
	}

	@Autowired
	public void setZrzxDao(BaseDaoI<Tzrzx> zrzxDao) {
		this.zrzxDao = zrzxDao;
	}

	public BaseDaoI<Tproject> getProjectDao() {
		return projectDao;
	}

	@Autowired
	public void setProjectDao(BaseDaoI<Tproject> projectDao) {
		this.projectDao = projectDao;
	}

	public BaseDaoI<Tfile> getFileDao() {
		return fileDao;
	}

	@Autowired
	public void setFileDao(BaseDaoI<Tfile> fileDao) {
		this.fileDao = fileDao;
	}

	public BaseDaoI<Tbudget> getBudgetDao() {
		return budgetDao;
	}

	@Autowired
	public void setBudgetDao(BaseDaoI<Tbudget> budgetDao) {
		this.budgetDao = budgetDao;
	}

	@Override
	public void add(Budget budget) {
		Tbudget t = new Tbudget();
		BeanUtils.copyProperties(budget, t);
		t.setCid(UUID.randomUUID().toString());
		t.setTdept(deptDao.get(Tdept.class, budget.getDeptId()));
		t.setTuser(userDao.get(Tuser.class, budget.getUserId()));
		if (budget.getFileId() != null) {
			t.setTfile(fileDao.get(Tfile.class, budget.getFileId()));
		}
		t.setTproject(projectDao.get(Tproject.class, budget.getProjectId()));
		t.setTzrzx(zrzxDao.get(Tzrzx.class, budget.getZrzxId()));
		t.setCstate(0);
		Date d = new Date();
		t.setCcreatedate(new Timestamp(d.getTime()));
		t.setCmodifydate(new Timestamp(d.getTime()));
		budgetDao.save(t);
	}

	@Override
	public void edit(Budget budget) {
		Tbudget t = budgetDao.get(Tbudget.class, budget.getCid());
		BeanUtils.copyProperties(budget, t, new String[] { "cid", "cstate",
				"cmodifydate", "ccreatedate" });
		if (budget.getFileId() != null) {
			t.setTfile(fileDao.get(Tfile.class, budget.getFileId()));
		}
		t.setTproject(projectDao.get(Tproject.class, budget.getProjectId()));
		t.setTzrzx(zrzxDao.get(Tzrzx.class, budget.getZrzxId()));
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}
	
	@Override
	public void auditEdit(Budget budget){
		Tbudget t = budgetDao.get(Tbudget.class, budget.getCid());
		BeanUtils.copyProperties(budget, t, new String[] { "cid", "cstate","cdate",
				"cmodifydate", "ccreatedate" });
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}

	@Override
	public void delete(Budget budget) {
		String cids = "";
		if (budget.getIds() != null) {
			String ids = budget.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tbudget t where t.cid in (" + cids + ")";
			budgetDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Budget budget) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(budget)));
		dg.setTotal(total(budget));
		return dg;
	}

	private Long total(Budget budget) {
		String hql = "select count(*) from Tbudget t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(budget, hql, params);
		return budgetDao.count(hql, params);
	}

	private List<Tbudget> find(Budget budget) {
		String hql = "from Tbudget t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(budget, hql, params);
		if (budget.getOrder() != null && budget.getSort() != null) {
			hql += " order by " + budget.getSort() + " " + budget.getOrder();
		}
		return budgetDao.find(hql, params, budget.getPage(), budget.getRows());
	}

	private List<Budget> listRows(List<Tbudget> lt) {
		List<Budget> rows = new ArrayList<Budget>();
		if (lt != null && lt.size() > 0) {
			for (Tbudget t : lt) {
				Budget sub = new Budget();
				BeanUtils.copyProperties(t, sub);
				sub.setDeptId(t.getTdept().getCid());
				sub.setDeptName(t.getTdept().getCdeptName());
				if (t.getTzrzx() !=null){
					sub.setZrzxId(t.getTzrzx().getCid());
					sub.setZrzxName(t.getTzrzx().getCname());
				}
				if (t.getTproject()!=null){
					sub.setProjectId(t.getTproject().getCid());
					sub.setProjectName(t.getTproject().getCname());
				}
				sub.setUserId(t.getTuser().getCid());
				sub.setUserName(t.getTuser().getCusername());
				sub.setCyt(DoubleUtil.Keep2(sumCost(t.getCid())));
				if (t.getTfile() != null) {
					sub.setFileId(t.getTfile().getCid());
					sub.setFileName(t.getTfile().getCname());
					sub.setFileNumber(t.getTfile().getCfilenumber());
					sub.setStartdate(t.getTfile().getCstartdate());
					sub.setEnddate(t.getTfile().getCenddate());
					sub.setFileDate(t.getTfile().getCdate());
					sub.setFilePath(t.getTfile().getCfilepath());
				}
				rows.add(sub);
			}
		}
		return rows;
	}
	
	private Double sumCost(String cid){
		String hql;
		Map<String, Object> params = new HashMap<String, Object>();
		hql = "select sum(t.camount) from Tcost t where  t.tbudget.cid = :budgetId  group by t.tbudget";
		params.put("budgetId", cid);
		return costDao.sum(hql, params);
	}

	private String addWhere(Budget budget, String hql,
			Map<String, Object> params) {
		if (budget != null) {
			if (budget.getDeptId() != null
					&& deptDao.get(Tdept.class, budget.getDeptId()).getTdept() != null) {
				hql += " and t.tdept.cid= :deptid";
				params.put("deptid", budget.getDeptId());
			}
			if (budget.getCreateStartDate() != null) {
				hql += " and t.ccreatedate >= :createStartDate";
				params.put("createStartDate", budget.getCreateStartDate());
			}
			if (budget.getCreateEndDate() != null) {
				hql += " and t.ccreatedate <= :createEndDate";
				params.put("createEndDate", budget.getCreateEndDate());
			}
			if (budget.getFileNumber() != null
					&& !budget.getFileNumber().trim().equals("")) {
				hql += " and t.tfile.cfilenumber like :cfilenumber";
				params.put("cfilenumber", "%%" + budget.getFileNumber() + "%%");
			}
			if (budget.getFileName() != null
					&& !budget.getFileName().trim().equals("")) {
				hql += " and t.tfile.cname like :cname";
				params.put("cname", "%%" + budget.getFileName() + "%%");
			}
			if (budget.getZrzxId() != null
					&& !budget.getZrzxId().trim().equals("")) {
				hql += " and t.tzrzx.cid = :zrzxId";
				params.put("zrzxId", budget.getZrzxId());
			}
			if (budget.getProjectId() != null
					&& !budget.getProjectId().trim().equals("")) {
				hql += " and t.tproject.cid = :projectId";
				params.put("projectId", budget.getProjectId());
			}
			if (budget.getCstate() != null) {
				hql += " and t.cstate = :cstate";
				params.put("cstate", budget.getCstate());
			}
		}
		return hql;
	}

	@Override
	public void audit(Budget budget) {
		String cids = "";
		if (budget.getIds() != null) {
			String ids = budget.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "update Tbudget t set t.cstate=3 where t.cid in ("
					+ cids + ")";
			budgetDao.executeHql(hql);
		}

	}
	
	@Override
	public void notAudit(Budget budget) {
		String cids = "";
		if (budget.getIds() != null) {
			String ids = budget.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "update Tbudget t set t.cstate=2 where t.cid in ("
					+ cids + ")";
			budgetDao.executeHql(hql);
		}

	}
	
	@Override
	public void submit(Budget budget) {
		String cids = "";
		if (budget.getIds() != null) {
			String ids = budget.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "update Tbudget t set t.cstate=1 where t.cid in ("
					+ cids + ")";
			budgetDao.executeHql(hql);
		}

	}

	@Override
	public Double totalBudget(String budgetId) {
		if (budgetId != null) {
			Tbudget t = budgetDao.get(Tbudget.class, budgetId);
			if (t!=null){
				return t.getCyjfy();
			}
		}
		return 0.0;
	}

	@Override
	public List<Budget> excelData(Budget budget) {
		String hql = "from Tbudget t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(budget, hql, params);
		hql += " order by t.tdept,t.ccreatedate ";
		List<Tbudget> list= budgetDao.find(hql, params);
		return listRows(list);
	}
	
	@Override
	public List<Budget> excelAudit(Budget budget) {
		String hql = "from Tbudget t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(budget, hql, params);
		hql += " and t.csjfy is not null order by t.tdept,t.ccreatedate ";
		List<Tbudget> list= budgetDao.find(hql, params);
		return listRows(list);
	}

	@Override
	public Tbudget get(String budgetId) {
		if (budgetId != null && !budgetId.trim().equals("")){
			return budgetDao.get(Tbudget.class, budgetId);
		}
		return null;
	}
}
