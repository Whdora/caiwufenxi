package com.post.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.post.comparator.SubjectComparator;
import com.post.dao.BaseDaoI;
import com.post.excelUtil.DateUtil;
import com.post.model.Tbudget;
import com.post.model.Tcost;
import com.post.model.Tdept;
import com.post.model.Tfile;
import com.post.model.Tkind;
import com.post.model.Tproject;
import com.post.model.Tshangpin;
import com.post.model.Tsubject;
import com.post.model.Tuser;
import com.post.model.Tzrzx;
import com.post.pageModel.Cost;
import com.post.pageModel.CostPrint;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Pzh;
import com.post.pageModel.Subject;
import com.post.pageModel.TjNormal;
import com.post.pageModel.TjProject;
import com.post.pageModel.TjSubject;
import com.post.service.CostServiceI;
import com.post.util.DoubleUtil;
import com.post.util.SimpleMoneyFormat;

@Service("costService")
public class CostServiceImpl implements CostServiceI {

	private BaseDaoI<Tcost> costDao;
	private BaseDaoI<Tdept> deptDao;
	private BaseDaoI<Tsubject> subjectDao;
	private BaseDaoI<Tuser> userDao;
	private BaseDaoI<Tkind> kindDao;
	private BaseDaoI<Tzrzx> zrzxDao;
	private BaseDaoI<Tproject> projectDao;
	private BaseDaoI<Tfile> fileDao;
	private BaseDaoI<Tbudget> budgetDao;
	private BaseDaoI<Tshangpin> shangpinDao;

	
	
	public BaseDaoI<Tshangpin> getShangpinDao() {
		return shangpinDao;
	}

	@Autowired
	public void setShangpinDao(BaseDaoI<Tshangpin> shangpinDao) {
		this.shangpinDao = shangpinDao;
	}

	public BaseDaoI<Tbudget> getBudgetDao() {
		return budgetDao;
	}

	@Autowired
	public void setBudgetDao(BaseDaoI<Tbudget> budgetDao) {
		this.budgetDao = budgetDao;
	}

	public BaseDaoI<Tdept> getDeptDao() {
		return deptDao;
	}

	@Autowired
	public void setDeptDao(BaseDaoI<Tdept> deptDao) {
		this.deptDao = deptDao;
	}

	public BaseDaoI<Tsubject> getSubjectDao() {
		return subjectDao;
	}

	@Autowired
	public void setSubjectDao(BaseDaoI<Tsubject> subjectDao) {
		this.subjectDao = subjectDao;
	}

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	public BaseDaoI<Tkind> getKindDao() {
		return kindDao;
	}

