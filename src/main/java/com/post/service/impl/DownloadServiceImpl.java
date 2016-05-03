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
import com.post.model.Tdownload;
import com.post.model.Tuser;
import com.post.pageModel.Download;
import com.post.pageModel.DataGrid;
import com.post.service.DownloadServiceI;

@Service("downloadService")
public class DownloadServiceImpl implements DownloadServiceI {

	private BaseDaoI<Tdownload> downloadDao;
	private BaseDaoI<Tuser> userDao;
	
	

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	public BaseDaoI<Tdownload> getDownloadDao() {
		return downloadDao;
	}

	@Autowired
	public void setDownloadDao(BaseDaoI<Tdownload> downloadDao) {
		this.downloadDao = downloadDao;
	}

	@Override
	public void add(Download download) {
		Tdownload t = new Tdownload();
		BeanUtils.copyProperties(download, t);
		t.setCid(UUID.randomUUID().toString());
		t.setCcount(0);
		Date d = new Date();
		t.setCuploaddate(new Timestamp(d.getTime()));
		t.setTuser(userDao.get(Tuser.class, download.getUserId()));
		downloadDao.save(t);
	}

	@Override
	public void edit(Download download) {
		Tdownload t = downloadDao.get(Tdownload.class, download.getCid());
		BeanUtils.copyProperties(download, t,new String[]{"cid","cuploaddate"});
	}

	@Override
	public void delete(Download download) {
		String cids = "";
		if (download.getIds() != null) {
			String ids = download.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tdownload t where t.cid in (" + cids + ")";
			downloadDao.executeHql(hql);
		}

	}

	@Override
	public DataGrid datagrid(Download download) {
		DataGrid dg = new DataGrid();
		dg.setRows(listRows(find(download)));
		dg.setTotal(total());
		return dg;
	}

	private Long total() {
		String hql = "select count(*) from Tdownload t where 1=1";
		return downloadDao.count(hql);
	}

	private List<Tdownload> find(Download download) {
		String hql = "from Tdownload t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(download, hql, params);
		if (download.getOrder() != null && download.getSort() != null) {
			hql += " order by " + download.getSort() + " "
					+ download.getOrder();
		}
		return downloadDao.find(hql,params,  download.getPage(), download.getRows());
	}
	
	private String addWhere(Download download, String hql, Map<String, Object> params) {
		if (download != null) {
			if (download.getCfilename()!=null && !download.getCfilename().trim().equals("")){
				hql +=" and t.cfilename like :cfilename";
				params.put("cfilename", "%%"+download.getCfilename()+"%%");
			}
			
		}
		return hql;
	}


	private List<Download> listRows(List<Tdownload> lt) {
		List<Download> rows = new ArrayList<Download>();
		if (lt != null && lt.size() > 0) {
			for (Tdownload t : lt) {
				Download sub = new Download();
				BeanUtils.copyProperties(t, sub);
				sub.setUserId(t.getTuser().getCid());
				sub.setUserName(t.getTuser().getCusername());
				rows.add(sub);
			}
		}
		return rows;
	}


	

	@Override
	public List<Download> listDownload() {
		String hql = "from Tdownload t order by t.cuploaddate desc";
		List<Tdownload> list = downloadDao.find(hql,1,5);
		return listRows(list);
	}

}
