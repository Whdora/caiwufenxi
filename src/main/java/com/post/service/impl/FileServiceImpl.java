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
import com.post.model.Tdept;
import com.post.model.Tfile;
import com.post.pageModel.DataGrid;
import com.post.pageModel.File;
import com.post.service.FileServiceI;

@Service("fileService")
public class FileServiceImpl implements FileServiceI {

	private BaseDaoI<Tfile> fileDao;
	private BaseDaoI<Tdept> deptDao;

	public BaseDaoI<Tdept> getDeptDao() {
		return deptDao;
	}

	@Autowired
	public void setDeptDao(BaseDaoI<Tdept> deptDao) {
		this.deptDao = deptDao;
	}

	public BaseDaoI<Tfile> getFileDao() {
		return fileDao;
	}

	@Autowired
	public void setFileDao(BaseDaoI<Tfile> fileDao) {
		this.fileDao = fileDao;
	}

	@Override
	public void add(File file) {
		Tfile t = new Tfile();
		BeanUtils.copyProperties(file, t);
		t.setTdept(deptDao.get(Tdept.class, file.getDeptId()));
		t.setCid(UUID.randomUUID().toString());
		Date d = new Date();
		t.setCcreatedate(new Timestamp(d.getTime()));
		t.setCmodifydate(new Timestamp(d.getTime()));
		t.setCpass(0);
		fileDao.save(t);
	}

	@Override
	public void edit(File file) {
		Tfile t = fileDao.get(Tfile.class, file.getCid());
		BeanUtils.copyProperties(file, t,new String[]{"cid","ccreatedate","cmodifydate","cpass"});
		Date d = new Date();
		t.setCmodifydate(new Timestamp(d.getTime()));
	}

	@Override
	public void delete(File file) {
		String cids = "";
		if (file.getIds() != null) {
			String ids = file.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tfile t where t.cid in (" + cids + ")";
			fileDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(File file) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(file)));
		dg.setTotal(total(file));
		return dg;
	}

	private Long total(File file) {
		String hql = "select count(*) from Tfile t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(file, hql, params);
		return fileDao.count(hql, params);
	}

	private List<Tfile> find(File file) {
		String hql = "from Tfile t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(file, hql, params);
		if (file.getOrder() != null && file.getSort() != null) {
			hql += " order by " + file.getSort() + " " + file.getOrder();
		}
		return fileDao.find(hql, params, file.getPage(), file.getRows());
	}

	private String addWhere(File file, String hql, Map<String, Object> params) {
		if (file != null) {
			if (file.getDeptId() != null
					&& deptDao.get(Tdept.class, file.getDeptId()).getTdept() != null) {
				hql += " and t.tdept.cid= :deptid ";
				params.put("deptid", file.getDeptId());
			}
			if (file.getCreateStartDate()!=null){
				hql +=" and t.cdate >= :createStartDate";
				params.put("createStartDate", file.getCreateStartDate());
			}
			if (file.getCreateEndDate()!=null){
				hql +=" and t.cdate <= :createEndDate";
				params.put("createEndDate", file.getCreateEndDate());
			}
			if (file.getCfilenumber()!=null && !file.getCfilenumber().trim().equals("")){
				hql +=" and t.cfilenumber like :cfilenumber";
				params.put("cfilenumber", "%%"+file.getCfilenumber()+"%%");
			}
			if (file.getCname()!=null && !file.getCname().trim().equals("")){
				hql +=" and t.cname like :cname";
				params.put("cname", "%%"+file.getCname()+"%%");
			}
		}
		return hql;
	}

	private List<File> listRows(List<Tfile> lt) {
		List<File> rows = new ArrayList<File>();
		if (lt != null && lt.size() > 0) {
			for (Tfile t : lt) {
				File sub = new File();
				BeanUtils.copyProperties(t, sub);
				if (t.getTdept() != null) {
					sub.setDeptName(t.getTdept().getCdeptName());
				}
				rows.add(sub);
			}
		}
		return rows;
	}

	@Override
	public List<File> combobox() {
		List<File> rl = new ArrayList<File>();
		List<Tfile> l = fileDao.find("from Tfile");
		if (l != null && l.size() > 0) {
			for (Tfile t : l) {
				File r = new File();
				r.setCid(t.getCid());
				r.setCname(t.getCname());
				rl.add(r);
			}
		}
		return rl;
	}


}
