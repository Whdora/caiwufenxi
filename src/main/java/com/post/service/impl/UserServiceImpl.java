package com.post.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.post.comparator.RoleMenuComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tauth;
import com.post.model.Tdept;
import com.post.model.Tmenu;
import com.post.model.Trole;
import com.post.model.TroleTauth;
import com.post.model.TroleTmenu;
import com.post.model.Tuser;
import com.post.model.TuserTrole;
import com.post.pageModel.DataGrid;
import com.post.pageModel.TreeNode;
import com.post.pageModel.User;
import com.post.service.UserServiceI;
import com.post.util.Encrypt;

@Service("userService")
public class UserServiceImpl implements UserServiceI {

	private BaseDaoI<Tuser> userDao;
	private BaseDaoI<Tdept> deptDao;
	private BaseDaoI<Trole> roleDao;
	private BaseDaoI<TuserTrole> userroleDao;

	public BaseDaoI<Trole> getRoleDao() {
		return roleDao;
	}

	@Autowired
	public void setRoleDao(BaseDaoI<Trole> roleDao) {
		this.roleDao = roleDao;
	}

	public BaseDaoI<TuserTrole> getUserroleDao() {
		return userroleDao;
	}

	@Autowired
	public void setUserroleDao(BaseDaoI<TuserTrole> userroleDao) {
		this.userroleDao = userroleDao;
	}

	public BaseDaoI<Tdept> getDeptDao() {
		return deptDao;
	}

	@Autowired
	public void setDeptDao(BaseDaoI<Tdept> deptDao) {
		this.deptDao = deptDao;
	}

	public BaseDaoI<Tuser> getUserDao() {
		return userDao;
	}

	@Autowired
	public void setUserDao(BaseDaoI<Tuser> userDao) {
		this.userDao = userDao;
	}

	@Override
	public void addUser(User user) {
		Tuser t = new Tuser();
		Date d = new Date();
		BeanUtils.copyProperties(user, t, new String[] { "password" });
		t.setCid(UUID.randomUUID().toString());
		t.setCpassword(Encrypt.e(user.getCpassword()));
		t.setCcreatedatetime(new Timestamp(d.getTime()));
		t.setCmodifydatetime(new Timestamp(d.getTime()));
		t.setTdept(deptDao.get(Tdept.class, user.getCdepartment()));
		userDao.save(t);
		this.saveUserRole(user, t);
	}

	private void saveUserRole(User user, Tuser u) {
		Map<String,Object> params=new HashMap<String,Object>();
		params.put("tuser", u);
		userroleDao.executeHql("delete TuserTrole t where t.tuser = :tuser", params);
		if (user.getRoleIds() != null) {
			for (String id : user.getRoleIds().split(",")) {
				TuserTrole tusertrole = new TuserTrole();
				tusertrole.setCid(UUID.randomUUID().toString());
				tusertrole.setTrole(roleDao.get(Trole.class, id.trim()));
				tusertrole.setTuser(u);
				userroleDao.save(tusertrole);
			}
		}
	}
	
	@Override
	public User login(User user) {
		Map<String, Object> m = new HashMap<String, Object>();
		m.put("username", user.getCusername());
		m.put("password", Encrypt.e(user.getCpassword()));
		Tuser t = userDao
				.get("from Tuser t where t.cusername= :username and t.cpassword = :password",
						m);
		if (t != null) {
			BeanUtils.copyProperties(t, user, new String[] { "cpassword" });
			user.setCdeptname(t.getTdept().getCdeptName());
			user.setCdepartment(t.getTdept().getCid());
			Map<String, String> authIdsMap = new HashMap<String, String>();
			String authIds = "";
			String authNames = "";
			Map<String, String> authUrlsMap = new HashMap<String, String>();
			String authUrls = "";
			String roleIds = "";
			String roleNames = "";
			boolean b1 = false;
			Set<TuserTrole> tusertroles = t.getTuserTroles();
			if (tusertroles != null && tusertroles.size() > 0) {
				for (TuserTrole tusertrole : tusertroles) {
					Trole trole = tusertrole.getTrole();
					if (b1) {
						roleIds += ",";
						roleNames += ",";
					}
					roleIds += trole.getCid();
					roleNames += trole.getCname();
					b1 = true;
					Set<TroleTauth> troletauths = trole.getTroleTauths();
					if (troletauths != null && troletauths.size() > 0) {
						for (TroleTauth troletauth : troletauths) {
							Tauth tauth = troletauth.getTauth();
							authIdsMap.put(tauth.getCid(), tauth.getCname());
							authUrlsMap.put(tauth.getCid(), tauth.getCurl());
						}
					}
				}
			}
			boolean b2 = false;
			for (String id : authIdsMap.keySet()) {
				if (b2) {
					authIds += ",";
					authNames += ",";
				}
				authIds += id;
				authNames += authIdsMap.get(id);
				b2 = true;
			}
			user.setAuthIds(authIds);
			user.setAuthNames(authNames);
			user.setRoleIds(roleIds);
			user.setRoleNames(roleNames);
			boolean b3 = false;
			for (String id : authUrlsMap.keySet()) {
				if (b3) {
					authUrls += ",";
				}
				authUrls += authUrlsMap.get(id);
				b3 = true;
			}
			user.setAuthUrls(authUrls);
			return user;
		}
		return null;
	}
	
	
	@Override
	public DataGrid datagrid(User user) {
		DataGrid dg = new DataGrid();
		dg.setRows(this.changeModel(this.find(user)));
		dg.setTotal(this.total(user));
		return dg;
	}

