package com.post.service.impl;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.post.dao.BaseDaoI;
import com.post.excelUtil.DateUtil;
import com.post.excelUtil.ExcelUtils;
import com.post.model.Tcost;
import com.post.model.Tkmlz;
import com.post.model.Tsubject;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Kmlz;
import com.post.pageModel.Pzh;
import com.post.service.KmlzServiceI;

@Service("kmlzService")
public class KmlzServiceImpl implements KmlzServiceI {
	
	private BaseDaoI<Tkmlz> kmlzDao;
	private BaseDaoI<Tsubject> kjkmDao;
	private BaseDaoI<Tcost> costDao;
	
	

	public BaseDaoI<Tsubject> getKjkmDao() {
		return kjkmDao;
	}

	@Autowired
	public void setKjkmDao(BaseDaoI<Tsubject> kjkmDao) {
		this.kjkmDao = kjkmDao;
	}

	public BaseDaoI<Tcost> getCostDao() {
		return costDao;
	}

	@Autowired
	public void setCostDao(BaseDaoI<Tcost> costDao) {
		this.costDao = costDao;
	}

	public BaseDaoI<Tkmlz> getKmlzDao() {
		return kmlzDao;
	}

	@Autowired
	public void setKmlzDao(BaseDaoI<Tkmlz> kmlzDao) {
		this.kmlzDao = kmlzDao;
	}

	@Override
	public void add(Kmlz kmlz) {
		Tkmlz t = new Tkmlz();
		BeanUtils.copyProperties(kmlz, t);
		t.setCid(UUID.randomUUID().toString());
		kmlzDao.save(t);
	}

	@Override
	public void edit(Kmlz kmlz) {
		Tkmlz t = kmlzDao.get(Tkmlz.class, kmlz.getCid());
		BeanUtils.copyProperties(kmlz, t);
	}

	@Override
	public void delete(Kmlz kmlz) {
		String cids = "";
		if (kmlz.getIds() != null) {
			String ids = kmlz.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tkmlz t where t.cid in (" + cids + ")";
			kmlzDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Kmlz kmlz) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(kmlz)));
		dg.setTotal(total(kmlz));
		return dg;
	}

	private Long total(Kmlz kmlz) {
		String hql = "select count(*) from Tkmlz t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(kmlz, hql, params);
		return kmlzDao.count(hql,params);
	}

	private List<Tkmlz> find(Kmlz kmlz) {
		String hql = "from Tkmlz t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(kmlz, hql, params);
		if (kmlz.getOrder() != null && kmlz.getSort() != null) {
			hql += " order by " + kmlz.getSort() + " " + kmlz.getOrder();
		}
		return kmlzDao.find(hql,params, kmlz.getPage(), kmlz.getRows());
	}

	private List<Kmlz> listRows(List<Tkmlz> lt) {
		List<Kmlz> rows = new ArrayList<Kmlz>();
		if (lt != null && lt.size() > 0) {
			for (Tkmlz t : lt) {
				Kmlz sub = new Kmlz();
				BeanUtils.copyProperties(t, sub);
				if (t.getTcost()!=null){
					sub.setCostId(t.getTcost().getCid());
				}
				if (t.getTsubject()!=null){
					sub.setKjkmId(t.getTsubject().getCid());
					sub.setKjkmName(t.getTsubject().getCname());
				}
				rows.add(sub);
			}
		}
		return rows;
	}
	
	private String addWhere(Kmlz kmlz,String hql,Map<String,Object> params){
		if (kmlz!=null){
			if (kmlz.getCostId()!=null && costDao.get(Tcost.class, kmlz.getCostId())!=null){
				hql +=" and t.tcost.cid= :costId ";
				params.put("costId", kmlz.getCostId());
			}
		}
		return hql;
	}

	@Override
	public int addKmlzs(Kmlz kmlz) {
		int i = 0;
		String hql =null;
		if (kmlz !=null && !kmlz.getFilename().isEmpty() && !kmlz.getCostId().isEmpty()){
			ExcelUtils eu = new ExcelUtils();
			List<ArrayList<String>> kmlzList = eu.read(kmlz.getFilename());
			for (ArrayList<String> row : kmlzList){
				if (!row.get(1).isEmpty()){
					hql ="from Tsubject t where t.cname=:cname ";
					Map<String,Object> params = new HashMap<String,Object>();
					params.put("cname",row.get(1).trim());
					List<Tsubject> lst = kjkmDao.find(hql,params);
					if (lst.size()==1){
						Tkmlz t = new Tkmlz();
						t.setCid(UUID.randomUUID().toString());
						t.setTsubject(lst.get(0));
						t.setTcost(costDao.get(Tcost.class, kmlz.getCostId()));
						t.setCdate(DateUtil.parse4yMd(row.get(0)));
						t.setCamount(Double.parseDouble(row.get(2)));
						kmlzDao.save(t);
						costDao.get(Tcost.class, kmlz.getCostId()).setCprogress(1);
						i++;
					}
				}
			}
			File f= new File(kmlz.getFilename());
			if (f.exists() && f.isFile() ){
				f.delete();
			}
		}
		return i;
	}

	@Override
	public void addPzh(Kmlz kmlz) {
		if (kmlz!=null && kmlz.getPzhs()!=null){
			List<Pzh> pzhs = JSON.parseArray(kmlz.getPzhs(), Pzh.class);
			for (Pzh pzh : pzhs){
				Tkmlz t = kmlzDao.get(Tkmlz.class, pzh.getCid());
				if (t!=null){
					t.setCpzh(pzh.getPzh());
				}
			}
		}
		
	}


}

