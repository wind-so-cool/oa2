package com.cool.service.impl;

import com.cool.dao.MenuMapper;
import com.cool.entity.Menu;
import com.cool.entity.Page;
import com.cool.service.MenuService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class MenuServiceImpl extends BaseServiceImpl<Menu> implements MenuService{

	@Autowired
	private MenuMapper menuMapper;

	@Override
	public List<Menu> getMenuListByParentId(Long id) {
		return menuMapper.getMenuListByParentId(id);
	}

	@Override
	public PageInfo<Menu> getAuthorizedMenuListByRoleId(String roleId, Page<Menu> page) {
		PageHelper.startPage(page.getCurrentPage(),page.getPageSize());
		List<Menu> menuList= menuMapper.getAuthorizedMenuListByRoleId(roleId);
		return new PageInfo<Menu>(menuList);
	}
	@Transactional
	@Override
	public void delRoleMenu(Long menuId, Long roleId) {
		menuMapper.delRoleMenu(menuId,roleId);
	}

	@Override
	public List<Menu> getMenuListByParentIdAndRoleId(Long id, Long roleId) {
		return menuMapper.getMenuListByParentIdAndRoleId(id,roleId);
	}

	@Override
	public void authorizeMenu(List<Long> menuIds, Long roleId) {
		menuMapper.delAllRoleMenu(roleId);
		menuMapper.authorizeMenu(menuIds,roleId);
	}

	@Override
	public Integer getRoleMenuCount(Long roleId, Long menuId) {
		return menuMapper.getRoleMenuCount(roleId,menuId);
	}

	@Override
	public List<Menu> getMenuListByUserId(Long userId) {
		return menuMapper.getMenuListByUserId(userId);
	}
}