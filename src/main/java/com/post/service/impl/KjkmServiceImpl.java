package com.post.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.comparator.SubjectComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tsubject;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Subject;
import com.post.service.KjkmServiceI;

@Service("kjkmService")
public class KjkmServiceImpl implements KjkmServiceI {
	
	private BaseDaoI<Tsubject> kjkmDao;
	
	

	public BaseDaoI<Tsubject> getKjkmDao() {
		return kjkmDao;
	}

	@Autowired
	public void setKjkmDao(BaseDaoI<Tsubject> kjkmDao) {
		this.kjkmDao = kjkmDao;
	}

	@Override
	public void add(Subject subject) {
		Tsubject t = new Tsubject();
		BeanUtils.copyProperties(subject, t);
		if (subject.getPid() != null) {
			t.setTsubject(kjkmDao.get(Tsubject.class, subject.getPid()));
		}
		kjkmDao.save(t);
	}

	@Override
	public void edit(Subject subject) {
		if (subject != null && subject.getCid() != null) {
			Tsubject t = kjkmDao.get(Tsubject.class, subject.getCid());
			BeanUtils.copyProperties(subject, t);
			if (subject.getPid() != null && !subject.getPid().equals(subject.getCid())) {
				Tsubject pt = kjkmDao.get(Tsubject.class, subject.getPid());
				if (pt != null) {
					if (isDown(t, pt)) {// 要将当前节点修改到当前节点的子节点中
						Set<Tsubject> tsubjects = t.getTsubjects();// 当前要修改的节点的所有下级节点
						if (tsubjects != null && tsubjects.size() > 0) {
							for (Tsubject tsubject : tsubjects) {
								if (tsubject != null) {
									tsubject.setTsubject(null);
								}
							}
						}
					}
					t.setTsubject(pt);
				}

			}
		}

	}
	
	private boolean isDown(Tsubject t, Tsubject pt) {
		if (pt.getTsubject() != null) {
			if (pt.getTsubject().getCid().equals(t.getCid())) {
				return true;
			} else {
				return isDown(t, pt.getTsubject());
			}
		}
		return false;
	}

	@Override
	public void delete(Subject subject) {
		del(subject.getCid());
	}

	private void del(String cid) {
		Tsubject t = kjkmDao.get(Tsubject.class, cid);
		if (t != null) {
			Set<Tsubject> subjects = t.getTsubjects();
			if (subjects != null && !subjects.isEmpty()) {
				for (Tsubject tsubject : subjects) {
					del(tsubject.getCid());
				}
			}
			kjkmDao.delete(t);
		}
	}

	@Override
	public DataGrid datagrid(Subject subject) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(subject)));
		dg.setTotal(total());
		return dg;
	}
	
	
	private Long total(){
		String hql ="select count(*) from Tsubject t where 1=1";
		return kjkmDao.count(hql);
	}
	
	
	private List<Tsubject> find(Subject subject){
		String hql = "from Tsubject t where 1=1";
		if (subject.getOrder()!=null && subject.getSort()!=null){
			hql+=" order by "+subject.getSort()+" "+subject.getOrder();
		}
		return kjkmDao.find(hql, subject.getPage(), subject.getRows());
	}
	
	private List<Subject> listRows(List<Tsubject> lt){
		List<Subject> rows= new ArrayList<Subject>();
		if (lt!=null && lt.size()>0){
			for (Tsubject t : lt){
				Subject sub=new Subject();
				BeanUtils.copyProperties(t, sub);
				rows.add(sub);
			}
		}
		return rows;
	}

	@Override
	public List<Subject> treegrid(Subject subject) {
		Map<String, Object> params = new HashMap<String, Object>();
		String hql = "from Tsubject t where t.tsubject is null order by t.cseq";
		if (subject != null && subject.getId() != null
				&& !subject.getId().trim().equals("")) {
			hql = "from Tsubject t where t.tsubject.cid = :cid order by t.cseq";
			params.put("cid", subject.getId());
		}
		List<Tsubject> l = kjkmDao.find(hql, params);
		List<Subject> tree = new ArrayList<Subject>();
		for (Tsubject t : l) {
			tree.add(this.tree(t));
		}
		return tree;
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


}
