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

import com.post.comparator.AuthComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tauth;
import com.post.model.Tmenu;
import com.post.pageModel.Auth;
import com.post.service.AuthServiceI;

@Service("authService")
public class AuthServiceImpl implements AuthServiceI {

	private BaseDaoI<Tauth> authDao;

	public BaseDaoI<Tauth> getAuthDao() {
		return authDao;
	}

	@Autowired
	public void setAuthDao(BaseDaoI<Tauth> authDao) {
		this.authDao = authDao;
	}

	@Override
	public void delete(Auth auth) {
		del(auth.getCid());

	}

	private void del(String cid) {
		Tauth t = authDao.get(Tauth.class, cid);
		if (t != null) {
			Set<Tauth> auths = t.getTauths();
			if (auths != null && !auths.isEmpty()) {
				for (Tauth tauth : auths) {
					del(tauth.getCid());
				}
			}
			authDao.delete(t);
		}
	}

	@Override
	public void add(Auth auth) {
		Tauth t = new Tauth();
		BeanUtils.copyProperties(auth, t);
		t.setCid(UUID.randomUUID().toString());
		if (auth.getPid() != null) {
			t.setTauth(authDao.get(Tauth.class, auth.getPid()));
		}
		authDao.save(t);
	}

	@Override
	public void edit(Auth auth) {
		Tauth t = authDao.get(Tauth.class, auth.getCid());
		BeanUtils.copyProperties(auth, t);
		if (auth.getPid() != null && !auth.getPid().equals(auth.getCid())) {
			Tauth pt = authDao.get(Tauth.class, auth.getPid());
			if (pt != null) {
				if (isDown(t, pt)) {// 要将当前节点修改到当前节点的子节点中
					Set<Tauth> tauths = t.getTauths();// 当前要修改的节点的所有下级节点
					if (tauths != null && tauths.size() > 0) {
						for (Tauth tauth : tauths) {
							if (tauth != null) {
								tauth.setTauth(null);
							}
						}
					}
				}
				t.setTauth(pt);
			}

		}
	}


	private boolean isDown(Tauth t, Tauth pt) {
		if (pt.getTauth() != null) {
			if (pt.getTauth().getCid().equals(t.getCid())) {
				return true;
			} else {
				return isDown(t, pt.getTauth());
			}
		}
		return false;
	}

	@Override
	public List<Auth> treegrid(Auth auth, boolean b) {
		Map<String, Object> params = new HashMap<String, Object>();
		String hql = "from Tauth t where t.tauth is null order by t.cseq";
		if (auth != null && auth.getCid() != null) {
			hql = "from Tauth t where t.tauth.cid=:cid order by t.cseq";
			params.put("cid", auth.getCid());
		}
		List<Tauth> tds = authDao.find(hql, params);
		List<Auth> tree = new ArrayList<Auth>();
		for (Tauth t : tds) {
			tree.add(this.tgrid(t, true));
		}
		return tree;
	}

	private Auth tgrid(Tauth t, boolean recursive) {
		Auth auth = new Auth();
		BeanUtils.copyProperties(t, auth, new String[] { "tauth" });
		auth.setText(t.getCname());
		auth.setId(t.getCid());
		if (t.getTauth() != null) {
			auth.setPid(t.getTauth().getCid());
			auth.setPname(t.getTauth().getCname());
		}

		if (t.getTauths() != null && t.getTauths().size() > 0) {
			if (recursive) {// 递归查询子节点menu
				List<Tauth> l = new ArrayList<Tauth>(t.getTauths());
				Collections.sort(l, new AuthComparator());// 排序
				List<Auth> children = new ArrayList<Auth>();
				for (Tauth r : l) {
					Auth tn = tgrid(r, true);
					children.add(tn);
				}
				auth.setChildren(children);
				auth.setState("open");
			}
		}
		return auth;
	}

}