	private Long total(User user) {
		String hql = "select count(*) from Tuser t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(user, hql, params);
		return userDao.count(hql, params);
	}

	private String addWhere(User user, String hql, Map<String, Object> params) {
		if (user.getCusername() != null
				&& !user.getCusername().trim().equals("")) {
			hql += " and t.cusername like :cusername ";
			params.put("cusername", "%%" + user.getCusername() + "%%");
		}
		if (user.getCcreatedatetimeStart() != null) {
			hql += " and t.ccreatedatetime>=:ccreatedatetimeStart ";
			params.put("ccreatedatetimeStart", user.getCcreatedatetimeStart());
		}
		if (user.getCcreatedatetimeEnd() != null) {
			hql += " and t.ccreatedatetime<=:ccreatedatetimeEnd ";
			params.put("ccreatedatetimeEnd", user.getCcreatedatetimeEnd());
		}
		return hql;
	}

	private List<User> changeModel(List<Tuser> tusers) {
		List<User> users = new ArrayList<User>();
		if (tusers != null && tusers.size() > 0) {
			for (Tuser tu : tusers) {
				User u = new User();
				BeanUtils.copyProperties(tu, u);
				u.setCdeptname(tu.getTdept().getCdeptName());
				u.setCdepartment(tu.getTdept().getCid());
				Set<TuserTrole> tusertroles = tu.getTuserTroles();
				String roleIds = "";
				String roleNames = "";
				boolean b = false;
				if (tusertroles != null && tusertroles.size() > 0) {
					for (TuserTrole tusertrole : tusertroles) {
						if (tusertrole.getTrole() != null) {
							if (b) {
								roleIds += ",";
								roleNames += ",";
							}
							roleIds += tusertrole.getTrole().getCid();
							roleNames += tusertrole.getTrole().getCname();
							b = true;
						}
					}
				}
				u.setRoleIds(roleIds);
				u.setRoleNames(roleNames);
				users.add(u);
			}
		}
		return users;
	}

	private List<Tuser> find(User user) {
		String hql = " from Tuser t where 1=1";
		Map<String, Object> params = new HashMap<String, Object>();
		hql = addWhere(user, hql, params);
		if (user.getSort() != null && user.getOrder() != null) {
			hql += " order by " + user.getSort() + " " + user.getOrder();
		}
		return userDao.find(hql, params, user.getPage(), user.getRows());
	}

	@Override
	public void update(User user) {
		Tuser u = userDao.get(Tuser.class, user.getCid());
		Date d = new Date();
		BeanUtils.copyProperties(user, u, new String[] { "cid", "cpassword","cmodifydatetime","ccreatedatetime" });
		if (user.getCcreatedatetime() == null) {
			u.setCcreatedatetime(new Timestamp(d.getTime()));
		}
			u.setCmodifydatetime(new Timestamp(d.getTime()));
		if (user.getCpassword() != null
				&& !user.getCpassword().trim().equals("")) {
			u.setCpassword(Encrypt.e(user.getCpassword()));
		}
		u.setTdept(deptDao.get(Tdept.class, user.getCdepartment()));
		this.saveUserRole(user, u);
	}

	@Override
	public int delete(User user) {
		String cids = "";
		if (user.getIds() != null) {
			String ids = user.getIds();
			for (String cid : ids.split(",")) {
				cids += "'" + cid + "'" + ",";
			}
			cids = cids.substring(0, cids.length() - 1);
			String hql = "delete Tuser t where t.cid in (" + cids + ")";
			return userDao.executeHql(hql);
		}
		return 0;
	}

	@Override
	public void del(String ids) {
		if (ids != null) {
			Map<String,Object> params=new HashMap<String,Object>();
			for (String id : ids.split(",")) {
				if (!id.trim().equals("0")) {
					Tuser u = userDao.get(Tuser.class, id.trim());
					params.put("tuser", u);
					if (u != null) {
						userroleDao.executeHql("delete TuserTrole t where t.tuser = :tuser", params);
						userDao.delete(u);
					}
				}
			}
		}
	}

	@Override
	public boolean editPwd(User user) {
		if (user!=null &&user.getCid()!=null){
			Tuser t=userDao.get(Tuser.class, user.getCid());
			if(t.getCpassword().equals(Encrypt.e(user.getOldpassword()))){
				t.setCpassword(Encrypt.e(user.getNewpassword()));
				t.setCmodifydatetime(new Timestamp(System.currentTimeMillis()));
				return true;
			}
		}
		return false;
	}

	@Override
	public boolean unlock(User user) {
		if (user!=null && user.getCid()!=null){
			Tuser u=userDao.get(Tuser.class, user.getCid());
			if (u.getCpassword().equals(Encrypt.e(user.getCpassword()))){
				return true;
			}
		}
		return false;
	}
	
	

}
