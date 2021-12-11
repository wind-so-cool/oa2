package com.cool.dao;

import com.cool.entity.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuMapper extends BaseMapper<Menu>{


    List<Menu> getMenuListByParentId(Long id);

    List<Menu> getAuthorizedMenuListByRoleId(String roleId);

    void delRoleMenu(@Param("menuId")Long menuId, @Param("roleId")Long roleId);

    List<Menu> getMenuListByParentIdAndRoleId(@Param("id")Long id,@Param("roleId") Long roleId);

    void authorizeMenu(@Param("menuIds")List<Long> menuIds, @Param("roleId")Long roleId);

    Integer getRoleMenuCount(@Param("roleId")Long roleId,@Param("menuId") Long menuId);

    void delAllRoleMenu(Long roleId);

    List<Menu> getMenuListByUserId(Long userId);
}