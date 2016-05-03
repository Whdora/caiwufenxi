package com.post.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.comparator.DeptComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tdept;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Dept;
import com.post.service.DeptServiceI;

@Service("deptService")
public class DeptServiceImpl implements DeptServiceI {

	private BaseDaoI<Tdept> deptDao;

	public BaseDaoI<Tdept> getDeptDao() {
		return deptDao;
	}

	@Autowired
	public void setDeptDao(BaseDaoI<Tdept> deptDao) {
		this.deptDao = deptDao;
	}

	@Override
	public void addDept(Dept dept) {
		Tdept t = new Tdept();
		Date d = new Date();
		BeanUtils.copyProperties(dept, t);
		t.setCid(UUID.randomUUID().toString());
		t.setCcreateDatetime(new Timestamp(d.getTime()));
		t.setCmodifyDatetime(new Timestamp(d.getTime()));
		if (dept.getPid() != null) {
			t.setTdept(deptDao.get(Tdept.class, dept.getPid()));
		}
		deptDao.save(t);
	}

	@Override
	public DataGrid datagrid(Dept dept) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Dept> listDept() {
		List<Tdept> l;
		String hql = "from Tdept";
		l = deptDao.find(hql);
		return changeModel(l);
	}

	private List<Dept> changeModel(List<Tdept> l) {
		List<Dept> depts = new ArrayList<Dept>();
		if (l != null && l.size() > 0) {
			for (Tdept t : l) {
				Dept d = new Dept();
				BeanUtils.copyProperties(t, d);
				depts.add(d);
			}
		}
		return depts;
	}

	@Override
	public List<Dept> treeDept(Dept dept) {
		Map<String, Object> params = new HashMap<String, Object>();
		String hql = "from Tdept t where t.tdept is null order by t.cseq";
		if (dept != null && dept.getCid() != null) {
			hql = "from Tdept t where t.cid=:cid order by t.cseq";
			params.put("cid", dept.getCid());
		}
		List<Tdept> tds = deptDao.find(hql, params);
		List<Dept> tree = new ArrayList<Dept>();
		for (Tdept t : tds) {
			tree.add(this.tree(t));
		}
		return tree;
	}

	private Dept tree(Tdept tdept) {
		Dept d = new Dept();
		BeanUtils.copyProperties(tdept, d);
		d.setId(tdept.getCid());
		d.setText(tdept.getCdeptName());
		if (tdept.getTdept() != null) {
			d.setPid(tdept.getTdept().getCid());
			d.setPdeptName(tdept.getTdept().getCdeptName());
		}
		if (tdept.getTdepts() != null && tdept.getTdepts().size() > 0) {
			List<Tdept> tdepts = new ArrayList<Tdept>(tdept.getTdepts());
			Collections.sort(tdepts, new DeptComparator());// 排序
			List<Dept> children = new ArrayList<Dept>();
			for (Tdept t : tdepts) {
				Dept dept = tree(t);
				children.add(dept);
			}
			d.setChildren(children);
			d.setState("open");
		}
		return d;

	}
	

	@Override
	public void add(Dept dept) {
		Tdept t = new Tdept();
		Date d = new Date();
		BeanUtils.copyProperties(dept, t);
		t.setCid(UUID.randomUUID().toString());
		t.setCcreateDatetime(new Timestamp(d.getTime()));
		t.setCmodifyDatetime(new Timestamp(d.getTime()));
		if (dept.getPid() != null) {
			t.setTdept(deptDao.get(Tdept.class, dept.getPid()));
		}
		deptDao.save(t);
	}

	@Override
	public void edit(Dept dept) {
		Tdept t = deptDao.get(Tdept.class, dept.getCid());
		Date d = new Date();
		BeanUtils.copyProperties(dept, t);
		t.setCmodifyDatetime(new Timestamp(d.getTime()));
		if (dept.getPid()!=null && !dept.getPid().equals(dept.getCid())){
			Tdept pt=deptDao.get(Tdept.class, dept.getPid());
			if (pt!=null){
				if (isDown(t,pt)){
					Set<Tdept> tdepts=t.getTdepts();
					if (tdepts!=null && tdepts.size()>0){
						for(Tdept tdept:tdepts){
							if (tdept!=null){
								tdept.setTdept(null);
							}
						}
					}
				}
				t.setTdept(pt);
			}
		}
	}

	private boolean isDown(Tdept t, Tdept pt) {
		if (pt.getTdept() != null) {
			if (pt.getTdept().getCid().equals(t.getCid())) {
				return true;
			} else {
				return isDown(t, pt.getTdept());
			}
		}
		return false;
	}

	@Override
	public void delete(Dept dept) {
		del(dept.getCid());
	}

	private void del(String cid) {
		Tdept t = deptDao.get(Tdept.class, cid);
		if (t != null) {
			Set<Tdept> depts = t.getTdepts();
			if (depts != null && !depts.isEmpty()) {
				for (Tdept tdept : depts) {
					del(tdept.getCid());
				}
			}
			deptDao.delete(t);
		}
	}

}
