package com.cool.service;

import com.cool.entity.Menu;
import com.cool.entity.Page;
import com.github.pagehelper.PageInfo;

import java.util.List;

public interface MenuService extends BaseService<Menu>{
    List<Menu> getMenuListByParentId(Long id);

    PageInfo<Menu> getAuthorizedMenuListByRoleId(String roleId, Page<Menu> page);

    void delRoleMenu(Long menuId, Long roleId);

    List<Menu> getMenuListByParentIdAndRoleId(Long id, Long roleId);

    void authorizeMenu(List<Long> menuIds, Long roleId);

    Integer getRoleMenuCount(Long roleId, Long menuId);

    List<Menu> getMenuListByUserId(Long userId);
}