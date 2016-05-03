package com.post.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.post.dao.BaseDaoI;
import com.post.model.Tauth;
import com.post.model.Tmenu;
import com.post.model.Trole;
import com.post.model.TroleTauth;
import com.post.model.TroleTmenu;
import com.post.model.TuserTrole;
import com.post.pageModel.DataGrid;
import com.post.pageModel.Role;
import com.post.service.RoleServiceI;

@Service("roleService")
public class RoleServiceImpl implements RoleServiceI {

	private BaseDaoI<Trole> roleDao;
	private BaseDaoI<Tauth> authDao;
	private BaseDaoI<Tmenu> menuDao;
	private BaseDaoI<TroleTauth> roleauthDao;
	private BaseDaoI<TuserTrole> userroleDao;
	private BaseDaoI<TroleTmenu> rolemenuDao;

	public BaseDaoI<Trole> getRoleDao() {
		return roleDao;
	}

	@Autowired
	public void setRoleDao(BaseDaoI<Trole> roleDao) {
		this.roleDao = roleDao;
	}

	public BaseDaoI<Tauth> getAuthDao() {
		return authDao;
	}

	@Autowired
	public void setAuthDao(BaseDaoI<Tauth> authDao) {
		this.authDao = authDao;
	}

	public BaseDaoI<Tmenu> getMenuDao() {
		return menuDao;
	}

	@Autowired
	public void setMenuDao(BaseDaoI<Tmenu> menuDao) {
		this.menuDao = menuDao;
	}

	public BaseDaoI<TroleTauth> getRoleauthDao() {
		return roleauthDao;
	}

	@Autowired
	public void setRoleauthDao(BaseDaoI<TroleTauth> roleauthDao) {
		this.roleauthDao = roleauthDao;
	}

	public BaseDaoI<TuserTrole> getUserroleDao() {
		return userroleDao;
	}

	@Autowired
	public void setUserroleDao(BaseDaoI<TuserTrole> userroleDao) {
		this.userroleDao = userroleDao;
	}

	public BaseDaoI<TroleTmenu> getRolemenuDao() {
		return rolemenuDao;
	}

	@Autowired
	public void setRolemenuDao(BaseDaoI<TroleTmenu> rolemenuDao) {
		this.rolemenuDao = rolemenuDao;
	}

	@Override
	public DataGrid datagrid(Role role) {
		DataGrid j = new DataGrid();
		j.setRows(changeModel(find(role)));
		j.setTotal(total(role));
		return j;
	}

	private List<Role> changeModel(List<Trole> troles) {
		List<Role> roles = new ArrayList<Role>();
		if (troles != null && troles.size() > 0) {
			for (Trole tu : troles) {
				Role u = new Role();
				BeanUtils.copyProperties(tu, u);

				Set<TroleTauth> troletauths = tu.getTroleTauths();
				String authIds = "";
				String authNames = "";
				boolean b = false;
				if (troletauths != null && troletauths.size() > 0) {
					for (TroleTauth troletauth : troletauths) {
						if (troletauth.getTauth() != null) {
							if (b) {
								authIds += ",";
								authNames += ",";
							}
							authIds += troletauth.getTauth().getCid();
							authNames += troletauth.getTauth().getCname();
							b = true;
						}
					}
				}
				Set<TroleTmenu> troletmenus = tu.getTroleTmenus();
				String menuIds = "";
				String menuNames = "";
				boolean f = false;
				if (troletmenus != null && troletmenus.size() > 0) {
					for (TroleTmenu troletmenu : troletmenus) {
						if (troletmenu.getTmenu() != null) {
							if (f) {
								menuIds += ",";
								menuNames += ",";
							}
							menuIds += troletmenu.getTmenu().getCid();
							menuNames += troletmenu.getTmenu().getCname();
							f = true;
						}
					}
				}
				u.setAuthIds(authIds);
				u.setAuthNames(authNames);
				u.setMenuIds(menuIds);
				u.setMenuNames(menuNames);
				roles.add(u);
			}
		}
		return roles;
	}

	private List<Trole> find(Role role) {
		String hql = "from Trole t where 1=1 ";
		if (role.getSort() != null && role.getOrder() != null) {
			hql += " order by " + role.getSort() + " " + role.getOrder();
		}
		List<Object> values = new ArrayList<Object>();
		hql = addWhere(role, hql, values);
		return roleDao.find(hql, values, role.getPage(), role.getRows());
	}

	private Long total(Role role) {
		String hql = "select count(*) from Trole t where 1=1 ";
		List<Object> values = new ArrayList<Object>();
		hql = addWhere(role, hql, values);
		return roleDao.count(hql, values);
	}

	private String addWhere(Role role, String hql, List<Object> values) {
		return hql;
	}

	@Override
	public void edit(Role role) {
		Trole r = roleDao.get(Trole.class, role.getCid());
		BeanUtils.copyProperties(role, r, new String[] { "cid" });
		this.saveRoleMenu(role, r);
		this.saveRoleAuth(role, r);

	}

	@Override
	public void delete(String ids) {
		if (ids != null) {
			Map<String ,Object> params=new HashMap<String,Object>();
			for (String id : ids.split(",")) {
				Trole r = roleDao.get(Trole.class, id.trim());
				params.put("trole", r);
				if (r != null) {
					roleauthDao.executeHql(
							"delete TroleTauth t where t.trole = :trole",params);
					rolemenuDao.executeHql("delete TroleTmenu t where t.trole = :trole", params);
					userroleDao.executeHql(
							"delete TuserTrole t where t.trole = :trole",params);
					roleDao.delete(r);
				}
			}
		}
	}

	@Override
	public List<Role> combobox() {
		List<Role> rl = new ArrayList<Role>();
		List<Trole> l = roleDao.find("from Trole");
		if (l != null && l.size() > 0) {
			for (Trole t : l) {
				Role r = new Role();
				r.setCid(t.getCid());
				r.setCname(t.getCname());
				rl.add(r);
			}
		}
		return rl;
	}

	@Override
	public void add(Role role) {
		Trole r = new Trole();
		BeanUtils.copyProperties(role, r);
		r.setCid(UUID.randomUUID().toString());
		roleDao.save(r);
		this.saveRoleAuth(role, r);
		this.saveRoleMenu(role, r);
	}

	private void saveRoleAuth(Role role, Trole r) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("trole", r);
		roleauthDao.executeHql("delete TroleTauth t where t.trole = :trole",
				params);
		if (role.getAuthIds() != null) {
			for (String id : role.getAuthIds().split(",")) {
				TroleTauth troletauth = new TroleTauth();
				troletauth.setCid(UUID.randomUUID().toString());
				troletauth.setTauth(authDao.get(Tauth.class, id.trim()));
				troletauth.setTrole(r);
				roleauthDao.save(troletauth);
			}
		}
	}

	private void saveRoleMenu(Role role, Trole r) {
		Map<String, Object> params = new HashMap<String, Object>();
		params.put("trole", r);
		rolemenuDao.executeHql("delete TroleTmenu t where t.trole = :trole",
				params);
		if (role.getMenuIds() != null) {
			for (String id : role.getMenuIds().split(",")) {
				TroleTmenu troletmenu = new TroleTmenu();
				troletmenu.setCid(UUID.randomUUID().toString());
				troletmenu.setTmenu(menuDao.get(Tmenu.class, id.trim()));
				troletmenu.setTrole(r);
				rolemenuDao.save(troletmenu);
			}
		}
	}

}
