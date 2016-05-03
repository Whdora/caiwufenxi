package com.post.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.model.Tproject;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Project;
import com.post.service.ProjectServiceI;

@Service("projectService")
public class ProjectServiceImpl implements ProjectServiceI {
	
	private BaseDaoI<Tproject> projectDao;

	public BaseDaoI<Tproject> getProjectDao() {
		return projectDao;
	}

	@Autowired
	public void setProjectDao(BaseDaoI<Tproject> projectDao) {
		this.projectDao = projectDao;
	}

	@Override
	public void add(Project project) {
		Tproject t = new Tproject();
		BeanUtils.copyProperties(project, t);
		t.setCid(UUID.randomUUID().toString());
		projectDao.save(t);
	}

	@Override
	public void edit(Project project) {
		Tproject t = projectDao.get(Tproject.class, project.getCid());
		BeanUtils.copyProperties(project, t);
	}

	@Override
	public void delete(Project project) {
		String cids = "";
		if (project.getIds() != null) {
			String ids = project.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tproject t where t.cid in (" + cids + ")";
			projectDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Project project) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(project)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tproject t where 1=1";
		return projectDao.count(hql);
	}

	private List<Tproject> find(Project project) {
		String hql = "from Tproject t where 1=1";
		if (project.getOrder() != null && project.getSort() != null) {
			hql += " order by " + project.getSort() + " " + project.getOrder();
		}
		return projectDao.find(hql, project.getPage(), project.getRows());
	}

	private List<Project> listRows(List<Tproject> lt) {
		List<Project> rows = new ArrayList<Project>();
		if (lt != null && lt.size() > 0) {
			for (Tproject t : lt) {
				Project sub = new Project();
				BeanUtils.copyProperties(t, sub);
				rows.add(sub);
			}
		}
		return rows;
	}

	@Override
	public List<Project> combobox() {
		List<Project> rl = new ArrayList<Project>();
		List<Tproject> l = projectDao.find("from Tproject");
		if (l != null && l.size() > 0) {
			for (Tproject t : l) {
				Project r = new Project();
				r.setCid(t.getCid());
				r.setCname(t.getCname());
				rl.add(r);
			}
		}
		return rl;
	}

}