	@Autowired
	public void setKindDao(BaseDaoI<Tkind> kindDao) {
		this.kindDao = kindDao;
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

	public BaseDaoI<Tcost> getCostDao() {
		return costDao;
	}

	@Autowired
	public void setCostDao(BaseDaoI<Tcost> costDao) {
		this.costDao = costDao;
	}

	@Override
	public void add(Cost cost) {
		Tcost t = new Tcost();
		BeanUtils.copyProperties(cost, t);
		t.setCid(UUID.randomUUID().toString());
		t.setTdept(deptDao.get(Tdept.class, cost.getDeptId()));
		t.setTuser(userDao.get(Tuser.class, cost.getUserId()));
		if (cost.getBudgetId() != null && !cost.getBudgetId().trim().equals("")) {
			t.setTbudget(budgetDao.get(Tbudget.class, cost.getBudgetId()));
		}
		if (cost.getSubjectId() != null && !cost.getSubjectId().trim().equals("")) {
			t.setTsubject(subjectDao.get(Tsubject.class, cost.getSubjectId()));
		}
		if (cost.getKindId() != null && !cost.getKindId().trim().equals("")) {
			t.setTkind(kindDao.get(Tkind.class, cost.getKindId()));
		}
		if (cost.getProjectId() != null && !cost.getProjectId().trim().equals("")) {
			t.setTproject(projectDao.get(Tproject.class, cost.getProjectId()));
		}
		if (cost.getShangpinId() != null && !cost.getShangpinId().trim().equals("")) {
			t.setTshangpin(shangpinDao.get(Tshangpin.class, cost.getShangpinId()));
		}
		if (cost.getCsj() == null) {
			t.setCsj(0.0);
		}
		t.setTzrzx(zrzxDao.get(Tzrzx.class, cost.getZrzxId()));
		t.setCprogress(1);
		Date d = new Date();
		t.setCcreatedate(new Timestamp(d.getTime()));
		t.setCmodifydate(new Timestamp(d.getTime()));
		costDao.save(t);
	}

	@Override
	public void edit(Cost cost) {
		Tcost t = costDao.get(Tcost.class, cost.getCid());
		BeanUtils.copyProperties(cost, t, new String[] { "cid", "ccreatedate", "cmodifydate", "cprogress", "cpzh",  "ciszd" });
		if (cost.getBudgetId() != null) {
			t.setTbudget(budgetDao.get(Tbudget.class, cost.getBudgetId()));
		}
		if (cost.getSubjectId() != null) {
			t.setTsubject(subjectDao.get(Tsubject.class, cost.getSubjectId()));
		}
		if (cost.getKindId() != null) {
			t.setTkind(kindDao.get(Tkind.class, cost.getKindId()));
		}
		if (cost.getProjectId() != null) {
			t.setTproject(projectDao.get(Tproject.class, cost.getProjectId()));
		}
		if (cost.getShangpinId() != null && !cost.getShangpinId().trim().equals("")) {
			t.setTshangpin(shangpinDao.get(Tshangpin.class, cost.getShangpinId()));
		}
		t.setTzrzx(zrzxDao.get(Tzrzx.class, cost.getZrzxId()));
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}

	@Override
	public void delete(Cost cost) {
		String cids = "";
		if (cost.getIds() != null) {
			String ids = cost.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tcost t where t.cid in (" + cids + ")";
			costDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Cost cost) {
		DataGrid dg = new DataGrid();
		List<Cost> list = listRows(find(cost));
		dg.setRows(list);
		List<Map<String,Object>> footer = new ArrayList<Map<String,Object>>();
		Map<String,Object> foot = new HashMap<String,Object>();
		Double amount =0.0;
		Double sj =0.0;
		if (list!=null && list.size()>0){
			for (Cost c:list){
				if (c.getCamount()!=null){
					amount+=c.getCamount();
				}
				if (c.getCsj()!=null){
					sj+=c.getCsj();
				}
			}
			if (amount>0&&sj>0){
				foot.put("subjectName", "合计：");
				foot.put("camount", amount);
				foot.put("csj", sj);
			}
		}
		if (foot.size()>0){
			footer.add(foot);
			dg.setFooter(footer);
		}
		dg.setTotal(total(cost));
		return dg;
	}

	private Long total(Cost cost) {
		String hql = "select count(*) from Tcost t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(cost, hql, params);
		return costDao.count(hql, params);
	}

	private List<Tcost> find(Cost cost) {
		String hql = "from Tcost t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(cost, hql, params);
		if (cost.getOrder() != null && cost.getSort() != null) {
			hql += " order by " + cost.getSort() + " " + cost.getOrder();
		}
		return costDao.find(hql, params, cost.getPage(), cost.getRows());
	}

	private List<Cost> listRows(List<Tcost> lt) {
		List<Cost> rows = new ArrayList<Cost>();
		if (lt != null && lt.size() > 0) {
			for (Tcost t : lt) {
				rows.add(ChangeModel(t));
			}
		}
		return rows;
	}

	private Cost ChangeModel(Tcost t) {
		Cost sub = new Cost();
		BeanUtils.copyProperties(t, sub);
		sub.setDeptId(t.getTdept().getCid());
		sub.setDeptName(t.getTdept().getCdeptName());
		if (t.getTkind() != null) {
			sub.setKindId(t.getTkind().getCid());
			sub.setKindName(t.getTkind().getCname());
		}
		if (t.getTzrzx() != null) {
			sub.setZrzxId(t.getTzrzx().getCid());
			sub.setZrzxName(t.getTzrzx().getCname());
		}
		if (t.getTproject() != null) {
			sub.setProjectId(t.getTproject().getCid());
			sub.setProjectName(t.getTproject().getCname());
		}
		
		if (t.getTshangpin() != null) {
			sub.setShangpinId(t.getTshangpin().getCid());
			sub.setShangpinName(t.getTshangpin().getCname());
		}
		if (t.getTsubject() != null) {
			sub.setSubjectName(t.getTsubject().getCname());
			sub.setSubjectId(t.getTsubject().getCid());
		}
		sub.setUserId(t.getTuser().getCid());
		sub.setUserName(t.getTuser().getCusername());
		if (t.getTbudget() != null) {
			sub.setBudgetId(t.getTbudget().getCid());
			sub.setFileId(t.getTbudget().getCid());
			sub.setFileName(t.getTbudget().getTfile().getCname());
			sub.setFilePath(t.getTbudget().getTfile().getCfilepath());
			sub.setFileNumber(t.getTbudget().getTfile().getCfilenumber());
		}
		return sub;
	}

	private String addWhere(Cost cost, String hql, Map<String, Object> params) {
		if (cost != null) {
			if (cost.getDeptId() != null && deptDao.get(Tdept.class, cost.getDeptId()).getTdept() != null) {
				hql += " and t.tdept.cid= :deptid";
				params.put("deptid", cost.getDeptId());
			}
			if (cost.getCreateStartDate() != null) {
				hql += " and t.cdate >= :createStartDate";
				params.put("createStartDate", cost.getCreateStartDate());
			}
			if (cost.getCreateEndDate() != null) {
				hql += " and t.cdate <= :createEndDate";
				params.put("createEndDate", cost.getCreateEndDate());
			}
			if (cost.getCshiyou() != null && !cost.getCshiyou().trim().equals("")) {
				hql += " and t.cshiyou like :cshiyou";
				params.put("cshiyou", "%%" + cost.getCshiyou() + "%%");
			}
			if (cost.getFileNumber() != null && !cost.getFileNumber().trim().equals("")) {
				hql += " and t.tbudget.tfile.cfilenumber like :cfilenumber";
				params.put("cfilenumber", "%%" + cost.getFileNumber() + "%%");
			}
			if (cost.getFileName() != null && !cost.getFileName().trim().equals("")) {
				hql += " and t.tbudget.tfile.cname like :cname";
				params.put("cname", "%%" + cost.getFileName() + "%%");
			}
			if (cost.getZrzxId() != null && !cost.getZrzxId().trim().equals("")) {
				hql += " and t.tzrzx.cid = :zrzxId";
				params.put("zrzxId", cost.getZrzxId());
			}
			if (cost.getProjectId() != null && !cost.getProjectId().trim().equals("")) {
				hql += " and t.tproject.cid = :projectId";
				params.put("projectId", cost.getProjectId());
			}
			
			if (cost.getShangpinId() != null && !cost.getShangpinId().trim().equals("")) {
				hql += " and t.tshangpin.cid = :shangpinId";
				params.put("shangpinId", cost.getShangpinId());
			}
			
			if (cost.getSubjectId() != null && !cost.getSubjectId().trim().equals("")) {
				hql += " and t.tsubject.cid = :subjectId";
				params.put("subjectId", cost.getSubjectId());
			}
			if (cost.getCxz() != null && !cost.getCxz().trim().equals("")) {
				hql += " and t.cxz = :cxz";
				params.put("cxz", cost.getCxz());
			}
			if (cost.getBudgetId() != null && !cost.getBudgetId().trim().equals("")) {
				hql += " and t.tbudget.cid = :budgetId";
				params.put("budgetId", cost.getBudgetId());
			}
			if (cost.getCprogress() != 0) {
				hql += " and t.cprogress = :cprogress";
				params.put("cprogress", cost.getCprogress());
			}
			if (cost.getCiszd() != null) {
				hql += " and t.ciszd = :ciszd";
				params.put("ciszd", cost.getCiszd());
			}
			if (cost.getClzfs() != null && !cost.getClzfs().trim().equals("")) {
				hql += " and t.clzfs = :lzfs";
				params.put("lzfs", cost.getClzfs());
			}
			if (cost.getCbh() != null && !cost.getCbh().trim().equals("")) {
				hql += " and t.cbh =:cbh";
				params.put("cbh", cost.getCbh());
			}
		}
		return hql;
	}

	@Override
	public Double totalCost(Cost cost) {
		String hql = "select sum(t.camount) from Tcost t  where t.tfile.cid = :cid group by t.tfile";
		if (cost != null && cost.getFileId() != null) {
			Map<String, Object> params = new HashMap<String, Object>();
			params.put("cid", cost.getFileId());
			return costDao.sum(hql, params);
		}
		return 0.0;
	}

	@Override
	public Double sumyt(Cost cost) {
		String hql;
		Map<String, Object> params = new HashMap<String, Object>();
		if (cost != null) {
			if (cost.getCid() != null && !cost.getCid().trim().equals("")) {
				hql = "select sum(t.camount) from Tcost t where t.cid != :cid and t.tbudget.cid = :budgetId  group by t.tbudget";
				params.put("cid", cost.getCid());
			} else {
				hql = "select sum(t.camount) from Tcost t where  t.tbudget.cid = :budgetId  group by t.tbudget";
			}
			if (cost.getBudgetId() != null) {
				params.put("budgetId", cost.getBudgetId());
			}
			return costDao.sum(hql, params);
		}
		return 0.0;
	}

	@Override
	public List<Cost> excelData(Cost cost) {
		String hql = " from Tcost t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(cost, hql, params);
		hql += " order by t.tdept,t.ccreatedate ";
		List<Tcost> list = costDao.find(hql, params);
		return listRows(list);
	}

	@Override
	public void addPzh(Cost cost) {
		if (cost != null && cost.getIds() != null) {
			List<Pzh> pzhs = JSON.parseArray(cost.getIds(), Pzh.class);
			for (Pzh pzh : pzhs) {
				Tcost t = costDao.get(Tcost.class, pzh.getCid());
				if (t != null) {
					t.setCpzh(pzh.getPzh());
					t.setCprogress(2);
				}
			}
		}
	}

	@Override
	public CostPrint printData(Cost cost) {
		CostPrint cp = new CostPrint();
		Double amount = 0.00;
		int i = 0;
		List<Cost> l = new ArrayList<Cost>();
		if (cost != null && cost.getIds() != null && !cost.getIds().trim().equals("")) {
			for (String id : cost.getIds().split(",")) {
				Tcost t = costDao.get(Tcost.class, id);
				if (t != null) {
					i++;
					amount += t.getCamount();
					if (t.getCsj() != null) {
						amount += t.getCsj();
					}
					l.add(ChangeModel(t));
					cp.setDeptName(t.getTdept().getCdeptName());
					if (t.getCbh() != null) {
						cp.setDzbh(t.getCbh());
					} else {
						cp.setDzbh("____");
					}
					if (!t.getClzfs().equals("银行（市局付）")) {
						cp.setLzfs(t.getClzfs());
					} else {
						cp.setLzfs("银行");
					}
				}
			}
			BigDecimal bg = new BigDecimal(amount);
			amount = bg.setScale(2, BigDecimal.ROUND_HALF_UP).doubleValue();
			cp.setAmount(amount);
			if (amount >= 0) {
				cp.setUpperNumber(SimpleMoneyFormat.getInstance().format(amount));
			} else {
				cp.setUpperNumber("负" + SimpleMoneyFormat.getInstance().format(amount * (-1)));
			}

			cp.setTotal(i);
			cp.setRows(l);
		}
		return cp;
	}

	@Override
	public DataGrid tjSubject(Cost cost) {
		DataGrid dg = new DataGrid();
		Tsubject t = subjectDao.get(Tsubject.class, cost.getSubjectId());
		List<TjSubject> tjs = new ArrayList<TjSubject>();
		tjs = getSubject(cost, t, tjs);
		dg.setRows(tjs);
		dg.setTotal((long) (tjs.size()));
		return dg;
	}

	private List<TjSubject> getSubject(Cost cost, Tsubject t, List<TjSubject> l) {
		String hql;
		Map<String, Object> params = new HashMap<String, Object>();
		hql = "select sum(t.camount),sum(t.csj) from Tcost t where 1=1 ";
		if (cost.getDeptId() != null && deptDao.get(Tdept.class, cost.getDeptId()).getTdept() != null) {
			hql += " and t.tdept.cid= :deptid";
			params.put("deptid", cost.getDeptId());
		}
		if (cost.getCiszd() != null && cost.getCiszd() != 0) {
			hql += " and t.ciszd = :ciszd";
			params.put("ciszd", cost.getCiszd());
		}
		if (!StringUtils.isEmpty(cost.getZrzxId())){
			hql += " and t.tzrzx.cid= :zrzxid";
			params.put("zrzxid", cost.getZrzxId());
		}
		hql += " and t.cdate >=:startdate and t.cdate<=:enddate and t.cfx=:cfx ";
		hql += "  and t.tsubject.cid in (:ids)  ";
		TjSubject sub = getSumBySubject(cost, t, hql, params);
//		if (sub.getBqye()!=0 || sub.getBqyed()!=0 || sub.getBqyej()!=0 || sub.getSqye()!=0){
//			l.add(sub);
//		}
		l.add(sub);
		List<Subject> childrens = tree(t).getChildren();
		if (childrens != null && childrens.size() > 0) {
			for (Subject tsub : childrens) {
				Tsubject tt = subjectDao.get(Tsubject.class,tsub.getCid());
				getSubject(cost, tt, l);
			}
		}
		return l;
	}

	private List<String> getChildrenId(Tsubject t, List<String> list) {
		list.add(t.getCid());
		if (t.getTsubjects() != null && t.getTsubjects().size() > 0) {
			for (Tsubject s : t.getTsubjects()) {
				getChildrenId(s, list);
			}
		}
		return list;
	}
	
	private Subject tree(Tsubject t) {
		Subject subject = new Subject();
		BeanUtils.copyProperties(t, subject, new String[] { "tsubject" });
		subject.setId(t.getCid());
		subject.setText(t.getCname());
		if (t.getTsubject() != null) {
			subject.setPid(t.getTsubject().getCid());
			subject.setPname(t.getTsubject().getCname());
		}
		if (t.getTsubjects() != null && t.getTsubjects().size() > 0) {
			// 递归查询子节点subject
			List<Tsubject> l = new ArrayList<Tsubject>(t.getTsubjects());
			Collections.sort(l, new SubjectComparator());// 排序
			List<Subject> children = new ArrayList<Subject>();
			for (Tsubject r : l) {
				Subject tn = tree(r);
				children.add(tn);
			}
			subject.setChildren(children);
			subject.setState("closed");
		}
		return subject;
	}


	private TjSubject getSumBySubject(Cost cost, Tsubject t, String hql, Map<String, Object> params) {
		List<String> ids = new ArrayList<String>();
		Object[] obj;
		double bqyej = 0.0;
		double bqyed = 0.0;
		double sqyej = 0.0;
		double sqyed = 0.0;
		double sqye = 0.0;
		Tdept dept = deptDao.get(Tdept.class, cost.getDeptId());
		TjSubject tjs = new TjSubject();
		tjs.setDeptName(dept.getCdeptName());
		tjs.setSubjectId(t.getCid());
		tjs.setSubjectName(t.getCname());
		ids = getChildrenId(t, ids);
		params.put("ids", ids);
		params.put("startdate", cost.getStartdate());
		params.put("enddate", cost.getEnddate());
		params.put("cfx", "借");
		obj = costDao.summ(hql, params);
		if (obj != null ) {
			if (obj[0]!=null){
				bqyej += (Double)obj[0];
			}
			if (obj[1]!=null){
				bqyej += (Double)obj[1];
			}
			tjs.setBqyej(DoubleUtil.Keep2(bqyej));
		} else {
			bqyej = 0.0;
			tjs.setBqyej(DoubleUtil.Keep2(bqyej));
		}
		params.put("cfx", "贷");
		obj = costDao.summ(hql, params);
		if (obj != null ) {
			if (obj[0]!=null){
				bqyed += (Double)obj[0];
			}
			if (obj[1]!=null){
				bqyed += (Double)obj[1];
			}
			tjs.setBqyed(DoubleUtil.Keep2(bqyed));
		} else {
			bqyed = 0.0;
			tjs.setBqyed(DoubleUtil.Keep2(bqyed));
		}
		params.put("startdate", DateUtil.getFirstDateOfCurYear(cost.getStartdate()));
		params.put("enddate", DateUtil.getLastDateOfUpMonth(cost.getStartdate()));
		params.put("cfx", "借");
		obj = costDao.summ(hql, params);
		if (obj != null ) {
			if (obj[0]!=null){
				sqyej += (Double)obj[0];
			}
			if (obj[1]!=null){
				sqyej += (Double)obj[1];
			}
		} else {
			sqyej = 0.0;
		}
		params.put("cfx", "贷");
		obj = costDao.summ(hql, params);
		if (obj != null ) {
			if (obj[0]!=null){
				sqyed += (Double)obj[0];
			}
			if (obj[1]!=null){
				sqyed += (Double)obj[1];
			}
		} else {
			bqyed = 0.0;
		}
		sqye = DoubleUtil.Keep2(sqyej - sqyed);
		tjs.setSqye(sqye);
		tjs.setBqye(DoubleUtil.Keep2((sqye + bqyej - bqyed)));
		return tjs;
	}

	@Override
	public List<TjSubject> exportTjSubject(Cost cost) {
		Tsubject t = subjectDao.get(Tsubject.class, cost.getSubjectId());
		List<TjSubject> tj = new ArrayList<TjSubject>();
		return getSubject(cost, t, tj);
	}

	@Override
	public List<TjProject> exportTjProject(Cost cost) {
		String hql = "from Tzrzx";
		List<Tzrzx> projects = zrzxDao.find(hql);
		List<TjProject> tjps = new ArrayList<TjProject>();
		Map<String, Object> params = new HashMap<String, Object>();
		hql =" select sum(t.camount),sum(t.csj) from Tcost t where t.ciszd=2 and t.tzrzx.cid = :projectId and t.cxz= :cxz";
		params.put("cxz", "重点");
		if (cost.getDeptId() != null && deptDao.get(Tdept.class, cost.getDeptId()).getTdept() != null) {
			hql += " and t.tdept.cid= :deptid";
			params.put("deptid", cost.getDeptId());
		} 
		hql += " and t.cdate>= :startdate and t.cdate <= :enddate and t.tkind.cid = :kindId";
		for (Tzrzx t : projects){
			tjps.add(getTjproject(cost,t,hql,params));
		}
		return tjps;
	}

	private TjProject getTjproject(Cost cost,Tzrzx t,String hql,Map<String, Object> params){
		TjProject tj = new TjProject();
		Tdept dept = deptDao.get(Tdept.class, cost.getDeptId());
		Object[] obj;
		Double bnnb = 0.0;
		Double bnwb = 0.0;
		Double bynb = 0.0;
		Double bywb = 0.0;
		String nbId="d3003280-8746-45d3-baf4-3a444195b128";
		String wbId="8df10f18-f817-4799-8af7-a7992d067be2";
		params.put("projectId", t.getCid());
		params.put("startdate", DateUtil.getYearFirst4y2M(cost.getCmonth()));
		params.put("enddate", DateUtil.getLast4y2M(cost.getCmonth()));
		params.put("kindId", nbId);
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bnnb = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bnnb = 0.0;
		}
		tj.setBnnb(bnnb);
		params.put("kindId", wbId);
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bnwb = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bnwb = 0.0;
		}
		tj.setBnwb(bnwb);
		tj.setBntotal(DoubleUtil.Keep2(bnnb+bnwb));
		params.put("startdate", DateUtil.getFirst4y2M(cost.getCmonth()));
		params.put("enddate", DateUtil.getLast4y2M(cost.getCmonth()));
		params.put("kindId", nbId);
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bynb = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bynb = 0.0;
		}
		tj.setBynb(bynb);
		params.put("kindId", wbId);
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bywb = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bywb = 0.0;
		}
		tj.setBywb(bywb);
		tj.setBytotal(DoubleUtil.Keep2(bynb+bywb));
		tj.setCid(t.getCid());
		tj.setCname(t.getCname());
		tj.setDeptName(dept.getCdeptName());
		return tj;
	}
	@Override
	public DataGrid tjProject(Cost cost) {
		DataGrid dg = new DataGrid();
		List<TjProject> rows= exportTjProject(cost);
		dg.setRows(rows);
		Double bnnb = 0.0;
		Double bnwb = 0.0;
		Double bynb = 0.0;
		Double bywb = 0.0;
		for (TjProject tj : rows){
			bnnb +=tj.getBnnb();
			bnwb +=tj.getBnwb();
			bynb +=tj.getBynb();
			bywb +=tj.getBywb();
		}
		Map<String,Object> foot = new HashMap<String,Object>();
		foot.put("bnnb", DoubleUtil.Keep2(bnnb));
		foot.put("bnwb", DoubleUtil.Keep2(bnwb));
		foot.put("bynb", DoubleUtil.Keep2(bynb));
		foot.put("bywb", DoubleUtil.Keep2(bywb));
		foot.put("bytotal", DoubleUtil.Keep2(bynb+bywb));
		foot.put("bntotal", DoubleUtil.Keep2(bnnb+bnwb));
		foot.put("cname", "合计:");
		List<Map<String,Object>> f = new ArrayList<Map<String,Object>>();
		f.add(foot);
		dg.setFooter(f);
		return dg;
	}

	@Override
	public DataGrid tjNormal(Cost cost) {
		DataGrid dg = new DataGrid();
		List<TjNormal> rows= exportTjNormal(cost);
		dg.setRows(rows);
		Double bntotal = 0.0;
		Double bytotal = 0.0;
		for (TjNormal tj : rows){
			bntotal +=tj.getBntotal();
			bytotal +=tj.getBytotal();
		}
		Map<String,Object> foot = new HashMap<String,Object>();
		foot.put("bytotal", DoubleUtil.Keep2(bytotal));
		foot.put("bntotal", DoubleUtil.Keep2(bntotal));
		foot.put("cname", "合计:");
		List<Map<String,Object>> f = new ArrayList<Map<String,Object>>();
		f.add(foot);
		dg.setFooter(f);
		return dg;
	}
	
	
	
	private TjNormal getTjNormal(Cost cost,String kindId,String kindName,String hql,Map<String, Object> params){
		TjNormal normal = new TjNormal();
		Tdept dept = deptDao.get(Tdept.class, cost.getDeptId());
		Object[] obj;
		Double bntotal = 0.0;
		Double bytotal = 0.0;
		params.put("startdate", DateUtil.getYearFirst4y2M(cost.getCmonth()));
		params.put("enddate", DateUtil.getLast4y2M(cost.getCmonth()));
		params.put("kindId", kindId);
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bntotal = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bntotal = 0.0;
		}
		normal.setBntotal(bntotal);
		params.put("startdate", DateUtil.getFirst4y2M(cost.getCmonth()));
		params.put("enddate", DateUtil.getLast4y2M(cost.getCmonth()));
		obj = costDao.summ(hql, params);
		if (obj != null && obj[0] != null && obj[1] != null) {
			bytotal = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
		} else {
			bytotal = 0.0;
		}
		normal.setBytotal(bytotal);
		normal.setCname(kindName);
		normal.setCid(kindId);
		normal.setDeptName(dept.getCdeptName());
		return normal;
	}

	@Override
	public List<TjNormal> exportTjNormal(Cost cost) {
		String[] kid = new String[]{"f1faf756-e7d3-4fd7-af1b-6f22ce46bca9","99556ebe-30c5-4a96-88ee-dcb40fc3285d","7ee2d967-8617-40b9-85eb-962edfa2da5b","5142ed69-9fe9-47f3-ae8e-0ce75dbb323b"};
		String[] kname = new String[]{"合同工","劳务工","离退休","食堂、门卫"};
		List<TjNormal> tjs = new ArrayList<TjNormal>();
		Map<String, Object> params = new HashMap<String, Object>();
		String hql =" select sum(t.camount),sum(t.csj) from Tcost t where t.ciszd=2 and t.tkind.cid = :kindId and t.cxz= :cxz";
		params.put("cxz", "正常");
		if (cost.getDeptId() != null && deptDao.get(Tdept.class, cost.getDeptId()).getTdept() != null) {
			hql += " and t.tdept.cid= :deptid";
			params.put("deptid", cost.getDeptId());
		} 
		hql += " and t.cdate>= :startdate and t.cdate <= :enddate ";
		for (int i=0;i<4;i++){
			tjs.add(getTjNormal(cost, kid[i],kname[i], hql, params));
		}
		return tjs;
	}

	/**
	@Override
	public List<Map<String, String>> tjFunds(Cost cost) {
		List<Map<String,String>> tjf = new ArrayList<Map<String,String>>();
		Map<String, Object> params = new HashMap<String, Object>();
		Tdept dept = deptDao.get(Tdept.class, cost.getDeptId());
		List<Tdept> depts = new ArrayList<Tdept>();
		Object[] obj;
		if (dept.getTdept()!=null){
			depts.add(dept);
		}else{
			String q = " from Tdept t where t.tdept.cid = :deptid order by t.cseq";
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("deptid", dept.getCid());
			depts = deptDao.find(q, p);
		}
		String hql = " from Tzrzx t order by t.cid";
		List<Tzrzx> zrzxs = zrzxDao.find(hql);
		hql = "select sum(t.camount),sum(t.csj) from Tcost t where  t.tdept.cid= :deptid and t.cdate>= :startdate and t.cdate <= :enddate and t.tzrzx.cid = :zrzxid and t.clzfs in (:lzfs) ";
		params.put("startdate", DateUtil.getFirst4y2M(cost.getCmonth()));
		params.put("enddate", DateUtil.getLast4y2M(cost.getCmonth()));
		List<String> lzfs = new ArrayList<String>();
		lzfs.add("现金");
		lzfs.add("银行");
		params.put("lzfs", lzfs);
		for (Tdept tdept : depts){
			params.put("deptid", tdept.getCid());
			Map<String,String> fund = new LinkedHashMap<String,String>();
			fund.put("deptname",tdept.getCdeptName());
			for (Tzrzx tzrzx:zrzxs){
				params.put("zrzxid", tzrzx.getCid());
				Double zijin = 0.0;
				obj = costDao.summ(hql, params);
				if (obj != null && obj[0] != null && obj[1] != null) {
					zijin = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
				} else {
					zijin = 0.0;
				}
				fund.put(tzrzx.getCid(),""+zijin);
			}
			tjf.add(fund);
		}
	
		return tjf;
	}
*/
	
	@Override
	public List<Map<String, String>> tjFunds(Cost cost) {
		List<Map<String,String>> tjf = new ArrayList<Map<String,String>>();
		Map<String, Object> params = new HashMap<String, Object>();
		Tdept dept = deptDao.get(Tdept.class, cost.getDeptId());
		List<Tdept> depts = new ArrayList<Tdept>();
		Object[] obj;
		if (dept.getTdept()!=null){
			depts.add(dept);
		}else{
			String q = " from Tdept t where t.tdept.cid = :deptid order by t.cseq";
			Map<String, Object> p = new HashMap<String, Object>();
			p.put("deptid", dept.getCid());
			depts = deptDao.find(q, p);
		}
		String hql = " from Tzrzx t order by t.cid";
		List<Tzrzx> zrzxs = zrzxDao.find(hql);
		hql = "select sum(t.camount),sum(t.csj) from Tcost t where  t.tdept.cid= :deptid and t.cdate>= :startdate and t.cdate <= :enddate and t.tzrzx.cid = :zrzxid and t.cfx =:cfx and t.tsubject.cid in (:subjectIds) ";
		params.put("startdate", cost.getStartdate());
		params.put("enddate", cost.getEnddate());
		List<String> subjectIds = new ArrayList<String>();
		subjectIds = getChildrenId(subjectDao.get(Tsubject.class, "6"), subjectIds);//统计损益类（id=6）
		params.put("subjectIds", subjectIds);
		for (Tdept tdept : depts){
			params.put("deptid", tdept.getCid());
			Map<String,String> fund = new LinkedHashMap<String,String>();
			fund.put("deptname",tdept.getCdeptName());
			for (Tzrzx tzrzx:zrzxs){
				params.put("zrzxid", tzrzx.getCid());
				params.put("cfx", "借");
				Double zijin_jie = 0.0;
				obj = costDao.summ(hql, params);
				if (obj != null && obj[0] != null && obj[1] != null) {
					zijin_jie = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
				} else {
					zijin_jie = 0.0;
				}
				params.put("cfx", "贷");
				Double zijin_dai = 0.0;
				obj = costDao.summ(hql, params);
				if (obj != null && obj[0] != null && obj[1] != null) {
					zijin_dai = DoubleUtil.Keep2((Double) obj[0] + (Double) obj[1]);
				} else {
					zijin_dai = 0.0;
				}
				DecimalFormat df = new DecimalFormat("0.00"); //double 转字符串，防止自动转科学技术法
				fund.put(tzrzx.getCid(),df.format(DoubleUtil.Keep2(zijin_jie-zijin_dai)));
			}
			tjf.add(fund);
		}
		
		return tjf;
	}
	
}
