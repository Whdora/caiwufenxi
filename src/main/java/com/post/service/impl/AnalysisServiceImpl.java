package com.post.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.service.AnalysisServiceI;

@Service("analysisService")
public class AnalysisServiceImpl implements AnalysisServiceI {

	private BaseDaoI<Object> analysisDao;

	public BaseDaoI<Object> getAnalysisDao() {
		return analysisDao;
	}

	@Autowired
	public void setAnalysisDao(BaseDaoI<Object> analysisDao) {
		this.analysisDao = analysisDao;
	}

	@Override
	public List<Object> analysisData() {
		String hql = "select new com.post.pageModel.Analysis(t.cid,t.tdept.cdeptName,t.tfile.cfilenumber,sum(t.camount) ) from Tcost t where t.tfile is not null group by t.tfile";
		return analysisDao.find(hql);
	}

}
