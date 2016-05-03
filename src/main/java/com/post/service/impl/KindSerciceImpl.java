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

import com.post.comparator.KindComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tkind;
import com.post.pageModel.Kind;
import com.post.service.KindServiceI;

@Service("kindService")
public class KindSerciceImpl implements KindServiceI {

	private BaseDaoI<Tkind> kindDao;

	public BaseDaoI<Tkind> getKindDao() {
		return kindDao;
	}

	@Autowired
	public void setKindDao(BaseDaoI<Tkind> kindDao) {
		this.kindDao = kindDao;
	}

	@Override
	public void add(Kind kind) {
		Tkind t = new Tkind();
		BeanUtils.copyProperties(kind, t);
		t.setCid(UUID.randomUUID().toString());
		if (kind.getPid() != null) {
			t.setTkind(kindDao.get(Tkind.class, kind.getPid()));
		}
		kindDao.save(t);
	}

	@Override
	public void edit(Kind kind) {
		if (kind != null && kind.getCid() != null) {
			Tkind t = kindDao.get(Tkind.class, kind.getCid());
			BeanUtils.copyProperties(kind, t);
			if (kind.getPid() != null && !kind.getPid().equals(kind.getCid())) {
				Tkind pt = kindDao.get(Tkind.class, kind.getPid());
				if (pt != null) {
					if (isDown(t, pt)) {// 要将当前节点修改到当前节点的子节点中
						Set<Tkind> tkinds = t.getTkinds();// 当前要修改的节点的所有下级节点
						if (tkinds != null && tkinds.size() > 0) {
							for (Tkind tkind : tkinds) {
								if (tkind != null) {
									tkind.setTkind(null);
								}
							}
						}
					}
					t.setTkind(pt);
				}

			}
		}

	}
	
	private boolean isDown(Tkind t, Tkind pt) {
		if (pt.getTkind() != null) {
			if (pt.getTkind().getCid().equals(t.getCid())) {
				return true;
			} else {
				return isDown(t, pt.getTkind());
			}
		}
		return false;
	}

	@Override
	public void delete(Kind kind) {
		del(kind.getCid());
	}

	private void del(String cid) {
		Tkind t = kindDao.get(Tkind.class, cid);
		if (t != null) {
			Set<Tkind> kinds = t.getTkinds();
			if (kinds != null && !kinds.isEmpty()) {
				for (Tkind tkind : kinds) {
					del(tkind.getCid());
				}
			}
			kindDao.delete(t);
		}
	}

	@Override
	public List<Kind> treegrid(Kind kind) {
		Map<String, Object> params = new HashMap<String, Object>();
		String hql = "from Tkind t where t.tkind is null order by t.cseq";
		if (kind != null && kind.getId() != null
				&& !kind.getId().trim().equals("")) {
			hql = "from Tkind t where t.tkind.cid = :cid order by t.cseq";
			params.put("cid", kind.getId());
		}
		List<Tkind> l = kindDao.find(hql, params);
		List<Kind> tree = new ArrayList<Kind>();
		for (Tkind t : l) {
			tree.add(this.tree(t));
		}
		return tree;
	}

	private Kind tree(Tkind t) {
		Kind kind = new Kind();
		BeanUtils.copyProperties(t, kind, new String[] { "tkind" });
		kind.setId(t.getCid());
		kind.setText(t.getCname());
		if (t.getTkind() != null) {
			kind.setPid(t.getTkind().getCid());
			kind.setPname(t.getTkind().getCname());
		}
		if (t.getTkinds() != null && t.getTkinds().size() > 0) {
			// 递归查询子节点kind
			List<Tkind> l = new ArrayList<Tkind>(t.getTkinds());
			Collections.sort(l, new KindComparator());// 排序
			List<Kind> children = new ArrayList<Kind>();
			for (Tkind r : l) {
				Kind tn = tree(r);
				children.add(tn);
			}
			kind.setChildren(children);
			kind.setState("open");
		}
		return kind;
	}

}
