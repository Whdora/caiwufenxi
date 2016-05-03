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
import com.post.model.Tlink;
import com.post.model.Tuser;
import com.post.pageModel.Link;
import com.post.pageModel.DataGrid;
import com.post.service.LinkServiceI;

@Service("linkService")
public class LinkServiceImpl implements LinkServiceI {

	private BaseDaoI<Tlink> linkDao;
	private BaseDaoI<Tuser> userDao;
	
	

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	public BaseDaoI<Tlink> getLinkDao() {
		return linkDao;
	}

	@Autowired
	public void setLinkDao(BaseDaoI<Tlink> linkDao) {
		this.linkDao = linkDao;
	}

	@Override
	public void add(Link link) {
		Tlink t = new Tlink();
		BeanUtils.copyProperties(link, t);
		t.setCid(UUID.randomUUID().toString());
		Date d = new Date();
		t.setCcreatedate(new Timestamp(d.getTime()));
		t.setCmodifydate(new Timestamp(d.getTime()));
		t.setTuser(userDao.get(Tuser.class, link.getUserId()));
		linkDao.save(t);
	}

	@Override
	public void edit(Link link) {
		Tlink t = linkDao.get(Tlink.class, link.getCid());
		BeanUtils.copyProperties(link, t,new String[]{"cid","ccreatedate"});
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}

	@Override
	public void delete(Link link) {
		String cids = "";
		if (link.getIds() != null) {
			String ids = link.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tlink t where t.cid in (" + cids + ")";
			linkDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Link link) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(link)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tlink t where 1=1";
		return linkDao.count(hql);
	}

	private List<Tlink> find(Link link) {
		String hql = "from Tlink t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(link, hql, params);
		if (link.getOrder() != null && link.getSort() != null) {
			hql += " order by " + link.getSort() + " "
					+ link.getOrder();
		}
		return linkDao.find(hql,params,  link.getPage(), link.getRows());
	}
	
	private String addWhere(Link link, String hql, Map<String, Object> params) {
		if (link != null) {
			if (link.getCtitle()!=null && !link.getCtitle().trim().equals("")){
				hql +=" and t.ctitle like :ctitle";
				params.put("ctitle", "%%"+link.getCtitle()+"%%");
			}
			
		}
		return hql;
	}


	private List<Link> listRows(List<Tlink> lt) {
		List<Link> rows = new ArrayList<Link>();
		if (lt != null && lt.size() > 0) {
			for (Tlink t : lt) {
				Link sub = new Link();
				BeanUtils.copyProperties(t, sub);
				sub.setUserId(t.getTuser().getCid());
				sub.setUserName(t.getTuser().getCusername());
				rows.add(sub);
			}
		}
		return rows;
	}


	

	@Override
	public List<Link> listLink() {
		String hql = "from Tlink t order by t.ccreatedate desc";
		List<Tlink> list = linkDao.find(hql,1,10);
		return listRows(list);
	}

}
