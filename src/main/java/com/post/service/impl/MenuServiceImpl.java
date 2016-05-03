package com.post.service.impl;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Set;
import java.util.UUID;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.alibaba.fastjson.JSON;
import com.post.comparator.MenuComparator;
import com.post.comparator.RoleMenuComparator;
import com.post.dao.BaseDaoI;
import com.post.model.Tmenu;
import com.post.model.Trole;
import com.post.model.TroleTmenu;
import com.post.model.Tuser;
import com.post.model.TuserTrole;
import com.post.pageModel.Menu;
import com.post.pageModel.TreeNode;
import com.post.service.MenuServiceI;

@Service("menuService")
public class MenuServiceImpl implements MenuServiceI {

    private BaseDaoI<Tmenu> menuDao;
    private BaseDaoI<Tuser> userDao;
    private BaseDaoI<TuserTrole> userroleDao;
    private BaseDaoI<TroleTmenu> rolemenuDao;

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

    public BaseDaoI<Tuser> getUserDao() {
        return userDao;
    }

    @Autowired
    public void setUserDao(BaseDaoI<Tuser> userDao) {
        this.userDao = userDao;
    }

    public BaseDaoI<Tmenu> getMenuDao() {
        return menuDao;
    }

    @Autowired
    public void setMenuDao(BaseDaoI<Tmenu> menuDao) {
        this.menuDao = menuDao;
    }

    public List<TreeNode> tree(Menu menu, Boolean b) {
        List<Object> param = new ArrayList<Object>();
        String hql = "from Tmenu t where t.tmenu is null order by t.cseq";
        if (menu != null && menu.getId() != null
                && !menu.getId().trim().equals("")) {
            hql = "from Tmenu t where t.tmenu.cid = ? order by t.cseq";
            param.add(menu.getId());
        }
        List<Tmenu> l = menuDao.find(hql, param);
        List<TreeNode> tree = new ArrayList<TreeNode>();
        for (Tmenu t : l) {
            tree.add(this.tree(t, b));
        }
        return tree;
    }

    private TreeNode tree(Tmenu t, boolean recursive) {
        TreeNode node = new TreeNode();
        node.setId(t.getCid());
        node.setText(t.getCname());
        Map<String, Object> attributes = new HashMap<String, Object>();
        attributes.put("url", t.getCurl());
        node.setAttributes(attributes);
        if (t.getCiconcls() != null) {
            node.setIconCls(t.getCiconcls());
        } else {
            node.setIconCls("");
        }
        if (t.getTmenus() != null && t.getTmenus().size() > 0) {
            node.setState("closed");
            if (recursive) {// 递归查询子节点
                List<Tmenu> l = new ArrayList<Tmenu>(t.getTmenus());
                Collections.sort(l, new MenuComparator());// 排序
                List<TreeNode> children = new ArrayList<TreeNode>();
                for (Tmenu r : l) {
                    TreeNode tn = tree(r, true);
                    children.add(tn);
                }
                node.setChildren(children);
                node.setState("open");
            }
        }
        return node;
    }

    public List<Menu> treegrid(Menu menu) {
        List<Tmenu> l;
        if (menu != null && menu.getId() != null) {
            Map<String, Object> params = new HashMap<String, Object>();
            params.put("cid", menu.getId());
            l = menuDao.find(
                    "from Tmenu t where t.tmenu.cid = :cid order by t.cseq",
                    params);
        } else {
            l = menuDao
                    .find("from Tmenu t where t.tmenu is null order by t.cseq");
        }
        return changeModel(l);
    }

    private List<Menu> changeModel(List<Tmenu> Tmenus) {
        List<Menu> l = new ArrayList<Menu>();
        if (Tmenus != null && Tmenus.size() > 0) {
            for (Tmenu t : Tmenus) {
                Menu m = new Menu();
                BeanUtils.copyProperties(t, m);
                if (t.getTmenu() != null) {
                    m.setPid(t.getTmenu().getCid());
                    m.setPname(t.getTmenu().getCname());
                }
                if (countChildren(t.getCid()) > 0) {
                    m.setState("closed");
                }
                if (t.getCiconcls() == null) {
                    m.setIconCls("");
                } else {
                    m.setIconCls(t.getCiconcls());
                }
                l.add(m);
            }
        }
        return l;
    }

    private Menu tgrid(Tmenu t, boolean recursive) {
        Menu menu = new Menu();
        BeanUtils.copyProperties(t, menu, new String[]{"tmenu"});
        if (t.getTmenu() != null) {
            menu.setPid(t.getTmenu().getCid());
            menu.setPname(t.getTmenu().getCname());
        }
        if (t.getCiconcls() == null) {
            menu.setIconCls("");
        } else {
            menu.setIconCls(t.getCiconcls());
        }
        if (t.getTmenus() != null && t.getTmenus().size() > 0) {
            menu.setState("closed");
            if (recursive) {// 递归查询子节点menu
                List<Tmenu> l = new ArrayList<Tmenu>(t.getTmenus());
                Collections.sort(l, new MenuComparator());// 排序
                List<Menu> children = new ArrayList<Menu>();
                for (Tmenu r : l) {
                    Menu tn = tgrid(r, true);
                    children.add(tn);
                }
                menu.setChildren(children);
                menu.setState("open");
            }
        }
        return menu;
    }

    /**
     * 统计有多少子节点
     */
    private Long countChildren(String pid) {
        Map<String, Object> params = new HashMap<String, Object>();
        params.put("cid", pid);
        return menuDao
                .count("select count(*) from Tmenu t where t.tmenu.cid = :cid",
                        params);
    }

