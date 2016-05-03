package com.post.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.model.Tzrzx;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Zrzx;
import com.post.service.ZrzxServiceI;

@Service("zrzxService")
public class ZrzxServiceImpl implements ZrzxServiceI {
	
	private BaseDaoI<Tzrzx> zrzxDao;

	public BaseDaoI<Tzrzx> getZrzxDao() {
		return zrzxDao;
	}

	@Autowired
	public void setZrzxDao(BaseDaoI<Tzrzx> zrzxDao) {
		this.zrzxDao = zrzxDao;
	}

	@Override
	public void add(Zrzx zrzx) {
		Tzrzx t = new Tzrzx();
		BeanUtils.copyProperties(zrzx, t);
		t.setCid(UUID.randomUUID().toString());
		zrzxDao.save(t);
	}

	@Override
	public void edit(Zrzx zrzx) {
		Tzrzx t = zrzxDao.get(Tzrzx.class, zrzx.getCid());
		BeanUtils.copyProperties(zrzx, t);
	}

	@Override
	public void delete(Zrzx zrzx) {
		String cids = "";
		if (zrzx.getIds() != null) {
			String ids = zrzx.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tzrzx t where t.cid in (" + cids + ")";
			zrzxDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Zrzx zrzx) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(zrzx)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tzrzx t where 1=1";
		return zrzxDao.count(hql);
	}

	private List<Tzrzx> find(Zrzx zrzx) {
		String hql = "from Tzrzx t where 1=1";
		if (zrzx.getOrder() != null && zrzx.getSort() != null) {
			hql += " order by " + zrzx.getSort() + " " + zrzx.getOrder();
		}
		return zrzxDao.find(hql, zrzx.getPage(), zrzx.getRows());
	}

	private List<Zrzx> listRows(List<Tzrzx> lt) {
		List<Zrzx> rows = new ArrayList<Zrzx>();
		if (lt != null && lt.size() > 0) {
			for (Tzrzx t : lt) {
				Zrzx sub = new Zrzx();
				BeanUtils.copyProperties(t, sub);
				rows.add(sub);
			}
		}
		return rows;
	}

	@Override
	public List<Zrzx> combobox() {
		List<Zrzx> rl = new ArrayList<Zrzx>();
		List<Tzrzx> l = zrzxDao.find("from Tzrzx");
		if (l != null && l.size() > 0) {
			for (Tzrzx t : l) {
				Zrzx r = new Zrzx();
				r.setCid(t.getCid());
				r.setCname(t.getCname());
				rl.add(r);
			}
		}
		return rl;
	}

}
