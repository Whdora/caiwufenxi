package com.post.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.model.Tshangpin;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Shangpin;
import com.post.service.ShangpinServiceI;

@Service("shangpinService")
public class ShangpinServiceImpl implements ShangpinServiceI {
	
	private BaseDaoI<Tshangpin> shangpinDao;

	public BaseDaoI<Tshangpin> getShangpinDao() {
		return shangpinDao;
	}

	@Autowired
	public void setShangpinDao(BaseDaoI<Tshangpin> shangpinDao) {
		this.shangpinDao = shangpinDao;
	}

	@Override
	public void add(Shangpin shangpin) {
		Tshangpin t = new Tshangpin();
		BeanUtils.copyProperties(shangpin, t);
		t.setCid(UUID.randomUUID().toString());
		shangpinDao.save(t);
	}

	@Override
	public void edit(Shangpin shangpin) {
		Tshangpin t = shangpinDao.get(Tshangpin.class, shangpin.getCid());
		BeanUtils.copyProperties(shangpin, t);
	}

	@Override
	public void delete(Shangpin shangpin) {
		String cids = "";
		if (shangpin.getIds() != null) {
			String ids = shangpin.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tshangpin t where t.cid in (" + cids + ")";
			shangpinDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Shangpin shangpin) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(shangpin)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tshangpin t where 1=1";
		return shangpinDao.count(hql);
	}

	private List<Tshangpin> find(Shangpin shangpin) {
		String hql = "from Tshangpin t where 1=1";
		if (shangpin.getOrder() != null && shangpin.getSort() != null) {
			hql += " order by " + shangpin.getSort() + " " + shangpin.getOrder();
		}
		return shangpinDao.find(hql, shangpin.getPage(), shangpin.getRows());
	}

	private List<Shangpin> listRows(List<Tshangpin> lt) {
		List<Shangpin> rows = new ArrayList<Shangpin>();
		if (lt != null && lt.size() > 0) {
			for (Tshangpin t : lt) {
				Shangpin sub = new Shangpin();
				BeanUtils.copyProperties(t, sub);
				rows.add(sub);
			}
		}
		return rows;
	}

	@Override
	public List<Shangpin> combobox() {
		List<Shangpin> rl = new ArrayList<Shangpin>();
		List<Tshangpin> l = shangpinDao.find("from Tshangpin");
		if (l != null && l.size() > 0) {
			for (Tshangpin t : l) {
				Shangpin r = new Shangpin();
				r.setCid(t.getCid());
				r.setCname(t.getCname());
				rl.add(r);
			}
		}
		return rl;
	}

}