    public void delete(Menu menu) {
        del(menu.getCid());
    }

    private void del(String cid) {
        Tmenu t = menuDao.get(Tmenu.class, cid);
        if (t != null) {
            Set<Tmenu> menus = t.getTmenus();
            if (menus != null && !menus.isEmpty()) {
                // 说明当前菜单下面还有子菜单
                for (Tmenu tmenu : menus) {
                    del(tmenu.getCid());
                }
            }
            menuDao.delete(t);
        }
    }

    public void add(Menu menu) {
        Tmenu t = new Tmenu();
        BeanUtils.copyProperties(menu, t);
        t.setCid(UUID.randomUUID().toString());
        if (menu.getPid() != null) {
            t.setTmenu(menuDao.get(Tmenu.class, menu.getPid()));
        }
        if (menu.getIconCls() != null) {
            t.setCiconcls(menu.getIconCls());
        }
        menuDao.save(t);
    }

    public void edit(Menu menu) {
        Tmenu t = menuDao.get(Tmenu.class, menu.getCid());
        BeanUtils.copyProperties(menu, t);
        if (menu.getIconCls() != null) {
            t.setCiconcls(menu.getIconCls());
        }
        if (menu.getPid() != null && !menu.getPid().equals(menu.getCid())) {
            Tmenu pt = menuDao.get(Tmenu.class, menu.getPid());
            if (pt != null) {
                if (isDown(t, pt)) {// 要将当前节点修改到当前节点的子节点中
                    Set<Tmenu> tmenus = t.getTmenus();// 当前要修改的节点的所有下级节点
                    if (tmenus != null && tmenus.size() > 0) {
                        for (Tmenu tmenu : tmenus) {
                            if (tmenu != null) {
                                tmenu.setTmenu(null);
                            }
                        }
                    }
                }
                t.setTmenu(pt);
            }

        }
    }

    /**
     * 判断是否是将当前节点修改到当前节点的子节点
     *
     * @param t
     * @param pt
     * @return
     */
    private boolean isDown(Tmenu t, Tmenu pt) {
        if (pt.getTmenu() != null) {
            if (pt.getTmenu().getCid().equals(t.getCid())) {
                return true;
            } else {
                return isDown(t, pt.getTmenu());
            }
        }
        return false;
    }

    @Override
    public List<Menu> tgrid(Menu menu, boolean b) {
        List<Object> param = new ArrayList<Object>();
        String hql = "from Tmenu t where t.tmenu is null order by t.cseq";
        if (menu != null && menu.getId() != null
                && !menu.getId().trim().equals("")) {
            hql = "from Tmenu t where t.tmenu.cid = ? order by t.cseq";
            param.add(menu.getId());
        }
        List<Tmenu> l = menuDao.find(hql, param);
        List<Menu> tree = new ArrayList<Menu>();
        for (Tmenu t : l) {
            tree.add(this.tgrid(t, b));
        }
        return tree;
    }

    @Override
    public List<TreeNode> getUserMenus(Menu menu) {
        if (menu != null && menu.getUserId() != null) {
            Tuser tuser = userDao.get(Tuser.class, menu.getUserId());
            Set<TuserTrole> tusertroles = tuser.getTuserTroles();
            List<TreeNode> usermenus = new ArrayList<TreeNode>();
            if (tusertroles != null && tusertroles.size() > 0) {
                for (TuserTrole tusertrole : tusertroles) {
                    Trole trole = tusertrole.getTrole();
                    Set<TroleTmenu> troletmenus = trole.getTroleTmenus();
                    Tmenu tmenu = new Tmenu();
                    if (troletmenus != null && troletmenus.size() > 0) {
                        for (TroleTmenu troletmenu : troletmenus) {
                            if (troletmenu.getTmenu().getTmenu() == null) {
                                tmenu = troletmenu.getTmenu();
                                usermenus.addAll(listUserMenus(tmenu, troletmenus));
                            }
                        }
                        return usermenus;
                    }

                }
            }
        }
        return null;
    }

    private List<TreeNode> listUserMenus(Tmenu tmenu,
                                         Set<TroleTmenu> troletmenus) {
        List<TreeNode> menus = new ArrayList<TreeNode>();
        menus.add(getUserMenu(tmenu, troletmenus));
        return menus;
    }

    private TreeNode getUserMenu(Tmenu tmenu, Set<TroleTmenu> tmenus) {
        TreeNode m = new TreeNode();
        m.setId(tmenu.getCid());
        m.setText(tmenu.getCname());
//		m.setText("用户管理");
        Map<String, Object> attributes = new HashMap<String, Object>();
        attributes.put("url", tmenu.getCurl());
//		attributes.put("url", "roleAction!roleManager.action");
        m.setAttributes(attributes);
        if (tmenu.getCiconcls() == null) {
            m.setIconCls("");
        } else {
            m.setIconCls(tmenu.getCiconcls());
        }
        List<TreeNode> children = new ArrayList<TreeNode>();
        if (tmenu.getTmenus() != null & tmenu.getTmenus().size() > 0) {
            List<TroleTmenu> ts = new ArrayList<TroleTmenu>(tmenus);
            Collections.sort(ts, new RoleMenuComparator());
            for (TroleTmenu t : ts) {
                if (t.getTmenu().getTmenu() != null
                        && t.getTmenu().getTmenu().getCid() != null) {
                    if (tmenu.getCid() == t.getTmenu().getTmenu().getCid()) {
                        TreeNode menu = getUserMenu(t.getTmenu(), tmenus);
                        children.add(menu);
                    }
                }
            }
            m.setChildren(children);
            m.setState("open");
        }
        return m;
    }

}
