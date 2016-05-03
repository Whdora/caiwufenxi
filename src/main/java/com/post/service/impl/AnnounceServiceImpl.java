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
import com.post.model.Tannounce;
import com.post.model.Tuser;
import com.post.pageModel.Announce;
import com.post.pageModel.DataGrid;
import com.post.service.AnnounceServiceI;

@Service("announceService")
public class AnnounceServiceImpl implements AnnounceServiceI {

	private BaseDaoI<Tannounce> announceDao;
	private BaseDaoI<Tuser> userDao;
	
	

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	public BaseDaoI<Tannounce> getAnnounceDao() {
		return announceDao;
	}

	@Autowired
	public void setAnnounceDao(BaseDaoI<Tannounce> announceDao) {
		this.announceDao = announceDao;
	}

	@Override
	public void add(Announce announce) {
		Tannounce t = new Tannounce();
		BeanUtils.copyProperties(announce, t);
		t.setCid(UUID.randomUUID().toString());
		Date d = new Date();
		t.setCcreatedate(new Timestamp(d.getTime()));
		t.setCmodifydate(new Timestamp(d.getTime()));
		t.setTuser(userDao.get(Tuser.class, announce.getUserId()));
		announceDao.save(t);
	}

	@Override
	public void edit(Announce announce) {
		Tannounce t = announceDao.get(Tannounce.class, announce.getCid());
		BeanUtils.copyProperties(announce, t,new String[]{"cid","ccreatedate"});
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}

	@Override
	public void delete(Announce announce) {
		String cids = "";
		if (announce.getIds() != null) {
			String ids = announce.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tannounce t where t.cid in (" + cids + ")";
			announceDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Announce announce) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(announce)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tannounce t where 1=1";
		return announceDao.count(hql);
	}

	private List<Tannounce> find(Announce announce) {
		String hql = "from Tannounce t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(announce, hql, params);
		if (announce.getOrder() != null && announce.getSort() != null) {
			hql += " order by " + announce.getSort() + " "
					+ announce.getOrder();
		}
		return announceDao.find(hql,params,  announce.getPage(), announce.getRows());
	}
	
	private String addWhere(Announce announce, String hql, Map<String, Object> params) {
		if (announce != null) {
			if (announce.getCtitle()!=null && !announce.getCtitle().trim().equals("")){
				hql +=" and t.ctitle like :ctitle";
				params.put("ctitle", "%%"+announce.getCtitle()+"%%");
			}
			
		}
		return hql;
	}


	private List<Announce> listRows(List<Tannounce> lt) {
		List<Announce> rows = new ArrayList<Announce>();
		if (lt != null && lt.size() > 0) {
			for (Tannounce t : lt) {
				Announce sub = new Announce();
				BeanUtils.copyProperties(t, sub);
				sub.setUserId(t.getTuser().getCid());
				sub.setUserName(t.getTuser().getCusername());
				rows.add(sub);
			}
		}
		return rows;
	}


	@Override
	public String getContentById(String cid) {
		Tannounce t = announceDao.get(Tannounce.class, cid);
		return t.getCcontent();
	}

	@Override
	public List<Announce> listAnnounce() {
		String hql = "from Tannounce t order by t.ccreatedate desc";
		List<Tannounce> list = announceDao.find(hql,1,5);
		return listRows(list);
	}

}
